require('colors')
const fs = require('fs')
const Context = require('../models/Context')

const migrate = require('migratus')({
  loader: loadState,
  saver: saveState,
  directory: __dirname + '/../../migrations'
})

migrate.on('migrate started', (name) => {
  Context.log(`⏲️ ${name}`)
})

migrate.on('migrate failed', (name, direction, err) => {
  Context.log(`❌ ${name}`, err)
})

migrate.on('migrate succeeded', (name, direction) => {
  Context.log(`✔️ ${name}`)
})

const db = require('./db.js')

let loadedState

const sql_load = fs.readFileSync(__dirname + '/../sql/migration/load.sql').toString()
const sql_save = fs.readFileSync(__dirname + '/../sql/migration/save.sql').toString()

function saveState (state, cb) {
  db.conn((err, conn, done) => {
    if (err)
      return cb(err)

    conn.query(sql_save, [JSON.stringify(state)], (err, res) => {
      done()
      cb(err, res)
    })
  })
}

function loadState (cb) {
  db.conn((err, conn, done) => {
    if (err)
      return cb(err)

    conn.query(sql_load, (err, res) => {
      done()

      if (err)
        return cb(err)

      if (res.rows.length < 1)
        return cb(null, [])

      loadedState = res.rows[0].state
      if (!Array.isArray(loadedState))
        loadedState = []

      return cb(null, loadedState)
    })
  })
}

function performMigration (cb) {
  migrate.up(err => {
    if (err) {
      console.log('Migrations failure:', err)
      process.exit(1)
      return
    }

    cb()
  })
}

module.exports = performMigration
