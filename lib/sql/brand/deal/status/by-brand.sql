SELECT id FROM brands_deal_statuses
WHERE brand IN (SELECT brand_parents($1::uuid))
AND deleted_at IS NULL
