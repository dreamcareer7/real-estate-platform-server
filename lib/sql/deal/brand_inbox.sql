SELECT
  DISTINCT deals.id
FROM deals
  JOIN deals_checklists ON deals.id = deals_checklists.deal
  JOIN tasks ON deals_checklists.id = tasks.checklist
WHERE
  deals.deleted_at IS NULL
  AND deals_checklists.terminated_at   IS NULL
  AND deals_checklists.deactivated_at  IS NULL
  AND tasks.needs_attention = TRUE
  AND tasks.deleted_at IS NULL
  AND deals.brand IN (SELECT brand_children($1::uuid))