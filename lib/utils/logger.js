const config = require('../config.js')
const uuid = require('uuid')
const redis = require('redis')
const db = require('./db.js')
const Context = require('../models/Context')
const Metric = require('../models/Metric')
const Crypto = require('../models/Crypto')

async function logRequest () {
  const res = this
  const req = this.req
  let statusColor

  const [seconds, nanoseconds] = process.hrtime(req.start)

  const elapsed = Math.round((seconds * 1000) + (nanoseconds * 1e-6))

  Metric.set('request.elapsed', elapsed)

  const queries = Context.get('query_count') || 0
  const query_elapsed = Context.get('query_elapsed') || 0

  if (queries > 0) {
    Metric.set('request.queries', queries)
    Metric.set('request.query_elapsed', query_elapsed)
  }

  if (res.statusCode < 400)
    statusColor = 'green'
  else if (res.statusCode < 500)
    statusColor = 'yellow'
  else
    statusColor = 'red'

  let name
  if (req.user && req.user.type === 'user') // It could also be a session response on ClientPassword requests
    name = '(' + req.user.email + ')'
  else
    name = '(Guest)'

  let userColor
  if (!req.user)
    userColor = 'white'
  else if (req.user && req.user.email_confirmed)
    userColor = 'green'
  else
    userColor = 'red'

  const agent = req.client ? req.client.name + ' ' + req.client.version : ''

  let text = ''
  text += 'Σ' + (queries) + ' (' + query_elapsed + 'ms)\t'
  text += ('HTTP ' + res.statusCode)[statusColor]
  text += (' ' + req.method + ' ' + req.url + '  ')[statusColor]
  text += name[userColor] + ' ' + (agent + ' ')

  Context.log(text)

  const client_id = req.client ? req.client.id : null
  const user_id = req.user && req.user.type === 'user' ? req.user.id : null

  db.conn((err, client, done) => {
    if (err)
      return Context.log('Cannot get connection to save request', err)

    db.query('requests/insert', [
      req.rechat_id,
      req.method,
      req.originalUrl,
      elapsed,
      query_elapsed,
      res.statusCode,
      client_id,
      user_id,
      queries,
      req.route ? req.route.path : null
    ], client, err => {
      done()

      if (err)
        return Context.log('Cannot save log', err)
    })
  })
}

const redisClient = redis.createClient(config.redis)

function saveBody (req) {
  const ct = req.headers['content-type']
  if (!ct)
    return

  const types = [
    'application/json',
    'text/xml'
  ]

  if (!types.includes(ct.toLowerCase()))
    return

  if (!req.body)
    return

  const blacklist = [
    '/oauth2/token'
  ]

  if (blacklist.indexOf(req.path) > -1)
    return

  redisClient.set(`bodies:${req.rechat_id}`, JSON.stringify(req.body), 'EX', 14 * 24 * 60 * 60 /* 14 Days */)
}


module.exports = function (app) {
  app.use(function (req, res, next) {
    req.start = process.hrtime()
    req.rechat_id = req.headers['x-request-id'] || uuid.v1()
    res.setHeader('X-Request-ID', req.rechat_id)
    res.on('finish', logRequest)

    // eslint-disable-next-line callback-return
    next()
    saveBody(req)
  })

  setImmediate(() => {
    app.get('/_/requests/:id', function(req, res) {
      const req_id = Crypto.decrypt(req.params.id)

      redisClient.get(`bodies:${req_id}`, (err, body) => {
        if (err) {
          return res.json({
            code: 'error',
            error: 'Redis connection failed.'
          })
        }
        
        db.conn((err, client, done) => {
          if (err) {
            return res.json({
              code: 'error',
              error: 'Redis connection failed.'
            })
          }

          db.query('requests/get', [req_id], client, (err, result) => {
            done()
            if (err) {
              return res.json({
                code: 'error',
                error: err
              })
            }

            const req_props = result.rows[0]

            if (!req_props)
              return res.sendStatus(404)

            res.json({
              code: 'OK',
              data: {
                ...req_props,
                body: JSON.parse(body)
              }
            })
          })
        })
      })
    })
  })
}
