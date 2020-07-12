const db = require('../../utils/db')
const Orm = require('../Orm')
const chargebee = require('../Brand/chargebee')

const BillingPlan = {}

BillingPlan.get = async id => {
  const plans = await BillingPlan.getAll([id])
  if (plans.length < 1)
    throw Error.ResourceNotFound(`Billing Plan ${id} not found`)

  return plans[0]
}

BillingPlan.getAll = async ids => {
  return await db.select('billing_plan/get', [ids])
}

BillingPlan.getByChargebeeId = async chargebee_id => {
  const found = await db.selectOne('billing_plan/get-by-chargebee-id', [
    chargebee_id
  ])

  if (found)
    return BillingPlan.get(found.id)
}

BillingPlan.sync = async chargebee_id => {
  const chargebee_object = await chargebee.plan.retrieve(chargebee_id).request()

  const { rows } = await db.query.promise('billing_plan/set', [
    [],
    chargebee_object.id,
    JSON.stringify(chargebee_object)
  ])

  return BillingPlan.get(rows[0].id)
}

Orm.register('billing_plan', 'BillingPlan', BillingPlan)

module.exports = BillingPlan