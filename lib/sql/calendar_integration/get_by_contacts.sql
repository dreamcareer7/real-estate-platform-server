SELECT id FROM calendar_integration WHERE contact = ANY($1::uuid[]) AND deleted_at IS NULL