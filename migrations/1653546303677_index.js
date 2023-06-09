const db = require('../lib/utils/db')

const migrations = [
  'CREATE INDEX CONCURRENTLY IF NOT EXISTS current_deal_context_searchable ON current_deal_context (deal, searchable) WHERE text IS NOT NULL AND deleted_at IS NULL'
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
