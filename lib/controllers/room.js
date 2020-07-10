/**
 * @namespace controller/room
 */

const async = require('async')
const validator = require('../utils/validator.js')
const expect = validator.expect
const _u = require('underscore')
const AttachedFile = require('../models/AttachedFile')
const ObjectUtil = require('../models/ObjectUtil')
const Room = require('../models/Room')
const User = require('../models/User/create')


const room_type_schema = {
  type: 'array',
  required: false,
  uniqueItems: true,
  minItems: 0,
  items: {
    enum: ['Group', 'Direct', 'Personal', 'ListingBoard']
  }
}

/**
 * Retreives a `Room` object
 * @name getRoom
 * @memberof controller/room
 * @instance
 * @function
 * @public
 * @summary GET /rooms/:id
 */
function getRoom (req, res) {
  const room_id = req.params.id
  const user_id = req.user.id

  expect(req.params.id).to.be.uuid

  Room.get(room_id, (err, room) => {
    if (err)
      return res.error(err)

    if (!Room.belongs(room.users, user_id))
      return res.error(Error.Forbidden('You do not have access to this room'))

    res.model(room)
  })
}

/**
 * Creates a `Room` object
 * @name createRoom
 * @memberof controller/room
 * @instance
 * @function
 * @public
 * @summary POST /rooms
 */
function createRoom (req, res) {
  const room = req.body
  room.owner = req.user.id

  Room.compose(room, (err, room_id) => {
    if (err)
      return res.error(err)

    Room.get(room_id, (err, room) => {
      if (err)
        return res.error(err)

      return res.model(room)
    })
  })
}

/**
 * Patches a `Room` object using partial parameters
 * @name patchRoom
 * @memberof controller/room
 * @instance
 * @function
 * @public
 * @summary PATCH /rooms/:id
 */
function patchRoom (req, res) {
  const room_id = req.params.id
  const data = req.body

  expect(room_id).to.be.uuid

  Room.get(room_id, (err, room) => {
    if (err)
      return res.error(err)

    Room.patch(room_id, data, (err, room) => {
      if (err)
        return res.error(err)

      return res.model(room)
    })
  })
}

/**
 * Retrieves all `Room` objects the specified user is a member of
 * @name getUserRooms
 * @memberof controller/room
 * @instance
 * @function
 * @public
 * @summary GET /rooms
 */
function getUserRooms (req, res) {
  const paging = {}
  const room_type = req.query.room_types || []

  expect(room_type).to.be.a('array')

  validator(room_type_schema, room_type, err => {
    if (err)
      return res.error(err)

    req.pagination(paging)
    paging.room_type = room_type

    Room.getUserRooms(req.user.id, paging, (err, rooms) => {
      if (err)
        return res.error(err)

      return res.collection(rooms)
    })
  })
}

/**
 * Adds a `User` to a `Room`
 * @name addUser
 * @memberof controller/room
 * @instance
 * @function
 * @public
 * @summary POST /rooms/:id/users
 */
function addUsers (req, res) {
  const users = req.body.users || []
  const emails = req.body.emails || []
  const phone_numbers = req.body.phone_numbers || []
  const room_id = req.params.id
  const user_id = req.user.id

  expect(room_id).to.be.uuid

  if (_u.isEmpty(users) && _u.isEmpty(emails) && _u.isEmpty(phone_numbers))
    return res.error(Error.Validation('You must supply either an array of user ids, emails or phone numbers'))

  if (!Array.isArray(users))
    return res.error(Error.Validation('`user` property must be an array of user ids'))

  if (!Array.isArray(emails))
    return res.error(Error.Validation('`emails` property must be an array of email addresses'))

  if (!Array.isArray(phone_numbers))
    return res.error(Error.Validation('`phone_numbers` property must be an array of phone numbers'))

  async.auto({
    bulk: cb => {
      User.getOrCreateBulk(user_id, users, emails, phone_numbers, cb)
    },
    add: [
      'bulk',
      (cb, results) => {
        async.map(results.bulk, (r, cb) => {
          Room.addUser({
            inviting_id: user_id,
            user_id: r,
            room_id: room_id
          }, cb)
        }, cb)
      }
    ],
    room: [
      'bulk',
      'add',
      cb => {
        Room.get(room_id, cb)
      }
    ]
  }, (err, results) => {
    if(err)
      return res.error(err)

    return res.model(results.room)
  })
}

function search (req, res) {
  const user_id = req.user.id
  const room_types = req.query.room_types || [ 'Group' ]
  const similarity = req.query.similarity || 0.05
  const limit = req.query.limit || 5
  expect(limit).not.to.be.NaN
  expect(room_types).to.be.an('array')
  validator(room_type_schema, room_types, err => {
    if (err)
      return res.error(err)

    if (req.query.q) {
      const terms = req.query.q
      expect(terms).to.be.an('array')
      const similar = (req.query.similar === 'true')
      if (similar) {
        Room.stringSearchFuzzy(user_id, terms, limit, similarity, room_types, (err, rooms) => {
          if (err)
            return res.error(err)

          return res.collection(rooms)
        })
      } else {
        Room.stringSearch(user_id, terms, limit, room_types, (err, rooms) => {
          if (err)
            return res.error(err)

          return res.collection(rooms)
        })
      }
    } else if (req.query.users || req.query.emails || req.query.phone_numbers) {
      const users = req.query.users || []
      const emails = req.query.emails || []
      let phones = req.query.phone_numbers || []

      phones = phones.map(ObjectUtil.formatPhoneNumberForDialing)

      Room.searchForParties({user_id, users, emails, phones, room_types}, (err, results) => {
        if (err)
          return res.error(err)

        return res.collection(results)
      })
    } else {
      return res.error(Error.Validation('Malformed search query'))
    }
  })
}

/**
 * Removes a `User` from a `Room`
 * @name removeUser
 * @memberof controller/room
 * @instance
 * @function
 * @public
 * @summary DELETE /rooms/:id/users/:id
 */
function removeUser (req, res) {
  const room_id = req.params.rid
  const user_id = req.params.id

  expect(room_id).to.be.uuid
  expect(user_id).to.be.uuid

  Room.removeUser(room_id, user_id, err => {
    if (err)
      return res.error(err)

    res.status(204)
    return res.end()
  })
}

function archiveRoom (req, res) {
  const room_id = req.params.id
  const user_id = req.user.id

  expect(room_id).to.be.uuid

  Room.archive(room_id, user_id, err => {
    if(err)
      return res.error(err)

    res.status(204)
    return res.end()
  })
}

function attach(req, res) {
  const room_id = req.params.id

  AttachedFile.saveFromRequest({
    path: req.params.id,
    req,
    relations: [
      {
        role: 'Room',
        role_id: room_id
      }
    ],
    public: false
  }, (err, {file}) => {
    if (err)
      return res.error(err)

    res.model(file)
  })
}

const router = (app) => {
  const b = app.auth.bearer

  app.get('/rooms/search', b(search))
  app.post('/rooms/:id/attachments', b(attach))
  app.get('/rooms/:id', b(getRoom))
  app.get('/rooms', b(getUserRooms))
  app.post('/rooms/:id/users', b(addUsers))
  app.post('/rooms', b(createRoom))
  app.put('/rooms/:id', b(patchRoom))
  app.delete('/rooms/:rid/users/:id', b(removeUser))
  app.delete('/rooms/:id', b(archiveRoom))
}

module.exports = router
