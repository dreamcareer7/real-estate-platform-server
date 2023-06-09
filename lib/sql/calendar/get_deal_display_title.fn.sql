CREATE OR REPLACE FUNCTION get_deal_display_title(deal_id uuid)
RETURNS text
LANGUAGE SQL
STABLE
AS $$
  WITH dc AS (
    SELECT
      text AS full_address
    FROM
      current_deal_context
    WHERE
      deal = deal_id
      AND key = 'full_address'
      AND deleted_at IS NULL
    LIMIT 1
  ), mc AS (
    SELECT
      (
        SELECT ARRAY_TO_STRING
        (
          array_remove(ARRAY[
            NULLIF(addresses.street_number, ''),
            NULLIF(addresses.street_dir_prefix, ''),
            NULLIF(addresses.street_name, ''),
            NULLIF(addresses.street_suffix, ''),
            NULLIF(addresses.street_dir_suffix, ''),
            CASE
              WHEN addresses.unit_number IS NULL THEN NULL
              WHEN addresses.unit_number = '' THEN NULL
              ELSE 'Unit ' || addresses.unit_number || ',' END,
            addresses.city || ',',
            addresses.state_code,
            addresses.postal_code
          ], NULL), ' ', NULL
        )
      ) AS full_address
    FROM
      deals
      JOIN listings ON deals.listing = listings.id
      JOIN properties ON listings.property_id = properties.id
      JOIN addresses ON properties.address_id = addresses.id
    WHERE
      deals.id = deal_id
  )
  SELECT COALESCE(
    (SELECT full_address FROM dc),
    (SELECT full_address FROM mc),
    'Draft deal'
  )
$$
