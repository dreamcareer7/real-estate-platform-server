SELECT * FROM sso_users
WHERE
  provider = (
    SELECT id FROM sso_providers WHERE identifier = $1
  )
  AND foreign_id = $2
