SELECT
  *
FROM
  users_jobs 
WHERE
  microsoft_credential IS NOT NULL
  AND job_name = 'calendar'
  AND ((start_at <= (NOW() - $1::interval) OR start_at IS NULL) OR status = 'waiting')
  AND deleted_at IS NULL
FOR UPDATE SKIP LOCKED