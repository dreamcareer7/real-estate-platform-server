'use strict'

const async = require('async')
const db = require('../lib/utils/db')

const up = [
  'ALTER TYPE notification_object_class ADD VALUE \'AttachedFile\'',
  'ALTER TYPE activity_type ADD VALUE \'UserViewedFile\'',
]

const down = []

const runAll = (sqls, next) => {
  db.conn((err, client) => {
    if (err)
      return next(err)

    async.eachSeries(sqls, client.query.bind(client), next)
  })
}

const run = (queries) => {
  return (next) => {
    runAll(queries, next)
  }
}

exports.up = run(up)
exports.down = run(down)
