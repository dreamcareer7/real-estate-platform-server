const _ = require('lodash')
const moment = require('moment-timezone')

const belt = require('../../utils/belt')
const db   = require('../../utils/db')
const sq   = require('../../utils/squel_extensions')

const BrandFlow = require('../Brand/flow')
const Context   = require('../Context/index')
const User      = require('../User/get')

const emitter  = require('./emitter')
const FlowStep = require('./step')

const { get, getAll } = require('./get')
const { filter } = require('./filter')


/**
 * @param {UUID} brand_id 
 * @param {UUID} user_id 
 * @param {UUID[]} flow_ids
 * @param {number} starts_at 
 * @param {UUID[]} brand_steps brand_flow_step ids
 * @param {UUID[]} contact_ids contact ids to enroll
 */
const _createSteps = async (brand_id, user_id, flow_ids, starts_at, brand_steps, contact_ids ) => {
  const steps = contact_ids.flatMap((contact, i) => brand_steps.map(bs => ({
    flow: flow_ids[i],
    origin: bs,
    contact,
  })))

  const user = await User.get(user_id)

  await FlowStep.create(brand_id, user_id, moment.unix(starts_at).tz(user.timezone).startOf('day').unix(), brand_steps, steps)
}

/**
 * @param {UUID} brand_id 
 * @param {UUID} user_id 
 * @param {UUID} brand_flow_id template flow id
 * @param {number} starts_at 
 * @param {UUID[]} brand_steps brand_flow_step ids
 * @param {UUID[]} contact_ids contact ids to enroll
 */
const enrollContacts = async (brand_id, user_id, brand_flow_id, starts_at, brand_steps, contact_ids) => {
  if (brand_steps.length < 1) {
    throw Error.Validation('Selected steps cannot be empty!')
  }

  if (contact_ids.length < 1) {
    throw Error.Validation('Contacts cannot be empty!')
  }

  const accessIndex = await BrandFlow.hasAccess(brand_id, 'read', [brand_flow_id])

  if (!accessIndex.get(brand_flow_id)) {
    throw Error.ResourceNotFound(`Flow template ${brand_flow_id} not found`)
  }

  const existing_flow_ids = await filter({
    brand: brand_id,
    origin: brand_flow_id,
    contacts: contact_ids,
    status: 'Active'
  })

  const existing_flows = await getAll(existing_flow_ids)
  const contacts_to_enroll = _.difference(contact_ids, existing_flows.map(f => f.contact))

  if (contacts_to_enroll.length < 1) return []

  // TODO: Make sure all brand_steps belong to brand_flow_id
  const brand_flow = await BrandFlow.get(brand_flow_id)

  Context.log(`Enroll ${contacts_to_enroll.length} contacts to flow ${brand_flow.name}`)

  const flow_ids = await create(brand_id, user_id, brand_flow, starts_at, contacts_to_enroll)
  await _createSteps(brand_id, user_id, flow_ids, starts_at, brand_steps, contacts_to_enroll)

  return getAll(flow_ids)
}

/**
 * Enables a set of steps from the flow template
 * @param {UUID} user_id
 * @param {UUID} flow_id
 * @param {UUID[]} brand_steps
 */
const enableSteps = async (user_id, flow_id, brand_steps) => {
  const flow = await get(flow_id)
  const steps = await FlowStep.getAll(flow.steps)

  // Skip existing steps
  const existing_brand_steps = steps.map(s => s.origin)

  await _createSteps(
    flow.brand,
    user_id,
    [flow.id],
    flow.starts_at,
    brand_steps.filter(bs => !existing_brand_steps.includes(bs)),
    [flow.contact]
  )
}

/**
 * Stops a flow from moving forward. Removes all future events and scheduled emails.
 * @param {UUID} user_id 
 * @param {UUID} flow_id 
 */
const stop = async (user_id, flow_id) => {
  const flow = await get(flow_id)

  const remaining_steps = await db.select('flow/remaining_steps', [
    flow_id
  ])

  await disableSteps(user_id, flow_id, remaining_steps.map(rs => rs.origin))

  await db.update('flow/delete', [
    flow_id,
    user_id
  ])

  emitter.emit('stop', { flow_id, user_id, brand_id: flow.brand })
}

/**
 * Disables a set of steps from the flow template
 * @param {UUID} user_id
 * @param {UUID} flow_id
 * @param {UUID[]} brand_steps
 */
const disableSteps = async (user_id, flow_id, brand_steps) => {
  const flow = await get(flow_id)
  const steps = await FlowStep.getAll(flow.steps)

  // Skip non-existing steps
  const existing_steps = steps.filter(s => brand_steps.includes(s.origin)).map(s => s.id)

  await FlowStep.delete(existing_steps, user_id, flow.brand)
}



module.exports =  {
  _createSteps,
  enrollContacts,
  stop,
  enableSteps,
  disableSteps
}
