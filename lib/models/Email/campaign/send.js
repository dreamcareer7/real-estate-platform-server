const _ = require('lodash')
const uuid = require('uuid')

const db     = require('../../../utils/db')

const AttachedFile = require('../../AttachedFile')
const Context = require('../../Context')
const User = require('../../User/get')
const Contact = require('../../Contact/get')

const MicrosoftCredential = require('../../Microsoft/credential/get')
const GoogleCredential = require('../../Google/credential/get')

const { MARKETING } = require('../constants')
const htmlToText = require('../html-to-text')
const { create, createAll } = require('../create')


const emitter = require('./emitter')
const EmailCampaignEmail = require('./email')
const EmailCampaignAttachment = require('./attachment')

const { notify } = require('./notify')
const { FAIL_EVENT, SEND_EVENT } = require('./constants')

const regexp = /{{\s*((recipient|sender)+)\.([\w]+)\s*(or\s*"(.*)")*\s*}}/gi

const { get } = require('./get')

/**
 * @param {UUID} brand_id 
 * @param {UUID} user_id 
 */
const checkQuota = async (brand_id, user_id) => {
  const res = await db.selectOne('email/campaign/check_quota', [
    brand_id,
    user_id
  ])

  return parseInt(res.count)
}

/**
 * @param {Object} campaign
 * @param {string} error
 */
const saveError = async (campaign, error) => {
  return db.query.promise('email/campaign/save-error', [campaign.id, Context.getId(), error])
}

/**
 * @param {UUID} id
 */
const markAsExecuted = async id => {
  await db.query.promise('email/campaign/mark-as-executed', [id])
}

const render = (template, entities) => {
  const matches = template.matchAll(regexp)

  for(const match of matches) {
    const [
      text,
      entity,,
      attribute,,
      default_value
    ] = match

    const model = entities[entity.toLowerCase()]

    const value = model && model[attribute] ? model[attribute] : default_value

    template = template.replace(text, value)
  }

  return template
}

const sendIndividualCampaign = async ({email, recipients = [], campaign, user}) => {
  Context.log('Sending individual campaign', campaign.id)

  const max_allowed = user.email_quota
  const used_quota = await checkQuota(campaign.brand, user.id)

  if (used_quota + recipients.length > max_allowed) {
    Context.log(`used_quota: ${used_quota}, recipients: ${recipients.length}, max_allowed: ${max_allowed}`)
    throw new Error('Maximum marketing email quota per month exceeded.')
  }

  const contact_ids = recipients
    .map(r => r.contact)
    .filter(Boolean)


  const contacts = await Contact.getAll(contact_ids)
  const indexed = _.keyBy(contacts, 'id')

  const renderer = recipient => {
    const contact = indexed[recipient.contact] || {
      email: recipient.email
    }

    const subject = render(email.subject, {
      recipient: contact,
      sender: user
    })

    const text = render(email.text, {
      recipient: contact,
      sender: user
    })

    const html = render(email.html, {
      recipient: contact,
      sender: user
    })

    return {
      ...email,
      subject,
      html,
      text,
      tags: [campaign.brand, campaign.id],
      to: [recipient.email]
    }
  }

  const emails = recipients.map(renderer)

  Context.log(`Rendering is completed for campaign ${campaign.id}, resulting in ${emails.length} emails.`)

  const saved = await createAll(emails)
  Context.log(`Scheduled ${emails.length} emails.`)

  const campaign_emails = recipients.map((to, i) => {
    return {
      ...to,
      email: saved[i],
      campaign: campaign.id,
      email_address: to.email
    }
  })

  const created_email_ids = await EmailCampaignEmail.createAll(campaign_emails)
  emitter.emit('sent', {
    brand: campaign.brand,
    individual: true,
    campaign: campaign.id,
    emails: created_email_ids
  })

  Context.log(`Finished sending campaign ${campaign.id}.`)
}

const lock = async id => {
  Context.log('Acquiring lock for campaign', id)
  const { rows } = await db.query.promise('email/campaign/lock', [ id ])

  const [ lock ] = rows

  if (!lock)
    throw Error.Generic('Lock not acquired for campaign', id)

  if (lock.executed_at)
    throw Error.Generic('Email Campaign Already Executed')

  Context.log('Lock Acquired')
}

const sendCampaign = async ({email, recipients = [], campaign, user}) => {
  const grouped = _.groupBy(recipients, 'send_type')

  email.to = _.map(grouped.To, 'email')
  email.cc = _.map(grouped.CC, 'email')
  email.bcc = _.map(grouped.BCC, 'email')
  email.tags = [campaign.brand, campaign.id]

  /*
   * In case of normal email campaigns, we still wanted to support
   * template variables. But since we have only 1 email address,
   * we cannot render it per-recipient.
   * Therefore, we render if for To recipient #1.
   * Please note that this _assumes_ that there's a To recipient.
   * As of current date, Mailgun forces us to have at least 1 To recipient.
   * Therefore that's a given. Although there's no guarantee that the To
   * recipient will have a contact.
   */

  const primaryRecpient = Array.isArray(grouped.To) ? grouped.To[0] : null

  const contact_id = primaryRecpient ? primaryRecpient.contact : null

  const contact = contact_id ? (await Contact.get(contact_id)) : null

  const subject = render(email.subject, {
    recipient: contact,
    sender: user
  })

  const text = render(email.text, {
    recipient: contact,
    sender: user
  })

  const html = render(email.html, {
    recipient: contact,
    sender: user
  })

  const saved = await create({
    ...email,
    subject,
    html,
    text
  })

  const campaign_emails = recipients.map(to => {
    return {
      ...to,
      email: saved.id,
      email_address: to.email,
      campaign: campaign.id
    }
  })

  const created_email_ids = await EmailCampaignEmail.createAll(campaign_emails)
  emitter.emit('sent', {
    brand: campaign.brand,
    individual: false,
    campaign: campaign.id,
    emails: created_email_ids
  })
}

/**
 * @param {IEmailCampaign} campaign
 */
const send = async id => {
  const campaign = await get(id)
  await lock(campaign.id)

  const recipients = await db.select('email/campaign/emails', [campaign.id])
  const user       = await User.get(campaign.from)
  const text       = campaign.text || htmlToText(campaign.html)

  const attachments = await EmailCampaignAttachment.getByCampaign(campaign.id)

  const ids   = attachments.map(att => att.file)
  const files = await AttachedFile.getAll(ids)

  const filesById = _.keyBy(files, 'id')

  const populated = attachments.map(attachment => {
    return {
      ...attachment,
      ...filesById[attachment.file]
    }
  })

  let from = `${user.display_name} <${user.email}>`

  if ( campaign.google_credential ) {
    const credential = await GoogleCredential.get(campaign.google_credential)
    from = `${credential.display_name} <${credential.email}>`
  }
  
  if ( campaign.microsoft_credential ) {
    const credential = await MicrosoftCredential.get(campaign.microsoft_credential)
    from = `${credential.display_name} <${credential.email}>`
  }
  
  const email = {
    domain: MARKETING,
    from,
    subject: campaign.subject,
    html: campaign.html,
    text,
    campaign: campaign.id,
    user: campaign.created_by,
    attachments: populated,
    headers: campaign.headers,
    google_credential: campaign.google_credential,
    microsoft_credential: campaign.microsoft_credential,
    tracking_id: uuid.v4()
  }


  await markAsExecuted(campaign.id)

  try {

    // individual campaign ==> marketing-center
    // normal campaign     ==> insigtht, contact-profile, inbox

    // outlook => 30 messages per minute
    // gmail   => 2000 daily

    // outlook recipients limit per message: 500
    // gmail recipients limit per message: 100
    // gmail and outlook daily recipients: 10,000

    const rlen = recipients.length
    const isGoogle    = campaign.google_credential ? true : false
    const isMicrosoft = campaign.microsoft_credential ? true : false

    if ( campaign.individual ) {

      campaign.headers = {}
      campaign.microsoft_credential = ''
      campaign.google_credential    = ''
      email.microsoft_credential    = ''
      email.google_credential       = ''

      await sendIndividualCampaign({campaign, recipients, email, user})

    } else {

      if ( (isGoogle && rlen > 100) || (isMicrosoft && rlen > 500) ) {
        campaign.headers = {}
        campaign.microsoft_credential = ''
        campaign.google_credential    = ''
        email.microsoft_credential    = ''
        email.google_credential       = ''
      }      

      if (rlen < 1000) {
        await sendCampaign({campaign, recipients, email, user})

      } else {

        // If campaign's gateway was either of Google or Microsoft, It would be switched to Mailgun due of lines 746-752
        await sendIndividualCampaign({campaign, recipients, email, user})
      }
    }

  } catch(error) {
    Context.log('Error during email send', error)
    await saveError(campaign, error.message)

    notify(
      FAIL_EVENT,
      user.id,
      campaign.brand,
      [campaign.id]
    )
  }

  notify(
    SEND_EVENT,
    user.id,
    campaign.brand,
    [campaign.id]
  )
}

module.exports = {
  send,
  sendIndividualCampaign,
  sendCampaign,
  saveError,
}
