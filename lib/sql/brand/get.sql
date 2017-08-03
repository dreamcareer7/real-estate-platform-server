SELECT brands.*,
  'brand' AS TYPE,
  EXTRACT(EPOCH FROM created_at) AS created_at,
  EXTRACT(EPOCH FROM updated_at) AS updated_at,

  ARRAY(
    SELECT mls_id FROM offices WHERE id IN (
      SELECT office FROM brands_offices WHERE brand = brands.id
    )
  ) AS offices,

  (
    SELECT ARRAY_AGG(hostname ORDER BY "default" DESC) FROM brands_hostnames WHERE brand = brands.id
  ) AS hostnames

FROM brands
JOIN unnest($1::uuid[]) WITH ORDINALITY t(bid, ord) ON brands.id = bid
ORDER BY t.ord
