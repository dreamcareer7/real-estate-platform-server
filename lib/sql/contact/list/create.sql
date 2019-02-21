WITH list_id AS (
  INSERT INTO crm_lists (
    "created_by",
    brand,
    name,
    touch_freq,
    is_editable,
    is_and_filter,
    query
  ) VALUES (
    $1,
    $2,
    $3,
    $4,
    $5,
    $6,
    $7
  ) RETURNING id
), filters AS (
  INSERT INTO crm_lists_filters (
    crm_list,

    attribute_def,
    operator,
    "value",
    invert
  )
  SELECT
    list_id,
    attribute_def,
    COALESCE(operator, 'eq') AS operator,
    "value",
    COALESCE(invert, FALSE) AS invert
  FROM
    json_populate_recordset(null::crm_lists_filters, $8::json) AS filters,
    list_id AS l(list_id)
  RETURNING
    crm_list AS id
)
SELECT DISTINCT
  list_id.id
FROM
  list_id
  LEFT JOIN filters
    ON TRUE
