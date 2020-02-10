WITH to_delete AS (
  (
    SELECT
      thread_key
    FROM
      unnest($1::text[]) t(thread_key)
  ) EXCEPT (
    SELECT
      thread_key
    FROM
      google_messages
      JOIN google_credentials
        ON google_messages.google_credential = google_credentials.id
    WHERE
      google_messages.deleted_at IS NULL
      AND google_credentials.deleted_at IS NULL
  ) EXCEPT (
    SELECT
      thread_key
    FROM
      microsoft_messages
      JOIN microsoft_credentials
        ON microsoft_messages.microsoft_credential = microsoft_credentials.id
    WHERE
      microsoft_messages.deleted_at IS NULL
      AND microsoft_credentials.deleted_at IS NULL
  )
)
UPDATE
  email_threads
SET
  deleted_at = now()
FROM
  to_delete
WHERE
  email_threads.id = to_delete.thread_key
RETURNING
  email_threads.id
