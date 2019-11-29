const db = require('../lib/utils/db')

const migrations = [
  'BEGIN',
  `CREATE TABLE IF NOT EXISTS email_threads (
    id text PRIMARY KEY NOT NULL,
    created_at timestamptz NOT NULL DEFAULT NOW(),
    updated_at timestamptz NOT NULL DEFAULT NOW(),

    brand uuid NOT NULL REFERENCES brands (id),
    "user" uuid NOT NULL REFERENCES users (id),
  
    google_credential uuid REFERENCES google_credentials (id),
    microsoft_credential uuid REFERENCES microsoft_credentials (id),
  
    subject text,
    first_message_in_reply_to text,
    first_message_date timestamptz NOT NULL,
    last_message_date timestamptz NOT NULL,
    recipients text[],
    message_count integer
  )`,

  `CREATE OR REPLACE FUNCTION update_google_threads_on_new_messages() RETURNS trigger
  LANGUAGE plpgsql
  AS $$
    BEGIN
      INSERT INTO email_threads (
        id,
        google_credential,
        "user",
        brand,
        "subject",
        first_message_in_reply_to,
        first_message_date,
        last_message_date,
        recipients,
        message_count
      )
      (
        WITH thread_recipients AS (
          SELECT
            thread_key, array_agg(DISTINCT recipient) AS recipients
          FROM
            new_messages, unnest(recipients) AS t(recipient)
          GROUP BY
            thread_key
        )
        SELECT DISTINCT ON (new_messages.thread_key)
          new_messages.thread_key,
          google_credential,
          google_credentials."user",
          google_credentials.brand,
          last_value(subject) OVER (w) AS "subject",
          first_value(new_messages.in_reply_to) OVER (w) AS first_message_in_reply_to,
          min(message_date) OVER (w) AS first_message_date,
          max(message_date) OVER (w) AS last_message_date,
          thread_recipients.recipients AS recipients,
          count(*) OVER (w) AS message_count
        FROM
          new_messages
          JOIN google_credentials
            ON new_messages.google_credential = google_credentials.id
          JOIN thread_recipients USING (thread_key)
        WINDOW w AS (PARTITION BY thread_key ORDER BY message_date)
        ORDER BY
          new_messages.thread_key, message_date
      )
      ON CONFLICT (id) DO UPDATE SET
        updated_at = now(),
        last_message_date = EXCLUDED.last_message_date,
        recipients = (
          SELECT
            array_agg(DISTINCT recipient)
          FROM
            unnest(COALESCE(email_threads.recipients, '{}'::text[]) || COALESCE(EXCLUDED.recipients, '{}'::text[])) u(recipient)
        ),
        message_count = email_threads.message_count + EXCLUDED.message_count;
      
      RETURN NULL;
    END;
  $$`,

  `CREATE OR REPLACE FUNCTION update_microsoft_threads_on_new_messages() RETURNS trigger
  LANGUAGE plpgsql
  AS $$
    BEGIN
      INSERT INTO email_threads (
        id,
        microsoft_credential,
        "user",
        brand,
        "subject",
        first_message_in_reply_to,
        first_message_date,
        last_message_date,
        recipients,
        message_count
      )
      (
        WITH thread_recipients AS (
          SELECT
            thread_key, array_agg(DISTINCT recipient) AS recipients
          FROM
            new_messages, unnest(recipients) AS t(recipient)
          GROUP BY
            thread_key
        )
        SELECT DISTINCT ON (new_messages.thread_key)
          new_messages.thread_key,
          microsoft_credential,
          microsoft_credentials."user",
          microsoft_credentials.brand,
          last_value(subject) OVER (w) AS "subject",
          first_value(new_messages.in_reply_to) OVER (w) AS first_message_in_reply_to,
          min(message_date) OVER (w) AS first_message_date,
          max(message_date) OVER (w) AS last_message_date,
          thread_recipients.recipients AS recipients,
          count(*) OVER (w) AS message_count
        FROM
          new_messages
          JOIN microsoft_credentials
            ON new_messages.microsoft_credential = microsoft_credentials.id
          JOIN thread_recipients USING (thread_key)
        WINDOW w AS (PARTITION BY thread_key ORDER BY message_date)
        ORDER BY
          new_messages.thread_key, message_date
      )
      ON CONFLICT (id) DO UPDATE SET
        updated_at = now(),
        last_message_date = EXCLUDED.last_message_date,
        recipients = (
          SELECT
            array_agg(DISTINCT recipient)
          FROM
            unnest(COALESCE(email_threads.recipients, '{}'::text[]) || COALESCE(EXCLUDED.recipients, '{}'::text[])) u(recipient)
        ),
        message_count = email_threads.message_count + EXCLUDED.message_count;
  
      RETURN NULL;
    END;
  $$`,

  `CREATE OR REPLACE VIEW analytics.calendar AS (
    (
      SELECT
        id::text,
        created_by,
        created_at,
        updated_at,
        'crm_task' AS object_type,
        task_type AS event_type,
        task_type AS type_label,
        due_date AS "timestamp",
        due_date AS "date",
        NULL::timestamptz AS next_occurence,
        end_date,
        False AS recurring,
        title,
        id AS crm_task,
        NULL::uuid AS deal,
        NULL::uuid AS contact,
        NULL::uuid AS campaign,
        NULL::uuid AS credential_id,
        NULL::text AS thread_key,
        (
          SELECT
            ARRAY_AGG("user")
          FROM
            crm_tasks_assignees
          WHERE
            crm_task = crm_tasks.id
            AND deleted_at IS NULL
        ) AS users,
        (
          SELECT
            ARRAY_AGG(json_build_object(
              'id', contact,
              'type', 'contact'
            ))
          FROM
            (
              SELECT
                contact
              FROM
                crm_associations
              WHERE
                crm_task = crm_tasks.id
                AND deleted_at IS NULL
                AND association_type = 'contact'
              LIMIT 5
            ) t
        ) AS people,
        (
          SELECT
            COUNT(contact)::INT
          FROM
            crm_associations
          WHERE
            crm_task = crm_tasks.id
            AND deleted_at IS NULL
            AND association_type = 'contact'
          LIMIT 5
        ) AS people_len,
        brand,
        status,
        jsonb_build_object(
          'status', status
        ) AS metadata
      FROM
        crm_tasks
      WHERE
        deleted_at IS NULL
    )
    UNION ALL
    (
      SELECT
        ca.id::text,
        ct.created_by,
        ct.created_at,
        ct.updated_at,
        'crm_association' AS object_type,
        ct.task_type AS event_type,
        ct.task_type AS type_label,
        ct.due_date AS "timestamp",
        ct.due_date AS "date",
        NULL::timestamptz AS next_occurence,
        ct.end_date,
        False AS recurring,
        ct.title,
        ct.id AS crm_task,
        ca.deal,
        ca.contact,
        ca.email AS campaign,
        NULL::uuid AS credential_id,
        NULL::text AS thread_key,
        (
          SELECT
            ARRAY_AGG("user")
          FROM
            crm_tasks_assignees
          WHERE
            crm_task = ct.id
            AND deleted_at IS NULL
        ) AS users,
        (
          SELECT
            ARRAY_AGG(json_build_object(
              'id', contact,
              'type', 'contact'
            ))
          FROM
            (
              SELECT
                contact
              FROM
                crm_associations
              WHERE
                crm_task = ct.id
                AND deleted_at IS NULL
                AND association_type = 'contact'
              LIMIT 5
            ) t
        ) AS people,
        (
          SELECT
            COUNT(contact)::INT
          FROM
            crm_associations
          WHERE
            crm_task = ct.id
            AND deleted_at IS NULL
            AND association_type = 'contact'
        ) AS people_len,
        ct.brand,
        ct.status,
        jsonb_build_object(
          'status', ct.status
        ) AS metadata
      FROM
        crm_associations AS ca
        JOIN crm_tasks AS ct
          ON ca.crm_task = ct.id
      WHERE
        ca.deleted_at IS NULL
        AND ct.deleted_at IS NULL
    )
    UNION ALL
    (
      SELECT
        cdc.id::text,
        deals.created_by,
        cdc.created_at,
        cdc.created_at AS updated_at,
        'deal_context' AS object_type,
        cdc."key" AS event_type,
        bc.label AS type_label,
        cdc."date" AS "timestamp",
        timezone('UTC', date_trunc('day', cdc."date")) AT TIME ZONE 'UTC' AS "date",
        cdc."date" AS next_occurence,
        NULL::timestamptz AS end_date,
        False AS recurring,
        deals.title,
        NULL::uuid AS crm_task,
        cdc.deal,
        NULL::uuid AS contact,
        NULL::uuid AS campaign,
        NULL::uuid AS credential_id,
        NULL::text AS thread_key,
        (
          SELECT
            ARRAY_AGG(DISTINCT r."user")
          FROM
            deals_roles AS r
          WHERE
            r.deal = deals.id
            AND r.deleted_at IS NULL
            AND r."user" IS NOT NULL
        ) AS users,
        NULL::json[] AS people,
        NULL::int AS people_len,
        COALESCE(dr.brand, deals.brand) AS brand,
        NULL::text AS status,
        NULL::jsonb AS metadata
      FROM
        current_deal_context cdc
        JOIN deals
          ON cdc.deal = deals.id
        JOIN brands_contexts bc
          ON bc.id = cdc.definition
        JOIN deals_checklists dcl
          ON dcl.id = cdc.checklist
        LEFT JOIN (SELECT id, deal, brand FROM deals_roles WHERE brand IS NOT NULL AND deleted_at IS NULL) dr
          ON deals.id = dr.deal
      WHERE
        deals.deleted_at IS NULL
        AND cdc.data_type = 'Date'::context_data_type
        AND dcl.deleted_at     IS NULL
        AND dcl.deactivated_at IS NULL
        AND dcl.terminated_at  IS NULL
        AND deals.faired_at    IS NOT NULL
        AND deal_status_mask(deals.id, '{Withdrawn,Cancelled,"Contract Terminated"}', cdc.key, '{expiration_date}'::text[], '{Sold,Leased}'::text[]) IS NOT FALSE
    )
    UNION ALL
    (
      SELECT
        cr.contact::text || ':' || cdc.id::text AS id,
        deals.created_by,
        cdc.created_at,
        cdc.created_at AS updated_at,
        'deal_context' AS object_type,
        'home_anniversary' AS event_type,
        'Home Anniversary' AS type_label,
        cdc."date" AS "timestamp",
        timezone('UTC', date_trunc('day', cdc."date")) AT TIME ZONE 'UTC' AS "date",
        cast(cdc."date" + ((extract(year from age(cdc."date")) + 1) * interval '1 year') as date) AS next_occurence,
        NULL::timestamptz AS end_date,
        True AS recurring,
        deals.title,
        NULL::uuid AS crm_task,
        cdc.deal,
        cr.contact,
        NULL::uuid AS campaign,
        NULL::uuid AS credential_id,
        NULL::text AS thread_key,
        (
          SELECT
            ARRAY_AGG(DISTINCT r."user")
          FROM
            deals_roles AS r
          WHERE
            r.deal = deals.id
            AND r.deleted_at IS NULL
            AND r."user" IS NOT NULL
        ) AS users,
        (
          SELECT
            ARRAY_AGG(json_build_object(
              'id', contact,
              'type', 'contact'
            ))
          FROM
            contacts_roles
          WHERE
            role_name = 'Buyer'
            AND deal = deals.id
        ) AS people,
        NULL::int AS people_len,
        cr.brand,
        NULL::text AS status,
        NULL::jsonb AS metadata
      FROM
        current_deal_context cdc
        JOIN deals
          ON cdc.deal = deals.id
        JOIN brands_contexts bc
          ON bc.id = cdc.definition
        JOIN deals_checklists dcl
          ON dcl.id = cdc.checklist
        -- JOIN brands_checklists bcl
        --   ON dcl.origin = bcl.id
        JOIN contacts_roles cr
          ON (deals.id = cr.deal)
      WHERE
        deals.deleted_at IS NULL
        AND (
          (cdc.key = 'closing_date' AND cdc.date < NOW())
          OR cdc.key = 'lease_end'
        )
        AND cr.role_name = 'Buyer'
        AND deals.deal_type = 'Buying'
        -- AND bcl.deal_type = 'Buying'
        AND dcl.deleted_at     IS NULL
        AND dcl.deactivated_at IS NULL
        -- AND bcl.deleted_at     Is NULL
        AND dcl.terminated_at  IS NULL
        AND deals.faired_at    IS NOT NULL
        AND deal_status_mask(deals.id, '{Withdrawn,Cancelled,"Contract Terminated"}', cdc.key, '{expiration_date}'::text[], '{Sold,Leased}'::text[]) IS NOT FALSE
    )
    UNION ALL
    (
      SELECT
        ca.id::text,
        contacts.created_by,
        ca.created_at,
        ca.updated_at,
        'contact_attribute' AS object_type,
        COALESCE(cad.name, cad.label) AS event_type,
        (CASE
          WHEN attribute_type = 'birthday' AND is_partner IS TRUE THEN 'Spouse Birthday'
          WHEN attribute_type = 'child_birthday' THEN COALESCE('Child Birthday (' || ca.label || ')', 'Child Birthday')
          ELSE COALESCE(cad.label, cad.name)
        END) AS type_label,
        "date" AS "timestamp",
        timezone('UTC', date_trunc('day', "date")::timestamp) AT TIME ZONE 'UTC' AS "date",
        cast("date" + ((extract(year from age("date")) + 1) * interval '1' year) as date) as next_occurence,
        NULL::timestamptz AS end_date,
        True AS recurring,
        (CASE
          WHEN attribute_type = 'birthday' AND ca.is_partner IS TRUE THEN
            array_to_string(ARRAY['Spouse Birthday', '(' || contacts.partner_name || ')', '- ' || contacts.display_name], ' ')
          WHEN attribute_type = 'birthday' AND ca.is_partner IS NOT TRUE THEN
            contacts.display_name || $$'s Birthday$$
          WHEN attribute_type = 'child_birthday' AND ca.label IS NOT NULL AND LENGTH(ca.label) > 0 THEN
            array_to_string(ARRAY['Child Birthday', '(' || ca.label || ')', '- ' || contacts.display_name], ' ')
          WHEN attribute_type = 'child_birthday' AND (ca.label IS NULL OR LENGTH(ca.label) = 0) THEN
            'Child Birthday - ' || contacts.display_name
          WHEN attribute_type = ANY('{
            work_anniversary,
            wedding_anniversary,
            home_anniversary
          }'::text[]) THEN
            contacts.display_name || $$'s $$  || cad.label
          ELSE
            contacts.display_name
        END) AS title,
        NULL::uuid AS crm_task,
        NULL::uuid AS deal,
        contact,
        NULL::uuid AS campaign,
        NULL::uuid AS credential_id,
        NULL::text AS thread_key,
        ARRAY[contacts."user"] AS users,
        ARRAY[json_build_object('id', contact, 'type', 'contact')]::json[] AS people,
        1 AS people_len,
        contacts.brand,
        NULL::text AS status,
        jsonb_build_object(
          'is_partner', is_partner
        ) AS metadata
      FROM
        contacts
        JOIN contacts_attributes AS ca
          ON contacts.id = ca.contact
        JOIN contacts_attribute_defs AS cad
          ON ca.attribute_def = cad.id
      WHERE
        contacts.deleted_at IS NULL
        AND ca.deleted_at IS NULL
        AND cad.deleted_at IS NULL
        AND data_type = 'date'
    )
    UNION ALL
    (
      SELECT
        id::text,
        created_by,
        created_at,
        updated_at,
        'contact' AS object_type,
        'next_touch' AS event_type,
        'Next Touch' AS type_label,
        next_touch AS "timestamp",
        next_touch AS "date",
        next_touch AS next_occurence,
        NULL::timestamptz AS end_date,
        False AS recurring,
        display_name AS title,
        NULL::uuid AS crm_task,
        NULL::uuid AS deal,
        id AS contact,
        NULL::uuid AS campaign,
        NULL::uuid AS credential_id,
        NULL::text AS thread_key,
        ARRAY[contacts."user"] AS users,
        ARRAY[json_build_object('id', id, 'type', 'contact')]::json[] AS people,
        1 AS people_len,
        brand,
        NULL::text AS status,
        NULL::jsonb AS metadata
      FROM
        contacts
      WHERE
        deleted_at IS NULL
        AND next_touch IS NOT NULL
    )
    UNION ALL
    (
      SELECT
        id::text,
        ec.created_by,
        ec.created_at,
        ec.updated_at,
        'email_campaign' AS object_type,
        'scheduled_email' AS event_type,
        'Scheduled Email' AS type_label,
        due_at AS "timestamp",
        due_at AS "date",
        due_at AS next_occurence,
        NULL::timestamptz AS end_date,
        False AS recurring,
        subject AS title,
        NULL::uuid AS crm_task,
        ec.deal,
        NULL::uuid AS contact,
        id AS campaign,
        NULL::uuid AS credential_id,
        NULL::text AS thread_key,
        ARRAY[ec.from] AS users,
  
        (
          SELECT
            ARRAY_AGG(json_build_object(
              'id', COALESCE(contact, agent),
              'type', (CASE WHEN agent IS NOT NULL THEN 'agent' ELSE 'contact' END)
            ))
          FROM
            (
              SELECT
                contact,
                agent
              FROM
                email_campaigns_recipient_emails AS ecr
              WHERE
                campaign = ec.id
              LIMIT 5
            ) t
        ) AS people,
  
        (
          SELECT
            COUNT(DISTINCT email)::int
          FROM
            email_campaigns_recipient_emails AS ecr
          WHERE
            campaign = ec.id
        ) AS people_len,
  
        brand,
        NULL::text AS status,
        NULL::jsonb AS metadata
      FROM
        email_campaigns AS ec
      WHERE
        deleted_at IS NULL
        AND executed_at IS NULL
        AND due_at IS NOT NULL
    )
    UNION ALL
    (
      SELECT
        ec.id::text,
        ec.created_by,
        ec.created_at,
        ec.updated_at,
        'email_campaign' AS object_type,
        'executed_email' AS event_type,
        'Executed Email' AS type_label,
        executed_at AS "timestamp",
        executed_at AS "date",
        executed_at AS next_occurence,
        NULL::timestamptz AS end_date,
        False AS recurring,
        subject AS title,
        NULL::uuid AS crm_task,
        ec.deal,
        NULL::uuid AS contact,
        id AS campaign,
        NULL::uuid AS credential_id,
        NULL::text AS thread_key,
        ARRAY[ec.from] AS users,
  
        (
          SELECT
            ARRAY_AGG(json_build_object(
              'id', COALESCE(contact, agent),
              'type', (CASE WHEN agent IS NOT NULL THEN 'agent' ELSE 'contact' END)
            ))
          FROM
            (
              SELECT DISTINCT ON (ece.email_address)
                c.id AS contact,
                ece.agent
              FROM
                email_campaign_emails AS ece
                LEFT JOIN contacts AS c
                  ON (((c.id = ece.contact) OR (c.email @> ARRAY[ece.email_address])) AND c.brand = ec.brand AND c.deleted_at IS NULL)
              WHERE
                ece.campaign = ec.id
                AND (ece.agent IS NOT NULL OR c.id IS NOT NULL)
              ORDER BY
                ece.email_address
              LIMIT 5
            ) t
        ) AS people,
  
        (
          SELECT
            count(*)::int
          FROM
            email_campaign_emails AS ece
          WHERE
            ece.campaign = ec.id
        ) AS people_len,
  
        brand,
        NULL::text AS status,
        NULL::jsonb AS metadata
      FROM
        email_campaigns AS ec
      WHERE
        deleted_at IS NULL
        AND executed_at IS NOT NULL
        AND due_at IS NOT NULL
    )
    UNION ALL
    (
      SELECT
        ec.id::text,
        ec.created_by,
        ec.created_at,
        ec.updated_at,
        'email_campaign_recipient' AS object_type,
        'scheduled_email' AS event_type,
        'Scheduled Email' AS type_label,
        ec.due_at AS "timestamp",
        ec.due_at AS "date",
        ec.due_at AS next_occurence,
        NULL::timestamptz AS end_date,
        False AS recurring,
        ec.subject AS title,
        NULL::uuid AS crm_task,
        ec.deal,
        ecr.contact,
        ec.id AS campaign,
        NULL::uuid AS credential_id,
        NULL::text AS thread_key,
        ARRAY[ec.from] AS users,
        (
          SELECT
            ARRAY_AGG(json_build_object(
              'id', COALESCE(contact, agent),
              'type', (CASE WHEN agent IS NOT NULL THEN 'agent' ELSE 'contact' END)
            ))
          FROM
            (
              SELECT
                contact,
                agent
              FROM
                email_campaigns_recipient_emails
              WHERE
                campaign = ec.id
              LIMIT 5
            ) t
        ) AS people,
        (
          SELECT
            COUNT(DISTINCT email)::int
          FROM
            email_campaigns_recipient_emails
          WHERE
            campaign = ec.id
        ) AS people_len,
        ec.brand,
        NULL::text AS status,
        NULL::jsonb AS metadata
      FROM
        email_campaigns AS ec
        JOIN email_campaigns_recipient_emails AS ecr
          ON ec.id = ecr.campaign
      WHERE
        ec.deleted_at IS NULL
        AND ec.executed_at IS NULL
        AND ec.due_at IS NOT NULL
        AND ecr.contact IS NOT NULL
    )
    UNION ALL
    (
      SELECT
        ec.id::text,
        ec.created_by,
        ec.created_at,
        ec.updated_at,
        'email_campaign_recipient' AS object_type,
        'executed_email' AS event_type,
        'Executed Email' AS type_label,
        executed_at AS "timestamp",
        executed_at AS "date",
        executed_at AS next_occurence,
        NULL::timestamptz AS end_date,
        False AS recurring,
        subject AS title,
        NULL::uuid AS crm_task,
        ec.deal,
        c.id AS contact,
        ec.id AS campaign,
        NULL::uuid AS credential_id,
        NULL::text AS thread_key,
        ARRAY[ec.from] AS users,
  
        (
          SELECT
            ARRAY_AGG(json_build_object(
              'id', COALESCE(contact, agent),
              'type', (CASE WHEN agent IS NOT NULL THEN 'agent' ELSE 'contact' END)
            ))
          FROM
            (
              SELECT DISTINCT ON (email_campaign_emails.email_address)
                contacts.id AS contact,
                email_campaign_emails.agent
              FROM
                email_campaign_emails
                LEFT JOIN contacts
                  ON ((contacts.email @> ARRAY[email_campaign_emails.email_address]) OR (contacts.id = email_campaign_emails.contact))
                     AND contacts.brand = ec.brand
                     AND contacts.deleted_at IS NULL
              WHERE
                email_campaign_emails.campaign = ec.id
                AND (email_campaign_emails.agent IS NOT NULL OR contacts.id IS NOT NULL)
              ORDER BY
                email_campaign_emails.email_address
              LIMIT 5
            ) t
        ) AS people,
  
        (
          SELECT
            count(*)::int
          FROM
            email_campaign_emails
          WHERE
            email_campaign_emails.campaign = ec.id
        ) AS people_len,
  
        ec.brand,
        NULL::text AS status,
        NULL::jsonb AS metadata
      FROM
        email_campaigns AS ec
        JOIN email_campaign_emails AS ece
          ON ece.campaign = ec.id
        JOIN contacts c
          ON (c.brand = ec.brand AND ec.id = ece.campaign)
      WHERE
        ec.deleted_at IS NULL
        AND c.deleted_at IS NULL
        AND c.email @> ARRAY[ece.email_address]
        AND ec.executed_at IS NOT NULL
    )
    UNION ALL
    (
      SELECT
        email_threads.id::text,
        email_threads.user AS created_by,
        email_threads.created_at,
        email_threads.updated_at,
        'email_thread' AS object_type,
        (CASE WHEN google_credential IS NOT NULL THEN 'gmail' ELSE 'outlook' END) AS event_type,
        'Email Thread' AS type_label,
        last_message_date AS "timestamp",
        last_message_date AS "date",
        last_message_date AS next_occurence,
        NULL::timestamptz AS end_date,
        False AS recurring,
        COALESCE(subject, '(no subject)') AS "title",
        NULL::uuid AS crm_task,
        NULL::uuid AS deal,
        NULL::uuid AS contact,
        NULL::uuid AS campaign,
        COALESCE(google_credential, microsoft_credential) AS credential_id,
        email_threads.id AS thread_key,
        ARRAY[email_threads."user"] AS users,
  
        (
          SELECT
            ARRAY_AGG(json_build_object(
              'id', contact,
              'type', 'contact'
            ))
          FROM
            (
              SELECT DISTINCT ON (recipient)
                contacts.id AS contact
              FROM
                unnest(recipients) AS recipients(recipient)
                JOIN contacts
                  ON contacts.email @> ARRAY[recipient]
              WHERE
                contacts.brand = email_threads.brand
                AND contacts.deleted_at IS NULL
              ORDER BY
                recipient,
                contacts.last_touch DESC,
                contacts.updated_at DESC
              LIMIT 5
            ) t
        ) AS people,
        (
          SELECT
            count(DISTINCT contacts.id)::int
          FROM
            unnest(recipients) AS recipients(recipient)
            JOIN contacts
              ON contacts.email @> ARRAY[recipient]
          WHERE
            contacts.brand = brand
            AND contacts.deleted_at IS NULL
        ) AS people_len,
  
        email_threads.brand,
        NULL::text AS status,
        NULL::jsonb AS metadata
      FROM
        email_threads
    )
    UNION ALL
    (
      SELECT
        email_threads.id::text,
        email_threads."user" AS created_by,
        email_threads.created_at,
        email_threads.updated_at,
        'email_thread_recipient' AS object_type,
        (CASE WHEN google_credential IS NOT NULL THEN 'gmail' ELSE 'outlook' END) AS event_type,
        'Email Thread' AS type_label,
        last_message_date AS "timestamp",
        last_message_date AS "date",
        last_message_date AS next_occurence,
        NULL::timestamptz AS end_date,
        False AS recurring,
        COALESCE(subject, '(no subject)') AS "title",
        NULL::uuid AS crm_task,
        NULL::uuid AS deal,
        c.id AS contact,
        NULL::uuid AS campaign,
        google_credential AS credential_id,
        email_threads.id AS thread_key,
        ARRAY[email_threads."user"] AS users,
  
        (
          SELECT
            ARRAY_AGG(json_build_object(
              'id', contact,
              'type', 'contact'
            ))
          FROM
            (
              SELECT DISTINCT ON (recipient)
                contacts.id AS contact
              FROM
                unnest(recipients) AS recipients(recipient)
                JOIN contacts
                  ON contacts.email @> ARRAY[recipient]
              WHERE
                contacts.brand = brand
                AND contacts.deleted_at IS NULL
              ORDER BY
                recipient,
                contacts.last_touch DESC,
                contacts.updated_at DESC
              LIMIT 5
            ) t
        ) AS people,
  
        (
          SELECT
            count(DISTINCT contacts.id)::int
          FROM
            unnest(recipients) AS recipients(recipient)
            JOIN contacts
              ON contacts.email @> ARRAY[recipient]
          WHERE
            contacts.brand = brand
            AND contacts.deleted_at IS NULL
        ) AS people_len,
  
        brand,
        NULL::text AS status,
        NULL::jsonb AS metadata
      FROM
        email_threads
        CROSS JOIN LATERAL (
          SELECT
            contacts.id
          FROM
            contacts
          WHERE
            contacts.email && recipients
        ) AS c
    )
  )`,

  `CREATE OR REPLACE VIEW crm_last_touches AS (
    SELECT
      contact,
      MAX(timestamp) AS last_touch
    FROM
      (
        (
          SELECT
            ca.contact,
            ct.due_date AS "timestamp"
          FROM
            crm_associations AS ca
            JOIN crm_tasks AS ct
              ON ca.crm_task = ct.id
          WHERE
            ca.deleted_at IS NULL
            AND ct.deleted_at IS NULL
            AND ct.task_type <> ALL('{Note,Other}')
            AND ct.due_date <= NOW()
        ) UNION ALL (
          SELECT
            c.id,
            last_message_date AS "timestamp"
          FROM
            email_threads
            CROSS JOIN LATERAL (
              SELECT
                contacts.id
              FROM
                contacts
              WHERE
                contacts.email && email_threads.recipients
                AND contacts.brand = email_threads.brand
                AND contacts.deleted_at IS NULL
            ) AS c
        ) UNION ALL (
          SELECT
            c.id AS contact,
            executed_at AS "timestamp"
          FROM
            email_campaigns AS ec
            JOIN email_campaign_emails AS ece
              ON ece.campaign = ec.id
            JOIN contacts c
              ON (c.brand = ec.brand)
          WHERE
            ec.deleted_at IS NULL
            AND c.deleted_at IS NULL
            AND c.email && ARRAY[ece.email_address]
            AND ec.executed_at IS NOT NULL
        )
      ) AS touches
    GROUP BY
      contact
  )`,

  'DROP TABLE IF EXISTS google_threads',
  'DROP TABLE IF EXISTS microsoft_threads',

  `WITH mc AS (
    SELECT
      thread_key AS id,
      count(*) AS message_count
    FROM
      microsoft_messages
      JOIN microsoft_credentials
        ON microsoft_messages.microsoft_credential = microsoft_credentials.id
    WHERE
      microsoft_credentials.revoked IS NOT TRUE
      AND microsoft_credentials.deleted_at IS NULL
    GROUP BY
      thread_key
  )
  UPDATE
    email_threads
  SET
    message_count = mc.message_count
  FROM
    mc
  WHERE
    mc.id = email_threads.id
  `,

  `WITH mc AS (
    SELECT
      thread_key AS id,
      count(*) AS message_count
    FROM
      google_messages
      JOIN google_credentials
        ON google_messages.google_credential = google_credentials.id
    WHERE
      google_credentials.revoked IS NOT TRUE
      AND google_credentials.deleted_at IS NULL
    GROUP BY
      thread_key
  )
  UPDATE
    email_threads
  SET
    message_count = mc.message_count
  FROM
    mc
  WHERE
    mc.id = email_threads.id
  `,

  'COMMIT'
]


const run = async () => {
  const { conn } = await db.conn.promise()

  for(const sql of migrations) {
    await conn.query(sql)
  }

  conn.release()
}

exports.up = cb => {
  run().then(cb).catch(cb)
}

exports.down = () => {}
