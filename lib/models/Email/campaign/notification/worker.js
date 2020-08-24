const config  = require('../../../../config')
const Context = require('../../../Context')
const promisify = require('../../../../utils/promisify')

const { get: getCampaign } = require('../../campaign/get')
const { getByEmail }       = require('../../campaign/email/get')
const { issueForUsers }    = require('../../../Notification/issue')
const { getByMailgunId }   = require('../../get')

/*
  We only have recipient's value for mailgun events
*/
const sendNotification = async (event, email, recipient = null) => {
  Context.log('sendNotification ==> step 2 ==>', event, email, recipient)

  let email_id = email

  if (recipient) {
    email_id = await getByMailgunId(email)
  }

  const emailCampaignEmail = await getByEmail(email_id)
  const emailCampaign      = await getCampaign(emailCampaignEmail.campaign)


  let message = `Email campaign ${emailCampaign.subject} has been ${event}.`

  if ( event === config.email_events.clicked && recipient ) {
    message = `Email campaign ${emailCampaign.subject} has been ${event} by ${recipient}.`
  }

  const notification = {}
  notification.subject_class = 'EmailCampaign'
  notification.object_class  = 'EmailCampaignEmail'
  notification.subject = emailCampaignEmail.campaign
  notification.object  = emailCampaignEmail.id
  notification.action  = 'ReactedTo'
  notification.title   = ''
  notification.data    = { event }
  notification.message = message

  const user_ids = Array.from(new Set([emailCampaign.created_by, emailCampaign.from]))
  await promisify(issueForUsers)(notification, user_ids, {})

  Context.log('sendNotification ==> step 3 ==>', JSON.stringify(notification), JSON.stringify(user_ids))

  return
}


module.exports = {
  sendNotification
}