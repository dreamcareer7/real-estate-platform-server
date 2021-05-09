process.env.ORIGINAL_NODE_ENV = process.env.NODE_ENV || 'development'
process.env.NODE_ENV = 'tests' // So we read the proper config file

require('colors')
const sortBy = require('lodash/sortBy')

const path = require('path')
const fs = require('fs')
const EventEmitter = require('events')
const program = require('commander')

const Run = new EventEmitter()
global['Run'] = Run

const config = require('../../lib/config.js')
const migrate = require('../../lib/utils/migrate')
const { peanar } = require('../../lib/utils/peanar')
const fork = require('child_process').fork
const async = require('async')
const redis = require('redis')
const AssertionError = require('assertion-error')

const Context = require('../../lib/models/Context')
const Notification = require('../../lib/models/Notification')
const { formatPhoneNumberForDialing } = require('../../lib/models/ObjectUtil.js')

const {handleJob, installJobsRoute} = require('./jobs')

const redisClient = redis.createClient(config.redis)

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

if (program.curl)
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

  const runner = fork(__dirname + '/runner.js', [suite, url], {
    execArgv: []
  })

  Run.emit('spawn', suite)

  runner.on('message', (m) => {
    Run.emit('message', suite, m)
  })

  runner.on('suite error', (m) => {
    Run.emit('suite error', m.suite)
  })

  runner.on('exit', () => {
    Run.emit('suite done', suite)
    cb()
  })
}

const db = require('../../lib/utils/db')
const {app, start} = require('../../lib/bootstrap.js')

const connections = {}

const database = (req, res, next) => {
  const context = Context.create()
  const suite = req.headers['x-suite']

  context.watchOver(req)
  context.watchOver(res)

  let handled = false
  const end = res.end

  context.on('error', (e) => {
    if (handled)
      return
    handled = true

    delete e.domain
    delete e.domainThrown
    delete e.domainEmitter
    delete e.domainBound

    if (e instanceof AssertionError) {
      const rootDir = path.dirname(path.resolve(__dirname, '../../index.js'))

      console.log(e.stack.split('\n')[0])
      console.log(e.stack.split('\n').filter(/** @param {string} line */line => line.includes(rootDir) && !line.includes('node_modules')).join('\n'))
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

  res.end = function (data, encoding, callback) {
    if (req.headers['x-handle-jobs'] === 'yes') {
      async.whilst(() => {
        return (Context.get('jobs') || []).length > 0 || (Context.get('rabbit_jobs') || []).length > 0
      }, cb => {
        async.parallel([
          cb => {
            async.whilst(() => {
              const jobs = Context.get('jobs')
              return jobs.length > 0
            }, (cb) => {
              const job = Context.get('jobs').shift()
              handleJob(job.type, null, job.data, (err, result) => {
                if (result) {
                  Context.log(JSON.stringify(result, null, 2))
                }
                cb(err, result)
              })
            }, cb)
          },
          cb => {
            peanar.enqueueContextJobs().nodeify(cb)
          }
        ], cb)
      }, (err) => {
        if (err) {
          console.error(err)
        }

        Context.log('finished jobs')
        end.call(res, data, encoding, callback)
      })
    }
    else (
      end.call(res, data, encoding, callback)
    )
  }

  if (connections[suite]) {
    context.set({
      db: connections[suite],
      jobs: [],
      rabbit_jobs: [],
      suite
    })
    context.run(next)
    return
  }

  db.conn((err, conn, done) => {
    if (err)
      return res.error(err)

    conn.done = done

    const cb = () => {
      connections[suite] = conn
      context.set({
        db: conn,
        jobs: []
      })
      context.run(next)
    }

    if (suite) {
      conn.query('BEGIN', (err) => {
        if (err)
          return res.error(err)

        cb()
      })
    }
    else {
      return cb()
    }
  })
}

app.use(database)

app.post('_/rollback', (req, res) => {
  rollback(req.query.suite)
  res.end()
})

app.get('/sms/inbox/:number', (req, res) => {
  const suite = req.header('x-suite')
  const number = formatPhoneNumberForDialing(req.params.number)
  
  if (!suite) {
    res.status(500)
    return res.end()
  }
  const TEMP_PATH = path.resolve(__dirname, '../temp')
  const dir = path.resolve(TEMP_PATH, 'sms', suite, number)

  try {
    const files = fs.readdirSync(dir)
    const messages = files.map(f => {
      return {
        ...JSON.parse(fs.readFileSync(path.resolve(dir, f), { encoding: 'utf-8' })),
        timestamp: parseInt(f.replace(/\.json$/, ''))
      }
    })
    for (const f of files) {
      fs.unlinkSync(path.resolve(dir, f))
    }
    res.json({
      data: sortBy(messages, 'timestamp')
    })
  } catch {
    res.status(404)
  }

  res.end()
})

app.use((req, res, next) => {
  const newAllowedHeaders = (res.get('Access-Control-Allow-Headers') || '')
    .split(',').concat(['x-suite', 'x-handle-jobs'])
    .join(',')
  res.header('Access-Control-Allow-Headers', newAllowedHeaders)
  next()
})

app.on('after loading routes', () => {
  app.use((err, req, res, next) => {
    Context.getActive().emit('error', err)
  })
})

Run.emit('app ready', app)

const rollback = suite => {
  if(suite && connections[suite]) {
    connections[suite].query('ROLLBACK', connections[suite].done)
    delete connections[suite]
  }
}

const setupApp = cb => {
  migrate(() => {
    start(config.url.port, () => {
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
  })

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

  installJobsRoute(app)
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
