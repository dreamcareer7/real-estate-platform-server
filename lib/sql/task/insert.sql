INSERT INTO tasks
(
  room,
  checklist,
  title,
  task_type,
  submission,
  form,
  is_deletable,
  required,
  origin,
  "order"
) VALUES (
  $1,
  $2,
  $3,
  $4,
  $5,
  $6,
  COALESCE($7, FALSE),
  COALESCE($8, FALSE),
  $9,
  COALESCE($10, 0)
)
RETURNING id
