SELECT
  id,
  EXTRACT(EPOCH FROM created_at) AS created_at,
  EXTRACT(EPOCH FROM updated_at) AS updated_at,
  EXTRACT(EPOCH FROM deleted_at) AS deleted_at,
  title,
  "description",
  EXTRACT(EPOCH FROM due_date) AS due_date,
  EXTRACT(EPOCH FROM end_date) AS end_date,
  "status",
  task_type,
  all_day,
  metadata,
  (
    SELECT
      ARRAY_AGG("user" ORDER BY created_at)
    FROM
      crm_tasks_assignees
    WHERE
      $2 && ARRAY['crm_task.assignees']
      AND crm_task = crm_tasks.id
      AND deleted_at IS NULL
      AND EXISTS (
        SELECT
          brand
        FROM
          user_brands(crm_tasks_assignees."user", NULL) ub
        WHERE
          ub.brand = crm_tasks.brand
      )
  ) AS assignees,
  (
    SELECT
      ARRAY_AGG(id ORDER BY index, "created_at")
    FROM
      crm_associations
    WHERE
      $2 @> ARRAY['crm_task.associations']
      AND crm_task = crm_tasks.id
      AND deleted_at IS NULL
    LIMIT $3
  ) as associations,
  (
    SELECT
      array_agg(id)
    FROM
      role_files
    WHERE
      $2 @> ARRAY['crm_task.files']
      AND "role" = 'CrmTask'
      AND role_id = crm_tasks.id
  ) as files,
  (
    SELECT
      ARRAY_AGG(id ORDER BY "created_at")
    FROM
      reminders
    WHERE
      task = crm_tasks.id
      AND deleted_at IS NULL
  ) as reminders,
  brand,
  created_by,
  updated_by,
  'crm_task' as "type"
FROM
  crm_tasks
JOIN unnest($1::uuid[]) WITH ORDINALITY t(did, ord)
  ON crm_tasks.id = did
ORDER BY
  t.ord
