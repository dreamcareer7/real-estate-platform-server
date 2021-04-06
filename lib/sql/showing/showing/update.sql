UPDATE
  showings
SET
  updated_at = NOW(),
  updated_by = $1::uuid,
  start_date = $2::timestamptz,
  end_date = $3::timestamptz,
  duration = $4 * '1 second'::interval,
  notice_period = $5 * '1 second'::interval,
  feedback_template = $6::uuid,
  address = JSON_TO_STDADDR($7::json),
  allow_appraisal = $8::boolean,
  allow_inspection = $9::boolean,
  instructions = $10
WHERE
  id = $1::uuid
