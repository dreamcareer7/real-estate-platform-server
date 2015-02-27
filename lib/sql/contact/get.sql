SELECT contact_id
FROM contacts
WHERE
  user_id = $1
AND CASE
    WHEN $2 = 'Since_C' THEN created_at > TIMESTAMP WITH TIME ZONE 'EPOCH' + $3 * INTERVAL '1 SECOND'
    WHEN $2 = 'Max_C' THEN created_at < TIMESTAMP WITH TIME ZONE 'EPOCH' + $3 * INTERVAL '1 SECOND'
    WHEN $2 = 'Since_U' THEN updated_at > TIMESTAMP WITH TIME ZONE 'EPOCH' + $3 * INTERVAL '1 SECOND'
    WHEN $2 = 'Max_U' THEN updated_at < TIMESTAMP WITH TIME ZONE 'EPOCH' + $3 * INTERVAL '1 SECOND'
    ELSE TRUE
    END
ORDER BY
    CASE $2
        WHEN 'Since_C' THEN created_at
        WHEN 'Since_U' THEN updated_at
    END,
    CASE $2
        WHEN 'Max_C' THEN created_at
        WHEN 'Max_U' THEN updated_at
    END DESC
LIMIT $4;
