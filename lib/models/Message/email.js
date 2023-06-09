const async = require('async')
const config = require('../../config.js')
const db = require('../../utils/db.js')
const render = require('../../utils/render').html
const Orm = require('../Orm/index')
const Brand = require('../Brand/get')
const Crypto = require('../Crypto')
const Url = require('../Url')
const Room = {
  ...require('../Room/get'),
  ...require('../Room/branch'),
}

const {
  get: _getUser
} = require('../User/get')

const {
  shouldTryEmail
} = require('../User/notification')

const {
  getType: getNotificationType,
  isSystemGenerated,
  getUnreadForRoom
} = require('../Notification/get')

const {
  getBranchLink
} = require('../Notification/branch')

const {
  saveDelivery
} = require('../Notification/delivery')

const { retrieve } = require('./get')

const {
  create: createEmail
} = require('../Email/create')

const authored_notifications = [
  'UserSharedListing',
  'UserCreatedAlert',
  'UserInvitedRoom'
]

const getAuthor = m => {
  if (m.notification && authored_notifications.includes(m.notification.notification_type))
    return m.notification.subjects[0]

  return m.author
}

const sendStackedEmail = ({user, rooms}, cb) => {
  const user_id = user

  const getUser = cb => _getUser(user_id).nodeify(cb)

  const _saveDelivery = (user, room_id, cb) => {
    getUnreadForRoom(user.id, room_id, (err, notifications) => {
      if (err)
        return cb(err)

      async.map(notifications, (n, cb) => {
        saveDelivery(n.id, user.id, user.email, 'email', cb)
      }, cb)
    })
  }

  const saveDeliveries = (cb, results) => {
    async.forEach(results.rooms, (room, cb) => {
      _saveDelivery(results.user, room.id, cb)
    }, cb)
  }

  const send = (cb, results) => {
    if (results.rooms.length < 1)
      return cb()

    const header_id = `<head-${results.user.id}@rechat.com>`
    const subject = 'New messages on Rechat'

    /*
     * If this email we're sending has messages from only one room,
     * then we know which room it's being replied to.
     *
     * If it contains messages from several rooms, we wouldn't know where they should
     * reply to.
     */

    let replyTo = 'noreply@rechat.com'

    if (results.rooms.length === 1)
      replyTo = results.rooms[0].replyTo

    const headers = {
      'List-Unsubscribe': '<%unsubscribe_email%>',
      'Reply-To': replyTo,
    }

    const email = {
      from: config.email.from,
      to: [ results.user.email ],
      subject,
      html: results.html,
      headers
    }

    // This is the first email that includes invitation.
    // Its going to have an ID so later we can reference its ID for threading
    if (results.invitation)
      email.headers['Message-ID'] = header_id
    else
    // This is not the first email. So its going to be threaded under the first email which has been sent previously.
      email.headers['In-Reply-To'] = header_id


    createEmail(email).nodeify(cb)
  }

  const getInvitation = (cb, results) => {
    if (!results.user.is_shadow)
      return cb()

    let invitation_notification

    results.rooms.forEach(room => {
      room.messages.forEach(m => {
        if (!m.notification)
          return

        if (getNotificationType(m.notification) !== 'UserInvitedRoom')
          return

        if (m.notification.auxiliary_object.id !== results.user.id)
          return

        invitation_notification = m.notification
      })
    })


    cb(null, invitation_notification)
  }

  const renderEmail = (cb, results) => {
    results.base_url = Url.web({
      brand: results.brand
    })
    render(__dirname + '/../../html/message/body.html', results, cb)
  }

  const getBrand = (cb, results) => {
    if(!results.user.brand)
      return cb()

    Brand.get(results.user.brand).nodeify((err, b) => {
      if(err)
        return cb(err)

      Orm.populate({
        models: [b]
      }).nodeify((err, populated) => {
        if (err)
          return cb(err)

        cb(null, populated[0])
      })
    })
  }

  const getMessages = (room_id, first, cb) => {
    retrieve(room_id, {
      type: 'Since_C',
      timestamp: (first - 1) * 1000000,
      recommendation: 'None',
      reference: 'None'
    }, (err, messages) => {
      if(err)
        return cb(err)

      Orm.populate({
        models: messages,
        associations: ['message.notification', 'alert.listings', 'notification.subject']
      }).nodeify(cb)
    })
  }

  const prepareRoom = (user, room, cb) => {
    const messages = cb => {
      getMessages(room.id, room.first_unread, (err, messages) => {
        if (err)
          return cb(err)

        room.messages = messages

        const groups = []

        const next = (m, user) => {
          const g = {
            user,
            messages: []
          }

          if (m)
            g.messages.push(m)

          groups.push(g)

          return g
        }

        const current = (m, user) => {
          groups[groups.length - 1].messages.push(m)
        }

        messages.forEach((m, i) => {
          const prev = messages[i - 1]

          const author = getAuthor(m)

          if (!prev) // First item. New Group.
            return next(m, author)


          if (m.activity) // Activities are always in a new group.
            return next(m, author)

          const prev_author = getAuthor(prev)

          if (author !== prev_author)
            return next(m, author)

          current(m)
        })

        room.grouped_messages = groups

        cb()
      })
    }

    const room_branch = (cb, results) => {
      if (!room.ok)
        return cb()

      Room.getBranchLink({
        user_id: user_id,
        room_id: room.id
      }, (err, link) => {
        if (err)
          return cb(err)

        room.url = link
        cb()
      })
    }

    const notification_branches = (cb, results) => {
      if (!room.ok)
        return cb()

      const notifications = room.messages.filter(m => Boolean(m.notification)).map( m => m.notification )

      async.map(notifications, (n, cb) => {
        getBranchLink(n, user, room.id, cb)
      }, (err, urls) => {
        if(err)
          return cb(err)

        urls.forEach((u, i) => {
          notifications[i].branch_link = u ? u : room.url
        })

        return cb()
      })
    }

    const ok = cb => {
      const respond = is => {
        room.ok = is
        cb()
      }

      if (room.notification_setting === 'E_NONE')
        return respond(false)

      if (!shouldTryEmail(user))
        return respond(false)

      let user_generated = false
      let mentioned = false

      room.messages.forEach(m => {
        if (m.author)
          user_generated = true

        if (m.notification && !isSystemGenerated(m.notification))
          user_generated = true

        if (m.mentions && m.mentions.includes(user_id))
          mentioned = true
      })

      if (!user_generated)
        return respond(false)

      if (mentioned)
        return respond(true)

      respond(room.notification_setting === 'N_ALL')
    }

    const done = (err, results) => {
      cb(err, room)
    }

    async.auto({
      messages,
      ok: ['messages', ok],
      room_branch: ['ok', room_branch],
      notification_branches: ['ok', 'room_branch', notification_branches]
    }, done)
  }

  const getRooms = (cb, results) => {
    const filter = (err, rooms) => {
      if (err)
        return cb(err)

      const filtered = rooms.filter(r => r.ok)
      cb(null, filtered)
    }

    Room.getAll(rooms.map(r => r.room), (err, loaded) => {
      if (err)
        return cb(err)

      loaded.forEach((room, i) => {
        room.first_unread = rooms[i].first_unread
        room.notification_setting = rooms[i].notification_setting

        room.replyTo = Crypto.encrypt(JSON.stringify({
          room_id: room.id,
          user_id
        })) + '@' + config.email.seamless_address
      })

      async.map(loaded, prepareRoom.bind(null, results.user), filter)
    })
  }

  async.auto({
    user: getUser,
    rooms: ['user', getRooms],
    invitation: ['rooms', getInvitation],
    brand: ['user', getBrand],
    html: ['rooms', 'invitation', 'brand', renderEmail],
    deliveries: ['rooms', saveDeliveries],
    send: ['html', 'rooms', 'deliveries', send],
  }, cb)
}

const sendEmailForUnread = cb => {
  db.query('message/unread', [
    config.email.seamless_delay,
    config.email.seamless_timeout
  ], (err, res) => {
    if (err)
      return cb(err)

    async.forEach(res.rows, sendStackedEmail, cb)
  })
}

module.exports = {
  sendEmailForUnread
}
