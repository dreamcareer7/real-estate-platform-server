WITH cids AS (
  DELETE FROM
    contacts_attributes AS ca
  WHERE
    ca.text ILIKE $2
    AND attribute_type = 'tag'
    AND ca.contact = ANY(
      SELECT
        id
      FROM
        contacts
      WHERE
        brand = $1
    )
  RETURNING
    ca.contact
)
SELECT DISTINCT contact AS id FROM cids
