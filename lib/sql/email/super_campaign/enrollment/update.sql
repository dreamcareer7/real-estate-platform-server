WITH to_delete AS (
  UPDATE
    super_campaigns_enrollments
  SET
    deleted_at = now()
  WHERE
    super_campaign = $1::uuid
    AND brand = ANY($2::uuid[])
    -- AND is_pinned IS FALSE
    AND deleted_at IS NULL
)
INSERT INTO super_campaigns_enrollments as sce (
  super_campaign,
  brand,
  "user",
  tags,
  created_by
)
SELECT
  c.id AS super_campaign,
  bc.brand,
  bu.user,
  c.tags,
  NULL AS created_by
FROM
  super_campaigns AS c
  CROSS JOIN unnest($3::uuid[]) AS e(brand)
  CROSS JOIN LATERAL brand_valid_children(e.brand) AS bc(brand)
  JOIN brands_roles AS br
    ON bc.brand = br.brand
  JOIN brands_users AS bu
    ON br.id = bu.role
  JOIN users_settings AS us
    ON us.user = bu.user AND us.brand = bc.brand
WHERE
  c.id = $1::uuid
  AND cardinality(c.tags) > 0
  AND br.deleted_at IS NULL
  AND bu.deleted_at IS NULL
  AND COALESCE(us.super_campaign_admin_permission, FALSE)
GROUP BY
  c.id,
  bc.brand,
  bu.user
ON CONFLICT (super_campaign, brand, "user") DO UPDATE SET
  tags = excluded.tags::text[],
  deleted_at = NULL,
  created_by = NULL
WHERE
  (
    SELECT COALESCE(us.super_campaign_admin_permission, FALSE)
    FROM users_settings AS us
    WHERE us.brand = excluded.brand AND us.user = excluded.user
  ) = TRUE
  AND
  (
    sce.deleted_at IS NOT NULL OR
    sce.created_by IS DISTINCT FROM excluded.user
  )
