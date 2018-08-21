SELECT deals.*,
  'deal' AS type,
  EXTRACT(EPOCH FROM created_at) AS created_at,
  EXTRACT(EPOCH FROM updated_at) AS updated_at,
  EXTRACT(EPOCH FROM deleted_at) AS deleted_at,
  faired_at IS NULL as is_draft,
  (
    SELECT ARRAY_AGG(id ORDER BY created_at ASC) FROM deals_roles WHERE deal = deals.id AND deleted_at IS NULL
  ) AS roles,
  (
    SELECT ARRAY_AGG(id ORDER BY "order") FROM deals_checklists
    WHERE deal = deals.id AND deleted_at IS NULL
  ) as checklists,

  (
    SELECT ROW_TO_JSON(p.*) FROM
    (
      SELECT
      'mls_context' AS type,
      status AS listing_status,
      transaction_type,
      mls_number,
      mls_area_major,
      mls_area_minor,
      price AS list_price,
      EXTRACT(EPOCH FROM list_date) as list_date,
      property_type,
      year_built,
      city,
      county_or_parish AS county,
      postal_code,
      street_number,
      street_dir_prefix,
      street_name,
      street_suffix,
      postal_code,
      lot_number,
      subdivision_name AS subdivision,
      unit_number,
      state_code,
      state,
      (
        SELECT ARRAY_TO_STRING
        (
          ARRAY[
            addresses.street_number,
            addresses.street_dir_prefix,
            addresses.street_name,
            addresses.street_suffix,
            CASE
              WHEN addresses.unit_number IS NULL THEN NULL
              WHEN addresses.unit_number = '' THEN NULL
              ELSE 'Unit ' || addresses.unit_number || ',' END,
            addresses.city || ',',
            addresses.state_code,
            addresses.postal_code
          ], ' ', NULL
        )
      ) AS full_address,
      (
        SELECT ARRAY_TO_STRING(
          ARRAY[
          addresses.street_number,
          addresses.street_dir_prefix,
          addresses.street_name,
          addresses.street_suffix,
          CASE
            WHEN addresses.unit_number IS NULL THEN NULL
            WHEN addresses.unit_number = '' THEN NULL
            ELSE 'Unit ' || addresses.unit_number
          END
          ], ' ', NULL
        )
      ) AS street_address,
      (
        SELECT url FROM photos
        WHERE
        listing_mui = listings.matrix_unique_id
        AND photos.url IS NOT NULL
        AND photos.deleted_at IS NULL
        ORDER BY "order" LIMIT 1
      ) AS photo
      FROM listings
      JOIN properties ON listings.property_id = properties.id
      JOIN addresses ON properties.address_id = addresses.id
      WHERE listings.id = deals.listing
    ) p
  ) AS mls_context,

  (
    WITH c AS (
      SELECT
        id,
        type,
        key,
        text,
        number,
        date,
        context_type,
        EXTRACT(EPOCH FROM context.created_at) AS created_at,
        EXTRACT(EPOCH FROM context.approved_at) AS approved_at,
        EXTRACT(EPOCH FROM context.date) AS date
      FROM current_deal_context context WHERE context.deal = deals.id
    )

    SELECT
      JSON_OBJECT_AGG(c.key, c.*)
    FROM c
  ) as deal_context,

  (
    SELECT ARRAY_AGG(id) FROM envelopes WHERE deal = deals.id
  ) as envelopes,

  CASE WHEN $2::uuid IS NULL THEN
    NULL
  ELSE
  (
    SELECT JSON_AGG(
      JSON_BUILD_OBJECT
        (
          'id', id,
          'notification_type', (subject_class::text || action || object_class::text),
          'room', room,
          'type', 'notification_summary'
        )
      ) FROM new_notifications nn
    WHERE nn.user = $2
    AND (
      (
        nn.auxiliary_object_class = 'Deal'
        AND
        nn.auxiliary_object = deals.id
      )
      OR
      (
        nn.auxiliary_subject_class = 'Deal'
        AND
        nn.auxiliary_subject = deals.id
      )
      OR
      (
        nn.subject_class = 'Deal'
        AND
        nn.subject = deals.id
      )
    )
    AND (nn.room IS NULL OR nn.room NOT IN(
      SELECT room FROM tasks
        WHERE checklist IN (SELECT id FROM deals_checklists WHERE deal = deals.id)
        AND deleted_at IS NOT NULL
    ))
  )
  END AS new_notifications,

  (
    SELECT
      ARRAY_AGG(DISTINCT brands_checklists.tab_name)
    FROM tasks
    JOIN deals_checklists  ON tasks.checklist = deals_checklists.id
    JOIN brands_checklists ON deals_checklists.origin = brands_checklists.id
    WHERE
      deals_checklists.deal = deals.id
      AND deals_checklists.deleted_at IS NULL
      AND tasks.attention_requested_at IS NOT NULL
      AND tasks.deleted_at IS NULL
  ) as inboxes,

  (
    SELECT
      COUNT(*)::INT
    FROM tasks
    JOIN deals_checklists  ON tasks.checklist = deals_checklists.id
    WHERE
      deals_checklists.deal = deals.id
      AND deals_checklists.terminated_at  IS NULL
      AND deals_checklists.deactivated_at IS NULL
      AND deals_checklists.deleted_at IS NULL
      AND tasks.attention_requested_at IS NOt NULL
      AND tasks.deleted_at IS NULL
  ) as attention_requests,

  -- The logic for this part is a bit complex.
  -- Basically, backoffice needs to know when this deal was submitted.
  -- And we calculate the first time tht the first task was submitted on.
  -- So, so far, we need the earliest task that was submmited.
  -- That's calculated in the window function.
  -- However, there's a neat complexity:
  -- If the deal was a draft at the time of submission,
  -- Then the real time it was submitted would be the time it went live.
  -- That's why we have that LEAST statement.
  -- Please note that if there's nothing submitted, then attention_requested_at
  -- Is expected to be NULL, hence that IS NULL check
  -- More explanation at server#1146
  (
    WITH earliest_task AS (
      SELECT
        MIN(attention_requested_at) as attention_requested_at
      FROM tasks
      JOIN deals_checklists  ON tasks.checklist = deals_checklists.id
      WHERE
        deals_checklists.deal = deals.id
        AND deals_checklists.terminated_at  IS NULL
        AND deals_checklists.deactivated_at IS NULL
        AND deals_checklists.deleted_at IS NULL
        AND tasks.attention_requested_at IS NOT NULL
        AND tasks.deleted_at IS NULL
    )
    SELECT
      CASE WHEN (SELECT attention_requested_at FROM earliest_task) IS NULL THEN NULL
      ELSE LEAST(
        EXTRACT(EPOCH FROM (SELECT attention_requested_at FROM earliest_task)),
        EXTRACT(EPOCH FROM deals.faired_at)
      )
      END
  ) as attention_requested_at,

  (
    SELECT count(*) > 0 FROM deals_checklists
    JOIN brands_checklists ON deals_checklists.origin = brands_checklists.id
    WHERE
      deals_checklists.deal = deals.id
      AND deals_checklists.deactivated_at IS NULL
      AND deals_checklists.terminated_at  IS NULL
      AND deals_checklists.deleted_at IS NULL
      AND brands_checklists.deal_type = 'Buying'
  ) as has_active_offer,

  (
    SELECT
      ARRAY_AGG(id)
    FROM
      role_files
    WHERE
      "role" = 'Deal'
      AND role_id = deals.id
  ) AS files

FROM deals
JOIN unnest($1::uuid[]) WITH ORDINALITY t(did, ord) ON deals.id = did
ORDER BY t.ord
