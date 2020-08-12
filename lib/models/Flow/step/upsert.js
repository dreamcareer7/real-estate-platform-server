const _ = require('lodash')
const sq = require('../../../utils/squel_extensions')
const db = require('../../../utils/db')
const Context = require('../../Context')
const CrmTask = require('../../CRM/Task')
const EmailCampaign = require('../../Email/campaign')

const FlowEvent = require('../event')
const FlowEmail = require('../email')
const BrandFlowStep = require('../../Brand/flow_step')


/**
 * @param {UUID} brand_id 
 * @param {UUID} user_id 
 * @param {number} epoch 
 * @param {IBrandFlowStep[]} brand_steps 
 * @param {IFlowStepInput[]} steps 
 */
const _createEvents = async (brand_id, user_id, epoch, brand_steps, steps) => {
  Context.log('Creating event steps')

  const event_brand_steps = brand_steps.filter(bs => bs.event)
  const ebs_ids = event_brand_steps.map(es => es.id)
  const ebs_by_id = _.keyBy(event_brand_steps, 'id')
  const event_steps = steps.filter(s => ebs_ids.includes(s.origin))

  const events = event_steps.map(/** @returns {IFlowEventInput} */es => ({
    origin: ebs_by_id[es.origin].event,
    contact: es.contact,
    due_date: epoch + ebs_by_id[es.origin].due_in
  }))

  const event_ids = await FlowEvent.create(
    brand_id,
    user_id,
    event_brand_steps.map(es => es.event),
    events
  )

  for (let i = 0; i < event_ids.length; i++) {
    event_steps[i].event = event_ids[i]
  }
}

/**
 * @param {UUID} brand_id 
 * @param {UUID} user_id 
 * @param {number} epoch 
 * @param {IBrandFlowStep[]} brand_steps 
 * @param {IFlowStepInput[]} steps 
 */
const _createEmails = async (brand_id, user_id, epoch, brand_steps, steps) => {
  Context.log('Creating email steps')

  const email_brand_steps = brand_steps.filter(bs => bs.email)
  const ebs_ids = email_brand_steps.map(es => es.id)
  const ebs_by_id = _.keyBy(email_brand_steps, 'id')
  const email_steps = steps.filter(s => ebs_ids.includes(s.origin))

  const emails = email_steps.map(/** @returns {IFlowEmailInput} */es => ({
    origin: ebs_by_id[es.origin].email,
    contact: es.contact,
    is_automated: ebs_by_id[es.origin].is_automated,
    due_date: epoch + ebs_by_id[es.origin].due_in,
    event_title: ebs_by_id[es.origin].title
  }))

  const email_ids = await FlowEmail.create(
    brand_id,
    user_id,
    email_brand_steps.map(es => es.email),
    emails
  )

  for (let i = 0; i < email_ids.length; i++) {
    email_steps[i].email = email_ids[i]
  }
}

/**
 * @param {UUID} brand_id 
 * @param {UUID} user_id 
 * @param {number} epoch 
 * @param {UUID[]} brand_step_ids 
 * @param {IFlowStepInput[]} steps 
 */
const create = async (brand_id, user_id, epoch, brand_step_ids, steps) => {
  Context.log(`Creating ${steps.length} steps`)

  const brand_steps = await BrandFlowStep.getAll(brand_step_ids)

  await _createEvents(brand_id, user_id, epoch, brand_steps, steps)
  await _createEmails(brand_id, user_id, epoch, brand_steps, steps)

  const data = steps
    .filter(s => s.email || s.event)
    .map(step => ({
      flow: step.flow,
      origin: step.origin,
      event: step.event,
      email: step.email,
      created_by: user_id
    }))

  const q = sq.insert({ autoQuoteFieldNames: true })
    .into('flows_steps')
    .setFieldsRows(data)
    .returning('id')

  // @ts-ignore
  q.name = 'flow/step/create'

  return db.selectIds(q, [])
}

/**
 * @typedef IDeleteReturnType
 * @prop {UUID=} crm_task
 * @prop {UUID=} email
 *
 * @param {UUID} user_id
 * @param {UUID[]} step_ids
 * @param {UUID} brand_id
 */
const deleteSteps = async (step_ids, user_id, brand_id) => {
  /** @type {IDeleteReturnType[]} */
  const deleted_steps = await db.select('flow/step/delete', [
    step_ids,
    user_id
  ])

  const events = deleted_steps.filter(/** @type {TIsRequirePropPresent<IDeleteReturnType, 'crm_task'>} */(s => Boolean(s.crm_task))).map(s => s.crm_task)
  const emails = deleted_steps.filter(/** @type {TIsRequirePropPresent<IDeleteReturnType, 'email'>} */(s => Boolean(s.email))).map(s => s.email)

  await CrmTask.remove(events, user_id)

  await EmailCampaign.deleteMany(emails, user_id, brand_id)
}


module.exports = {
  _createEvents,
  _createEmails,
  create,
  delete: deleteSteps,
}