SELECT
  id,
  EXTRACT(epoch FROM created_at) AS created_at,
  EXTRACT(epoch FROM updated_at) AS updated_at,
  created_by,
  updated_by,
  brand,
  name,
  description,

  (
    SELECT
      array_agg(id ORDER BY due_in)
    FROM
      brands_flow_steps
    WHERE
      flow = brands_flows.id
      AND deleted_at IS NULL
  ) AS steps,

  (
    SELECT
      (count(id))::INT
    FROM
      flows
    WHERE
      origin = brands_flows.id
      AND flows.deleted_at IS NULL
  ) AS active_flows,

  'brand_flow' AS type
FROM
  brands_flows
JOIN
  unnest($1::uuid[]) WITH ORDINALITY t(bid, ord) ON brands_flows.id = bid
ORDER BY
  t.ord
