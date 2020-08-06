const db = require('../../../utils/db.js')


/**
 * @param {UUID[]} ids
 */
const getAll = async (ids) => {
  return await db.select('microsoft/calendar_events/get', [ids])
}

/**
 * @param {UUID} id
 */
const get = async (id) => {
  const calendars = await getAll([id])

  if (calendars.length < 1)
    throw Error.ResourceNotFound(`Microsoft calendar event by ${id} not found.`)

  return calendars[0]
}

/**
 * @param {Object} calendar MicrosoftCalendar
 * @param {string[]} events_remote_ids MicrosoftCalendarEvent remote-id
 */
const getByCalendarAndEventRemoteIds = async (calendar, events_remote_ids) => {
  const ids = await db.selectIds('microsoft/calendar_events/get_by_calendar_and_event_ids', [calendar.microsoft_credential, calendar.id, events_remote_ids])

  return await getAll(ids)
}

/**
 * @param {UUID} mcid Microsoft credential id
 * @param {UUID[]} calendar_ids Microsoft calendar ids
 */
const getByCalendarIds = async (mcid, calendar_ids) => {
  return await db.selectIds('microsoft/calendar_events/get_by_calendar_ids', [mcid, calendar_ids])
}


module.exports = {
  getAll,
  get,
  getByCalendarAndEventRemoteIds,
  getByCalendarIds
}