SELECT *,
  'envelope_recipient' AS type,
   EXTRACT(EPOCH FROM created_at) AS created_at,
   EXTRACT(EPOCH FROM updated_at) AS updated_at

FROM envelopes_recipients WHERE id = $1