SELECT
    google_calendars.*, 'google_calendars' AS type
FROM
    google_calendars
JOIN 
    unnest($2::uuid[]) WITH ORDINALITY t(gcid, ord)
ON 
    google_calendars.id = gcid
ORDER BY 
    google_calendars.created_at DESC