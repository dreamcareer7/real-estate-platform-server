const db = require('../lib/utils/db')

const migrations = [
  'BEGIN',
  `CREATE OR REPLACE VIEW calendar.holiday AS (
    SELECT
      id::text,
      NULL::uuid AS created_by,
      created_at,
      updated_at,
      deleted_at,
      NULL::timestamptz AS parent_deleted_at,
      GREATEST(created_at, updated_at, deleted_at) AS last_updated_at,
      'holiday' AS object_type,
      name::text AS event_type,
      name::text AS type_label,
      starts_at::timestamptz AS "timestamp",
      starts_at::date AS "date",
      starts_at::date AS next_occurence,
      NULL::timestamptz AS end_date,
      False AS recurring,
      name::text AS title,
      NULL::uuid AS crm_task,
      True AS all_day,
      NULL::uuid AS deal,
      NULL::uuid AS contact,
      NULL::uuid AS campaign,
      NULL::uuid AS credential_id,
      NULL::text AS thread_key,
      NULL::uuid AS activity,
      NULL::uuid AS showing,
      NULL::uuid AS flow,
      NULL::uuid[] AS users,
      NULL::uuid[] AS accessible_to,
      NULL::json[] AS people,
      0 AS people_len,
      NULL::uuid AS brand,
      NULL::text AS status,
      NULL::jsonb AS metadata
    FROM
      holidays AS h
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
