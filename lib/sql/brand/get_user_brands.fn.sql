CREATE OR REPLACE FUNCTION user_brands("user" uuid, roles text[]) RETURNS TABLE(
  brand uuid
)
AS
$$
  WITH roles AS (
    SELECT DISTINCT brands_roles.brand as brand FROM brands_users
    JOIN brands_roles ON brands_users.role = brands_roles.id
    WHERE brands_users.user = $1
    AND brands_users.deleted_at IS NULL
    AND (
      CASE
        WHEN $2 IS NULL THEN TRUE
        ELSE brands_roles.acl && $2
      END
    )
  )

SELECT brand_children(roles.brand) FROM roles
$$
LANGUAGE sql;
