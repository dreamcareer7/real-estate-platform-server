UPDATE
  microsoft_messages
SET
  deleted_at = now()
WHERE
  microsoft_credential = $1
  AND message_id = ANY($2)
RETURNING
  thread_key