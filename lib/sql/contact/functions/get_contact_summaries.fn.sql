CREATE OR REPLACE FUNCTION get_contact_summaries(contact_ids uuid[])
RETURNS TABLE (
  id uuid,
  title text,
  first_name text,
  middle_name text,
  last_name text,
  nickname text,
  email text,
  phone_number text,
  company text,
  birthday double precision,
  profile_image_url text,
  cover_image_url text,
  job_title text,
  source_type text,
  source_id text,
  stage text,
  source text
)
LANGUAGE plpgsql
AS $function$
  DECLARE
    cid_values text;
    crosstab_sql text;
  BEGIN
    cid_values := $$('$$ || array_to_string(contact_ids, $$'),('$$) || $$')$$;

    crosstab_sql := $ctsql$
      WITH contact_ids(id) AS ( VALUES $ctsql$ || cid_values || $ctsql$ )
      SELECT DISTINCT ON (contacts.id, contacts_attributes.attribute_def)
        contacts.id,
        contacts_attribute_defs.name,
        COALESCE(
          contacts_attributes.text,
          contacts_attributes.number::text,
          contacts_attributes.date::text
        ) AS "value"
      FROM
        contacts
        JOIN contacts_attributes ON contacts_attributes.contact = contacts.id
        JOIN contacts_attribute_defs ON contacts_attributes.attribute_def = contacts_attribute_defs.id
        JOIN contact_ids ON contacts.id = contact_ids.id::uuid
      WHERE
        contacts_attributes.deleted_at IS NULL
        AND contacts.deleted_at IS NULL
        AND global IS True
        AND (singular IS TRUE OR name = 'email' OR name = 'phone_number' OR name = 'company')
      ORDER BY
        contacts.id,
        contacts_attributes.attribute_def,
        contacts_attributes.is_primary desc,
        contacts_attributes.updated_at desc
    $ctsql$;

    RETURN QUERY SELECT
      cids.id,
      contacts_summaries.title,
      contacts_summaries.first_name,
      contacts_summaries.middle_name,
      contacts_summaries.last_name,
      contacts_summaries.nickname,
      contacts_summaries.email,
      contacts_summaries.phone_number,
      contacts_summaries.company,
      extract(epoch from contacts_summaries.birthday) AS birthday,
      contacts_summaries.profile_image_url,
      contacts_summaries.cover_image_url,
      contacts_summaries.job_title,
      contacts_summaries.source_type,
      contacts_summaries.source_id,
      contacts_summaries.stage,
      contacts_summaries.source
    FROM
      unnest(contact_ids) AS cids(id)
      LEFT JOIN crosstab(crosstab_sql, $$
      VALUES
        ('title'),
        ('first_name'),
        ('middle_name'),
        ('last_name'),
        ('nickname'),
        ('email'),
        ('phone_number'),
        ('company'),
        ('birthday'),
        ('profile_image_url'),
        ('cover_image_url'),
        ('job_title'),
        ('source_type'),
        ('source_id'),
        ('last_modified_on_source'),
        ('stage'),
        ('source')
    $$) AS contacts_summaries(
      cid uuid,
      title text,
      first_name text,
      middle_name text,
      last_name text,
      nickname text,
      email text,
      phone_number text,
      company text,
      birthday timestamptz,
      profile_image_url text,
      cover_image_url text,
      job_title text,
      source_type text,
      source_id text,
      last_modified_on_source timestamptz,
      stage text,
      source text
    ) ON cids.id = contacts_summaries.cid;
  END;
$function$