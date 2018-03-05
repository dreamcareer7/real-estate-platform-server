'use strict'

const async = require('async')
const db = require('../lib/utils/db')

const up = [
  'ALTER type room_type ADD VALUE IF NOT EXISTS \'Personal\';',
  'BEGIN',
  'UPDATE rooms SET room_type = \'Group\';',
  'ALTER TABLE users ADD personal_room uuid REFERENCES rooms(id);',
  'WITH room_ins AS (\
     INSERT INTO rooms(\
       owner, room_type, client_type\
     )\
     SELECT id, \'Personal\'::room_type, \'Unknown\'::client_type\
     FROM users\
     WHERE personal_room IS NULL RETURNING owner as userid, id as roomid\
   ),\
   users_upd AS (\
     UPDATE users\
     SET personal_room = room_ins.roomid\
     FROM room_ins WHERE room_ins.userid = users.id\
   )\
   INSERT INTO rooms_users(room, "user") SELECT roomid, userid FROM room_ins;',
  'COMMIT'
]

const down = [
  'BEGIN',
  'ALTER TABLE users DROP COLUMN personal_room;',
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
