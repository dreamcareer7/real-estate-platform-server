const db = require('../lib/utils/db')

const migrations = [
  'BEGIN',

  'ALTER TABLE google_calendar_events ADD COLUMN IF NOT EXISTS etag TEXT NOT NULL',

  'ALTER TABLE calendar_integration ADD COLUMN IF NOT EXISTS etag TEXT NOT NULL',
  'ALTER TABLE calendar_integration ADD COLUMN IF NOT EXISTS local_etag TEXT NULL',

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
