const config  = require('../../config')
const db      = require('../../utils/db.js')
const squel   = require('../../utils/squel_extensions')
const Orm     = require('../Orm')

const MicrosoftCredential = require('./credential')
const { getMockClient, getMGraphClient } = require('./plugin/client.js')


const MicrosoftCalendarEvent = {}

const SCOPE_OUTLOOK_CAL = config.microsoft_scopes.calendar[0]


/**
 * @param {UUID} cid microsoft_credential_id
 */
const getClient = async (cid) => {
  if ( process.env.NODE_ENV === 'tests' ) {
    return getMockClient()
  }

  const credential = await MicrosoftCredential.get(cid)

  if (credential.revoked)
    throw Error.BadRequest('Microsoft-Credential is revoked!')

  if (credential.deleted_at)
    throw Error.BadRequest('Microsoft-Credential is deleted!')

  if (!credential.scope.includes(SCOPE_OUTLOOK_CAL))
    throw Error.BadRequest('Access is denied! Insufficient permission.')

  const microsoft  = await getMGraphClient(credential)

  if (!microsoft)
    throw Error.BadRequest('Microsoft-Client failed!')

  return microsoft
}

const createRemote = async function (microsoftCalendar, resource) {
  const microsoft = await getClient(microsoftCalendar.microsoft_credential)

  return await microsoft.createEvent(microsoftCalendar.calendar_id, resource)
}

const updateRemote = async function (oldEvent, microsoftCalendar, resource) {
  const microsoft = await getClient(microsoftCalendar.microsoft_credential)

  const remoteEvent = await microsoft.getEvent(microsoftCalendar.calendar_id, oldEvent.event_id)

  if (!remoteEvent)
    throw Error.ResourceNotFound(`Microsoft event ${oldEvent.event_id} not found.`)

  if ( remoteEvent.updated > oldEvent.update ) {
    return {
      status: 204,
      local: oldEvent,
      remote: remoteEvent
    }    
  }

  const updatedEvent = await microsoft.updateEvent(microsoftCalendar.calendar_id, oldEvent.event_id, resource)
 
  await MicrosoftCalendarEvent.updateLocal(oldEvent.id, updatedEvent)

  return {
    status: 200,
    local: oldEvent,
    remote: updatedEvent
  }
}

const deleteRemote = async function (oldEvent, microsoftCalendar) {
  const microsoft = await getClient(microsoftCalendar.microsoft_credential)

  await microsoft.deleteEvent(microsoftCalendar.calendar_id, oldEvent.event_id)
  await MicrosoftCalendarEvent.deleteLocal(oldEvent.id)

  return
}

const checkStartEnd = resource => {
  if (!resource.start.timeZone)
    throw Error.BadRequest('Start timeZone is not specified.')

  if (!resource.end.timeZone)
    throw Error.BadRequest('Start timeZone is not specified.')

  if ( resource.start.date && resource.start.dateTime )
    throw Error.BadRequest('Its not allowed to send both Start.date and Start.dateTime.')

  if ( resource.end.date && resource.end.dateTime )
    throw Error.BadRequest('Its not allowed to send both End.date and End.dateTime.')

  if ( !resource.start.date && !resource.start.dateTime )
    throw Error.BadRequest('ٍEither of Start.date or Start.dateTime is required.')

  if ( !resource.end.date && !resource.end.dateTime )
    throw Error.BadRequest('ٍEither of End.date or End.dateTime is required.')
}


MicrosoftCalendarEvent.createLocal = async function (microsoftCalendar, event) {
  return db.insert('microsoft/calendar_events/insert',[
    microsoftCalendar.microsoft_credential,
    microsoftCalendar.id,
    event.id,

    event.subject || null,
    event.type || null,
    event.body_preview || null,
    event.created_date_time || null,
    event.original_start || null,
    event.last_modified_date_time || null,
    event.original_end_time_zone || null,
    event.original_start_time_zone || null,
    JSON.stringify(event.event_start) || null,
    JSON.stringify(event.event_end) || null,
    JSON.stringify(event.location) || null,
    JSON.stringify(event.locations) || false,
    JSON.stringify(event.organizer) || true,
    JSON.stringify(event.recurrence) || false,
    JSON.stringify(event.body) || true,
    JSON.stringify(event.attendees) || false,
    JSON.stringify(event.categories) || false,
    JSON.stringify(event.response_status) || false,
    event.has_attachments,
    event.is_all_day,
    event.is_cancelled,
    event.is_organizer,
    event.is_reminderOn,
    event.response_requested,
    event.change_key,
    event.ical_uid,
    event.importance,
    event.online_meeting_url,
    event.reminder_minutes_before_start,
    event.sensitivity,
    event.series_masterId,
    event.show_as || false,
    event.web_link,
    'rechat'
  ])
}

MicrosoftCalendarEvent.bulkUpsert = async (records) => {
  return await db.chunked(records, Object.keys(records[0]).length, (chunk, i) => {
    const q = squel
      .insert()
      .into('microsoft_calendar_events')
      .setFieldsRows(chunk)
      .onConflict(['microsoft_credential', 'microsoft_calendar', 'event_id'], {
        subject: squel.rstr('EXCLUDED.subject'),
        type: squel.rstr('EXCLUDED.type'),
        body_preview: squel.rstr('EXCLUDED.body_preview'),
        created_date_time: squel.rstr('EXCLUDED.created_date_time'),
        original_start: squel.rstr('EXCLUDED.original_start'),
        last_modified_date_time: squel.rstr('EXCLUDED.last_modified_date_time'),
        original_end_time_zone: squel.rstr('EXCLUDED.original_end_time_zone'),
        original_start_time_zone: squel.rstr('EXCLUDED.original_start_time_zone'),
        event_start: squel.rstr('EXCLUDED.event_start'),
        event_end: squel.rstr('EXCLUDED.event_end'),
        location: squel.rstr('EXCLUDED.location'),
        locations: squel.rstr('EXCLUDED.locations'),
        organizer: squel.rstr('EXCLUDED.organizer'),
        recurrence: squel.rstr('EXCLUDED.recurrence'),
        body: squel.rstr('EXCLUDED.body'),
        attendees: squel.rstr('EXCLUDED.attendees'),
        categories: squel.rstr('EXCLUDED.categories'),
        response_status: squel.rstr('EXCLUDED.response_status'),
        has_attachments: squel.rstr('EXCLUDED.has_attachments'),
        is_all_day: squel.rstr('EXCLUDED.is_all_day'),
        is_cancelled: squel.rstr('EXCLUDED.is_cancelled'),
        is_organizer: squel.rstr('EXCLUDED.is_organizer'),
        is_reminderOn: squel.rstr('EXCLUDED.is_reminderOn'),
        response_requested: squel.rstr('EXCLUDED.response_requested'),
        change_key: squel.rstr('EXCLUDED.change_key'),
        ical_uid: squel.rstr('EXCLUDED.ical_uid'),
        importance: squel.rstr('EXCLUDED.importance'),
        online_meeting_url: squel.rstr('EXCLUDED.online_meeting_url'),
        reminder_minutes_before_start: squel.rstr('EXCLUDED.reminder_minutes_before_start'),
        sensitivity: squel.rstr('EXCLUDED.sensitivity'),
        series_masterId: squel.rstr('EXCLUDED.series_masterId'),
        show_as: squel.rstr('EXCLUDED.show_as'),
        web_link: squel.rstr('EXCLUDED.web_link'),
        updated_at: squel.rstr('now()')
      })
      .returning('id, microsoft_credential, microsoft_calendar, event_id')

    q.name = 'microsoft/calendar_events/bulk_upsert'

    return db.select(q)
  })  
}

MicrosoftCalendarEvent.updateLocal = async function (id, updatedEvent) {
  return await db.selectIds('microsoft/calendar_events/update', [
    id,

    updatedEvent.subject || null,
    updatedEvent.type || null,
    updatedEvent.body_preview || null,
    updatedEvent.created_date_time || null,
    updatedEvent.original_start || null,
    updatedEvent.last_modified_date_time || null,
    updatedEvent.original_end_time_zone || null,
    updatedEvent.original_start_time_zone || null,
    JSON.stringify(updatedEvent.event_start) || null,
    JSON.stringify(updatedEvent.event_end) || null,
    JSON.stringify(updatedEvent.location) || null,
    JSON.stringify(updatedEvent.locations) || false,
    JSON.stringify(updatedEvent.organizer) || true,
    JSON.stringify(updatedEvent.recurrence) || false,
    JSON.stringify(updatedEvent.body) || true,
    JSON.stringify(updatedEvent.attendees) || false,
    JSON.stringify(updatedEvent.categories) || false,
    JSON.stringify(updatedEvent.response_status) || false,
    updatedEvent.has_attachments,
    updatedEvent.is_all_day,
    updatedEvent.is_cancelled,
    updatedEvent.is_organizer,
    updatedEvent.is_reminderOn,
    updatedEvent.response_requested,
    updatedEvent.change_key,
    updatedEvent.ical_uid,
    updatedEvent.importance,
    updatedEvent.online_meeting_url,
    updatedEvent.reminder_minutes_before_start,
    updatedEvent.sensitivity,
    updatedEvent.series_masterId,
    updatedEvent.show_as || false,
    updatedEvent.web_link,
  ])
}


/**
 * @param {UUID[]} ids
 */
MicrosoftCalendarEvent.getAll = async (ids) => {
  return await db.select('microsoft/calendar_events/get', [ids])
}

/**
 * @param {UUID} id
 */
MicrosoftCalendarEvent.get = async (id) => {
  const calendars = await MicrosoftCalendarEvent.getAll([id])

  if (calendars.length < 1)
    throw Error.ResourceNotFound(`Microsoft calendar event by ${id} not found.`)

  return calendars[0]
}

/**
 * @param {Object} calendar MicrosoftCalendar
 */
MicrosoftCalendarEvent.getByCalendar = async (calendar) => {
  const ids = await db.selectIds('microsoft/calendar_events/get_by_calendar', [calendar.microsoft_credential, calendar.id])

  return await MicrosoftCalendarEvent.getAll(ids)
}

/**
 * @param {Object} calendar MicrosoftCalendar
 * @param {string[]} events_remote_ids MicrosoftCalendarEvent remote-id
 */
MicrosoftCalendarEvent.getByCalendarAndEventRemoteIds = async (calendar, events_remote_ids) => {
  const ids = await db.selectIds('microsoft/calendar_events/get_by_calendar_and_event_ids', [calendar.microsoft_credential, calendar.id, events_remote_ids])

  return await MicrosoftCalendarEvent.getAll(ids)
}

/**
 * @param {UUID} id
 */
MicrosoftCalendarEvent.deleteLocal = async function (id) {
  return await db.select('microsoft/calendar_events/delete', [id])
}

/**
 * @param {Object} calendar MicrosoftCalendar
 * @param {string[]} remoteEventIds MicrosoftCalendarEvent remote-id
 */
MicrosoftCalendarEvent.deleteLocalByRemoteIds = async (calendar, remoteEventIds) => {
  return await db.select('microsoft/calendar_events/delete_by_remote_ids', [calendar.microsoft_credential, calendar.id, remoteEventIds])
}

/**
 * @param {Object} calendar MicrosoftCalendar
 * @param {string[]} remoteEventIds MicrosoftCalendarEvent remote-id
 */
MicrosoftCalendarEvent.restoreLocalByRemoteIds = async (calendar, remoteEventIds) => {
  return await db.select('microsoft/calendar_events/restore_by_remote_ids', [calendar.microsoft_credential, calendar.id, remoteEventIds])
}

/**
 * @param {Object} calendar MicrosoftCalendar
 */
MicrosoftCalendarEvent.deleteLocalByCalendar = async (calendar) => {
  return await db.select('microsoft/calendar_events/delete_by_cal_id', [calendar.microsoft_credential, calendar.id])
}

/**
 * @param {UUID} cid microsoft_credential_id
 */
MicrosoftCalendarEvent.getGCredentialEventsNum = async (cid) => {
  return await db.select('microsoft/calendar_events/count', [cid])
}

MicrosoftCalendarEvent.publicize = async (model) => {
  // delete model.xxxx

  return model
}


MicrosoftCalendarEvent.create = async (microsoftCalendar, resource) => {
  if (!resource.name)
    throw Error.BadRequest('Name is not specified.')

  if (!resource.start)
    throw Error.BadRequest('Start is not specified.')

  if (!resource.end)
    throw Error.BadRequest('End is not specified.')
  
  checkStartEnd(resource)

  const event = await createRemote(microsoftCalendar, resource)

  return await MicrosoftCalendarEvent.createLocal(microsoftCalendar, event)
}

MicrosoftCalendarEvent.update = async (id, microsoftCalendar, resource) => {
  const oldEvent = await MicrosoftCalendarEvent.get(id)

  if (!oldEvent)
    throw Error.ResourceNotFound(`Microsoft Calendar Event ${id} not found.`)

  checkStartEnd(resource)

  const { status, local, remote } = await updateRemote(oldEvent, microsoftCalendar, resource)

  if ( status === 204 )
    return local

  await MicrosoftCalendarEvent.updateLocal(local.id, remote)

  return await MicrosoftCalendarEvent.get(local.id)
}

MicrosoftCalendarEvent.delete = async (id, microsoftCalendar) => {
  const oldEvent = await MicrosoftCalendarEvent.get(id)

  if (!oldEvent)
    throw Error.ResourceNotFound(`Microsoft Calendar Event ${id} not found.`)

  await deleteRemote(oldEvent, microsoftCalendar)

  return await MicrosoftCalendarEvent.get(oldEvent.id)
}



Orm.register('microsoft_calendar', 'MicrosoftCalendarEvent', MicrosoftCalendarEvent)

module.exports = MicrosoftCalendarEvent