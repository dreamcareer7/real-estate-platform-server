UPDATE
  contacts
SET
  last_touch = tt.last_touch,
  last_touch_action = tt.last_touch_action,
  next_touch = tt.next_touch
FROM
  get_touch_times_for_contacts($1::uuid[]) AS tt
WHERE
  contacts.id = tt.contact
RETURNING
  contacts.id
