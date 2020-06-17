const db = require('../lib/utils/db')

const migrations = [
  `ALTER TYPE brand_setting
   ADD VALUE 'enable-liveby'`,
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
