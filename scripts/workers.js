require('colors')

const Domain = require('domain')
const db = require('../lib/utils/db')
const debug = require('debug')('rechat:workers')

const queue = require('../lib/utils/queue.js')
const async = require('async')

const Task = require('../lib/models/CRM/Task.js')

let i = 0

const getDomain = (job, cb) => {
  db.conn(function (err, conn, done) {
    if (err)
      return cb(Error.Database(err))

    const domain = Domain.create()
    domain.i = ++i
    debug('Started domain', domain.i, job)

    const rollback = function (err) {
      console.log('<- Rolling back on worker'.red, domain.i, job, err)

      Slack.send({
        channel: '7-server-errors',
        text: 'Worker Error: ' + '\n `' + err + '`',
        emoji: ':skull:'
      })

      conn.query('ROLLBACK', done)
    }

    const commit = cb => {
      conn.query('COMMIT', function () {
        debug('Commited transaction'.green, domain.i, job)
        done()
        Job.handle(domain.jobs, cb)
      })
    }

    conn.query('BEGIN', function (err) {
      if (err)
        return cb(Error.Database(err))

      domain.db = conn
      domain.jobs = []

      domain.run(() => {
        debug('Entered domain', domain.i, process.domain.i)
        cb(null, {rollback,commit})
      })
    })

    domain.on('error', function (e) {
      delete e.domain
      delete e.domainThrown
      delete e.domainEmitter
      delete e.domainBound

      console.log('⚠ Panic:'.yellow, domain.i, e, e.stack)
      rollback(e.message)
    })
  })
}

// We have proper error handling here. No need for auto reports.
Error.autoReport = false

const queues = require('./queues')

Object.keys(queues).forEach(queue_name => {
  const definition = queues[queue_name]

  const handler = (job, done) => {
    debug('Picking Job', queue_name)

    // eslint-disable-next-line
    getDomain(job.data, (err, {rollback, commit} = {}) => {
      if (err) {
        console.log('Error getting domain', err)
        done(err)
        return
      }

      debug('Executing job handler', process.domain.i)
      const examine = (err, result) => {
        if (err) {
          rollback(err)
          done(err)
          return
        }

        Metric.increment(`Job.${queue_name}`)
        commit(done.bind(null, null, result))
      }

      definition.handler(job, examine)
    })
  }

  queue.process(queue_name, definition.parallel, handler)
})

setInterval(reportQueueStatistics, 10000)

function reportQueueStatistics () {
  queue.inactiveCount((err, count) => {
    if (err)
      return Metric.set('inactive_jobs', 99999)

    return Metric.set('inactive_jobs', count)
  })
}

reportQueueStatistics()

const shutdown = () => {
  queue.shutdown(5000, process.exit)
}
process.once('SIGTERM', shutdown)
process.once('SIGINT', shutdown)

setTimeout(shutdown, 1000 * 60 * 3) // Restart every 3 minutes

const sendNotifications = function () {
  getDomain({}, (err, {rollback, commit}) => {
    if (err)
      return rollback(err)

    async.series([
      Notification.sendForUnread,
      Message.sendEmailForUnread,
      (cb) => Task.sendReminderNotifications().nodeify(),
    ], err => {
      if (err)
        return rollback(err)

      commit(err => {
        if (err)
          console.log('Error committing', err)

        setTimeout(sendNotifications, 5000)
      })
    })
  })
}

sendNotifications()
