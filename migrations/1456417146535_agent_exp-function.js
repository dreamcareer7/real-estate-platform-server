'use strict'

const async = require('async')
const db = require('../lib/utils/db')

const up = [
  'CREATE OR REPLACE FUNCTION agent_exp(mlsid TEXT) RETURNS TEXT AS $$\
  BEGIN\
    CASE substring(mlsid from 0 for 3)\
      WHEN \'02\' THEN RETURN \'25-40\';\
      WHEN \'03\' THEN RETURN \'15-25\';\
      WHEN \'04\' THEN RETURN \'10-15\';\
      WHEN \'05\' THEN RETURN \'5-10\';\
      WHEN \'06\' THEN RETURN \'0-5\';\
      ELSE RETURN \'20+\';\
    END CASE;\
  END;\
  $$ LANGUAGE plpgsql;'
]

const down = [
  'DROP FUNCTION IF EXISTS agent_exp(TEXT)'
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
