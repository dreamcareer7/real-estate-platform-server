// var newrelic   = require('newrelic');

require('colors')

const bodyParser = require('body-parser')
const express = require('express')
const app = express()
const http = require('http').Server(app)
const compress = require('compression')

// We compress all responses if proper `Accept-Encoding` headers are set
// by requesting party.
app.use(compress())
app.use(bodyParser.json({
  limit: '25mb'
}))

app.use(function (req, res, next) {
  res.header('Access-Control-Allow-Methods', 'GET, HEAD, POST, PUT, DELETE, OPTIONS, PATCH')
  res.header('Access-Control-Allow-Origin', '*')
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization, X-Rechat-Brand, X-RECHAT-FORMAT, X-Auth-Mode, Range')
  res.header('Access-Control-Expose-Headers', 'Content-Type, X-Request-Id')
  next()
})

// Serving public directory contents by convention.
app.use(express.static(__dirname + '/public'))

// Pretty-printing JSON responses. This is not going to cause major
// issues on production since we compress our responses.
app.set('json spaces', 2)

const middlewares = [
  'models/index.js',
  'utils/route_middleware.js',
  'auth/auth.js',
  'utils/slack.js',
  'controllers/brand.js',
  'controllers/brand_flow.js',
  'controllers/recommendation.js',
  'controllers/user.js',
  'controllers/agent.js',
  'controllers/listing.js',
  'controllers/room.js',
  'controllers/contact_list.js',
  'controllers/contact_attribute_def.js',
  'controllers/contact.js',
  'controllers/flow.js',
  'controllers/task.js',
  'controllers/message.js',
  'controllers/alert.js',
  'controllers/notification.js',
  'controllers/admin.js',
  'controllers/verification.js',
  'controllers/office.js',
  'controllers/school.js',
  'controllers/website.js',
  'controllers/payment.js',
  'controllers/domain.js',
  'controllers/form.js',
  'controllers/deal.js',
  'controllers/envelope.js',
  'controllers/activity.js',
  'controllers/analytics',
  'controllers/calendar',
  'controllers/template',
  'controllers/email',
  'controllers/slack',
  'controllers/showings',
  'controllers/google',
  'controllers/microsoft'
]

const load_middlewares = () => {
  middlewares.map((middleware) => require('./' + middleware)(app))
  require('./socket/index.js')(http)
}

process.on('unhandledRejection', (err, promise) => {
  Context.trace('Unhanled Rejection on request', err)
})

process.on('SIGTERM', () => {
  Context.log('[SIGTERM] http server: closing')
  http.close(() => {
    Context.log('[SIGTERM] http server: closed')
    process.exit()
  })
})


function start (port, cb) {
  load_middlewares()
  Error.autoReport = false
  app.emit('after loading routes')
  http.listen(port, cb)
}

module.exports = {app, start}
