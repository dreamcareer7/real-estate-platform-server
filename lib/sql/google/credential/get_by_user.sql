SELECT
  id
FROM
  google_credentials 
WHERE 
  "user" = $1
  AND brand = $2
  AND revoked IS FALSE
  AND deleted_at IS NULL
