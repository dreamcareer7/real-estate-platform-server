'use strict'

const async = require('async')
const db = require('../lib/utils/db')

const up = [
  'CREATE TABLE brands_parents ( id uuid NOT NULL DEFAULT uuid_generate_v1(),brand uuid NOT NULL UNIQUE REFERENCES brands(id), parent uuid NOT NULL REFERENCES brands(id))'
]

const down = [
  'DROP TABLE brands_parents'
]

const runAll = (sqls, next) => {
  db.conn( (err, client) => {
    if(err)
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
