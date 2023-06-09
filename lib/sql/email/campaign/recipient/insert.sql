WITH to_insert AS (
  SELECT
    campaign,
    tag,
    list,
    contact,
    email,
    brand,
    send_type,
    recipient_type,
    agent
  FROM json_populate_recordset(NULL::email_campaigns_recipients, $1::json)
),

clear AS (
  DELETE FROM email_campaigns_recipients WHERE campaign IN (
    SELECT campaign FROM to_insert
  )
)

INSERT INTO email_campaigns_recipients
(campaign, tag, list, contact, email, brand, send_type, recipient_type, agent)

SELECT * FROM to_insert
