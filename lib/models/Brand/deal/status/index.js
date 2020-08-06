const db = require('../../../../utils/db')

const BrandDealStatus = {
  ...require('./get')
}

BrandDealStatus.create = async context => {
  const id = await db.insert('brand/deal/status/insert', [
    context.brand,
    context.label,
    context.deal_types,
    context.property_types,
    context.admin_only,
    Boolean(context.is_archived),
    Boolean(context.is_active),
    Boolean(context.is_pending),
  ])

  return BrandDealStatus.get(id)
}

BrandDealStatus.update = async context => {
  await db.query.promise('brand/deal/status/update', [
    context.id,
    context.label,
    context.deal_types,
    context.property_types,
    context.admin_only,
    Boolean(context.is_archived),
    Boolean(context.is_active),
    Boolean(context.is_pending),
  ])

  return BrandDealStatus.get(context.id)
}

BrandDealStatus.delete = async id => {
  return db.query.promise('brand/deal/status/delete', [id])
}

module.exports = BrandDealStatus
