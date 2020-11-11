const db = require('../lib/utils/db')

const migrations = [
  'BEGIN',
  'DROP VIEW IF EXISTS triggers_due',
  `CREATE OR REPLACE VIEW triggers_due AS (
    (
      SELECT
        t.*,
        'contact' AS trigger_object_type,
        c.object_type,
        c.date + t.wait_for AS timestamp,
        c.date + t.wait_for - interval '3 days' AS due_at
      FROM
        triggers AS t
        JOIN analytics.calendar AS c
          ON t.contact = c.contact
      WHERE
        c.object_type = 'contact_attribute'
        AND t.event_type <> 'flow_start'
        AND c.brand = t.brand
        AND t.contact IS NOT NULL
        AND t.event_type = c.event_type
        AND t.executed_at IS NULL
        AND t.deleted_at IS NULL
    )
    UNION ALL
    (
      SELECT
        t.*,
        'deal' AS trigger_object_type,
        c.object_type,
        c.date + t.wait_for AS timestamp,
        c.date + t.wait_for - interval '3 days' AS due_at
      FROM
        triggers AS t
        JOIN analytics.calendar AS c
          ON t.deal = c.deal
      WHERE
        c.object_type = 'deal_context'
        AND t.event_type <> 'flow_start'
        AND c.brand = t.brand
        AND t.deal IS NOT NULL
        AND t.event_type = c.event_type
        AND t.executed_at IS NULL
        AND t.deleted_at IS NULL
    )
    UNION ALL
    (
      SELECT
        t.*,
        (CASE WHEN t.contact IS NOT NULL THEN 'contact' WHEN t.deal IS NOT NULL THEN 'deal' ELSE NULL END) AS trigger_object_type,
        c.object_type,
        c.date + t.wait_for AS timestamp,
        c.date + t.wait_for - interval '3 days' AS due_at
      FROM
        triggers AS t
        JOIN analytics.calendar AS c
          ON (t.deal = c.deal OR t.contact = c.contact)
      WHERE
        c.object_type = 'flow'
        AND c.brand = t.brand
        AND c.event_type = 'flow_start'
        AND t.event_type = 'flow_start'
        AND t.deleted_at IS NULL
        AND t.executed_at IS NULL
    )
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
