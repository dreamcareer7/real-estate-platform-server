'use strict'

const async = require('async')
const db = require('../lib/utils/db')
const fs = require('fs')
const listings_filters = fs.readFileSync('./lib/sql/alert/listings_filters.mv.sql').toString()

const up = [
  'DROP MATERIALIZED VIEW listings_filters',
  'ALTER TABLE properties ALTER COLUMN architectural_style TYPE text[] USING string_to_array(architectural_style, \',\')',
  listings_filters
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
