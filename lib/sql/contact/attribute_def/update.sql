UPDATE
  contacts_attribute_defs
SET
  label = $2,
  section = $3,
  "required" = $4,
  singular = $5,
  searchable = $6,
  has_label = $7,
  labels = $8::text[],
  enum_values = $9::text[],
  updated_at = now()
WHERE
  id = $1