UPDATE brands_checklists_tasks SET
  title = $2,
  task_type = $3,
  form = $4,
  "order" = $5,
  required = COALESCE($6, FALSE),
  tab_name = $7,
  acl = $8::task_acl[]
WHERE id = $1
