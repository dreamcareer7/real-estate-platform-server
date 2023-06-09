INSERT INTO calendar_integration (
  google_id,
  microsoft_id,

  crm_task,
  contact,
  contact_attribute,
  deal_context,

  object_type,
  event_type,
  origin,
  etag,
  local_etag
)
SELECT
  google_id,
  microsoft_id,

  crm_task,
  contact,
  contact_attribute,
  deal_context,

  object_type,
  event_type,
  origin,
  etag,
  local_etag
FROM json_populate_recordset(NULL::calendar_integration, $1::json)
RETURNING id, google_id, microsoft_id, crm_task, contact, contact_attribute, deal_context,object_type, event_type, origin, etag, local_etag