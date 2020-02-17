SELECT
  id
FROM 
  microsoft_credentials
WHERE
  (
    (calendars_last_sync_at <= (NOW() - $1::interval) OR calendars_last_sync_at IS NULL)
    AND (sync_status = 'success' OR sync_status IS NULL)
  )
  AND revoked IS FALSE
  AND deleted_at IS NULL
  AND microsoft_calendar IS NOT NULL