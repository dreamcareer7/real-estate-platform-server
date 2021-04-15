const db = require('../lib/utils/db')

const migrations = [
  `ALTER TYPE brand_type
    ADD VALUE IF NOT EXISTS 'Region'`,

  'BEGIN',

  'DROP VIEW IF EXISTS analytics.deals',
  'DROP VIEW IF EXISTS analytics.mini_deals',
  'DROP VIEW IF EXISTS analytics.roles',

  'DROP VIEW brands_branches',

  `CREATE OR REPLACE VIEW brands_relations AS (
  SELECT id,
  (
    SELECT
      brands.name
    FROM
      brands as b
      JOIN brand_parents(brands.id) bp(id) using (id)
    WHERE
      brands.brand_type = 'Office'
    LIMIT 1
  ) AS office,

  (
    SELECT
      brands.name
    FROM
      brands as b
      JOIN brand_parents(brands.id) bp(id) using (id)
    WHERE
      brands.brand_type = 'Region'
    LIMIT 1
  ) AS region

  FROM
    brands
)`,

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
