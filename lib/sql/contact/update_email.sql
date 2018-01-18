WITH u AS
(
  UPDATE contacts
  SET updated_at = CLOCK_TIMESTAMP()
  WHERE id = $1
)
UPDATE contacts_emails
SET email = $3,
    data = $4,
    label = $5,
    is_primary = $6,
    updated_at = CLOCK_TIMESTAMP()
WHERE contact = $1 AND
      id = $2
