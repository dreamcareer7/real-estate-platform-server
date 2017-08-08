UPDATE notifications_users
SET
  acked_at = CLOCK_TIMESTAMP()
WHERE
  "user" = $1 AND
  notification IN
  (
    SELECT id FROM notifications
    WHERE room IS NULL AND
    specific = $1 AND
    COALESCE(NOT ($1 = ANY(exclude)), TRUE)
  ) AND
  acked_at IS NULL
