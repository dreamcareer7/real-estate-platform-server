CREATE OR REPLACE FUNCTION get_brand_agents(id uuid) RETURNS TABLE (
   "user" uuid,
   agent uuid,
   mlsid text
) AS
$$
  SELECT
    users.id as "user",
    agents.id as agent,
    agents.mlsid as mlsid
    FROM agents
  JOIN users ON agents.id = users.agent
  WHERE users.id IN (
    (SELECT DISTINCT "user" FROM brands_users
    JOIN brands_roles ON brands_users.role = brands_roles.id
    WHERE brands_roles.brand = $1)
  )
  UNION
  SELECT
    users.id as "user",
    agents.id as agent,
    agents.mlsid as mlsid
    FROM agents
  LEFT JOIN users ON agents.id = users.agent
  WHERE office_mui IN (
    SELECT matrix_unique_id FROM offices
    WHERE id IN (SELECT office FROM brands_offices WHERE brand = $1)
  )
$$
LANGUAGE sql;