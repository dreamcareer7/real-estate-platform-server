UPDATE photos SET
  deleted_at = CASE
    WHEN matrix_unique_id = ANY($3::text[]) THEN NULL
    ELSE COALESCE(deleted_at, NOW())
  END
WHERE listing_mui = $1 AND mls = $2::mls
