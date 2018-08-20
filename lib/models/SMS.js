const config = require('../config.js')
const queue = require('../utils/queue.js')

const twilio = require('twilio')(config.twilio.sid, config.twilio.auth_token)

if (process.env.NODE_ENV === 'tests')
  twilio.messages.create = (data, cb) => {
    cb(null, {})
  }

SMS = {}

SMS.send = function (sms, cb) {
  Context.get('jobs').push(queue.create('sms', sms).removeOnComplete(true))
  cb()
}

SMS.callTwilio = function (sms, cb) {
  const data = {
    to: sms.to,
    from: sms.from,
    body: sms.body,
    mediaUrl: sms.image
  }

  if (!data.mediaUrl)
    delete data.mediaUrl // Sending undefined to twilio causes issues it seems.

  twilio.messages.create(data).nodeify((err, response) => {
    if (err)
      console.log('<- (Twilio-Transport) Error sending SMS message to'.red, sms.to.yellow, ':', JSON.stringify(err))
    else
      console.log('<- (Twilio-Transport) Successfully sent a message to'.magenta, sms.to.yellow)

    return cb(null, response)
  })
}

module.exports = function () {}
