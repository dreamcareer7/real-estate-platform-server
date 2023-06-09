WITH r AS MATERIALIZED (
  SELECT id FROM search_listings(to_tsquery('english', $1))
  WHERE
    CASE
      WHEN $2::listing_status[] IS NULL THEN TRUE
      ELSE status = ANY($2::listing_status[])
    END
  ORDER BY order_listings(status)
)

SELECT * FROM r LIMIT COALESCE($3, 50)

-- This used to be a simple query with no CTE.
-- But the LIMIT was causing a major slowdown.
-- I could not figure out why and needed to hotfix it.
