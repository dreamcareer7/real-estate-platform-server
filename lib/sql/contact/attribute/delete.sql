UPDATE
  contacts_attributes
SET
  deleted_at = now()
WHERE
  id = ANY($1::uuid[])
RETURNING contact
