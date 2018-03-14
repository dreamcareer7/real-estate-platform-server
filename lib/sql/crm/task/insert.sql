INSERT INTO crm_tasks (
    created_by,
    brand,
    assignee,
    title,
    description,
    due_date,
    status,
    task_type
)
VALUES (
    $1,
    $2,
    $3,
    $4,
    $5,
    $6,
    $7,
    $8
)
RETURNING id