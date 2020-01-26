SELECT brands.*,
  'brand' AS TYPE,
  EXTRACT(EPOCH FROM created_at) AS created_at,
  EXTRACT(EPOCH FROM updated_at) AS updated_at,

  (
    SELECT ARRAY_AGG(hostname ORDER BY "default" DESC) FROM brands_hostnames WHERE brand = brands.id
  ) AS hostnames,

  (
    SELECT ARRAY_AGG(id) FROM brands_roles WHERE brand = brands.id AND deleted_at IS NULL
  ) as roles,

  (
    SELECT JSON_OBJECT_AGG(bs.key, bs) AS settings FROM brands_settings bs WHERE brand = brands.id AND deleted_at IS NULL
  ),

  (
    SELECT
      count(distinct bu."user")
    FROM
      brands_users AS bu
      JOIN brands_roles AS br
        ON br.id = bu.role
    WHERE
      br.brand = brands.id
      AND bu.deleted_at IS NULL
  )::INT as member_count,

  -- Brand can return both parents and children
  -- In most cases it's parent that we care about
  -- But in some cases a client may request for it's children (tree)
  -- If brand.children is enabled, then we have to disable brand.parent
  -- Otherwise we'll fall into an infinite loop

  (
    CASE WHEN $2 @> ARRAY['brand.children'] THEN
      (
        SELECT ARRAY_AGG(id ORDER BY name) FROM brands children
        WHERE children.parent = brands.id AND deleted_at IS NULL
      )
    ELSE NULL
    END
  ) as children,

  (
    CASE WHEN $2 @> ARRAY['brand.children'] THEN NULL
    ELSE parent
    END
  ) as parent

FROM brands
JOIN unnest($1::uuid[]) WITH ORDINALITY t(bid, ord) ON brands.id = bid
ORDER BY t.ord
