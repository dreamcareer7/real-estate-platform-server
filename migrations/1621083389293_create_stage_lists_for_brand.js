const db = require('../lib/utils/db')

const migrations = [
  'BEGIN',
  `CREATE OR REPLACE FUNCTION public.create_stage_lists_for_brand(uuid)
   RETURNS TABLE (
     id uuid
   )
   LANGUAGE sql
  AS $function$
    WITH default_lists AS (
      SELECT
        $1::uuid AS brand,
        now() - (5 - row_number() over ()) * '1 seconds'::interval AS created_at,
        j.value AS name,
        '[]'::jsonb || to_jsonb(j.*) AS filters,
        true AS is_pinned
      FROM (
        SELECT
          cad.id AS attribute_def,
          false AS invert,
          t.title AS value
        FROM
          contacts_attribute_defs AS cad
          CROSS JOIN unnest('{"Warm", "Hot", "Past Client"}'::text[]) AS t(title)
        WHERE
          cad.name = 'tag'
      ) AS j
  
      UNION ALL
  
      SELECT
        $1::uuid AS brand,
        now() AS created_at,
        'iOS' AS name,
        '[]'::jsonb || to_jsonb(j.*) AS filters,
        true AS is_pinned
      FROM (
        SELECT
          cad.id AS attribute_def,
          false AS invert,
          'IOSAddressBook' AS value
        FROM
          contacts_attribute_defs AS cad
        WHERE
          cad.name = 'source_type'
      ) AS j
    )
    INSERT INTO crm_lists
      (brand, created_at, name, filters, is_pinned)
    SELECT
      *
    FROM
      default_lists
    RETURNING
      id
  $function$`,
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
