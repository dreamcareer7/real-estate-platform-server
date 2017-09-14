const validator = require('../utils/validator.js')
const expect = validator.expect
const _u = require('lodash')
const db = require('../utils/db.js')
const async = require('async')
const pascal = require('to-pascal-case')
const snake = require('to-snake-case')

Activity = {}

Orm.register('activity', 'Activity')

const schema = {
  type: 'object',
  properties: {
    action: {
      type: 'string',
      required: true,
      enum: [
        'UserViewedAlert',
        'UserViewedListing',
        'UserFavoritedListing',
        'UserSharedListing',
        'UserCreatedAlert',
        'UserCommentedRoom',
        'UserOpenedIOSApp',
        'UserCalledContact',
        'UserCreatedContact',
        'UserSignedUp',
        'UserInvited',

        'UserUpdatedSubmission',
        'UserUpdatedReview',
        'UserViewedFile',
        'UserEmailedFile',
        'UserPrintedFile',
        'UserCreatedEnvelopeForSubmission',
        'UserReactedToEnvelopeForSubmission'
      ]
    }
  }
}

const validate = validator.bind(null, schema)

Activity.get = function(id, cb) {
  Activity.getAll([id], (err, activities) => {
    if(err)
      return cb(err)

    if(activities.length < 1)
      return cb(Error.ResourceNotFound(`Activity ${id} not found`))

    const activity = activities[0]

    return cb(null, activity)
  })
}

Activity.getAll = function(activity_ids, cb) {
  db.query('activity/get', [activity_ids], (err, res) => {
    if(err)
      return cb(err)

    const activities = res.rows

    return cb(null, activities)
  })
}

Activity.userTimeline = function(user_id, paging, cb) {
  expect(user_id).to.be.uuid

  async.auto({
    get: cb => {
      User.get(user_id, cb)
    },
    refs: [
      'get',
      (cb, results) => {
        const contact_refs = results.get.contacts || []
        let refs = [user_id].concat(contact_refs)
        refs = _u.unique(refs)

        return cb(null, refs)
      }
    ],
    timeline: [
      'get',
      'refs',
      (cb, results) => {
        db.query('activity/timeline', [
          results.refs,
          paging.type,
          paging.timestamp,
          paging.limit
        ], (err, results) => {
          if(err)
            return cb(err)

          const activity_ids = results.rows.map(r => r.id)

          Activity.getAll(activity_ids, (err, activities) => {
            if(err)
              return cb(err)

            if(results.rows.length > 0)
              activities[0].total = results.rows[0].total

            return cb(null, activities)
          })
        })

      }
    ]
  }, (err, results) => {
    if(err)
      return cb(err)

    return cb(null, results.timeline)
  })
}

Activity.contactTimeline = function(contact_id, paging, cb) {
  expect(contact_id).to.be.uuid

  async.auto({
    get: cb => {
      Contact.get(contact_id, cb)
    },
    refs: [
      'get',
      (cb, results) => {
        const user_refs = results.get.users
        const contact_refs = results.get.sub_contacts.map(r => {
          return r.id
        })

        let refs = [contact_id].concat(user_refs).concat(contact_refs)
        refs = _u.unique(refs)

        return cb(null, refs)
      }
    ],
    timeline: [
      'get',
      'refs',
      (cb, results) => {
        db.query('activity/timeline', [
          results.refs,
          paging.type,
          paging.timestamp,
          paging.limit
        ], (err, results) => {
          if(err)
            return cb(err)


          const activity_ids = results.rows.map(r => r.id)

          Activity.getAll(activity_ids, (err, activities) => {
            if(err)
              return cb(err)

            if(results.rows.length > 0)
              activities[0].total = results.rows[0].total

            return cb(null, activities)
          })
        })
      }
    ]
  }, (err, results) => {
    if(err)
      return cb(err)

    return cb(null, results.timeline)
  })
}

Activity.parse = function (activity, cb) {
  expect(activity).to.be.a('object')
  expect(activity.action).to.be.a('string')
  expect(activity.object_class).to.be.a('string')

  const activity_class = pascal(activity.object_class)
  const activity_data = activity.object

  expect(activity_class).to.be.a('string')

  async.auto({
    model: cb => {
      const model = Orm.getModelFromType(activity.object_class)
      if(!model)
        return cb()

      expect(activity_data).to.be.uuid
      Orm.getAll(model, [activity_data]).nodeify((err, results) => {
        if(err)
          return cb(err)

        if (results.length < 1)
          return cb(Error.ResourceNotFound(`${activity_class} ${activity_data} not found`))

        return cb(null, {
          payload: results[0],
          type: model
        })
      })
    },
    standalone: cb => {
      if(Orm.getModelFromType(activity.object_class))
        return cb()

      expect(activity_data).to.be.a('object')
      expect(activity_data.type).to.be.a('string')

      const def = validator.types.activity[activity_data.type]

      expect(def).to.be.a('object')

      validator(def, activity_data, err => {
        if(err)
          return cb(err)

        return cb(null, {
          payload: activity_data,
          type: null
        })
      })
    }
  }, (err, results) => {
    if(err)
      return cb(err)

    const data = results.model || results.standalone || null
    if(!data)
      return cb(Error.Validation('Activity must either be a referenced model or a JSON object'))

    return cb(null, [data.payload, data.type, activity.action])
  })
}

Activity.add = function(reference_id, reference_type, activity, cb) {
  expect(activity).to.be.a('object')

  async.auto({
    validate: cb => {
      validate(activity, cb)
    },
    reference_check: [
      'validate',
      cb => {
        if (reference_type === 'Contact')
          return Contact.get(reference_id, cb)

        if (reference_type === 'User')
          return User.get(reference_id, cb)

        return cb(Error.Validation('Activity reference type must be either User or Contact'))
      }
    ],
    parse: [
      'validate',
      'reference_check',
      cb => {
        return Activity.parse(activity, cb)
      }
    ],
    record: [
      'validate',
      'reference_check',
      'parse',
      (cb, results) => {
        const [object, object_class, action] = results.parse

        db.query('activity/record', [
          reference_id,
          reference_type,
          object_class ? object.id : null,
          object_class,
          object_class ? null : object,
          action
        ], (err, results) => {
          if(err)
            return cb(err)

          return cb(null, results.rows[0].id)
        })
      }
    ],
    get: [
      'parse',
      'record',
      (cb, results) => {
        Activity.get(results.record, cb)
      }
    ]
  }, (err, results) => {
    if(err)
      return cb(err)

    return cb(null, results.get)
  })
}

Activity.postToRoom = function({room_id, activity, user_id, push = false}, cb) {
  if (!user_id)
    user_id = ObjectUtil.getCurrentUser()

  if (!user_id)
    return cb(Error.Generic('User is not defined when trying to add an acitivity to a room'))

  async.auto({
    room: cb => {
      Room.get(room_id, cb)
    },
    user: cb => {
      User.get(user_id, cb)
    },
    create: [
      'room',
      (cb, results) => {
        Activity.add(user_id, 'User', activity, cb)
      }
    ],
    parse: [
      'room',
      'user',
      'create',
      (cb, results) => {
        return Activity.parse(activity, (err, p) => {
          if(err)
            return cb(err)

          const [object, ,] = p
          const a = _u.cloneDeep(results.create)
          a.object = object

          return cb(null, a)
        })
      }
    ],
    message: [
      'room',
      'user',
      'create',
      'parse',
      (cb, results) => {
        Activity.formatForDisplay(results.parse, results.user, cb)
      }
    ],
    post: [
      'create',
      'message',
      (cb, results) => {
        const message = {
          comment: results.message,
          activity: results.create.id,
          author: user_id
        }

        Message.post(room_id, message, push, cb)
      }
    ]
  }, (err, results) => {
    if(err)
      return cb(err)

    return cb(null, results.create)
  })
}

Activity.templateFile = a => snake(a.action)

Activity.formatForDisplay = function(activity, data, cb) {
  const c = activity.object_class ? activity.object_class : activity.object_sa.type
  const a = _u.cloneDeep(activity)

  Activity.publicize(a)
  a.data = data

  const template = __dirname + '/../templates/activities/' +
                   snake(c) + '/' +
                   Activity.templateFile(a) + '.tmpl'

  Template.render(template, a, (err, message) => {
    if(err)
      return cb(err)

    return cb(null, message.replace(/\n/g, '').trim())
  })
}

Activity.associations = {
  object: {
    optional: true,
    model: (a, cb) => cb(null, a.object_class),
    id: (a, cb) => cb(null, a.object)
  }
}

Activity.publicize = function(model) {
  if(model.object_sa) {
    model.object = model.object_sa
  }

  delete model.object_class
  delete model.object_sa

  return model
}
