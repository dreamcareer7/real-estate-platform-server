SELECT *,
  'envelope_document' AS type,
   EXTRACT(EPOCH FROM created_at) AS created_at,
   EXTRACT(EPOCH FROM updated_at) AS updated_at

FROM envelopes_documents WHERE id = $1