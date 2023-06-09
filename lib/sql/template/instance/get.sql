SELECT templates_instances.*,
  'template_instance' AS type,
  EXTRACT(EPOCH FROM created_at) AS created_at,
  EXTRACT(EPOCH FROM created_at) AS updated_at, -- They are not updated at all for now but Dan needs this field.

  (
    SELECT ARRAY_AGG(deal) FROM templates_instances_relations
    WHERE templates_instances_relations.instance = templates_instances.id
          AND templates_instances_relations.deal IS NOT NULL
  ) as deals,

  (
    SELECT ARRAY_AGG(listing) FROM templates_instances_relations
    WHERE templates_instances_relations.instance = templates_instances.id
          AND templates_instances_relations.listing IS NOT NULL
  ) as listings,

  (
    SELECT ARRAY_AGG(contact) FROM templates_instances_relations
    WHERE templates_instances_relations.instance = templates_instances.id
    AND templates_instances_relations.contact IS NOT NULL
  ) as contacts

FROM templates_instances
JOIN unnest($1::uuid[]) WITH ORDINALITY t(iid, ord) ON templates_instances.id = iid
ORDER BY t.ord
