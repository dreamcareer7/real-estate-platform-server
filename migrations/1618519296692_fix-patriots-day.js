const db = require('../lib/utils/db')

const migrations = [
  'BEGIN',
  `ALTER TYPE template_type
    RENAME VALUE 'PatriotsDay' TO 'September11'`,
  `ALTER TYPE template_type
    ADD VALUE 'PatriotsDay'`,
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
