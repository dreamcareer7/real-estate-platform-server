SELECT id FROM contact_integration WHERE microsoft_id = ANY($1::uuid[])