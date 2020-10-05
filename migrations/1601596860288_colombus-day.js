const db = require('../lib/utils/db')

const migrations = [
  `ALTER TYPE template_type
    ADD VALUE 'ColombusDay'`,
  `ALTER TYPE template_type
    RENAME VALUE 'Diwaly' TO 'Diwali'`
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