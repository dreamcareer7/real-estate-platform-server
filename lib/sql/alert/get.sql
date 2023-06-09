WITH uas as (
  select id, alert from user_alert_settings 
  WHERE "user" = $2
)
SELECT alerts.*,
       'alert' AS type,
       uas.id as user_alert_setting,
       (
         SELECT COUNT(recommendations.id)
         FROM recommendations
         LEFT JOIN recommendations_eav
           ON recommendations.id = recommendations_eav.recommendation AND
           (
             CASE WHEN $2::uuid IS NOT NULL THEN recommendations_eav."user" = $2 ELSE FALSE END
           ) AND
           recommendations_eav.action = 'Read'
         WHERE recommendations_eav.id IS NULL AND
               recommendations.deleted_at IS NULL AND
               recommendations.hidden IS FALSE AND
               COALESCE(ARRAY_LENGTH(recommendations.referring_objects, 1), 0) > 0 AND
               ARRAY[alerts.id] <@ recommendations.referring_objects
       ) AS new_recommendations,
       (
         SELECT url FROM recommendations
         INNER  JOIN listings ON listings.id = recommendations.listing
         INNER  JOIN photos   ON listings.matrix_unique_id = photos.listing_mui
                            AND listings.mls = photos.mls
         WHERE ARRAY[alerts.id] <@ recommendations.referring_objects
           AND url IS NOT NULL
         ORDER BY recommendations.updated_at DESC
         LIMIT 1
       ) as cover_image_url,
       (
         SELECT ARRAY_AGG(DISTINCT("user")) FROM rooms_users WHERE room = alerts.room
       ) AS users,
       ST_AsGeoJSON(points) AS points,
       EXTRACT(EPOCH FROM alerts.created_at) AS created_at,
       EXTRACT(EPOCH FROM alerts.updated_at) AS updated_at,
       EXTRACT(EPOCH FROM alerts.deleted_at) AS deleted_at,
       EXTRACT(EPOCH FROM alerts.minimum_sold_date) AS minimum_sold_date,
       property_types::text[] AS property_types,
       property_subtypes::text[] AS property_subtypes,
       listing_statuses::text[] AS listing_statuses,
       excluded_listing_ids::uuid[] AS excluded_listing_ids
FROM alerts
LEFT JOIN uas on (uas.alert = alerts.id)
JOIN unnest($1::uuid[]) WITH ORDINALITY t(aid, ord) ON alerts.id = aid
ORDER BY t.ord
