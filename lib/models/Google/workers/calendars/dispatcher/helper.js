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
  // const all_day = event.all_day !== null ? event.all_day : event.resource.allDay

  if ( event.all_day !== null ) {
    return event.all_day
  }

  // fallback for crm_task and old events
  let allDay = (event.object_type === 'crm_task') ? false : true

  if (event.full_crm_task && event.full_crm_task.metadata) {
    if ( event.full_crm_task.all_day !== null ) {
      allDay = Boolean(event.full_crm_task.all_day)
    }
  }

  return allDay
}

const getDates = (event, timeZone) => {
  const allDay = getAllDay(event)

  if ( !event.end_date ) {
    event.end_date = event.timestamp
  }

  let start_date = event.timestamp
  let end_date   = event.end_date

  if ( allDay || event.object_type === 'contact_attribute' ) {
    start_date = new Date(event.timestamp * 1000).toISOString()
    end_date   = new Date(event.end_date * 1000).toISOString()
  } else {
    start_date = setTimezone(start_date, timeZone, event.event_type)
    end_date   = setTimezone(end_date, timeZone, event.event_type)
  }

  const start = {
    date: start_date.slice(0,10),
    dateTime: start_date,
    timeZone
  }

  const end = {
    date: end_date.slice(0,10),
    dateTime: end_date,
    timeZone
  }

  if (allDay) {
    delete start.dateTime
    delete end.dateTime
  } else {
    delete start.date
    delete end.date
  }

  const recurrence = event.recurring ? ['RRULE:FREQ=YEARLY;COUNT=25'] : []

  return {
    recurrence,
    allDay,
    start,
    end
  }
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

const getSendUpdates = (event, isInitialSync) => {
  return ( event.full_crm_task && event.full_crm_task.metadata && !isInitialSync ) ? (event.full_crm_task.metadata.send_updates ? 'all' : 'none') : 'none'
}

const getAttendees = (primaryEmail, event, sendUpdates) => {
  let associations = []
  let originalGuests = []
  let associationEmails = []

  if (event?.full_crm_task?.associations) {
    associations = event.full_crm_task.associations
      .filter(a => a.contact)
      .filter(a => {
        const email = a.contact.primary_email || a.contact.email
        if ( email && email !== primaryEmail ) {
          return true
        }
      })
  }

  if (event?.integrations[0]?.googleCalEvent?.attendees) {
    originalGuests = [...new Set(
      event.integrations[0].googleCalEvent.attendees
        .filter(a => a.email && !a.self && !a.organizer)
        .map(a => a.email)
    )]
  }

  if (event?.full_crm_task?.associations) {
    associationEmails = [...new Set(
      associations.map(a => a.contact.primary_email || a.contact.email)
    )]
  }


  if ( (sendUpdates === 'none') && (associationEmails.length > originalGuests.length) ) {
    const attendees = associations
      .filter(a => {
        const email = a.contact.primary_email || a.contact.email
        if ( originalGuests.includes(email) ) {
          return true
        }
      })
      .map(a => {
        const email = a.contact.primary_email || a.contact.email
        const displayName = a.contact.display_name
        
        return { email, displayName }
      })

    return attendees.slice(0, 99)
  }


  const attendees = associations.map(a => {
    const email = a.contact.primary_email || a.contact.email
    const displayName = a.contact.display_name
    
    return { email, displayName }
  })

  return attendees.slice(0, 99)
}

const generateGoogleCalendarEvent = (credential, event, timeZone, isInitialSync) => {
  const { recurrence, allDay, start, end } = getDates(event, timeZone)
  const sendUpdates = getSendUpdates(event, isInitialSync)
  const attendees   = getAttendees(credential.email, event, sendUpdates)
  const reminders   = getReminders(event)

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
  
    // Whether to send notifications about the creation of the new event. Note that some emails might still be sent.
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


module.exports = {
  generateGoogleCalendarEvent
}