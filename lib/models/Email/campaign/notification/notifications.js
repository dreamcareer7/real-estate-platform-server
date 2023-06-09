const { getByMailgunId, get: getEmail } = require('../../get')
const { get: getCampaign } = require('../../campaign/get')
const { sendNotification } = require('./')
const { isCampaignOlderThanAMonth, isRecipientOwner } = require('./helper')

const promisify = require('../../../../utils/promisify')
const redis = require('../../../../data-service/redis').createClient()
const zadd  = promisify(redis.zadd.bind(redis))

const { open_debounce_key, email_events } = require('./constants')


function easeOutExpo(x) {
  return x === 1 ? 1 : 1 - Math.pow(2, -10 * x)
}

const debounceOpenEvents = async (member, sent) => {
  const max   = 25000
  const index = ( sent > max ) ? 1 : (sent / max)
  const rate  = easeOutExpo(index) * 10000
  const delay = Math.ceil(rate)
  const score = Math.round(Date.now() / 1000) + delay

  await zadd(open_debounce_key, score, member)
}

const processNotification = async (object, event, email_id) => {
  const recipient = object.recipient

  const email = await getEmail(email_id)
  const campaign_id = email.campaign

  try {
    const emailCampaign = await getCampaign(campaign_id)

    if ( await isRecipientOwner(emailCampaign, recipient) ) {
      return
    }

    if (!emailCampaign.notifications_enabled) {
      return
    }

    if (isCampaignOlderThanAMonth(emailCampaign.created_at)) {
      return
    }

    /*
      We need to digest all of the opened events.
    */
    if ( event === email_events.opened ) {
      const member = JSON.stringify({ event, campaign_id }) // member: member of redis sorted-set
      await debounceOpenEvents(member, emailCampaign.sent)
    }

    /*
      We don not need to digest clicked events.
      Tip: We only have object.recipient's value for mailgun events.
    */
    if ( event === email_events.clicked ) {
      await sendNotification({ event, campaign_id, email_id, recipient, count: 1 })
    }

  } catch (ex) {

    if ( ex.code === 'ResourceNotFound' ) {
      return
    }

    throw ex
  }
}

const handleMailgun = async (object, event) => {
  const message_id = (object.message && object.message.headers) ? object.message.headers['message-id'] : null
  // const recipient = object.recipient

  /*
    message_id is the unique id of the relevant sent mailgun email.
  */
  if (!message_id) {
    return
  }

  /*
    email_id is the unique id of the relevant record of emails table.
  */
  const email_id = await getByMailgunId(message_id)

  return await processNotification(object, event, email_id)
}

const handleGmailOutlook = async (object, event) => {
  const email_id = object.email

  /*
    email_id is the unique id of the relevant record of emails table.
  */
  if (!email_id) {
    return
  }

  return await processNotification(object, event, email_id)
}

const handleNotifications = async (object, event) => {
  // object is actually email_events.object

  if ( object.origin === 'mailgun' ) {
    return await handleMailgun(object, event)
  }

  return await handleGmailOutlook(object, event)
}

// This method is being used only for 'opened' events.
const handleCampaignOpenNotifications = async (campaign_id) => {
  try {
    const emailCampaign = await getCampaign(campaign_id)

    if (!emailCampaign.notifications_enabled) {
      return
    }

    const member = JSON.stringify({ event: email_events.opened, campaign_id }) // member: member of redis sorted-set

    await debounceOpenEvents(member, emailCampaign.sent)

  } catch (ex) {

    if ( ex.code === 'ResourceNotFound' ) {
      return
    }

    throw ex
  }
}


module.exports = {
  handleNotifications,
  handleCampaignOpenNotifications
}