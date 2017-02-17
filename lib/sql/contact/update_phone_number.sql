WITH u AS
(
  UPDATE contacts
  SET updated_at = CLOCK_TIMESTAMP()
  WHERE id = $1
)
UPDATE contacts_phone_numbers
SET phone_number = $3,
    data = $4,
    updated_at = CLOCK_TIMESTAMP()
WHERE contact = $1 AND
      id = $2
