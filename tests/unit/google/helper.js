const { expect } = require('chai')

const GoogleCredential    = require('../../../lib/models/Google/credential')
const GoogleMessage       = require('../../../lib/models/Google/message')
const GoogleCalendar      = require('../../../lib/models/Google/calendar')
const GoogleCalendarEvent = require('../../../lib/models/Google/calendar_events')

const { generateGMesssageRecord } = require('../../../lib/models/Google/workers/gmail/common')

const google_messages_offline = require('./data/google_messages.json')
const calendars = require('./data/calendars.json')
const events    = require('./data/calendar_events.json')



async function createGoogleCredential(user, brand) {
  const body = require('./data/google_credential')
  
  body.user  = user.id
  body.brand = brand.id

  const credentialId = await GoogleCredential.create(body)
  const credential   = await GoogleCredential.get(credentialId)

  return {
    credential,
    body
  }
}

async function createGoogleMessages(user, brand) {
  const { credential } = await createGoogleCredential(user, brand)

  const googleMessages = []

  for (const message of google_messages_offline) {
    googleMessages.push(generateGMesssageRecord(credential.id, message))
  }

  const createdMessages = await GoogleMessage.create(googleMessages, credential.id)

  return {
    createdMessages,
    credential
  }
}

async function createGoogleCalendar(googleCredential) {
  const id  = await GoogleCalendar.createLocal(googleCredential.id, calendars.remote_cal_1)
  const cal = await GoogleCalendar.get(id)

  expect(cal.id).to.be.equal(id)
  expect(cal.calendar_id).to.be.equal(calendars.remote_cal_1.id)
  expect(cal.type).to.be.equal('google_calendars')
  expect(cal.google_credential).to.be.equal(googleCredential.id)
  expect(cal.summary).to.be.equal(calendars.remote_cal_1.summary)
  expect(cal.location).to.be.equal(calendars.remote_cal_1.location)
  expect(cal.description).to.be.equal(calendars.remote_cal_1.description)
  expect(cal.origin).to.be.equal(calendars.remote_cal_1.origin)
  expect(cal.selected).to.be.equal(false)
  expect(cal.deleted).to.be.equal(false)
  expect(cal.primary).to.be.equal(false)
  expect(cal.sync_token).to.be.equal(null)
  expect(cal.watcher).to.be.equal(null)
  expect(cal.watcher_status).to.be.equal(null)
  expect(cal.watcher_channel_id).to.be.equal(null)
  expect(cal.deleted_at).to.be.equal(null)

  return cal
}

async function createGoogleCalendarEvent(googleCredential) {
  const googleCalendar = await createGoogleCalendar(googleCredential)

  const id    = await GoogleCalendarEvent.createLocal(googleCalendar, events.remote_event_1)
  const event = await GoogleCalendarEvent.get(id)

  expect(event.id).to.be.equal(id)
  expect(event.google_calendar).to.be.equal(googleCalendar.id)
  expect(event.google_credential).to.be.equal(googleCredential.id)
  expect(event.event_id).to.be.equal(events.remote_event_1.id)
  expect(event.summary).to.be.equal(events.remote_event_1.summary)
  expect(event.location).to.be.equal(events.remote_event_1.location)
  expect(event.description).to.be.equal(events.remote_event_1.description)
  expect(event.origin).to.be.equal('rechat')
  expect(event.status).to.be.equal(events.remote_event_1.status)
  expect(event.recurring_event_id).to.be.equal(events.remote_event_1.recurringEventId)
  expect(event.type).to.be.equal('google_calendar_events')
  expect(event.organizer).to.deep.equal(events.remote_event_1.organizer)
  expect(new Date(event.created).getTime()).to.be.equal(new Date(events.remote_event_1.created).getTime())
  expect(event.event_start).to.deep.equal(events.remote_event_1.start)
  expect(event.event_end).to.deep.equal(events.remote_event_1.end)

  return event
}


module.exports = {
  createGoogleCredential,
  createGoogleMessages,
  createGoogleCalendar,
  createGoogleCalendarEvent
}
