INSERT INTO google_calendar_events
  (
    google_credential,
    google_calendar,
    event_id,
    description,
    summary,
    location,
    color_id,
    ical_uid,
    transparency,
    visibility,
    hangout_link,
    html_link,
    status,
    sequence,
    anyone_can_add_self,
    guests_can_invite_others,
    guests_can_modify,
    guests_can_see_other_guests,
    attendees_omitted,
    locked,
    private_copy,
    creator,
    organizer,
    attendees,
    attachments,
    conference_data,
    extended_properties,
    gadget,
    reminders,
    source,
    created,
    updated,
    event_start,
    event_end,
    end_time_unspecified,
    recurrence,
    recurring_event_id,
    original_start_time,
    etag,
    origin
  )
VALUES
  (
    $1,
    $2,
    $3,
    $4,
    $5,
    $6,
    $7,
    $8,
    $9,
    $10,
    $11,
    $12,
    $13,
    $14,
    $15,
    $16,
    $17,
    $18,
    $19,
    $20,
    $21,
    $22,
    $23,
    $24,
    $25,
    $26,
    $27,
    $28,
    $29,
    $30,
    $31,
    $32,
    $33,
    $34,
    $35,
    $36,
    $37,
    $38,
    $39,
    $40
  )
ON CONFLICT (google_credential, google_calendar, event_id) DO UPDATE SET
  description = $4,
  summary = $5,
  location = $6,
  color_id = $7,
  ical_uid = $8,
  transparency = $9,
  visibility = $10,
  hangout_link = $11,
  html_link = $12,
  status = $13,
  sequence = $14,
  anyone_can_add_self = $15,
  guests_can_invite_others = $16,
  guests_can_modify = $17,
  guests_can_see_other_guests = $18,
  attendees_omitted = $19,
  locked = $20,
  private_copy = $21,
  creator = $22,
  organizer = $23,
  attendees = $24,
  attachments = $25,
  conference_data = $26,
  extended_properties = $27,
  gadget = $28,
  reminders = $29,
  source = $30,
  created = $31,
  updated = $32,
  event_start = $33,
  event_end = $34,
  end_time_unspecified = $35,
  recurrence = $36,
  recurring_event_id = $37,
  original_start_time = $38,
  etag = $39,
  origin = $40,
  updated_at = now(),
  deleted_at = null
RETURNING id