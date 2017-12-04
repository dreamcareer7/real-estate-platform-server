process.env.ORIGINAL_NODE_ENV = process.env.NODE_ENV || 'development'
process.env.NODE_ENV = 'tests' // So we read the proper config file

require('colors')

const fs = require('fs')
const program = require('commander')
const config = require('../lib/config.js')
const fork = require('child_process').fork
const async = require('async')
const EventEmitter = require('events')
const redis = require('redis')
const AssertionError = require('assertion-error')

const redisClient = redis.createClient(config.redis)

global.Run = new EventEmitter()

program
  .usage('[options] <suite> <suite>')
  .option('-s, --server <server>', 'Instead of setting your own version, run tests against <server>')
  .option('-c, --concurrency <n>', 'Number of suites to run at the same time (defaults to 20)')
  .option('--curl', 'Throw curl commands')
  .option('--report', 'Use the nice plain text reporter')
  .option('--no-response', 'When in curl mode, do not write responses to stdout')
  .option('--stop-on-fail', 'Stops on the first sight of problem')
  .option('--keep', 'Keep the server running after execution is completed')
  .option('--docs', 'Setup REST API')
  .option('--commit <suite>', 'Commits the changes on specified suite after its done')
  .parse(process.argv)

if (!program.concurrency)
  program.concurrency = 1

if (program.docs)
  require('./docs.js')(program)
else if (program.curl)
  require('./curl.js')(program)
else
  require('./report.js')(program)


const getSuites = function (cb) {
  if (program.args.length > 0)
    return cb(null, program.args)

  const files = fs.readdirSync(__dirname + '/suites')
  const suites = files
        .filter((file) => file.substring(file.length - 3, file.length) === '.js')
        .map((file) => file.replace('.js', ''))

  return cb(null, suites)
}

function spawnProcesses (cb) {
  getSuites((err, suites) => {
    if (err)
      return cb(err)

    suites.map((suite) => Run.emit('register suite', suite))

    async.mapLimit(suites, program.concurrency, spawnSuite, cb)
  })
}

function spawnSuite (suite, cb) {
  const url = program.server ? program.server : 'http://localhost:' + config.url.port

  const runner = fork(__dirname + '/runner.js', [suite, url])

  Run.emit('spawn', suite)

  runner.on('message', (m) => {
    Run.emit('message', suite, m)
  })

  runner.on('exit', () => {
    Run.emit('suite done', suite)
    cb()
  })
}

const Domain = require('domain')
const db = require('../lib/utils/db')

const connections = {}

const database = (req, res, next) => {
  const domain = Domain.create()
  const suite = req.headers['x-suite']

  domain.add(req)
  domain.add(res)

  let handled = false
  domain.on('error', (e) => {
    if (handled)
      return
    handled = true

    delete e.domain
    delete e.domainThrown
    delete e.domainEmitter
    delete e.domainBound

    if (e instanceof AssertionError) {
      e = Error.Validation(e.message)
    }

    if (!e.http)
      e.http = 500

    console.log(e)
    process.stderr.write('Error: ' + JSON.stringify(e.stack) + '\n')

    res.status(e.http)

    if (e.http >= 500)
      res.json({message: 'Internal Error'})
    else
      res.json(e)
  })

  if (connections[suite]) {
    domain.db = connections[suite]
    domain.jobs = []
    domain.jobs.push = job => job.save()
    domain.run(next)
    return
  }

  db.conn((err, conn, done) => {
    if (err)
      return res.error(err)

    conn.done = done
    conn.query('BEGIN', (err) => {
      if (err)
        return res.error(err)

      connections[suite] = conn
      domain.db = conn
      domain.run(next)
    })
  })
}

function setupApp (cb) {
  const app = require('../lib/bootstrap.js')()
  app.use(database)

//   Error.autoReport = false;

  const rollback = suite => {
    connections[suite].query('ROLLBACK', connections[suite].done)
    delete connections[suite]
  }

  if (!program.keep) {
    Run.on('suite done', (suite) => {
      if (program.commit && program.commit === suite) {
        connections[suite].query('COMMIT', err => {
          if (err)
            console.log('Error committing', err)
          else
            console.log('Committed changes')

          rollback(suite)
          return
        })
      }

      rollback(suite)
    })
  }

  Run.emit('app ready', app)

  app.on('after loading routes', () => {
    app.use((err, req, res, next) => {
      process.domain.emit('error', err)
    })
  })

  require('./jobs')(app)

  app.listen(config.url.port, () => {
    // Clear all jobs on test db
    redisClient.flushdb(err => {
      if (err)
        console.log(err)

      Notification.schedule = function (notification, cb) {
        if (!notification.delay)
          notification.delay = 0

        setTimeout(function () {
          Notification.create(notification, cb)
        }, notification.delay)
      }

      cb()
    })
  })
}

const steps = []

if (!program.server)
  steps.push(setupApp)

steps.push(spawnProcesses)

async.series(steps, (err) => {
  if (err) {
    console.log(err)
  }

  Run.emit('done')
})
