const db = require('../lib/utils/db')

const migrations = [
  'BEGIN',


  'ALTER TABLE google_contact_groups DROP CONSTRAINT google_contact_groups_google_credential_entry_id_key',
  'DELETE FROM google_contact_groups',

  'ALTER TABLE google_contact_groups RENAME COLUMN entry_id TO resource_id',
  'ALTER TABLE google_contact_groups RENAME COLUMN entry    TO resource',

  'ALTER TABLE google_contact_groups ADD COLUMN resource_name TEXT',

  'ALTER TABLE google_contact_groups ADD CONSTRAINT gcgroups_gcredential_resource_name UNIQUE (google_credential, resource_id)',


  'ALTER TABLE google_credentials ADD COLUMN cgroups_sync_token TEXT',
  'ALTER TABLE google_credentials ADD COLUMN contacts_sync_token TEXT',


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