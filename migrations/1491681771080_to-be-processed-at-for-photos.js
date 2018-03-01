'use strict'

const async = require('async')
const db = require('../lib/utils/db')

const up = [
  'BEGIN',
  'ALTER TABLE photos RENAME COLUMN last_processed TO processed_at',
  'ALTER TABLE photos ADD to_be_processed_at timestamp with time zone DEFAULT CLOCK_TIMESTAMP()',
  'UPDATE photos SET to_be_processed_at = NULL',
  // Whlie we want the default value to be CLOCK_TIMESTAMP(), we want it to be NULL for our current photos
  // Otherwise we'll just start downloading the whole images again.
  'COMMIT'
]

const down = [
  'BEGIN',
  'ALTER TABLE photos DROP to_be_processed_at',
  'ALTER TABLE photos RENAME COLUMN processed_at TO last_processed',
  'COMMIT'
]

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
