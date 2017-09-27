SELECT 'user' AS type,
       users.*,
       to_char(NOW() AT TIME ZONE users.timezone, 'FMHH:MI AM - FMDay Mon DD, YYYY') AS current_time,
       (((CURRENT_TIME(0) AT TIME ZONE users.timezone)::time > '08:00:00'::time) AND
       ((CURRENT_TIME(0) AT TIME ZONE users.timezone)::time < '23:59:59'::time)) AS push_allowed,
       EXTRACT(EPOCH FROM users.created_at)   AS created_at,
       EXTRACT(EPOCH FROM users.updated_at)   AS updated_at,
       EXTRACT(EPOCH FROM users.deleted_at)   AS deleted_at,
       EXTRACT(EPOCH FROM users.last_seen_at) AS last_seen_at,
       COALESCE
       (
         profile_image_url,
         (
           SELECT url FROM agents_images WHERE mui =
           (
             SELECT matrix_unique_id FROM agents WHERE id = users.agent
           ) AND image_type = 'Profile' ORDER BY date DESC LIMIT 1
         )
       ) as profile_image_url,
       COALESCE
       (
         cover_image_url,
         (
           SELECT url FROM agents_images WHERE mui =
           (
             SELECT matrix_unique_id FROM agents WHERE id = users.agent
           ) AND image_type = 'Cover' ORDER BY date DESC LIMIT 1
         )
       ) as cover_image_url,
       (
         CASE WHEN $2::uuid IS NOT NULL THEN (
           WITH c AS
           (
             SELECT id
             FROM contacts
             WHERE "user" = $2::uuid AND
             deleted_at IS NULL
           ),
           ce AS
           (
             SELECT contact
             FROM contacts_emails
             WHERE contact IN (SELECT id FROM c) AND
             email = users.email AND
             deleted_at IS NULL
           ),
           cp AS
           (
             SELECT contact
             FROM contacts_phone_numbers
             WHERE contact IN (SELECT id FROM c) AND
             phone_number = users.phone_number AND
             deleted_at IS NULL
           )
           SELECT ARRAY_AGG(DISTINCT(contact)) FROM
           (
             SELECT contact FROM ce
             UNION ALL
             SELECT contact FROM cp
           ) p
         ) ELSE NULL END
       ) AS contacts,
       (
        SELECT count(*) > 0 FROM docusign_users WHERE "user" = users.id
       ) as has_docusign,

       (
        WITH roles AS (
          SELECT brand, ARRAY_AGG(access) AS acl FROM
            (
              SELECT
                DISTINCT UNNEST(brands_roles.acl) as access,
                brands_roles.brand,
                'user_roles' as type
              FROM brands_users JOIN brands_roles ON brands_users.role = brands_roles.id
              WHERE brands_users.user = users.id
            ) roles GROUP BY brand
        )

        SELECT JSON_AGG(roles) FROM roles
       ) as roles
FROM users
JOIN unnest($1::uuid[]) WITH ORDINALITY t(uid, ord) ON users.id = uid
ORDER BY t.ord
