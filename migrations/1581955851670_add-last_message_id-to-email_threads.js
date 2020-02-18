const db = require('../lib/utils/db')

const migrations = [
  'BEGIN',
  'ALTER TABLE email_threads ADD last_message_id text',

  `INSERT INTO email_threads (
    id,
    microsoft_credential,
    "user",
    brand,
    "subject",
    last_message_id,
    first_message_in_reply_to,
    first_message_date,
    last_message_date,
    recipients,
    message_count,
    has_attachments,
    is_read
  )
  (
    WITH thread_recipients AS (
      SELECT
        thread_key, array_agg(DISTINCT recipient) AS recipients
      FROM
        microsoft_messages, unnest(recipients) AS t(recipient)
      GROUP BY
        thread_key
    )
    SELECT DISTINCT ON (microsoft_messages.thread_key)
      microsoft_messages.thread_key,
      microsoft_credential,
      microsoft_credentials."user",
      microsoft_credentials.brand,
      last_value(subject) OVER (w ORDER BY message_date) AS "subject",
      last_value(message_id) OVER (w ORDER BY message_date) AS last_message_id,
      first_value(microsoft_messages.in_reply_to) OVER (w ORDER BY message_date) AS first_message_in_reply_to,
      min(message_date) OVER (w) AS first_message_date,
      max(message_date) OVER (w) AS last_message_date,
      thread_recipients.recipients AS recipients,
      count(*) OVER (w) AS message_count,
      SUM(has_attachments::int) OVER (w) > 0 AS has_attachments,
      AVG(is_read::int) OVER (w) = 1 AS is_read
    FROM
      microsoft_messages
      JOIN microsoft_credentials
        ON microsoft_messages.microsoft_credential = microsoft_credentials.id
      JOIN thread_recipients USING (thread_key)
    WHERE
      microsoft_messages.deleted_at IS NULL
    WINDOW w AS (PARTITION BY thread_key)
    ORDER BY
      microsoft_messages.thread_key, message_date
  )
  ON CONFLICT (id) DO UPDATE SET
    deleted_at = null,
    updated_at = now(),
    subject = EXCLUDED.subject,
    last_message_id = EXCLUDED.last_message_id,
    last_message_date = EXCLUDED.last_message_date,
    recipients = (
      SELECT
        array_agg(DISTINCT recipient)
      FROM
        unnest(COALESCE(EXCLUDED.recipients, '{}'::text[])) u(recipient)
    ),
    message_count = EXCLUDED.message_count,
    has_attachments = EXCLUDED.has_attachments,
    is_read = EXCLUDED.is_read`,
  
  `INSERT INTO email_threads (
    id,
    google_credential,
    "user",
    brand,
    "subject",
    last_message_id,
    first_message_in_reply_to,
    first_message_date,
    last_message_date,
    recipients,
    message_count,
    has_attachments,
    is_read
  )
  (
    WITH thread_recipients AS (
      SELECT
        thread_key, array_agg(DISTINCT recipient) AS recipients
      FROM
        google_messages, unnest(recipients) AS t(recipient)
      GROUP BY
        thread_key
    )
    SELECT DISTINCT ON (google_messages.thread_key)
      google_messages.thread_key,
      google_credential,
      google_credentials."user",
      google_credentials.brand,
      last_value(subject) OVER (w ORDER BY message_date) AS "subject",
      last_value(message_id) OVER (w ORDER BY message_date) AS last_message_id,
      first_value(google_messages.in_reply_to) OVER (w ORDER BY message_date) AS first_message_in_reply_to,
      min(message_date) OVER (w) AS first_message_date,
      max(message_date) OVER (w) AS last_message_date,
      thread_recipients.recipients AS recipients,
      count(*) OVER (w) AS message_count,
      SUM(has_attachments::int) OVER (w) > 0 AS has_attachments,
      AVG(is_read::int) OVER (w) = 1 AS is_read
    FROM
      google_messages
      JOIN google_credentials
        ON google_messages.google_credential = google_credentials.id
      JOIN thread_recipients USING (thread_key)
    WHERE
      google_messages.deleted_at IS NULL
    WINDOW w AS (PARTITION BY thread_key)
    ORDER BY
      google_messages.thread_key, message_date
  )
  ON CONFLICT (id) DO UPDATE SET
    deleted_at = null,
    updated_at = now(),
    subject = EXCLUDED.subject,
    last_message_id = EXCLUDED.last_message_id,
    last_message_date = EXCLUDED.last_message_date,
    recipients = (
      SELECT
        array_agg(DISTINCT recipient)
      FROM
        unnest(COALESCE(EXCLUDED.recipients, '{}'::text[])) u(recipient)
    ),
    message_count = EXCLUDED.message_count,
    has_attachments = EXCLUDED.has_attachments,
    is_read = EXCLUDED.is_read
  `,

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
