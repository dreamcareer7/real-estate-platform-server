const async = require('async')
const validator = require('../utils/validator.js')
const expect = require('../utils/validator.js').expect
const am = require('../utils/async_middleware.js')
const moment = require('moment-timezone')
const promisify = require('../utils/promisify')

const upgrade_schema = {
  type: 'object',
  properties: {
    agent: {
      type: 'string',
      uuid: true,
      required: true
    },
    secret: {
      type: 'string',
      required: true
    }
  }
}

/**
 * Creates a `User` object
 * @name createUser
 * @memberof controller/user
 * @instance
 * @function
 * @public
 * @summary POST /users
 * @param {request} req - request object
 * @param {response} res - response object
 */
function createUser (req, res) {
  const user = req.body

  expect(user.email).to.be.a('string').and.to.have.length.above('5')

  User.getByEmail(user.email, (err, current) => {
    if (err)
      return res.error(err)

    if (!current) {
      User.create(user, function (err, id) {
        if (err)
          return res.error(err)

        User.get(id, function (err, user) {
          if (err)
            return res.error(err)

          res.status(201)
          return res.model(user)
        })
      })
    } else if (current.is_shadow) {
      async.auto({
        agent: cb => {
          if (!user.actions)
            return cb()

          async.map(user.actions, (r, cb) => {
            if (!r.agent)
              return cb()

            return cb(null, r.agent)
          }, (err, results) => {
            if (err)
              return cb(err)

            return cb(null, results[0] || null)
          })
        },
        send_activation: [
          'agent',
          (cb, results) => {
            let context = false

            if (results.agent) {
              context = {
                agent: results.agent
              }
            }

            return User.sendActivation(current.id, context, cb)
          }
        ]
      }, (err, results) => {
        if (err)
          return res.error(err)

        res.status(202)
        return res.json(
          {
            data: {
              type: 'user_reference',
              id: current.id,
              email: current.email,
              created_at: current.created_at,
              updated_at: current.updated_at,
              email_confirmed: current.email_confirmed,
              phone_confirmed: current.phone_confirmed,
              is_shadow: current.is_shadow,
              fake_email: current.fake_email
            },
            code: 'OK'
          }
        )
      })
    } else {
      return res.error(Error.Conflict({
        details: {
          attributes: {
            email: 'Provided email already exists'
          }
        },
        slack: false,
        skip_trace_log: true,
      }))
    }
  })
}

/**
 * Retrieves a `User` object
 * @name getUser
 * @memberof controller/user
 * @instance
 * @function
 * @public
 * @summary GET /users/:id
 * @param {request} req - request object
 * @param {response} res - response object
 */
function getUser (req, res) {
  const user_id = req.params.id

  expect(user_id).to.be.uuid

  User.get(user_id, function (err, user) {
    if (err)
      return res.error(err)

    res.model(user)
  })
}

function getSelf (req, res) {
  res.model(req.user)
}

/**
 * Patches a `User` object using partial parameters
 * @name patchUser
 * @memberof controller/user
 * @instance
 * @function
 * @public
 * @summary PATCH /users/:id
 * @param {request} req - request object
 * @param {response} res - response object
 */
function patchUser (req, res) {
  const user_id = req.user.id

  User.get(user_id, function (err, user) {
    if (err)
      return res.error(err)

    const data = user
    for (const i in req.body)
      data[i] = req.body[i]

    // Amanda considers null !== undefined
    // That means while phone_number is optional, providing it as null would throw an error
    // Next two lines mean phone_number could be supplied as null and would be treated as undefined
    if (data.phone_number === null)
      delete data.phone_number

    User.patch(user_id, data, function (err) {
      if (err)
        return res.error(err)

      User.get(user_id, function (err, user) {
        if (err)
          return res.error(err)

        res.model(user)
      })
    })
  })
}

/**
 * Deletes a `User` object
 * @name deleteUser
 * @memberof controller/user
 * @instance
 * @function
 * @public
 * @summary DELETE /users/:id
 * @param {request} req - request object
 * @param {response} res - response object
 */
function deleteUser (req, res) {
  const user_id = req.user.id

  User.get(user_id, function (err, user) {
    if (err)
      return res.error(err)

    User.delete(user_id, function (err) {
      if (err) {
        return res.error(err)
      }

      res.status(204)
      res.end()
    })
  })
}

/**
 * Changes `User` password
 * @name changePassword
 * @memberof controller/user
 * @instance
 * @function
 * @public
 * @summary PATCH /users/:id/password
 * @param {request} req - request object
 * @param {response} res - response object
 */
function changePassword (req, res) {
  const user_id = req.user.id
  const old_password = req.body.old_password || ''
  const new_password = req.body.new_password || ''

  expect(new_password).to.be.a('string').and.to.have.length.above('5')

  User.get(user_id, function (err, user) {
    if (err)
      return res.error(err)

    User.changePassword(user_id, old_password, new_password, function (err, user) {
      if (err)
        return res.error(err)

      res.status(200)
      res.end()
    })
  })
}

/**
 * Sets an `Address` for a `User`
 * @name setAddress
 * @memberof controller/user
 * @instance
 * @function
 * @public
 * @summary PATCH /users/:id/address
 * @param {request} req - request object
 * @param {response} res - response object
 */
function setAddress (req, res) {
  const user_id = req.user.id
  const address = req.body

  User.get(user_id, function (err, user) {
    if (err)
      return res.error(err)

    User.setAddress(user_id, address, function (err, address_id) {
      if (err)
        return res.error(err)

      User.get(user_id, function (err, user) {
        if (err)
          return res.error(err)

        res.status(200)
        res.model(user)
      })
    })
  })
}

/**
 * Unsets the `Address` for a `User`
 * @name deleteAddress
 * @memberof controller/user
 * @instance
 * @function
 * @public
 * @summary DELETE /users/:id/address
 * @param {request} req - request object
 * @param {response} res - response object
 */
function deleteAddress(req, res) {
  const user_id = req.user.id

  User.get(user_id, (err, user) => {
    if (err)
      return res.error(err)

    User.unsetAddress(user_id, (err) => {
      if (err)
        return res.error(err)

      User.get(user_id, (err, user) => {
        if(err)
          return res.error(err)

        res.status(200)
        res.model(user)
      })
    })
  })
}

function InitiatePasswordReset (req, res) {
  const email = req.body.email

  expect(email).to.be.a('string')

  User.initiatePasswordReset(email, err => {
    if (err)
      return res.error(err)

    res.status(204)
    return res.end()
  })
}

function passwordReset (req, res) {
  const email = req.body.email
  const phone_number = req.body.phone_number
  const token = req.body.token
  const shadow_token = req.body.shadow_token
  const password = req.body.password
  const agent = req.body.agent

  const upgrade = agent && shadow_token

  expect(password).to.be.a('string')

  async.auto({
    user_by_email: (cb, results) => {
      if(!email)
        return cb()

      User.getByEmail(email, cb)
    },
    user_by_phone: (cb, results) => {
      if(!phone_number)
        return cb()

      User.getByPhoneNumber(phone_number, cb)
    },
    user: [
      'user_by_email',
      'user_by_phone',
      (cb, results) => {
        if ((!(email || phone_number)) || (email && phone_number))
          return cb(Error.Validation('You must provide either an email address or a phone number'))

        if (email && !results.user_by_email)
          return cb(Error.ResourceNotFound(`User with email ${email} not found`))

        if (phone_number && !results.user_by_phone)
          return cb(Error.ResourceNotFound(`User with phone number ${phone_number} not found`))

        if (email && results.user_by_email.email && results.user_by_email.fake_email)
          return cb(Error.NotAcceptable('You may only reset a phone shadow user by providing a phone number'))

        return cb(null, results.user_by_email || results.user_by_phone)
      }
    ],
    reset_normal: (cb, results) => {
      if (!(token && email))
        return cb()

      User.resetPassword(email, token, password, cb)
    },
    reset_shadow: [
      'user_by_email',
      'user_by_phone',
      'user',
      (cb, results) => {
        if (!shadow_token)
          return cb()

        const data = {
          token: shadow_token,
          password: password
        }

        if(results.user_by_email)
          data.email = email

        if(results.user_by_phone)
          data.phone_number = phone_number

        User.resetPasswordByShadowToken(data, cb)
      }
    ],
    upgrade: [
      'user',
      'reset_normal',
      'reset_shadow',
      (cb, results) => {
        if (!upgrade)
          return cb()

        return User.upgradeToAgentWithToken(results.user.id, shadow_token, agent, cb)
      }
    ],
    get: [
      'user',
      'reset_normal',
      'reset_shadow',
      'upgrade',
      (cb, results) => {
        User.get(results.user.id, cb)
      }
    ]
  }, (err, results) => {
    if(err)
      return res.error(err)

    return res.model(results.get)
  })
}

async function patchUserTimeZone (req, res) {
  const user_id = req.user.id
  const timezone = req.body.time_zone

  if (!moment.tz.zone(timezone)) {
    throw Error.Validation(`Timezone ${timezone} is not valid.`)
  }

  await User.patchTimeZone(user_id, timezone)

  const updated = await promisify(User.get)(user_id)
  res.model(updated)
}

function patchUserAvatars (req, res, type) {
  const attach = cb => {
    AttachedFile.saveFromRequest({
      path: req.user.id,
      req,
      relations: [
        {
          role: 'User',
          id: req.user.id
        }
      ],
      public: true
    }, cb)
  }

  const patch = (file, cb) => {
    User.patchAvatars(req.user.id, type, file.url, cb)
  }

  const get = (patched, cb) => User.get(req.user.id, cb)

  const done = (err, user) => {
    if (err)
      return res.error(err)

    return res.model(user)
  }

  async.waterfall([
    attach,
    patch,
    get,
  ], done)
}

function patchUserProfileImage (req, res) {
  return patchUserAvatars(req, res, 'Profile')
}

function patchUserCoverImage (req, res) {
  return patchUserAvatars(req, res, 'Cover')
}

function upgrade (req, res) {
  const user_id = req.user.id
  const agent_id = req.body.agent
  const secret = req.body.secret

  async.auto({
    validate: cb => {
      return validator(upgrade_schema, req.body, cb)
    },
    audit: [
      'validate',
      cb => {
        Agent.auditSecret(agent_id, secret, cb)
      }
    ],
    upgrade: [
      'validate',
      'audit',
      cb => {
        User.upgradeToAgent(user_id, agent_id, cb)
      }
    ],
    user: [
      'validate',
      'audit',
      'upgrade',
      cb => {
        User.get(user_id, cb)
      }
    ]
  }, (err, results) => {
    if (err)
      return res.error(err)

    return res.model(results.user)
  })
}

const getRoles = async (req, res) => {
  const roles = await UserRole.getForUser(req.user.id)
  res.collection(roles)
}

const router = function (app) {
  const auth = app.auth.bearer.middleware

  app.patch('/users/self/profile_image_url', auth, patchUserProfileImage)
  app.patch('/users/self/cover_image_url', auth, patchUserCoverImage)
  app.patch('/users/self/timezone', auth, am(patchUserTimeZone))
  app.patch('/users/self/upgrade', auth, upgrade)
  app.post('/users', app.auth.clientPassword(createUser))
  app.patch('/users/password', passwordReset)
  app.post('/users/reset_password', InitiatePasswordReset)
  app.get('/users/self', auth, getSelf)
  app.get('/users/:id', getUser)
  app.put('/users/self', auth, patchUser)
  app.patch('/users/self/password', auth, changePassword)
  app.delete('/users/self', auth, deleteUser)
  app.put('/users/self/address', auth, setAddress)
  app.delete('/users/self/address', auth, deleteAddress)
  app.get('/users/self/roles', auth, am(getRoles))
}

module.exports = router
