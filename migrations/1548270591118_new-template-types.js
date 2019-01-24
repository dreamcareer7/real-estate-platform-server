'use strict'

const async = require('async')
const db = require('../lib/utils/db')

const up = [
  `ALTER TYPE template_type
    ADD VALUE 'Valentines'`,
  `ALTER TYPE template_type
    ADD VALUE 'StPatrick'`,
]

const down = [
]

const runAll = (sqls, next) => {
  db.conn((err, client, release) => {
    if (err)
      return next(err)

    async.eachSeries(sqls, client.query.bind(client), err => {
      release()
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