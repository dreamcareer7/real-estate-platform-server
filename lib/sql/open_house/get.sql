SELECT id,
       type as open_house_type,
       'open_house' as type,
       EXTRACT(EPOCH FROM created_at) as created_at,
       EXTRACT(EPOCH FROM updated_at) as updated_at,
       EXTRACT(EPOCH FROM start_time) as start_time,
       EXTRACT(EPOCH FROM end_time)   as end_time,
       description
FROM open_houses
JOIN unnest($1::uuid[]) WITH ORDINALITY t(oid, ord) ON open_houses.id = oid
ORDER BY t.ord
