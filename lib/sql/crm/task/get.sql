SELECT
    id,
    EXTRACT(EPOCH FROM created_at) AS created_at,
    EXTRACT(EPOCH FROM updated_at) AS updated_at,
    EXTRACT(EPOCH FROM deleted_at) AS deleted_at,
    title,
    "description",
    EXTRACT(EPOCH FROM due_date) AS due_date,
    "status",
    task_type,
    assignee,
    (
        SELECT
            ARRAY_AGG(id ORDER BY "created_at")
        FROM
            crm_associations
        WHERE
            crm_task = crm_tasks.id
            AND deleted_at IS NULL
    ) as associations,
    (
        SELECT
            ARRAY_AGG(id ORDER BY "created_at")
        FROM
            reminders
        WHERE
            task = crm_tasks.id
            AND deleted_at IS NULL
    ) as reminders,
    'crm_task' as "type"
FROM
    crm_tasks
JOIN unnest($1::uuid[]) WITH ORDINALITY t(did, ord) ON crm_tasks.id = did
WHERE
    deleted_at IS NULL
ORDER BY t.ord