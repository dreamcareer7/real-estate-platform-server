SELECT DISTINCT(rooms_users."user") AS id
FROM recommendations
INNER JOIN rooms_users
  ON rooms_users.room = recommendations.room
WHERE recommendations.listing = $1 AND
      recommendations.deleted_at IS NULL AND
      COALESCE(ARRAY_LENGTH(recommendations.referring_objects, 1), 0) > 0
