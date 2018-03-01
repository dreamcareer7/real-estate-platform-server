'use strict'

const async = require('async')
const db = require('../lib/utils/db')

const up = [
  'ALTER TYPE notification_action ADD VALUE IF NOT EXISTS \'Attached\';',
  'ALTER TYPE notification_action ADD VALUE IF NOT EXISTS \'Detached\';',
  'ALTER TYPE notification_object_class ADD VALUE IF NOT EXISTS \'Attachment\';'
]

const down = [
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
