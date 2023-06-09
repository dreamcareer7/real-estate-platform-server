const config    = require('../../../config')
const db        = require('../../../utils/db.js')
const promisify = require('../../../utils/promisify')
const redis     = require('../../../data-service/redis').createClient()
const UsersJob  = require('../../UsersJob/update')

const publisher = require('./publisher')

const zrangebyscore = promisify(redis.zrangebyscore.bind(redis))
const zrem          = promisify(redis.zrem.bind(redis))

const MAILBOX_DEBOUNCER_KEY = 'outlook_mailbox_debouncer'


const Outlook = {
  syncDue: async () => {
    const records = await db.select('users_job/microsoft/outlook_sync_due', [config.emails_integration.outlook.time_gap])

    for (const record of records) {

      const data = {
        action: 'sync_outlook',
        cid: record.microsoft_credential
      }

      Outlook.syncOutlook(data)
      await UsersJob.updateStatus(record.id, 'queued')
    }
  },

  parseNotifications: async () => {
    const until = Math.round(Date.now() / 1000)

    const records = await zrangebyscore(MAILBOX_DEBOUNCER_KEY, 0, until)

    if (records.length < 1) {
      return
    }

    for (const record of records) {

      const keyObj = JSON.parse(record)

      const payload = {
        subscriptionId: keyObj.sId,
        changeType: keyObj.cType,
        resourceData: {
          id: keyObj.rId,
        } 
      }

      Outlook.pushEvent({ payload })

      await zrem(MAILBOX_DEBOUNCER_KEY, record)
    }
  },

  syncByQuery: async () => {
    const ids = []

    const records = await db.select('users_job/microsoft/outlook_sync_by_query', [config.emails_integration.sync_by_query.time_gap])

    for (const userJob of records) {

      const data = {
        action: 'sync_outlook_by_query',
        ...userJob
      }

      Outlook.syncOutlookByQuery(data)

      ids.push(userJob.id)
    }

    return ids
  },

  syncOutlook: publisher.Outlook.syncOutlook,
  pushEvent: publisher.Outlook.pushEvent,
  syncOutlookByQuery: publisher.Outlook.syncOutlookByQuery
}

const Calendar = {
  syncDue: async () => {
    const records = await db.select('users_job/microsoft/mcal_sync_due', [config.calendar_integration.time_gap])

    for (const record of records) {

      const data = {
        action: 'sync_microsoft_calendar',
        cid: record.microsoft_credential
      }

      Calendar.syncCalendar(data)
      await UsersJob.updateStatus(record.id, 'queued')
    }
  },

  syncCalendar: publisher.Calendar.syncCalendar,
  pushEvent: publisher.Calendar.pushEvent
}

const Contacts = {
  syncDue: async () => {
    const records = await db.select('users_job/microsoft/mcontacts_sync_due', [config.contacts_integration.time_gap])

    for (const record of records) {

      const data = {
        action: 'sync_microsoft_contact',
        cid: record.microsoft_credential
      }

      Contacts.syncContacts(data)
      await UsersJob.updateStatus(record.id, 'queued')
    }
  },

  syncAvatars: async () => {
    const records = await db.select('users_job/microsoft/mcontacts_avatarts_sync_due', [config.contacts_integration.avatars_time_gap])

    for (const record of records) {

      const data = {
        action: 'sync_microsoft_contacts_avtars',
        cid: record.microsoft_credential
      }

      Contacts.syncContactsAvatars(data)
      await UsersJob.updateStatus(record.id, 'queued')
    }
  },

  syncContacts: publisher.Contacts.syncContacts,
  syncContactsAvatars: publisher.Contacts.syncContactsAvatars,
  pushEvent: publisher.Contacts.pushEvent
}

const Disconnect = {
  credential: publisher.Disconnect.credential
}


module.exports = {
  Outlook,
  Calendar,
  Contacts,
  Disconnect
}