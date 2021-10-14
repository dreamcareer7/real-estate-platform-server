INSERT INTO showinghub.showable_listings (
  id,
  application_id,
  listing_id,
  created_on,
  upi,
  address1,
  city,
  state,
  zip_code,
  list_agent_mls_id,
  list_agent_name,
  list_agent_license_state_affirmation,
  list_agent_license_number,
  list_agent_license_state,
  showable_start_date,
  showable_end_date,
  showing_instructions,
  required_participants,
  showing_method,
  confirmation_type,
  showings_allowed,
  showing
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
  $19,
  $20,
  $21,
  $22
)
