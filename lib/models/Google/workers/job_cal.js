const Slack    = require('../../Slack')
const Context  = require('../../Context')
const Socket   = require('../../Socket')
const UsersJob = require('../../UsersJob/google')

const { getEvents, retrieveEvents } = require('../../Calendar/feed')
const { getGoogleClient } = require('../plugin/client.js')
const { handleException } = require('./helper')

const GoogleCredential = {
  ...require('../credential/get')
}

const calendarWorker       = require('./calendars/calendar')
const calendarEventsWorker = require('./calendars/events')
const { refineEvents, handleCreatedEvents, handleUpdatedEvents, handleDeletedEvents } = require('./calendars/dispatcher')

const JOB_NAME = 'calendar'



const reportFailure = async (credential, error) => {
  const emoji = ':skull:'
  const text  = `SyncGoogleCalendar - Job Finished With Failure ${credential.id} - ${credential.email} - ${error}`

  Slack.send({ channel: 'integration_logs', text, emoji })

  await UsersJob.upsertByGoogleCredential(credential, JOB_NAME, 'failed')
}

const syncGoogleToRechat = async (google, credential) => {
  const calendarResult = await calendarWorker.updateCalendarsWatcher(credential)
  if ( !calendarResult.status ) {
    const message = 'Job Error - SyncGoogleCalendar Failed [Google To Rechat - calendars]'
    await handleException(credential, JOB_NAME, message, calendarResult.ex)

    return {
      error: `${message} - ${calendarResult.ex.message}`,
      status: false,
      upserteIds: [],
      deletedIds: []
    }
  }

  if ( calendarResult.status ) {
    if ( calendarResult.ex === 'rechat-primary-cal-is-deleted' ) {
      const message = 'Job Error - SyncGoogleCalendar Stopped [Google To Rechat - calendars]'
      return {
        error: `${message} - ${calendarResult.ex}`,
        status: false,
        upserteIds: [],
        deletedIds: []
      }
    }
  }

  Context.log('SyncGoogleCalendar - CalendarResult')


  const calendarEventsResult = await calendarEventsWorker.syncCalendarEvents(google, credential)

  const upserteIds = calendarEventsResult.upserteIds
  const deletedIds = calendarEventsResult.deletedIds

  if ( !calendarEventsResult.status ) {
    const message = 'Job Error - SyncGoogleCalendar Failed [Google To Rechat - events]'
    await handleException(credential, JOB_NAME, message, calendarEventsResult.ex)

    return {
      error: `${message} - ${calendarEventsResult.ex.message}`,
      status: false,
      upserteIds,
      deletedIds
    }
  }

  Context.log('SyncGoogleCalendar - CalendarEventsResult')


  return {
    error: null,
    status: true,
    upserteIds,
    deletedIds
  }
}

const syncRechatToGoogle = async (credential, userJob, query) => {
  const { user, calEvents } = await getEvents(credential, query)

  const firstEvent = calEvents[calEvents.length - 1] || null

  let error = null

  if ( calEvents.length === 0 ) {
    return {
      error,
      firstEvent
    }
  }

  const isInitialSync = userJob.start_at ? false : true

  const { created, updated, deleted } = await refineEvents(credential, calEvents, user.timezone, isInitialSync)

  // printLogs(calEvents, created, updated, deleted)

  if ( !error && created.length !== 0 ) {
    const result = await handleCreatedEvents(credential, created)

    error = result.error
  }

  if ( !error && updated.length !== 0 ) {
    const result = await handleUpdatedEvents(credential, updated)

    error = result.error
  }

  if ( !error && deleted.length !== 0 ) {
    await handleDeletedEvents(credential, deleted)
  }

  return {
    error,
    firstEvent
  }
}

const syncCalendar = async (data) => {
  const credential = await GoogleCredential.get(data.cid)
  if ( credential.revoked || credential.deleted_at ) {
    await UsersJob.deleteByGoogleCredential(credential.id)
    return
  }

  if ( !credential.google_calendar ) {
    // await UsersJob.upsertByGoogleCredential(credential, JOB_NAME, 'canceled')
    await UsersJob.deleteByGoogleCredentialAndJob(credential.id, JOB_NAME)
    return
  }

  // check to know if there is a pending job or not
  const userJob = await UsersJob.checkLockByGoogleCredential(credential.id, JOB_NAME)
  if (!userJob) {
    // Context.log('SyncGoogleCalendar - Job skipped due to a pending job')
    return
  }

  if (userJob.resume_at) {
    if ( new Date(userJob.resume_at).getTime() >= new Date().getTime() ) {
      Context.log('SyncGoogleCalendar - Job skipped due to the paused job', credential.id)
      return
    }
  }

  /*
    check to know if current credential/job has already done ove the specific time period.
    *** Its disabled Because of supporting the real time sync.

    const diff = new Date().getTime() - new Date(userJob.start_at).getTime()
    if ( diff < config.calendar_integration.miliSec ) {
      return
    }
  */

  /*
    Lock users_jobs record

    select * from users_jobs where google_credential = credential.id AND job_name = JOB_NAME FOR UPDATE;
    ==> lock will be released after commiting or rollbacking current transaction
  */
  await UsersJob.lockByGoogleCredential(credential.id, JOB_NAME)
  await UsersJob.upsertByGoogleCredential(credential, JOB_NAME, 'pending')

  const google = await getGoogleClient(credential)
  if (!google) {
    Slack.send({ channel: 'integration_logs', text: `SyncGoogleCalendar Job Is Skipped, Client Is Failed - ${credential.id}`, emoji: ':skull:' })
    await UsersJob.upsertByGoogleCredential(credential, JOB_NAME, 'failed')
    return
  }


  Context.log('SyncGoogleCalendar - Job Started', credential.id, credential.email)

  const last_start_at   = userJob.start_at ? new Date(userJob.start_at) : new Date(0)
  const last_updated_gt = last_start_at.getTime() / 1000


  let result = {}

  Context.log('SyncGoogleCalendar - [Google To Rechat]')
  result = await syncGoogleToRechat(google, credential)
  if (result.error) {
    await reportFailure(credential, result.error)
    return
  }
  Context.log('SyncGoogleCalendar - [Google To Rechat] Done')

  const upsertedTaskIds = result.upserteIds
  const deletedTaskIds  = result.deletedIds


  Context.log('SyncGoogleCalendar - [Rechat To Google]')
  result = await syncRechatToGoogle(credential, userJob, { last_updated_gt })
  if (result.error) {
    await reportFailure(credential, result.error)
    return
  }
  Context.log('SyncGoogleCalendar - [Rechat To Google] Done')


  // Report success
  await UsersJob.upsertByGoogleCredential(credential, JOB_NAME, 'success')

  if ( upsertedTaskIds.length || deletedTaskIds.length ) {
    const upserted = await retrieveEvents(credential, upsertedTaskIds)
    Socket.send('Calendar.Updated', credential.brand, [{ upserted, deleted: deletedTaskIds }])
  }

  Context.log('SyncGoogleCalendar - Job Finished')
}


module.exports = {
  syncCalendar
}