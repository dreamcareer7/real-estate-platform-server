ALTER TABLE contacts
  ADD COLUMN created_by uuid REFERENCES users(id),
  ADD COLUMN brand uuid REFERENCES brands(id),
  ADD COLUMN parent uuid REFERENCES contacts(id);

UPDATE contacts
  SET created_by = "user",
  SET parent = id;

ALTER TABLE contacts ALTER COLUMN created_by SET NOT NULL;
ALTER TABLE contacts ALTER COLUMN parent SET NOT NULL;

ALTER TABLE contacts_attributes
  ADD COLUMN "text" text,
  ADD COLUMN "date" timestamptz,
  ADD COLUMN "number" double precision,
  ADD COLUMN created_by uuid REFERENCES users(id);

UPDATE
  contacts_attributes
SET
  created_by = contacts."user"
FROM
  contacts
WHERE
  contacts_attributes.contact = contacts.id;

UPDATE
  contacts_attributes
SET
  "text" = attribute->>attribute_type
WHERE
  attribute_type NOT IN ('name', 'address', 'birthday', 'last_modified_on_source');

INSERT INTO contacts_attributes
  (contact, "text", created_at, updated_at, deleted_at, label, is_primary, attribute_type)
SELECT
  contact,
  email,
  created_at,
  updated_at,
  deleted_at,
  label,
  is_primary,
  'email' AS attribute_type
FROM
  contacts_emails;

INSERT INTO contacts_attributes
  (contact, "text", created_at, updated_at, deleted_at, label, is_primary, attribute_type)
SELECT
  contact,
  phone_number,
  created_at,
  updated_at,
  deleted_at,
  label,
  is_primary,
  'phone_number' AS attribute_type
FROM
  contacts_phone_numbers;

UPDATE contacts_attributes
  SET "date" = to_timestamp((attribute->>attribute_type)::float / 1000)
where
  (attribute->>attribute_type)::float > extract(epoch from now())
  AND attribute_type = 'last_modified_on_source';

UPDATE contacts_attributes
  SET "date" = to_timestamp((attribute->>attribute_type)::float)
WHERE
  attribute_type = 'birthday' OR attribute_type = 'last_modified_on_source'
  AND (attribute->>attribute_type)::float <= extract(epoch from now())
  AND deleted_at IS NULL;

INSERT INTO contacts_attributes
  (contact, "text", created_at, updated_at, deleted_at, label, is_primary, attribute_type)
SELECT
  contact,
  names.value,
  created_at,
  updated_at,
  deleted_at,
  label,
  is_primary,
  names.key
FROM
  contacts_attributes,
  jsonb_each_text(attribute) as names
WHERE
  attribute_type = 'name'
  AND names.key IN ('first_name', 'middle_name', 'last_name', 'title', 'nickname')
  AND char_length(names.value) > 0;

INSERT INTO contacts_attributes
  (contact, "text", created_at, updated_at, deleted_at, label, is_primary, attribute_type)
SELECT
  contact,
  addresses.value,
  created_at,
  updated_at,
  deleted_at,
  label,
  is_primary,
  addresses.key
FROM
  contacts_attributes,
  jsonb_each_text(attribute) as addresses
WHERE
  attribute_type = 'address'
  AND addresses.key IN ('state', 'city', 'postal_code', 'country', 'zip_code', 'street_name')
  AND char_length(addresses.value) > 0;

DELETE FROM contacts_attributes WHERE attribute_type IN ('name', 'address');

DROP TABLE contacts_emails;
DROP TABLE contacts_phone_numbers;
