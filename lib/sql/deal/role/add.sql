INSERT INTO deals_roles (
  created_by,
  role_type,
  role,
  deal,
  "user",
  brand,
  agent,
  company_title,
  legal_prefix,
  legal_first_name,
  legal_middle_name,
  legal_last_name,
  email,
  phone_number,
  current_address,
  future_address,
  commission_dollar,
  commission_percentage,
  checklist,
  searchable
) VALUES (
  $1,
  $2,
  $3,
  $4,
  COALESCE($5, (
    SELECT id FROM users WHERE LOWER(email) = LOWER($13)
  )),
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
  $19,
  to_tsvector('english',
    COALESCE($9, '')  || ' ' ||
    COALESCE($10, '') || ' ' ||
    COALESCE($11, '') || ' ' ||
    COALESCE($12, '') || ' ' ||
    COALESCE($8, '')
  )
)

RETURNING id
