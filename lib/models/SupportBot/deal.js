const _ = require('lodash')
const squel = require('@rechat/squel').useFlavour('postgres')

const promisify = require('../../utils/promisify')

const Orm = require('../Orm/index')
const Deal = require('../Deal/index')
const BrandContext = require('../Brand/deal/context')

const sql = require('../../utils/sql')

const config = require('../../config')

const dealLink = id =>
  `${config.webapp.protocol}://${config.webapp.hostname}/dashboard/deals/${id}`


function getStatusColorClass(status) {
  switch (status) {
    case 'Active':
    case 'Lease':
      return ':green_apple:'

    case 'Pending':
    case 'Active Kick Out':
    case 'Active Contingent':
    case 'Active Option Contract':
    case 'Lease Contract':
      return ':tangerine:'

    case 'Sold':
    case 'Leased':
    case 'Expired':
    case 'Archived':
    case 'Cancelled':
    case 'Contract Terminated':
      return ':apple:'

    case 'Withdrawn':
    case 'Temp Off Market':
    case 'Withdrawn Sublisting':
      return ':black_square_for_stop:'

    default:
      return ''
  }
}

function getDealStatus(deal) {
  if (deal.is_draft) return 'Draft'

  const status = Deal.getContext(deal, deal.deal_type === 'Buying' ? 'contract_status' : 'listing_status')

  if (status) {
    const icon = getStatusColorClass(status)
    return `${icon} ${status}`
  }
}

  
async function getAll(ids) {
  const raw = await promisify(Deal.getAll)(ids)
  const deals = await Orm.populate({
    models: raw,
    associations: ['deal.roles', 'deal.brand', 'deal.created_by']
  })

  return deals
}

async function get(id) {
  const result = await getAll([id])

  return result[0]
}

function getPrimaryAgent(deal) {
  const primaryAgentRole =
    deal.deal_type === 'Buying' ? 'BuyerAgent' : 'SellerAgent'

  if (deal.roles) {
    return deal.roles.find(r => r.role === primaryAgentRole)
  }
}

async function undeleteDeal(deal_id) {
  return sql.update('UPDATE deals SET deleted_at = NULL WHERE id = $1::uuid', [
    deal_id
  ])
}

async function deleteDeal(deal_id) {
  return sql.update('UPDATE deals SET deleted_at = NOW() WHERE id = $1::uuid', [
    deal_id
  ])
}

async function setDealBrand(deal_id, brand_id) {
  return sql.update(
    'UPDATE deals SET brand = $2::uuid, updated_at = NOW() WHERE id = $1::uuid',
    [deal_id, brand_id]
  )
}

async function moveDealsToBrand(user_id, from_brand, to_brand) {
  return sql.update(`
    WITH deal_ids AS (
      SELECT
        d.id
      FROM
        deals d
        JOIN deals_roles dr
          ON d.id = dr.deal
      WHERE
        dr.deleted_at IS NULL
        AND d.brand = $2
        AND dr."user" = $1
        AND (
          CASE d.deal_type
            WHEN 'Buying' THEN
              dr.role = 'BuyerAgent'
            ELSE
              dr.role = 'SellerAgent'
          END
        )
    )
    UPDATE
      deals
    SET
      brand = $3
    FROM
      deal_ids
    WHERE
      deals.id = deal_ids.id
  `, [
    user_id,
    from_brand,
    to_brand
  ])
}

async function changeEnderType(deal_id, ender_type) {
  let enderTypeContext

  const { created_by: user, brand } = (await sql.select(
    'SELECT created_by, brand FROM deals WHERE id = $1',
    [deal_id]
  ))[0]
  const main_checklist = await sql.selectId(`
    SELECT
      id
    FROM
      deals_checklists
    WHERE
      deal = $1
      AND deleted_at IS NULL
    ORDER BY
      created_at
    LIMIT 1
  `, [deal_id])

  const context_defs = await BrandContext.getByBrand(brand)
  const def = context_defs.find(d => d.key === 'ender_type')

  try {
    enderTypeContext = await sql.selectOne(
      `SELECT
        *
      FROM
        deal_context
      WHERE
        deal = $1
        AND definition = $2
      ORDER BY
        created_at DESC
      LIMIT 1`,
      [
        deal_id,
        def.id
      ]
    )
  } catch (ex) {
    enderTypeContext = null
  }

  switch (ender_type) {
    case 'Normal':
      if (enderTypeContext) {
        await sql.update(
          `
          UPDATE deal_context SET text = NULL WHERE id = $1
        `,
          [enderTypeContext.id]
        )
      }
      break
    default:
      if (enderTypeContext) {
        await sql.update(
          'UPDATE deal_context SET text = $2, value = $2, updated_at = now() WHERE id = $1',
          [enderTypeContext.id, ender_type]
        )
      } else {
        await Deal.saveContext({
          deal: deal_id,
          user: user,
          context: [{
            definition: def.id,
            value: ender_type,
            approved: true,
            checklist: main_checklist
          }]
        })
      }
  }
}

async function switchPrimaryAgent(old_pa, new_pa) {
  const current = await sql.selectWithError(
    `
    SELECT * FROM deals_roles WHERE id = ANY($1::uuid[])
  `,
    [[old_pa, new_pa]]
  )

  const roles_index = _.keyBy(current, 'id')

  await sql.update('UPDATE deals_roles SET role = $1 WHERE id = $2', [
    roles_index[old_pa].role,
    new_pa
  ])

  await sql.update('UPDATE deals_roles SET role = $1 WHERE id = $2', [
    roles_index[new_pa].role,
    old_pa
  ])
}

async function searchForDeals(query) {
  const listingQuery = (query, expr) => {
    expr.or('listing IN (SELECT id FROM search_listings(plainto_tsquery(?)))', query)
  }

  const contextQuery = (query, expr) => {
    const q = `SELECT DISTINCT deal FROM deal_context
    WHERE to_tsvector('english', text) @@ plainto_tsquery('english', ?)`

    expr.or(`deals.id IN (${q})`, query, query)
  }

  const roleQuery = (query, expr) => {
    const q = `SELECT deal FROM deals_roles WHERE
    deleted_at IS NULL AND
    to_tsvector('english',
      COALESCE(legal_prefix, '')      || ' ' ||
      COALESCE(legal_first_name, '')  || ' ' ||
      COALESCE(legal_middle_name, '') || ' ' ||
      COALESCE(legal_last_name, '')   || ' ' ||
      COALESCE(company_title, '')
    )
    @@ plainto_tsquery('english', ?)`

    expr.or(`deals.id IN (${q})`, query)
  }

  const queryFilter = (q, filter) => {
    if (!filter.query) return

    const expr = squel.expr()

    listingQuery(filter.query, expr)
    contextQuery(filter.query, expr)
    roleQuery(filter.query, expr)

    q.where(expr)
  }

  const q = squel
    .select()
    .field('deals.id')
    .from('deals')
    .where('deals.deleted_at IS NULL')

  queryFilter(q, { query })

  const built = q.toParam()

  return sql.selectIds(built.text, built.values)
}

module.exports = {
  dealLink,
  getStatusColorClass,
  getDealStatus,
  getAll,
  get,
  getPrimaryAgent,
  undeleteDeal,
  deleteDeal,
  setDealBrand,
  changeEnderType,
  switchPrimaryAgent,
  searchForDeals,
  moveDealsToBrand
}
