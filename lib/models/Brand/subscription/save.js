const db = require('../../../utils/db')
const chargebee = require('../chargebee')
const Context = require('../../Context')
const BillingPlan = require('../../BillingPlan')
const BrandCustomer = require('../customer/utils')
const BrandRole = require('../role/get')
const emitter = require('../role/emitter')

const { get, getByBrand } = require('./get')

const getQuantity = async brand => {
  const { count } = await db.selectOne('brand/subscription/get-quantity', [
    brand
  ])

  return count
}

const create = async ({customer, plan, brand}) => {
  const data = {
    plan_id: plan.chargebee_id,
    plan_quantity: await getQuantity(brand)
  }

  const created = await chargebee.subscription.create_for_customer(customer.chargebee_id, data).request()

  const { rows } = await db.query.promise('brand/subscription/insert', [
    Context.getId(),
    brand,
    plan.id,
    customer.id,
    created.subscription.status,
    created.subscription.plan_quantity,
    created.subscription.id,
    JSON.stringify(created.subscription)
  ])

  return get(rows[0].id)
}

const sync = async chargebee_id => {
  Context.log('Syncing subscription', chargebee_id)
  const { subscription } = await chargebee.subscription.retrieve(chargebee_id).request()

  const plan = await BillingPlan.getByChargebeeId(subscription.plan_id)
  await BrandCustomer.sync(subscription.customer_id)

  await db.query.promise('brand/subscription/update', [
    Context.getId(),
    chargebee_id,
    plan.id,
    subscription.status,
    subscription.plan_quantity,
    JSON.stringify(subscription)
  ])
}

const updateQuantity = async brand_user => {
  const role = await BrandRole.get(brand_user.role)
  const subscription = await getByBrand(role.brand)

  if (!subscription) {
    Context.log('Cannot update subscription for brand with no subscription')
    return
  }

  const plan_quantity = await getQuantity(role.brand)

  await chargebee.subscription.update(subscription.chargebee_id, {
    plan_quantity
  }).request()

  return sync(subscription.chargebee_id)
}

emitter.on('member:join', updateQuantity)
emitter.on('member:leave', updateQuantity)

const cancel = async subscription => {
  await chargebee.subscription.cancel(subscription.chargebee_id).request()
  return sync(subscription.chargebee_id)
}


module.exports = {
  create,
  sync,
  updateQuantity,
  cancel
}
