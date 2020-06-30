/**
 * @namespace Notification
 */

const async = require('async')
const _u = require('underscore')
const UrbanAirshipPush = require('urban-airship-push')
const EventEmitter = require('events').EventEmitter
const validator = require('../../utils/validator.js')
const db = require('../../utils/db.js')
const config = require('../../config.js')
const snake = require('to-snake-case')
const emojify = require('emojify.js')
const Context = require('../Context')
const Orm = require('../Orm.js')
const urbanAirshipTokenHelper = require('./urban_airship_reports_service')
const promisify = require('../../utils/promisify')
const render = require('../../utils/render').text
const _ = require('lodash')

const emitter = new EventEmitter

const Notification = {}
global['Notification'] = Notification

Notification.on = emitter.on.bind(emitter)

const decorators = []

Notification.addDecorator = fn => decorators.push(fn)

Orm.register('notification', 'Notification', Notification)

Notification.object_enum = [
  'Recommendation',
  'Listing',
  'Message',
  'Comment',
  'Room',
  'HotSheet',
  'Photo',
  'Video',
  'Document',
  'Tour',
  'Co-Shopper',
  'Price',
  'Status',
  'User',
  'Alert',
  'Invitation',
  'Contact',
  'Attachment',
  'OpenHouse',
  'Envelope',
  'EnvelopeRecipient',
  'Deal',
  'DealRole',
  'CrmTask',
  'Reminder',
  'ContactList',
  'DealContext',
  'ContactAttribute'
]

Notification.action_enum = [
  'Liked',
  'Composed',
  'Edited',
  'Added',
  'Removed',
  'Posted',
  'Favorited',
  'Changed',
  'Created',
  'CreatedFor',
  'Shared',
  'Arrived',
  'Toured',
  'Accepted',
  'Declined',
  'Joined',
  'Left',
  'Archived',
  'Deleted',
  'Opened',
  'Closed',
  'Pinned',
  'Sent',
  'Invited',
  'BecameAvailable',
  'PriceDropped',
  'StatusChanged',
  'TourRequested',
  'IsDue',
  'Assigned',
  'Withdrew',
  'Attached',
  'Detached',
  'Available',
  'ReactedTo',
  'Reviewed'
]

const schema = {
  type: 'object',
  properties: {
    action: {
      type: 'string',
      enum: Notification.action_enum,
      required: true
    },

    object_class: {
      type: 'string',
      enum: Notification.object_enum,
      required: true
    },

    subject_class: {
      type: 'string',
      enum: Notification.object_enum,
      required: true
    },

    message: {
      type: 'string',
      required: false
    },

    image_url: {
      type: 'string',
      required: false
    },

    notified_user: {
      type: 'string',
      uuid: true,
      required: false
    },

    object: {
      type: 'string',
      uuid: true,
      required: true
    },

    subject: {
      type: 'string',
      uuid: true,
      required: true
    },

    room: {
      type: 'string',
      uuid: true,
      required: false
    },

    auxiliary_object: {
      type: 'string',
      uuid: true,
      required: false
    },

    auxiliary_object_class: {
      type: 'string',
      enum: Notification.object_enum,
      required: false
    },

    auxiliary_subject: {
      type: 'string',
      uuid: true,
      required: false
    },

    auxiliary_subject_class: {
      type: 'string',
      enum: Notification.object_enum,
      required: false
    },

    recommendation: {
      type: 'string',
      uuid: true,
      required: false
    },
    
    title: {
      type: 'string',
      required: false
    }
  }
}

Notification.TRANSPORT_SMS = 'SMS'
Notification.TRANSPORT_EMAIL = 'Email'
Notification.TRANSPORT_PUSH = 'Push'
Notification.TRANSPORT_NONE = 'None'

const validate = validator.bind(null, schema)

/**
 * Actually create a notification record in DB
 * @param {INotification} notification Notification object to be created
 * @param {(err, notification: INotification) => void} cb Callback function that returns created notification
 */
function create (notification, cb) {
  validate(notification, err => {
    if (err)
      return cb(err)

    db.query('notification/insert', [
      notification.action,
      notification.object_class,
      notification.object,
      notification.subject,
      notification.message,
      notification.auxiliary_object_class,
      notification.auxiliary_object,
      notification.recommendation,
      notification.room,
      notification.auxiliary_subject,
      notification.subject_class,
      notification.auxiliary_subject_class,
      notification.extra_object_class,
      notification.extra_subject_class,
      notification.exclude,
      notification.specific,
      notification.title,
      notification.data
    ], function (err, res) {
      if (err)
        return cb(err)

      Notification.get(res.rows[0].id, (err, notification) => {
        if (err)
          return cb(err)

        cb(null, notification)
      })
    })
  })
}

Notification.get = function (id, cb) {
  Notification.getAll([id], (err, notifications) => {
    if(err)
      return cb(err)

    if (notifications.length < 1)
      return cb(Error.ResourceNotFound(`Notification ${id} not found`))

    const notification = notifications[0]

    return cb(null, notification)
  })
}

Notification.getAll = function(notification_ids, cb) {
  const user_id = ObjectUtil.getCurrentUser()

  db.query('notification/get', [notification_ids, user_id], (err, res) => {
    if (err)
      return cb(err)

    const notifications = res.rows

    return cb(null, notifications)
  })
}

Notification.schedule = function (notification, cb) {
  if (!notification.delay)
    notification.delay = 0

  const job = Job.queue.create('create_notification', {
    notification: notification
  })
    .removeOnComplete(true)
    .delay(notification.delay)
    .attempts(1)
    .backoff({type: 'exponential'})

  Context.get('jobs').push(job)
  return cb(null, {})
}

const sms_list = new Set([
  'UserCreatedAlert',
  'UserEditedAlert',
  'UserSharedListing',
  'UserSentMessage',
  'UserInvitedRoom',
  'ListingStatusChanged'
])

const insertForUser = function ({notification, user, room}, cb) {
  const type = Notification.type(notification)

  const sms_enabled = sms_list.has(type)

  const branch = cb => {
    if (!sms_enabled)
      return cb()

    if(!room)
      return cb()

    if (Notification.branchType(notification) === 'Room')
      return Room.getBranchLink({
        user_id: user.id,
        room_id: room.id
      }, cb)

    Notification.getBranchLink(notification, user, room.id, cb)
  }

  const sms = (cb, results) => {
    if (!sms_enabled)
      return cb()

    Notification.formatForDisplay({
      notification: {
        ...notification,
        branch: results.branch
      },
      user,
      room,
      transport: Notification.TRANSPORT_SMS
    }, cb)
  }

  const push = cb => {
    Notification.formatForDisplay({
      notification,
      user,
      room,
      transport: Notification.TRANSPORT_PUSH
    }, cb)
  }

  const normal = cb => {
    Notification.formatForDisplay({
      notification,
      user,
      room,
      transport: Notification.TRANSPORT_NONE
    }, cb)
  }

  const insert = (cb, results) => {
    db.query('notification/insert_user', [
      notification.id,
      user.id,
      results.sms,
      results.push,
      results.normal
    ], cb)
  }

  async.auto({
    branch,
    sms: ['branch', sms],
    push,
    normal,
    insert: ['sms', 'push', 'normal', insert]
  }, (err, results) => {
    if (err)
      return cb(err)

    cb(null, results.insert.rows[0])
  })
}

Notification.create = function (notification, cb) {
  const getUsers = (cb, results) => {
    if (notification.specific) {
      Context.log('>>> (Notification::create::getUsers) Issuing for user:', notification.specific)
      return User.getAll([notification.specific]).nodeify(cb)
    }

    if (notification.room) {
      Context.log('>>> (Notification::create::getUsers) Issuing for room:', notification.room)
      return User.getAll(results.room.users).nodeify(cb)
    }

    return cb(null, [])
  }

  const push = (user, results, cb) => {
    const populated = results.populated

    const airship = _u.clone(populated)
    airship.notification_id = populated.id
    airship.recommendation = populated.recommendation ? populated.recommendation.id : null

    const send = notification_user => {
      if (!airship.message && notification_user)
        airship.message = notification_user.message

      // eslint-disable-next-line
      Socket.send('Notification', user.id, [airship], (err) => {
        // notification.exclude only excludes people from sms/push. Not socket. So we send socket anyways.
        // However, if he is the exclude user, we dont have to bother anymore.
        if (_u.contains(notification.exclude, user.id))
          return cb()

        User.getStatus(user, (err, status) => {
          // If user is Online, we will not send a push notification.
          // We will give user a little while because he probably has got in-app notifications
          // If user doesnt read the notification,
          // in a little while, Notification.sendPushForUnread will pick this up and send push notification
          // However, if he is Offline or Background, we must notify him immediately.

          Context.log('► (Socket-Transport) signaled via socket'.cyan,
            Notification.getFormattedForLogs(notification),
            'for user', user.id,
            'with status', status,
            'on room', '#' + (results.room ? results.room.proposed_title : 'N/A'.red),
            ('(' + (results.room ? results.room.id : 'N/A') + ')').blue)

          if (err || status === User.BACKGROUND || status === User.OFFLINE)
            return Notification.send({
              notification_user,
              user,
              notification: airship,
              room: results.room
            }, cb)

          return cb()
        })
      })
    }

    if (_u.contains(notification.exclude, user.id))
      return send()

    insertForUser({
      notification: populated,
      user,
      room: results.room
    }, (err, notification_user) => {
      if (err)
        return cb(err)

      send(notification_user)
    })
  }

  const pushToAll = (cb, results) => {
    Context.log('>>> (Notification::create::pushToAll) Sending push to users:', results.users.map(u => u.id))
    async.map(results.users, (user, cb) => push(user, results, cb), cb)
  }

  const sendViewMessage = (cb, results) => {
    if (!results.room) {
      Context.log('>>> (Notification::create::sendViewMessage) NOT A ROOM')
      return cb()
    }

    if (notification.action === 'Sent') {
      Context.log('>>> (Notification::create::sendViewMessage) No need to create a NotifcationViewMessage for a Message')
      return cb()
    }

    const message = {}

    message.comment = results.message
    message.notification = results.saved.id
    message.recommendation = notification.recommendation

    Context.log('>>> (Notification::create::sendViewMessage) Issuing NotificationViewMessage for room:', notification.room, 'Message:', JSON.stringify(message))
    return Message.post(notification.room, message, false, cb)
  }

  const done = (err, results) => {
    if (err)
      return cb(err)

    return cb(err, results.saved)
  }

  const getRoom = (notification, cb) => {
    if (!notification.room)
      return cb()

    return Room.get(notification.room, cb)
  }

  const _decorate = async ({notification, room}) => {
    for(const decorator of decorators)
      await decorator({notification, room})
  }

  const decorate = (cb, results) => {
    _decorate({
      notification,
      room: results.room
    }).nodeify(cb)
  }

  async.auto({
    room: cb => getRoom(notification, cb),
    decorate: [
      'room',
      decorate
    ],
    saved: [
      'decorate',
      cb => {
        create(notification, cb)
      }
    ],
    populated: [
      'saved',
      (cb, results) => {
        Orm.populate({
          models: [results.saved],
          enabled: [
            'notification.objects',
            'notification.subjects',
            'notification.auxiliary_object',
            'notification.auxiliary_subject',
          ]
        }).nodeify((err, res) => {
          if (err) {
            return cb(err)
          }

          cb(undefined, res[0])
        })
      }
    ],
    message: [
      'saved',
      'populated',
      'room',
      (cb, results ) => {
        Notification.formatForDisplay({
          notification: results.populated,
          transport: Notification.TRANSPORT_NONE,
          room: results.room
        }, cb)
      }
    ],
    users: [
      'room',
      getUsers
    ],
    send: [
      'saved',
      'populated',
      'users',
      'room',
      pushToAll
    ],
    view_message: [
      'room',
      'saved',
      'message',
      sendViewMessage
    ],
    log: [
      'saved',
      (cb, results) => {
        Context.log('<- (Notification-Driver) Successfully created a notification with id:'.grey, results.saved.id, Notification.getFormattedForLogs(results.saved))
        return cb()
      }
    ]
  }, done)
}

Notification.remove = async function(notification_id) {
  return db.query.promise('notification/delete', [notification_id])
}

Notification.getDeviceTokensForUser = function (user_id, cb) {
  User.get(user_id).nodeify((err, user) => {
    if (err)
      return cb(err)

    db.query('notification/user_channels', [user_id], (err, res) => {
      if (err)
        return cb(err)


      
      const invalidTokens = []
      const tokens = []
      
      async.each(
        res.rows,
        (r, calbk) => {
          urbanAirshipTokenHelper.isTokenValid(r.channel).nodeify((err, result) => {
            // TODO: (JAVAD) => What if other situations happen, e.g. any network error, then shall we delete the token?
            if (err || !result) {
              invalidTokens.push(r.channel)
              return calbk()
            }
            tokens.push(r.channel)
            calbk()
          })
        },
        (err) => {
          if (err) {
            Context.log(err)
          }
          Notification.deleteInvalidTokensForUser(user_id, invalidTokens).nodeify(err => {
            if (err) {
              Context.log('Error deleting invalid tokens form notifications_tokens for user: %s\n', user_id, err)
            }
            return cb(null, tokens)
          })
        }
      )
    })
  })
}

Notification.getForUser = function (user_id, paging, cb) {
  User.get(user_id).nodeify((err, user) => {
    if (err)
      return cb(err)

    db.query('notification/user', [
      user_id,
      paging.type,
      paging.timestamp,
      paging.limit
    ], (err, res) => {
      if (err)
        return cb(err)

      if (res.rows.length < 1)
        return cb(null, [])

      const notification_ids = res.rows.map(r => {
        return r.id
      })

      Notification.getAll(notification_ids, (err, notifications) => {
        if (err)
          return cb(err)

        if (res.rows.length > 0) {
          notifications[0].total = res.rows[0].total
          notifications[0].new = res.rows[0].new
        }

        return cb(null, notifications)
      })
    })
  })
}

Notification.ackRoom = function (user_id, room_id, cb) {
  async.auto({
    user: cb => {
      User.get(user_id).nodeify(cb)
    },
    room: cb => {
      Room.get(room_id, cb)
    },
    ack: [
      'user',
      'room',
      cb => {
        db.query('notification/ack_room', [user_id, room_id], cb)
      }
    ],
    socket: [
      'ack',
      cb => {
        Socket.send('Room.Acknowledged', room_id, [{
          room: room_id,
          user: user_id
        }])

        cb()
      }
    ]
  }, cb)
}

Notification.ackPersonal = function (user_id, notifications, cb) {
  async.auto({
    user: cb => {
      User.get(user_id).nodeify(cb)
    },
    ack: [
      'user',
      cb => {
        db.query('notification/ack_personal', [user_id, notifications], cb)
      }
    ]
    // FIXME: probably needs a socket event
    // socket: [
    //   'ack',
    //   cb => {
    //     Socket.send('Room.Acknowledged', room_id, [{
    //       room: room_id,
    //       user: user_id
    //     }])
    //   }
    // ]
  }, cb)
}

Notification.ackSingle = (user_id, notification_id) => {
  return db.query.promise('notification/ack_single', [user_id, notification_id])
}

Notification.patchSeen = function (user_id, notificationIDs, cb) {
  async.auto({
    user: cb => {
      User.get(user_id).nodeify(cb)
    },
    seen: [
      'user',
      cb => {
        notificationIDs = (notificationIDs && [notificationIDs]) || null 
        db.query('notification/patch_seen', [user_id, notificationIDs], cb)
      }
    ]
  }, cb)
}

Notification.issueForRoom = function (notification, cb) {
  Context.log('>>> (Notification::issueForRoom)', 'Notification Object:', JSON.stringify(notification))
  return Notification.schedule(notification, cb)
}

Notification.issueForRoomExcept = function (notification, exceptions, cb) {
  Context.log('>>> (Notification::issueForRoomExcept)', 'Notification Object:', JSON.stringify(notification), 'Except:', exceptions)
  notification.exclude = exceptions
  return Notification.schedule(notification, cb)
}

Notification.issueForUser = function (notification, user_id, cb) {
  Context.log('>>> (Notification::issueForUser)', 'Notification Object:', JSON.stringify(notification), 'Specific:', user_id)
  notification.specific = user_id
  return Notification.schedule(notification, cb)
}

Notification.issueForUsers = function (notification, users, overrides, cb) {
  Context.log('>>> (Notification::issueForUsers)', 'Notification Object:', JSON.stringify(notification), 'For users:', users)
  async.map(users, (r, cb) => {
    let n = _u.clone(notification)
    n.specific = r
    n = Notification.override(n, overrides, r)

    return Notification.schedule(n, cb)
  }, (err, results) => {
    if (err)
      return cb(err)

    return cb(null, results)
  })
}

Notification.issueForUsersExcept = function (notification, users, user_id, overrides, cb) {
  Context.log('>>> (Notification::issueForUsersExcept)', 'Notification Object:', JSON.stringify(notification), 'For users:', users)
  async.map(users, (r, cb) => {
    if (r === user_id)
      return cb()

    let n = _u.clone(notification)
    n.specific = r
    n = Notification.override(n, overrides, r)

    return Notification.schedule(n, cb)
  }, (err, results) => {
    if (err)
      return cb(err)

    return cb(null, results)
  })
}

Notification.override = function (notification, overrides, entity) {
  if (overrides.subject)
    notification.subject = entity

  if (overrides.object)
    notification.object = entity

  return notification
}

Notification.registerForPush = function (user_id, channel_id, cb) {
  if (!channel_id)
    return cb(Error.Validation('Channel ID cannot be null'))

  async.auto({
    user: cb => {
      return User.get(user_id).nodeify(cb)
    },
    register:
      cb => {
        db.query('notification/register_push', [user_id, channel_id], cb)
      }
  }, (err, results) => {
    if (err)
      return cb(err)

    return cb(null, results.user)
  })
}

Notification.unregisterForPush = function (user_id, channel_id, cb) {
  User.get(user_id).nodeify((err, user) => {
    if (err)
      return cb(err)

    db.query('notification/unregister_push', [user_id, channel_id], (err, res) => {
      if (err)
        return cb(err)

      return cb(null, user)
    })
  })
}

Notification.publicize = function (model) {
  if (model.total) delete model.total
  if (model.exclude) delete model.exclude
  if (model.specific) delete model.specific

  return model
}

const airship = new UrbanAirshipPush(config.airship)

Notification.sendToDevice = function (notification_user, notification, channel_id, user_id, cb) {

  const alert = emojify.replace(notification_user.push_message)

  const pushInfo = {
    audience: {
      ios_channel: channel_id
    },
    notification: {
      ios: {
        alert,
        title: notification.title || '',
        sound: 'default',
        badge: notification.badge_count,
        extra: {
          notification_id: notification.notification_id,
          object_type: notification.object_class,
          recommendation_id: notification.recommendation
        }
      }
    },
    device_types: ['ios']
  }
  
  Context.log('<- (Airship-Transport) Sending payload to', channel_id, ':', pushInfo)

  airship.push.send(pushInfo, (err, data) => {
    if (err) {
      Context.log('<- (Airship-Transport) Error sending push notification to'.red, channel_id, ':', err)
      return cb()
    }

    Context.log('<- (Airship-Transport) Successfully sent a push notification to device'.green, channel_id)

    return cb(null, data)
  })
}

Notification.saveDelivery = function(nid, u, token, type, cb) {
  Notification.get(nid, (err, n) => {
    if(err)
      return cb(err)

    db.query('notification/insert_delivery', [n.id, u, token, type], err => {
      if(err)
        return cb(err)

      if(!n.room)
        return cb()

      Orm.populate({
        models: [n]
      }).nodeify((err, populated) => {
        if (err)
          return cb(err)

        Socket.send('Notification.Delivered', n.room, [{
          notification: populated[0],
          user: u,
          delivery_type: type
        }])

        cb()
      })
    })
  })
}

Notification.getUnreadForRoom = function (user_id, room_id, cb) {
  db.query('notification/unread_room', [user_id, room_id], (err, res) => {
    if (err)
      return cb(err)

    cb(null, res.rows)
  })
}

Notification.getAppBadgeForUser = function (user_id, cb) {
  db.query('notification/app_badge', [user_id], (err, res) => {
    if (err)
      return cb(err)

    cb(null, res.rows[0].app_badge)
  })
}

Notification.sendForUnread = async () => {
  const res = await db.query.promise('notification/unread', [])

  if (res.rows.length < 1)
    return

  const user_ids = res.rows.map(r => r.user)
  const user_objects = await User.getAll(user_ids)
  const users = _.keyBy(user_objects, 'id')

  const notification_ids = res.rows.map(r => r.notification)
  const notification_objects = await promisify(Notification.getAll)(notification_ids)
  const notifications_pop = await Orm.populate({models: notification_objects})
  const notifications = _.keyBy(notifications_pop, 'id')


  const room_ids = notification_objects.map(n => n.room)
  const room_objects = await promisify(Room.getAll)(room_ids)
  const rooms = _.keyBy(room_objects, 'id')


  for(const notification_user of res.rows) {
    const notification = notifications[notification_user.notification]
    const room = rooms[notification.room]
    const user = users[notification_user.user]

    const clone = _u.clone(notification)
    clone.notification_id = notification.id
    clone.recommendation = notification.recommendation ? notification.recommendation.id : null

    await promisify(Notification.send)({
      notification: clone,
      user,
      room,
      notification_user
    })
  }
}

const sendAsPush = function(notification_user, notification, user, room, tokens, delay, cb) {
  async.auto({
    summary: (cb, results) => {
      Notification.getAppBadgeForUser(user.id, (err, count) => {
        if(err)
          return cb(err)

        notification.badge_count = count || 0
        return cb()
      })
    },
    send: [
      'summary',
      (cb, results) => {
        async.map(tokens, (token, cb) => {
          Notification.saveDelivery(notification.notification_id, user.id, token, 'airship', (err) => {
            if (err)
              return cb(err)

            const job = Job.queue.create('airship_transport_send_device', {
              notification_user,
              notification,
              token: token,
              user_id: user.id
            }).removeOnComplete(true)

            if (delay > 0)
              job.delay(delay)

            Context.log('>>> (Notification::send) Job pushed to domain for user:', User.getDisplayName(user), 'on room:', (room ? room.proposed_title : 'N/A'),
              'notification:', Notification.getFormattedForLogs(notification))
            Context.get('jobs').push(job)
            Context.log('⇪ (Airship-Transport) scheduled a notification'.green,
              Notification.getFormattedForLogs(notification),
              'for user', User.getFormattedForLogs(user),
              'on room', (room ? room.proposed_title : 'N/A'.red),
              ('(' + (room ? room.id : 'N/A') + ')').blue,
              ('delay +' + delay).red, 'token:', token.yellow)

            return cb()
          })
        }, cb)
      }
    ]
  }, cb)
}

const sendAsText = function(notification_user, notification, user, room, delay, cb) {
  const saveDelivery = (cb, results) => {
    Notification.saveDelivery(notification.id, user.id, user.phone_number, 'sms', cb)
  }

  const send = (cb, results) => {
    if (!results.from) {
      Context.log('NO PHONE NUMBER ASSOCIATED WITH USER:', user.id, 'ON ROOM:', room)
      return cb()
    }

    // We have not yet implemented this correctly
    if (!room)
      return cb()

    const text = {
      to: user.phone_number,
      from: results.from,
      body: notification_user.sms_message
    }

    if (results.photo)
      text.image = results.photo

    SMS.send(text, cb)
  }

  const resolvePhoneNumber = (cb, results) => {
    if (!room)
      return cb(null, config.twilio.from)

    Room.resolvePhoneForSeamless(user.id, room.id, cb)
  }

  const report = (err) => {
    if (!err)
      return cb()

    if (err.http === 501)
      return cb()

    return cb(err)
  }

  const resolvePhoto = (cb, results) => {
    if (notification.notification_type === 'UserSentMessage') {
      const message = notification.objects[0]

      if (!message || !message.attachments || !(message.attachments.length > 0))
        return cb()

      const attachment = message.attachments[0]
      return cb(null, attachment.preview_url)
    }

    if (notification.notification_type === 'UserSharedListing') {
      return cb(null, notification.objects[0].cover_image_url)
    }

    cb()
  }

  async.auto({
    from: resolvePhoneNumber,
    delivery: saveDelivery,
    photo: resolvePhoto,
    send: ['from', 'delivery', 'photo', send]
  }, report)
}

Notification.send = function ({
  notification,
  user,
  notification_user,
  room
}, cb) {
  const room_id = room ? room.id : null
  const send = (cb, results) => {
    let delay = 0

    if (!Notification.isSystemGenerated(notification))
      delay = 0
    else
      delay = (results.user_ok_for_push < 0) ? 0 : results.user_ok_for_push

    if (!results.room_ok_for_push && Notification.isSystemGenerated(notification))
      return cb()

    if (results.transport === Notification.TRANSPORT_PUSH)
      return sendAsPush(notification_user, notification, user, room, results.tokens, delay, cb)

    else if (results.transport === Notification.TRANSPORT_SMS)
      return sendAsText(notification_user, notification, user, room, delay, cb)

    cb()
  }

  const roomOkForPush = (user_id, room_id, cb) => {
    if (!room_id)
      return cb(null, true)

    return Room.isPushOK(user_id, room_id, cb)
  }

  const transport = (cb, results) => {
    if (!_u.isEmpty(results.tokens))
      return cb(null, Notification.TRANSPORT_PUSH)

    if (_u.isEmpty(results.tokens) && User.shouldTrySMS(user))
      return cb(null, Notification.TRANSPORT_SMS)

    return cb(null, Notification.TRANSPORT_NONE)
  }

  async.auto({
    tokens: Notification.getDeviceTokensForUser.bind(null, user.id),
    user_ok_for_push: User.isPushOK.bind(null, user.id),
    room_ok_for_push: (cb, results) => roomOkForPush(user.id, room_id, cb),
    transport: ['tokens', transport],
    send: [
      'tokens',
      'user_ok_for_push',
      'room_ok_for_push',
      'transport',
      send
    ]
  }, cb)
}

Notification.getFormattedForLogs = function (notification) {
  const subject_class = notification.subject_class
  const action = notification.action
  const object_class = notification.object_class

  return ((subject_class ? subject_class.yellow : 'None') + '::' +
         (action ? action.yellow : 'None') + '::' +
         (object_class ? object_class.yellow : 'None'))
}

Notification.isSystemGenerated = function (notification) {
  if (notification.action === 'BecameAvailable' ||
      notification.action === 'PriceDropped' ||
      notification.action === 'Available' ||
      notification.action === 'StatusChanged')
    return true

  return false
}

Notification.getBranchLink = function(notification, user, room_id, cb) {
  const type = Notification.type(notification)

  if(type !== 'UserCreatedAlert' && type !== 'UserSharedListing')
    return cb() // Only these three notifications have specific branch links for now

  const b = {}

  if(type === 'UserSharedListing') {
    b.listing = notification.object
    b.action = 'RedirectToListing'
  } else if (type === 'UserCreatedAlert') {
    b.alert = notification.object
    b.action = 'RedirectToAlert'
  }

  const getBrand = cb => {
    if (!user.brand)
      return cb()

    Brand.get(user.brand).nodeify(cb)
  }

  getBrand((err, brand) => {
    if (err)
      return cb(err)

    const url = Url.web({
      uri: '/branch',
      brand
    })

    b.room = room_id || notification.room || undefined
    b.sending_user = notification.subject
    b.receiving_user = user.id
    b.token = user.secondary_password
    b.email = user.email

    if (user.phone_number)
      b.phone_number = user.phone_number

    b['$desktop_url'] = url
    b['$fallback_url'] = url

    Branch.createURL(b).nodeify(cb)
  })
}

Notification.formatForDisplay = function({notification, user, room, transport}, cb) {
  notification.target_user = user
  const template = __dirname + '/../../templates/notifications/' +
                   snake(notification.object_class) + '/' +
                   Notification.templateFile(notification) + '.tmpl'

  const data = _u.clone(notification)
  data.target_user = user
  data.room = room
  data.transport = transport

  render(template, data, (err, message) => {
    if(err)
      return cb(err)

    cb(null, message
      .replace(/\n/g, '')
      .replace(/<br>/ig, '\n')
      .trim()
    )
  })
}

Notification.type = n => n.subject_class + n.action + n.object_class
Notification.branchType = n => (Notification.type(n) === 'UserCreatedAlert' || Notification.type(n) === 'UserSharedListing') ? 'Resource' : 'Room'
Notification.templateFile = n => snake(Notification.type(n))

Notification.deleteInvalidTokensForUser = async function (userID, tokenList) {
  return db.query.promise('notification/tokens/delete', [userID, tokenList])
}

Notification.associations = {
  recommendations: {
    collection: true,
    model: 'Recommendation',
    ids: (n, cb) => {
      if (n.recommendation)
        return cb(null, [n.recommendation])

      return cb()
    }
  },
  objects: {
    collection: true,
    model: (n, cb) => cb(null, n.object_class),
    ids: (n, cb) => {
      if (n.object_class === 'Room')
        return cb()

      if (n.object)
        return cb(null, [n.object])
      return cb()
    }
  },
  subjects: {
    collection: true,
    model: (n, cb) => cb(null, n.subject_class),
    ids: (n, cb) => {
      if (n.subject_class === 'Room' || n.subject_class === 'Message')
        return cb()

      if (n.subject)
        return cb(null, [n.subject])

      return cb()
    }
  },
  auxiliary_object: {
    optional: true,
    model: (n, cb) => cb(null, n.auxiliary_object_class),
    id: (n, cb) => {
      if (n.auxiliary_object_class === 'Room' || n.auxiliary_object_class === 'Message')
        return cb()

      return cb(null, n.auxiliary_object)
    }
  },
  auxiliary_subject: {
    optional: true,
    model: (n, cb) => cb(null, n.auxiliary_subject_class),
    id: (n, cb) => {
      if (n.auxiliary_subject_class === 'Room' || n.auxiliary_subject_class === 'Message')
        return cb()

      return cb(null, n.auxiliary_subject)
    }
  }
}

module.exports = Notification
