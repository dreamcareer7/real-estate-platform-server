const db = require('../lib/utils/db')

const migrations = [
  'ALTER TABLE brands_checklists_tasks ADD COLUMN application uuid REFERENCES applications(id)'
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
