const _  = require('lodash')
const sq = require('@rechat/squel').useFlavour('postgres')

const belt = require('../../../utils/belt')
const db   = require('../../../utils/db')

const BrandEmail    = require('../../Brand/email/get')
const EmailCampaign = require('../../Email/campaign/create')
const Email   = require('../../Email/constants')
const Contact = require('../../Contact/get')
const Context = require('../../Context')


/**
 * @param {UUID} brand_id
 * @param {UUID} user_id
 * @param {UUID[]} brand_email_ids
 * @param {IFlowEmailInput[]} emails
 */
const create = async (brand_id, user_id, brand_email_ids, emails) => {
  Context.log(`Creating ${emails.length} emails`)
  if (emails.length < 1) return []

  const brand_emails = await BrandEmail.getAll(brand_email_ids)
  const be_by_id = _.keyBy(brand_emails, 'id')

  const contacts = await Contact.getAll(emails.map(e => e.contact))
  const cs_by_id = _.keyBy(contacts, 'id')

  const valid_emails = emails.filter(e => cs_by_id[e.contact].email !== null)

  if (valid_emails.length < 1) return []

  const campaigns = valid_emails.map(/** @returns {IEmailCampaignInput} */e => ({
    created_by: user_id,
    brand: brand_id,
    due_at: e.is_automated ? belt.epochToDate(e.due_date).toISOString() : null,
    from: user_id,
    html: be_by_id[e.origin].body,
    subject: be_by_id[e.origin].subject,
    individual: true,
    to: [{
      contact: e.contact,
      email: /** @type {string} */(cs_by_id[e.contact].email),
      recipient_type: Email.EMAIL
    }]
  }))

  const campaign_ids = await EmailCampaign.createMany(campaigns)

  const data = valid_emails.map((email, i) => ({
    email: campaign_ids[i],
    origin: email.origin,
    created_by: user_id
  }))

  const q = sq.insert({ autoQuoteFieldNames: true })
    .into('flows_emails')
    .setFieldsRows(data)
    .returning('id')

  // @ts-ignore
  q.name = 'flow/email/create'

  return db.selectIds(q, [])
}


module.exports = {
  create
}
