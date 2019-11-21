INSERT INTO email_campaigns (
  due_at,
  created_by,
  "from",
  brand,
  template,
  deal,
  subject,
  include_signature,
  individual,
  html,
  text,
  headers,
  google_credential,
  microsoft_credential
)
SELECT
  due_at,
  created_by,
  "from",
  brand,
  template,
  deal,
  subject,
  COALESCE(include_signature, false),
  COALESCE(individual, false),
  html,
  text,
  headers,
  google_credential,
  microsoft_credential
FROM json_populate_recordset(NULL::email_campaigns, $1::json)
RETURNING id
