const db = require('../lib/utils/db')

const migrations = [
  'BEGIN',

  'ALTER TABLE notifications DROP COLUMN IF EXISTS sound',
  'ALTER TABLE notifications ADD COLUMN IF NOT EXISTS sound TEXT DEFAULT NULL',

  'COMMIT'
]


const run = async () => {
  const { conn } = await db.conn.promise()

  for(const sql of migrations) {
    await conn.query(sql)
  }

  conn.release()
}

exports.up = cb => {
  run().then(cb).catch(cb)
}

exports.down = () => {}