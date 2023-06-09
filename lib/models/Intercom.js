const I = require('intercom-client')
const config = require('../config.js')
const client = new I.Client({ token: config.intercom.token })
const debug = require('debug')('rechat:intercom')

const timestamp = () => Math.floor((new Date()).getTime() / 1000)

function handleError(res) {
  if (res.status > 299)
    throw new Error('Intercom error')
  
  return res
}

const Intercom = {}

Intercom.updateUser = (user, ip, agent) => {
  const payload = {
    user_id: user.id,
    email: user.email,
    name: user.first_name + ' ' + user.last_name,
    signed_up_at: Math.floor(user.created_at),
    last_seen_ip: ip,
    last_request_at: timestamp(),
    last_seen_user_agent: agent,
    custom_data: {
      is_shadow: user.is_shadow,
      user_type: user.user_type,
      user_status: user.user_status,
      email_confirmed: user.email_confirmed,
      phone_confirmed: user.phone_confirmed
    }
  }

  debug('(updateUser) ' + JSON.stringify(payload, null, 2))

  return client.users.create(payload).then(handleError)
}

Intercom.createEvent = (data, ip, agent) => {
  const payload = {
    event_name: data.event,
    created_at: timestamp(),
    user_id: data.user.id,
    metadata: data.metadata
  }

  debug('(createEvent)' + JSON.stringify(payload, null, 2))

  return Intercom.updateUser(data.user, ip, agent).then(
    () => client.events.create(payload).then(handleError)
  )
}

Intercom.handleEvents = (req, res, events) => {
  if (!req.user)
    return

  if (res.statusCode > 299)
    return

  if (!Array.isArray(events))
    return

  return Promise.all(events.map(event =>
    Intercom.createEvent({
      event: event.event,
      user: event.user || req.user,
      metadata: {
        source: req.client.name,
        elapsed: (event.timestamp - req.start) / 1000
      }
    }, req.headers['x-forwarded-for'] || req.connection.remoteAddress, req.headers['x-real-agent']))
  )
}

module.exports = Intercom
