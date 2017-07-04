INSERT INTO addresses(
  title,
  subtitle,
  street_suffix,
  street_number,
  street_name,
  city,
  state,
  state_code,
  country,
  country_code,
  unit_number,
  postal_code,
  neighborhood,
  matrix_unique_id,
  county_or_parish,
  direction,
  street_dir_prefix,
  street_dir_suffix,
  street_number_searchable
) VALUES (
  $1,
  $2,
  $3,
  $4,
  $5,
  $6,
  $7,
  $8,
  $9,
  $10,
  $11,
  $12,
  $13,
  $14,
  $15,
  $16,
  $17,
  $18,
  $19
)

ON CONFLICT (matrix_unique_id) DO UPDATE SET
  updated_at = CLOCK_TIMESTAMP(),
  title = $1,
  subtitle = $2,
  street_suffix = $3,
  street_number = $4,
  street_name = $5,
  city = $6,
  state = $7,
  state_code = $8,
  country = $9,
  country_code = $10,
  unit_number = $11,
  postal_code = $12,
  neighborhood = $13,
  county_or_parish = $15,
  direction = $16,
  street_dir_prefix = $17,
  street_dir_suffix = $18,
  street_number_searchable = $19
  WHERE addresses.matrix_unique_id = $14

RETURNING id