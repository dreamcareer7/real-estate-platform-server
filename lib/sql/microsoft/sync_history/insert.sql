INSERT INTO microsoft_sync_histories
  (
    "user",
    brand,

    microsoft_credential,

    extract_contacts_error,
    synced_contacts_num,
    contacts_total,

    sync_messages_error,
    synced_messages_num,
    messages_total,

    sync_duration,

    status
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
    $11
  )
RETURNING id