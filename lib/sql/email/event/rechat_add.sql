WITH insert AS (
  INSERT INTO emails_events (email, event, created_at, recipient, url, ip, client_os, client_type, device_type, location, object)
  VALUES
  (
    (
      SELECT id FROM emails WHERE id = $1::uuid
    ),
    $2::email_event,
    to_timestamp($3),
    $4,
    $5,
    $6,
    $7,
    $8,
    $9,
    $10
  )
)

SELECT campaign FROM emails WHERE id = $1::uuid