UPDATE
  google_credentials
SET
  access_token = $2,
  updated_at = $3
WHERE
  id = $1