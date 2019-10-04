const _ = require('lodash')
const mjml2html = require('mjml')

const db = require('../../../utils/db')
const render = require('../../../utils/render')

const Task = require('../../CRM/Task')

const AttachedFile = require('../../AttachedFile')
const Context = require('../../Context')
const Orm = require('../../Orm')
const Socket = require('../../Socket')
const User = require('../../User')
const Contact = require('../../Contact')

const htmlToText = require('../html-to-text')

const Email = require('../index')
const EmailCampaign = {}

global['EmailCampaign'] = EmailCampaign

const EmailCampaignEmail = require('./email')
const EmailCampaignRecipient = require('./recipient')

require('./stats')

const default_event_title = '(untitled email)'

const CREATE_EVENT = 'email_campaign:create'
const SEND_EVENT = 'email_campaign:create'
const DELETE_EVENT = 'email_campaign:delete'

/**
 * @param {UUID[]} ids
 * @returns {Promise<IEmailCampaign[]>}
 */
EmailCampaign.getAll = async ids => {
  const associations = Orm.getEnabledAssociations()
  const conditions = Orm.getAssociationConditions('email_campaign.emails')

  return db.select('email/campaign/get', [ids, associations, conditions ? conditions.contact : null])
}

/**
 * @param {UUID} id
 * @returns {Promise<IEmailCampaign>}
 */
EmailCampaign.get = async id => {
  const campaigns = await EmailCampaign.getAll([id])


  if (campaigns.length < 1)
    throw Error.ResourceNotFound(`Email Campaign ${id} not found`)

  return campaigns[0]
}

/**
 * @param {UUID} brand
 */
EmailCampaign.getByBrand = async brand => {
  const ids = await db.selectIds('email/campaign/by_brand', [brand])

  return EmailCampaign.getAll(ids)
}

/**
 * @param {UUID} id 
 */
const markAsExecuted = async id => {
  await db.query.promise('email/campaign/mark-as-executed', [id])
}

/**
 * @param {IEmailCampaignInput[]} campaigns 
 */
const insert = async campaigns => {
  campaigns.forEach(campaign => {
    if (!campaign.text)
      campaign.text = htmlToText(campaign.html)

    /*
     * Mailgun doesn't allow sending an email with no text and no html.
     * However, user's tend to do that (eg send an attachment with no body)
     * Also, Mailgun doesn't allow setting them as "". It needs at least a space.
     * More info at server#1381
     */
    if (_.isEmpty(campaign.text) && _.isEmpty(campaign.html))
      campaign.text = ' '
  })

  return db.selectIds('email/campaign/insert', [JSON.stringify(campaigns)])
}

/**
 * @param {IEmailCampaign[]} campaigns 
 */
const insertAttachments = async campaigns => {
  const links = []

  for(const campaign of campaigns) {
    const { attachments = [] } = campaign

    for(const attachment of attachments)
      links.push({
        role: 'EmailCampaign',
        role_id: campaign.id,
        file: attachment
      })
  }

  await AttachedFile.linkMany(links)
}

/**
 * @param {IEmailCampaignInput[]} campaigns
 */
EmailCampaign.createMany = async (campaigns) => {
  campaigns.forEach(validate)

  const template_instance_ids = campaigns
    .map(campaign => campaign.template)
    .filter(Boolean)

  const template_instances = await TemplateInstance.getAll(template_instance_ids)
  const indexed_instances = _.keyBy(template_instances, 'id')

  const template_ids = template_instances
    .map(t => t.template)

  const templates = await Template.getAll(template_ids)
  const indexed_templates = _.keyBy(templates, 'id')

  campaigns.forEach((campaign, i) => {
    if (!campaign.template)
      return

    const instance = indexed_instances[campaign.template]
    const template = indexed_templates[instance.template]

    const { html } = instance
    const { mjml } = template

    campaign.html = mjml ? mjml2html(html).html : html
  })

  const ids = await insert(campaigns)

  campaigns.forEach((campaign, i) => {
    campaign.id = ids[i]
  })

  await EmailCampaignRecipient.insertForCampaigns(campaigns)

  await insertAttachments(/** @type {IEmailCampaign[]} */(campaigns))

  notify(
    CREATE_EVENT,
    campaigns[0].created_by,
    campaigns[0].brand,
    ids
  )

  return ids
}

/**
 * @param {IEmailCampaign} campaign
 */
EmailCampaign.update = async campaign => {
  const text = campaign.text || htmlToText(campaign.html)

  validate(campaign)

  await db.query.promise('email/campaign/update', [
    campaign.id,
    campaign.subject,
    campaign.include_signature,
    campaign.html,
    text,
    campaign.due_at
  ])

  await EmailCampaignRecipient.insertForCampaigns([campaign])

  const old = await EmailCampaign.get(campaign.id)
  const attachments = old.attachments || []

  const toDelete = attachments.map(file => {
    return {
      file,
      role_id: campaign.id,
      role: 'EmailCampaign'
    }
  })
  await AttachedFile.unlinkMany(toDelete)

  await insertAttachments([campaign])

  return EmailCampaign.get(campaign.id)
}

EmailCampaign.deleteMany = async (ids, user, brand) => {
  await db.update('email/campaign/delete', [
    ids
  ])

  notify(
    DELETE_EVENT,
    user.id,
    brand,
    ids
  )
}

EmailCampaign.sendDue = async () => {
  const due = await db.selectIds('email/campaign/due')

  const campaigns = await EmailCampaign.getAll(due)

  for(const campaign of campaigns)
    await EmailCampaign.send(campaign)
}

const renderSubject = ({email, user, contact}) => {
  const { subject = '' } = email

  return render.textString(subject, {
    recipient: contact,
    sender: user
  })
}

const renderHtmlBody = ({email, user, contact}) => {
  const { html = '' } = email

  return render.htmlString(html, {
    recipient: contact,
    sender: user
  })
}

const renderTextBody = ({email, user, contact}) => {
  const { text = '' } = email

  return render.textString(text, {
    recipient: contact,
    sender: user
  })
}

const sendIndividualCampaign = async ({email, recipients = [], campaign, user}) => {
  const contact_ids = recipients
    .map(r => r.contact)
    .filter(Boolean)

  const contacts = await Contact.getAll(contact_ids)
  const indexed = _.keyBy(contacts, 'id')

  const emails = recipients.map(recipient => {
    const contact = indexed[recipient.contact] || {
      email: recipient.email
    }

    return {
      ...email,
      subject: renderSubject({email, contact, user}),
      html: renderHtmlBody({email, contact, user}),
      text: renderTextBody({email, contact, user}),
      tags: [campaign.brand],
      to: [recipient.email]
    }
  })

  const saved = await Email.createAll(emails)

  const campaign_emails = recipients.map((to, i) => {
    return {
      ...to,
      email: saved[i],
      campaign: campaign.id,
      email_address: to.email
    }
  })

  await EmailCampaignEmail.createAll(campaign_emails)

  const contact_emails = recipients
    .filter((ce, i) => ce.contact)
    .map((ce, i) => {
      return {
        user: campaign.from,
        contact: ce.contact,
        email: saved[i]
      }
    })

  /** @type {ICrmAssociationInput[]} */
  const associations = contact_emails.map(/** @returns {ICrmAssociationInputContact} */ce => {
    return {
      association_type: 'contact',
      contact: ce.contact,
      brand: campaign.brand,
      created_by: campaign.created_by
    }
  })

  associations.push({
    association_type: 'email',
    email: campaign.id,
    brand: campaign.brand,
    created_by: campaign.created_by
  })

  if (campaign.deal) {
    associations.push({
      association_type: 'deal',
      deal: campaign.deal,
      brand: campaign.brand,
      created_by: campaign.created_by
    })
  }

  await Task.create({
    created_by: campaign.from,
    brand: campaign.brand,
    title: campaign.subject || default_event_title,
    status: 'DONE',
    task_type: 'Email',
    due_date: Date.now() / 1000,
    associations,
    assignees: [campaign.from]
  })
}

const sendCampaign = async ({email, recipients = [], campaign, user}) => {
  const grouped = _.groupBy(recipients, 'send_type')

  email.to = _.map(grouped.To, 'email')
  email.cc = _.map(grouped.CC, 'email')
  email.bcc = _.map(grouped.BCC, 'email')
  email.tags = [campaign.brand]

  const saved = await Email.create({
    ...email,
    subject: renderSubject({email, user}),
    html: renderHtmlBody({email, user}),
    text: renderTextBody({email, user}),
  })

  const campaign_emails = recipients.map(to => {
    return {
      ...to,
      email: saved.id,
      email_address: to.email,
      campaign: campaign.id
    }
  })

  await EmailCampaignEmail.createAll(campaign_emails)

  const contact_emails = recipients
    .filter(ce => ce.contact)
    .map(ce => {
      return {
        user: campaign.from,
        contact: ce.contact,
        email: saved.id
      }
    })

  /** @type {ICrmAssociationInput[]} */
  const associations = contact_emails.map(/** @returns {ICrmAssociationInputContact} */ce => {
    return {
      association_type: 'contact',
      contact: ce.contact,
      brand: campaign.brand,
      created_by: campaign.created_by
    }
  })

  associations.push({
    association_type: 'email',
    email: campaign.id,
    brand: campaign.brand,
    created_by: campaign.created_by
  })

  if (campaign.deal) {
    associations.push({
      association_type: 'deal',
      deal: campaign.deal,
      brand: campaign.brand,
      created_by: campaign.created_by
    })
  }

  await Task.create({
    created_by: campaign.from,
    brand: campaign.brand,
    title: campaign.subject || default_event_title,
    status: 'DONE',
    task_type: 'Email',
    due_date: Date.now() / 1000,
    associations,
    assignees: [campaign.from]
  })
}

/**
 * @param {IEmailCampaign} campaign
 */
EmailCampaign.send = async (campaign) => {
  const recipients = await db.select('email/campaign/emails', [campaign.id])

  const user = await User.get(campaign.from)

  const text = campaign.text || htmlToText(campaign.html)

  const email = {
    domain: Email.MARKETING,
    from: `${user.display_name} <${user.email}>`,
    subject: campaign.subject,
    html: campaign.html,
    text,
    campaign: campaign.id,
    attachments: campaign.attachments || []
  }

  markAsExecuted(campaign.id)

  if (campaign.individual)
    await sendIndividualCampaign({campaign, recipients, email, user})
  else
    await sendCampaign({campaign, recipients, email, user})

  notify(
    SEND_EVENT,
    user.id,
    campaign.brand,
    [campaign.id]
  )
}

const notify = (event, user, brand, ids) => {
  Socket.send(
    event,
    brand,
    [{ user, brand, ids }],

    err => {
      if (err) Context.error(`Error sending ${event} socket event.`, err)
    }
  )
}

Orm.register('email_campaign', 'EmailCampaign', EmailCampaign)

const validate = campaign => {
  const { html, text, subject } = campaign

  const email = {
    subject, html, text
  }

  try {
    renderSubject({email})
  } catch(e) {
    console.log(e)
    throw Error.Validation('Error in formatting of subject')
  }

  try {
    renderHtmlBody({email})
  } catch(e) {
    console.error(e)
    throw Error.Validation('Error in formatting of body')
  }

  try {
    renderTextBody({email})
  } catch(e) {
    console.error(e)
    throw Error.Validation('Error in formatting of text body')
  }
}

EmailCampaign.associations = {
  emails: {
    collection: true,
    model: 'EmailCampaignEmail',
    enabled: false,
  },

  template: {
    model: 'TemplateInstance',
    enabled: false
  },

  from: {
    model: 'User',
    enabled: false
  },

  recipients: {
    model: 'EmailCampaignRecipient',
    collection: true,
    enabled: false
  },

  deal: {
    model: 'Deal',
    enabled: false,
    optional: true
  },

  attachments: {
    model: 'AttachedFile',
    enabled: false,
    collection: true
  }
}

module.exports = EmailCampaign