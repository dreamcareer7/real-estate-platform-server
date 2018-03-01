'use strict'

const async = require('async')
const db = require('../lib/utils/db')
const fs = require('fs')
const schools = fs.readFileSync('./lib/sql/school/schools.mv.sql').toString()
const subdivisions = fs.readFileSync('./lib/sql/listing/subdivision/subdivisions.mv.sql').toString()

const up = [
  'DROP MATERIALIZED VIEW schools',
  schools,
  'DROP MATERIALIZED VIEW subdivisions',
  subdivisions
]

const down = []

const runAll = (sqls, next) => {
  db.conn((err, client) => {
    if (err)
      return next(err)

    async.eachSeries(sqls, client.query.bind(client), err => {
      client.release()
      next(err)
    })
  })
}

const run = (queries) => {
  return (next) => {
    runAll(queries, next)
  }
}

exports.up = run(up)
exports.down = run(down)
