UPDATE brands_allowed_templates SET thumbnail_requested_at = NULL WHERE id = ANY($1)
