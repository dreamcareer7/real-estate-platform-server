INSERT INTO microsoft_contact_folders
  (
    microsoft_credential,
    folder_id,
    parent_folder_id,
    display_ame
  )
VALUES
  (
    $1,
    $2,
    $3,
    $4
  )
ON CONFLICT (microsoft_credential, folder_id) DO UPDATE SET
  parent_folder_id = $3,
  display_ame = $4
RETURNING id