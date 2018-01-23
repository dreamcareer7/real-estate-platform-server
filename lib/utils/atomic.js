const Domain = require('domain')
const db = require('./db.js')
const AssertionError = require('assertion-error')

function transaction (req, res, next) {
  console.log('Acquiring connection for', req.rechat_id)

  db.conn(function (err, conn, done) {
    console.log('Connection acquired for', req.rechat_id)
    const domain = Domain.create()
    if (err) {
      return next(Error.Database(err))
    }

    domain.add(req)
    domain.add(res)

    const rollback = function () {
      console.log('<- Rolling back'.red, req.method.yellow, req.url)
      conn.query('ROLLBACK', done)
    }

    conn.query('BEGIN', function (err) {
      if (err) {
        return next(Error.Database(err))
      }

      domain.db = conn
      domain.jobs = []

      return domain.run(next)
    })

    const end = res.end

    let handled = false
    domain.on('error', function (e) {
      delete e.domain
      delete e.domainThrown
      delete e.domainEmitter
      delete e.domainBound

      // Request comes through, 3 async operations start. Lets call them a,b,c.
      // a fails.
      // We rollback and send error
      // b fails, but we already have rolled back the connection and released the connection and sent the error
      // So just ignore b.
      // Working of this situation is tested by unit test atomic/async_fail.
      // /GET/admin/async_fail emits this situation
      if (handled)
        return
      handled = true

      if (res.headersSent) {
        // We have already responded. The request is complete. However, an error has happened on the background.
        // We cannot Rollback. User already counts on the response. We probably have already rollback/commited.
        console.log('⚠ Panic after request is complete:'.yellow, e)
        return
      }

      // res.end() is hijacked by us to COMMIT when we're done.
      // Since we want to close the connection, we need to use res.error()
      // but res.error will end up commiting since it uses the hijacked version of res.end()
      // So we undo our hijacking of res.end() and make sure we can safely do res.error()
      res.end = end

      if (e instanceof AssertionError) {
        e = Error.Validation({
          message: e.message,
          stack: e.stack
        })
      }

      let status = e.http

      if (!status)
        status = 500

      res.status(status)

      if (status >= 500)
        res.json({message: 'Internal Error'})
      else
        res.json(e)

      console.log('⚠ Panic:'.yellow, e)
      rollback()
    })

    res.end = function (data, encoding, callback) {
      console.log('Committing transaction for', req.rechat_id)
      conn.query('COMMIT', function () {
        console.log('Committed', req.rechat_id)
        Intercom.handleEvents(req, res, domain.intercom)

        Job.handle(domain.jobs, err => {
          if (err)
            console.log('⚠ JOB Panic:'.red, err, err.stack)

          end.call(res, data, encoding, callback)
          done()
        })
      })
    }

    // You might want to ask yourself why this is necessary?
    // Looks like that res.end() does not get called if a connection gets
    // terminated halfway through. What happens is a sequence of funny events known to our team as
    // "The Fucking Timeout Issues". We make sure that if a request gets closed for any reason,
    // we do a rollback on current transction and immediately terminate whatever we're doing.
    req.on('close', function () {
      console.log('× Connection closed by peer', req.url, req.user ? req.user.email : 'Guest')
      rollback()
    })
  })
}

module.exports = function (app) {
  app.use(transaction)

  app.on('after loading routes', () => {
    // If an error happens on any of the middlewares/controllers, this middleware will be called
    // If the error happens before our atomic controller, there wont be any process.domain
    app.use((err, req, res, next) => {
      if (process.domain)
        return process.domain.emit('error', err)

      res.status(500)
      res.json({
        error: err,
        status: 'Error'
      })
    })
  })
}
