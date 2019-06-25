INSERT INTO deals_roles (
  created_by,
  role_type,
  role,
  deal,
  "user",
  brand,
  checklist,
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
  office_name,
  office_email,
  office_phone,
  office_fax,
  office_license_number,
  office_mls_id,
  office_address
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
  $20,
  $21,
  $22,
  $23,
  $24,
  $25,
  JSON_TO_STDADDR($26)
)

RETURNING id
