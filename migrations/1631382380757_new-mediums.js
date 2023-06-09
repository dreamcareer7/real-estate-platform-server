const db = require('../lib/utils/db')

const migrations = [
  `ALTER TYPE template_medium 
    ADD VALUE 'RealtorCover'`,

  `ALTER TYPE template_medium 
    ADD VALUE 'YouTubeCover'`,

  `ALTER TYPE template_medium 
    ADD VALUE 'TwitterCover'`,
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
