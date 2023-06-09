INSERT INTO agents
(
  email,
  mlsid,
  fax,
  full_name,
  first_name,
  last_name,
  middle_name,
  phone_number,
  nar_number,
  office_mui,
  status,
  office_mlsid,
  work_phone,
  generational_name,
  matrix_unique_id,
  matrix_modified_dt,
  license_number,
  designation,
  mls,
  nrds
)
VALUES
(
  $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20
)
ON CONFLICT (matrix_unique_id, mls) DO UPDATE SET
  email = $1,
  mlsid = $2,
  fax = $3,
  full_name = $4,
  first_name = $5,
  last_name = $6,
  middle_name = $7,
  phone_number = $8,
  nar_number = $9,
  office_mui = $10,
  status = $11,
  office_mlsid = $12,
  work_phone = $13,
  generational_name = $14,
  matrix_modified_dt = $16,
  license_number = $17,
  designation = $18,
  nrds = $20,
  updated_at = CLOCK_TIMESTAMP()
  WHERE agents.matrix_unique_id = $15 AND agents.mls =$19::mls
RETURNING id
