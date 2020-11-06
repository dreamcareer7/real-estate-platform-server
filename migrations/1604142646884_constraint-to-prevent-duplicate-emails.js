const db = require('../lib/utils/db')

const migrations = [
  'BEGIN',
  `WITH dupes AS (
    SELECT * FROM email_campaign_emails
    EXCEPT SELECT DISTINCT ON(campaign, email_address) * FROM email_campaign_emails
    ORDER BY campaign, email_address, opened DESC
   )
   DELETE FROM email_campaign_emails WHERE id IN(SELECT id FROM dupes)`,
  'ALTER TABLE email_campaign_emails ADD CONSTRAINT email_campaign_email_unique UNIQUE(campaign, email_address)',
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