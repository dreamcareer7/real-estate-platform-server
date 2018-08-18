SELECT envelopes.*,
       'envelope' AS type,
       EXTRACT(EPOCH FROM created_at) AS created_at,
       EXTRACT(EPOCH FROM updated_at) AS updated_at,
       -- The reason we ORDER recipients and documents
       -- is to make sure the are predictable for tests
       -- That's also a better and more predictable UI
       (
         SELECT ARRAY_AGG(id ORDER BY envelopes_recipients.created_at)
         FROM envelopes_recipients WHERE envelopes_recipients.envelope = envelopes.id
       ) AS recipients,
       (
        SELECT ARRAY_AGG(id ORDER BY envelopes_documents.document_id)
        FROM envelopes_documents WHERE envelopes_documents.envelope = envelopes.id
       ) AS documents,
       webhook_token
FROM envelopes
JOIN unnest($1::uuid[]) WITH ORDINALITY t(eid, ord) ON envelopes.id = eid
ORDER BY t.ord
