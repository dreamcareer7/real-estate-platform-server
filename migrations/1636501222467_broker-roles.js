const db = require('../lib/utils/db')

const migrations = [
  'BEGIN',
  `ALTER TYPE deal_role 
    ADD VALUE 'BuyerBroker'`,
  `ALTER TYPE deal_role 
    ADD VALUE 'SellerBroker'`,
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
