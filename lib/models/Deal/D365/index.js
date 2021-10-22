const request = require('request-promise-native')
const moment = require('moment')
const _ = require('lodash')

const db = require('../../../utils/db')
const { peanar } = require('../../../utils/peanar')

const Context = require('../../Context')

const BrandPropertyType = require('../../Brand/deal/property_type/get')
const DealRole = require('../role/get')
const Deal = {
  ...require('../context/get'),
  ...require('../constants'),
}

const Brand = {
  ...require('../../Brand/get'),
  ...require('../../Brand/constants')
}

const BrandStatus = require('../../Brand/deal/status/get')

const getState = async deal => {
  const { rows } = await db.executeSql.promise('SELECT * FROM de.deals WHERE deal = $1', [deal])
  const [ row ] = rows
  return row
}

const getToken = async () => {
  const uri = 'https://webapi.elliman.com/token?username=emil@rechat.com&password=Skiing4-Monetize-Excitable'

  const { token } = await request({
    uri,
    json: true
  })

  return token
}

const getRoleCommission = role => {
  if (role.commission_dollar !== null) {
    return {
      PercentOrAmount: 'Amount',
      Share: role.commission_dollar
    }
  }

  return {
    PercentOrAmount: 'Percent',
    Share: role.commission_percentage
  }
}

const getCommissionValue = (deal, role) => {
  if (role.commission_dollar !== null)
    return role.commission_dollar


  const sales_price = Deal.getContext(deal, 'sales_price')
  return sales_price * (role.commission_percentage / 100)
}

const getCommissionRate = (deal, role) => {
  if (role.commission_percentage !== null)
    return role.commission_percentage


  const sales_price = Deal.getContext(deal, 'sales_price')
  return (role.commission_dollar / sales_price) * 100
}

const save = async ({deal, is_finalized = false}) => {
  return db.executeSql.promise('INSERT INTO de.deals(deal, is_finalized) VALUES ($1, $2) ON CONFLICT (deal) DO UPDATE SET is_finalized = EXCLUDED.is_finalized', [
    deal.id,
    is_finalized
  ])
}

const getRegionDetails = async brand => {
  const { rows } = await db.executeSql.promise('SELECT * FROM de.regions WHERE brand = $1', [brand.id])
  return rows[0]
}

const getOfficeDetails = async brand => {
  const { rows } = await db.executeSql.promise('SELECT * FROM de.offices WHERE brand = $1', [brand.id])
  return rows[0]
}

const getAgentDetails = async user_ids => {
  const { rows } = await db.executeSql.promise(`SELECT 
    "user", object->>'d365AgentId' as "AgentId", object->'offices'->0->'businessLocations'->0->>'businessLocation' as "BusinessLocation"
    FROM de.users WHERE "user" = ANY($1::uuid[])`, [user_ids])
  return rows
}

const getLeaseAttributes = ({deal, roles}) => {
  const lease_begin = Deal.getContext(deal, 'lease_begin')
  const lease_end = Deal.getContext(deal, 'lease_end')

  const LeaseStartDate = lease_begin ? moment(lease_begin).format('YYYY-MM-DD') : null
  const LeaseEndDate = lease_end ? moment(lease_end).format('YYYY-MM-DD') : null

  const contract_date = Deal.getContext(deal, 'lease_executed')
  const ContractDate = contract_date ? moment(contract_date).format('YYYY-MM-DD') : null

  const MonthlyRent = Deal.getContext(deal, 'leased_price')
  const ListingPrice = Deal.getContext(deal, 'lease_price')

  const RenterName = _.chain(roles)
    .filter({
      role: 'Tenant'
    })
    .map('legal_full_name')
    .value()
    .join(' & ')

  const LandlordrName = _.chain(roles)
    .filter({
      role: 'Landlord'
    })
    .map('legal_full_name')
    .value()
    .join('& ')

  return {
    ContractDate,

    LeaseStartDate,
    LeaseEndDate,

    MonthlyRent,
    ListingPrice,

    LandlordrName,
    RenterName,

    DealType: 'Rentals'
  }
}

const getSaleAttributes = ({deal, roles}) => {
  let ListSideSalesPrice, BuySideSalesPrice
  let ListSideDealValue, BuySideDealValue
  let ListSideCommissionRate, BuySideCommissionRate

  const contract_date = Deal.getContext(deal, 'contract_date')
  const ContractDate = contract_date ? moment(contract_date).format('YYYY-MM-DD') : null

  const isSellside = role => role.role === 'SellerAgent' || role.role === 'CoSellerAgent'
  const isBuyside = role => role.role === 'BuyerAgent' || role.role === 'CoBuyerAgent'

  const sum = (s, n) => s + n

  if (deal.side === Deal.SELLING) {
    ListSideSalesPrice = Deal.getContext(deal, 'sales_price')

    ListSideDealValue = _.chain(roles)
      .filter(isSellside)
      .map(r => getCommissionValue(deal, r))
      .reduce(sum)
      .value()

    ListSideCommissionRate = _.chain(roles)
      .filter(isSellside)
      .map(r => getCommissionRate(deal, r))
      .reduce(sum)
      .value()
  } else {
    BuySideSalesPrice = Deal.getContext(deal, 'sales_price')

    BuySideDealValue = _.chain(roles)
      .filter(isBuyside)
      .map(r => getCommissionValue(deal, r))
      .reduce(sum)
      .value()


    BuySideCommissionRate = _.chain(roles)
      .filter(isBuyside)
      .map(r => getCommissionRate(deal, r))
      .reduce(sum)
      .value()
  }

  const BuyerName = _.chain(roles)
    .filter({
      role: 'Buyer'
    })
    .map('legal_full_name')
    .value()
    .join('& ')

  const SellerName = _.chain(roles)
    .filter({
      role: 'Seller'
    })
    .map('legal_full_name')
    .value()
    .join('& ')

  return {
    ContractDate,

    ListSideSalesPrice,
    BuySideSalesPrice,
    ListSideDealValue,
    BuySideDealValue,
    ListSideCommissionRate,
    BuySideCommissionRate,

    BuyerName,
    SellerName,

    DealType: 'Sales'
  }
}

const sync = async (deal, brand_ids) => {
  Context.log('Syncing D365 for', deal.id)

  const token = await getToken()

  const state = await getState(deal.id)

  const brands = await Brand.getAll(brand_ids)

  const region = _.find(brands, {brand_type: Brand.REGION})
  const office = _.find(brands, {brand_type: Brand.OFFICE})

  const property_type = await BrandPropertyType.get(deal.property_type)

  const roles = await DealRole.getAll(deal.roles)

  const type = property_type.is_lease ? 'rental' : 'sale'
  const update = state ? '/update' : ''
  const uri = `https://webapi.elliman.com/api/adc/postdeal/${type}${update}`

  const ListingId = Deal.getContext(deal, 'mls_number') ?? `Hippocket-${deal.number}`
  const Street = Deal.getContext(deal, 'street_address')
  const ZipCode = Deal.getContext(deal, 'postal_code')
  const PropertyType = property_type.label
  const ListingDate = Deal.getContext(deal, 'list_date')
  const ListingPrice = Deal.getContext(deal, 'list_price')
  const UnitNum = Deal.getContext(deal, 'unit_number')

  const closing_date = Deal.getContext(deal, 'closing_date')
  const DealDate = closing_date ? moment(closing_date).format('YYYY-MM-DD') : null

  let DealSide = deal.side === Deal.SELLING ? 'List' : 'Buy'

  const ender_type = Deal.getContext(deal, 'ender_type')
  if (ender_type === Deal.AGENT_DOUBLE_ENDER || ender_type === Deal.OFFICE_DOUBLE_ENDER)
    DealSide = 'Both'


  const leaseAttributes = property_type.is_lease ? getLeaseAttributes({deal, roles}) : {}
  const saleAttributes = !property_type.is_lease ? getSaleAttributes({deal, roles}) : {}

  const isInternal = role => {
    return (deal.deal_type === Deal.SELLING && (role.role === 'SellerAgent' || role.role === 'CoSellerAgent')) 
      || (deal.deal_type === Deal.BUYING && (role.role === 'BuyerAgent' || role.role === 'CoBuyerAgent'))
  }

  const isAgent = role => {
    return [
      'SellerAgent',
      'CoSellerAgent',
      'BuyerAgent',
      'CoBuyerAgent'
    ].includes(role.role)
  }

  const user_ids = _.chain(roles)
    .filter(isAgent)
    .filter(isInternal)
    .map('user')
    .value()

  const agent_details = await getAgentDetails(user_ids)
  const region_details = await getRegionDetails(region)
  const office_details = await getOfficeDetails(office)

  const agents = _.chain(roles)
    .filter(isAgent)
    .filter(isInternal)
    .map(role => {
      const { AgentId, BusinessLocation } = _.find(agent_details, {user: role.user})
      const DealSide = (role.role === 'SellerAgent' || role.role === 'CoSellerAgent') ? 'List' : 'Buy'      
      
      const commissionAttributes = isInternal(role) ? getRoleCommission(role) : {}

      //   [
      //     {
      //         "AgentType": "AgentReferral",
      //         "DealAgentRef": "A000939",
      //         "FeeBase": "Off_the_agent_net",
      //     }
      // ]

      return  {
        AgentType: 'Primary',
        AgentId,
        BusinessLocation,
        'OfficeGCIAllocation': 100,
        DealSide,
        ...commissionAttributes
      }
    })
    .value()

  const body = {
    listing: {
      ListingId,
      Street,
      ZipCode,
      PropertyType,
      ListingDate,
      ListingPrice,
      UnitNum,
      ListingType: 'Other',
      BusinessLocation: office_details.business_locations[0]
    },
    deal: {
      Source: 'StudioPro',
      DealUniqueRef: deal.id,
      DealSide,
      'LineOfBusiness': 'Brokerage',
      DealDate,
      PaidBy: region_details.paid_by,


      ...leaseAttributes,
      ...saleAttributes,
    },
    agents
  }

  const res = await request({
    uri,
    headers: {
      Authorization: `Bearer ${token}`
    },
    json: true,
    method: 'post',
    body
  })

  Context.log(res)

  await save({deal})
}

const queue = peanar.job({
  handler: sync,
  queue: 'd365',
  exchange: 'd365',
  error_exchange: 'd365.error',
  retry_exchange: 'd365.retry',
  max_retries: 10,
  name: 'sync_d365',
  retry_delay: 600000
})


const considerSync = async (deal, brand_ids) => {
  Context.log('Considering D365 sync for', deal.id)

  if (!brand_ids.includes('a1daa4ea-6fb4-4a6f-81a4-5fe9ea7f6e83'))
    return

  const contract_status = Deal.getContext(deal, 'contract_status')
  if (!contract_status)
    return

  const state = await getState(deal.id)
  if (state?.is_finalized)
    return

  const statuses = await BrandStatus.getByBrand(deal.brand)

  const status = _.find(statuses, {label: contract_status})
  if (!status.is_closed)
    return

  Context.log('Queueing D365 sync for', deal.id)
  await queue(deal, brand_ids)
}

module.exports = {
  considerSync,
  sync
}