SELECT
    *, 'showings_credentials' AS type
FROM
    showings_credentials
JOIN 
    unnest($1::uuid[]) WITH ORDINALITY t(srid, ord)
ON 
    showings_credentials.id = srid
ORDER BY 
    t.ord