const moment = require('moment-timezone')


const setTimezone = (ts, tz, type = null) => {
  const m = moment(ts * 1000)

  if ( type === 'birthday' ) {
    const currentYear = new Date().getFullYear()
    m.year(currentYear)
  }

  if (moment.tz.zone(tz)) {
    m.tz(tz)
  }

  return m.format()
}

const getAllDay = (event) => {
  let allDay = (event.object_type === 'crm_task') ? false : true

  if (event.full_crm_task && event.full_crm_task.metadata) {
    if ( event.full_crm_task.metadata.all_day !== null ) {
      allDay = Boolean(event.full_crm_task.metadata.all_day)
    }
  }

  return allDay
}

const getDates = (event, timeZone) => {
  if ( !event.end_date ) {
    event.end_date = event.timestamp
  }

  // if ( event.timestamp < event.end_date ) {
  //   event.timestamp = event.end_date
  // }

  let start_date = event.timestamp
  let end_date   = event.end_date

  start_date = setTimezone(start_date, timeZone, event.event_type)
  end_date   = setTimezone(end_date, timeZone, event.event_type)

  const start = {
    date: start_date.slice(0,10),
    timeZone: timeZone
  }

  const end = {
    date: end_date.slice(0,10),
    timeZone: timeZone
  }

  const allDay = getAllDay(event)

  if (!allDay) {
    start.dateTime = start_date
    end.dateTime   = end_date
  }

  const recurrence = event.recurring ? ['RRULE:FREQ=YEARLY;COUNT=25'] : []

  return {
    recurrence,
    allDay,
    start,
    end
  }
}

const getAttendees = (primaryEmail, event) => {
  let attendees = []

  if (event.full_crm_task && event.full_crm_task.associations) {
    attendees = event.full_crm_task.associations
      .filter(a => a.contact)
      .filter(a => {
        const email = a.contact.primary_email || a.contact.email
        if ( email !== primaryEmail ) {
          return true
        }
      })
      .map(a => {
        const email = a.contact.primary_email || a.contact.email
        const displayName = a.contact.display_name

        return { email, displayName }
      })
  }

  attendees = attendees.slice(0, 100)

  return attendees
}

const getReminders = (event) => {
  let overrides = []

  if (event.full_crm_task && event.full_crm_task.reminders) {
    overrides = event.full_crm_task.reminders.map(r => ({
      method: 'email',
      minutes: Math.round((event.timestamp - r.timestamp) / 60)
    }))
  }

  const reminders = {
    useDefault: ( overrides.length > 0 ) ? false : true,
    overrides
  }

  return reminders
}

const getSendUpdates = (event,isInitialSync) => {
  return ( event.full_crm_task && event.full_crm_task.metadata && !isInitialSync ) ? (event.full_crm_task.metadata.send_updates ? 'all' : 'none') : 'none'
}

const generateGoogleCalendarEvent = (credential, event, timeZone, isInitialSync) => {
  const { recurrence, allDay, start, end } = getDates(event, timeZone)
  const attendees   = getAttendees(credential.email, event)
  const reminders   = getReminders(event)
  const sendUpdates = getSendUpdates(event, isInitialSync)

  return {
    summary: (event.object_type === 'deal_context') ? `${event.type_label} for ${event.title}` : event.title,
    description: event.full_crm_task ? event.full_crm_task.description : '',
    status: 'confirmed',
  
    allDay,
    start,
    end,
  
    attendees,
    reminders,
    recurrence,
  
    sendUpdates,

    extendedProperties: {
      shared: {
        origin: 'rechat',
        object_type: event.object_type,
        event_type: event.event_type,
        rechat_cal_event_id: event.id,
        rechat_cal_orginal_id: event.orginal_id || event.id
      }
    }
  }
}

const pruneStartEnd = (event) => {
  if (event.resource.allDay) {
    delete event.resource.start.dateTime
    delete event.resource.end.dateTime
  } else {
    delete event.resource.start.date
    delete event.resource.end.date
  }

  delete event.resource.allDay

  return event
}


module.exports = {
  generateGoogleCalendarEvent,
  pruneStartEnd
}