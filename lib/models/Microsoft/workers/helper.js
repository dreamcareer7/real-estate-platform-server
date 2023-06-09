const config  = require('../../../config')
const Context = require('../../Context')
const Slack   = require('../../Slack')

// const { deleteByMicrosoftCredential } = require('../../UsersJob/microsoft')
const { updateStatus, postpone }      = require('../../UsersJob/update')
const { deleteById }                  = require('../../UsersJob/delete')
const { removeContactSyncToken }      = require('../credential')

const { lock } = require('../../UsersJob/lock')

const { getMGraphClient } = require('../plugin/client.js')
// const { disconnect }      = require('../credential/update')

const fiveXErr = [500, 501, 502, 503, 504]
const channel  = config.microsoft_integration.slack_channel

/**
 * Tries to parse where the `err` has been thrown. Prefers an *absolute* file
 * path that does not contain 'node_modules'.
 * @param {Error} err
 * @returns {string | null | undefined}
 */
function parseCause (err) {
  const [, ...lines] = String(err?.stack || '').split('\n')
  let primaryCause = null

  for (const line of lines) {
    const cause = line.match(/\(([^)]*)\)$/)?.[1]

    if (cause?.startsWith('/') && !cause.includes('node_modules')) {
      return cause
    }
    primaryCause || (primaryCause = cause)
  }

  return primaryCause
}

async function sendSlackMsg (userJob, description, ex) {
  const code  = Number(ex.statusCode)
  const emoji = ':skull:'

  let text = `${description} - CID: ${userJob.microsoft_credential} - Code: ${code}`

  if (!fiveXErr.includes(code)) {
    text += ` - Ex.Msg: ${ex.message}`
  }

  const cause = parseCause(ex)
  if (cause) { text += ` - at ${cause}` }

  if ( code === 410 ) {
    /*
      This is a same error:
      https://stackoverflow.com/questions/53742769/410-gone-error-in-msgraph-delta-api-for-onedrive

      So, we need to reset the state of this very failing job.
      Base on the slack message ang logs, we can find out which job(contacts/calendars) is failing.

      Lets assume it is contatcs, here is the required steps to be done:
      UPDATE microsoft_credentials SET cfolders_sync_token = null, contacts_sync_token = null WHERE id = '<cid>';
      UPDATE microsoft_contact_folders SET sync_token = null WHERE microsoft_credential = '<cid>';
      UPDATE users_jobs SET start_at = null, deleted_at = null, status = 'waiting', resume_at = null WHERE job_name = 'contacts' AND microsoft_credential = '<cid>';
    */
    await removeContactSyncToken(userJob.microsoft_credential)
    Slack.send({ channel, text: `A new 410 error has been caught and recovered - CID: ${userJob.microsoft_credential}`, emoji })
  }

  if ( code !== 503 ) {
    Slack.send({ channel, text, emoji })
  }
}

const lockJob = async (userJob) => {
  await lock(userJob.id)
  await updateStatus(userJob.id, 'pending')
}

const reportFailure = async (credential, error) => {
  const emoji = ':skull:'
  const text  = `SyncMicrosoftCalendar - Job Finished With Failure ${credential.id} - ${credential.email} - ${error}`

  Slack.send({ channel, text, emoji })
}

const postponeJob = async (userJob, ex) => {
  Context.log('Postpone-Microsoft-Job', userJob.microsoft_credential, userJob.job_name, ex.statusCode, ex.message, ex)

  let interval = '5 minutes'

  if ( ex.statusCode === 429 ) {
    interval = '60 minutes'
  }

  if ( fiveXErr.includes(Number(ex.statusCode)) || ex.message === 'Error: read ECONNRESET' ) {
    interval = '10 minutes'
  }

  if ( (ex.statusCode === 404) && (ex.code === 'ResourceNotFound') ) {
    interval = '120 minutes'
  }

  await postpone(userJob.id, interval)
}

const handleException = async (userJob, description, ex) => {
  /*
    I know the whole structure here is stupid, but we have to fix it for now asap.
    And also it provides some space for future refactoring.
    We need to implement a new generic solution to handle Microsoft exceptions.

    Microsoft Graph returns errors in different styles, and we didn't know that,
    So it became a bit difficult to design an exception handler module to cover
    all possible scenarios and error messages.

    This logic is now working well, but that would be better if we somehow gather all
    different Microsoft-Graph errors and implement a solid module to parse error body
    in a well organized structure.
  */

  const req = ex.options
  delete ex.options

  if (req) {
    Context.log(`HTTP ${ex.statusCode} ${req.method} ${req.url}`)
  }
  Context.log('HandleException', userJob.microsoft_credential, userJob.job_name, description, ' - Ex:', ex)

  let unknownError       = false
  let is_503_error       = false
  let timeoutError       = false
  let invalidGrant       = false
  let permanentError     = false
  let permanentError400  = false
  let quotaExceededError = false
  let badMailBoxError    = false // The mailbox is either inactive, soft-deleted, or is hosted on-premise
  let resourceNotFound   = false
  let mailboxNotEnabledForRESTAPI = false

  if ( ex.code === 'UnknownError' ) {
    unknownError = true
  }

  if ( ex.code === 'UnknownError' ) {
    is_503_error = true
  }

  if ( (ex.statusCode === 503) && (ex.code === '') ) {
    is_503_error = true
  }

  if ( (ex.code === 'ESOCKETTIMEDOUT') || (ex.message === 'Error: ESOCKETTIMEDOUT') ) {
    timeoutError = true
  }

  if ( (ex.statusCode === -1) && (ex.code === 'FetchError') ) {
    timeoutError = true
  }

  if ( (ex.statusCode === 401) || (ex.message === 'invalid_grant') ) {
    invalidGrant = true
  }

  if ( ex.statusCode === 400 ) {
    if ( ex.code === 'ExtensionError' ) {
      permanentError400 = true
    }
  }

  if ( ex.statusCode === 403 ) {

    if ( ex.code === 'ExtensionError' ) {
      try {
        // Posibility of not having <ex.body> convertable to a json object
        const pattern = /The operation failed with a permanent mailbox error.Error Details: QuotaExceededException/
        if (pattern.test(JSON.parse(ex.body).message)) {

          /*
            Unfortunately there is no proper explanation regarding this exception on the net,
            So, We have to stop this job to debug it manually.
            There is only one explanation for this case: <mailbox becomes full>

            check the below links for more details.
            https://docs.microsoft.com/en-us/exchange/troubleshoot/send-emails/smtp-submission-improvements
            https://docs.microsoft.com/en-us/exchange/troubleshoot/email-delivery/mapiexceptionnotfound-ndr

          */

          permanentError = true
        }
      } catch (extensionErrorEx) {
        Context.log('HandleException-failed - New case on ExtensionError has been found!', userJob.id, description, extensionErrorEx)
      }

    } else if ( ex.error ) {

      // Posibility of not having <ex.error> convertable to a json object
      try {
        // Sample: '{"error":{"code":"ErrorQuotaExceeded","message":"Cannot save changes made to an item to store."}}'
        const errorObj = JSON.parse(ex.error)
        if (errorObj?.error?.code === 'ErrorQuotaExceeded') {
          quotaExceededError = true
        }
      } catch (quotaExceededEx) {
        Context.log('HandleException-failed - New case on ErrorQuotaExceeded has been found!', userJob.id, description, quotaExceededEx)
      }
    }
  }

  if ( (ex.statusCode === 404) && (ex.code === 'ExtensionError') ) {
    try {
      // Posibility of not having <ex.body> convertable to a json object
      const pattern = /The mailbox is either inactive, soft-deleted, or is hosted on-premise/
      if (pattern.test(JSON.parse(ex.body).message)) {
        badMailBoxError = true
      }
    } catch (badMailBoxErrorEx) {
      Context.log('HandleException-failed - New case on (MailBox is inactive, soft-deleted, or is hosted on-premise) has been found!', userJob.id, description, badMailBoxErrorEx)
    }
  }

  if ( ((ex.statusCode === 404) || (ex.code === 404)) && ex.error ) {
    try {

      Context.log('HandleException-failed-MailboxNotEnabledForRESTAPI - ex.error:', ex.error)
      Context.log('HandleException-failed-MailboxNotEnabledForRESTAPI - ex.body:', ex.body)
      Context.log('HandleException-failed-MailboxNotEnabledForRESTAPI - ex.message:', ex.message)
      Context.log('HandleException-failed-MailboxNotEnabledForRESTAPI - ex:', ex)

      // Posibility of not having <ex.body> convertable to a json object
      const errorObj = JSON.parse(ex.error)
      if (errorObj?.error?.code === 'MailboxNotEnabledForRESTAPI') {
        mailboxNotEnabledForRESTAPI = true
        /*
          mailbox is either inactive, soft-deleted, or is hosted on-premise
        */
      }
    } catch (mailboxNotEnabledEx) {
      Context.log('HandleException-failed - New case on MailboxNotEnabledForRESTAPI has been found!', userJob.id, description, mailboxNotEnabledEx)
    }
  }

  if ( (ex.statusCode === 404) && (ex.code === 'ResourceNotFound') ) {
    // I need to investigate more on this
    // JSON.parse(ex.body).message = Resource could not be discovered.
    resourceNotFound = true
  }

  if (ex.response) {
    if (ex.response.body) {

      /*
        This try-catch is a temporary hack to debug the below error:
          Unexpected token < in JSON at position 0
          at handleException (/app/lib/models/Microsoft/workers/helper.js:69:25)

        Tip: Lines inside the try block should remain as part of code after fixing the problem.
      */
      try {
        const body = JSON.parse(ex.response.body)
        if ( body.error === 'invalid_grant' ) {
          invalidGrant = true
        }
      } catch (ex) {
        Context.log('HandleException-failed', userJob.id, description, ex)
        throw ex
      }
    }
  }

  if (!timeoutError && !unknownError && !is_503_error) {
    sendSlackMsg(userJob, description, ex)
  }

  if (invalidGrant) {
    // await disconnect(userJob.microsoft_credential)
    // await deleteByMicrosoftCredential(userJob.microsoft_credential)

  } else {
    await updateStatus(userJob.id, 'failed')

    if (permanentError) {
      sendSlackMsg(userJob, 'The operation failed with a permanent error - QuotaExceededException', ex)
      await deleteById(userJob.id)

    } else if (permanentError400) {
      // The mailbox is located on premises and the Exchange server does not support federated Microsoft Graph requests,
      // or an application policy prevents the application from accessing the mailbox.
      sendSlackMsg(userJob, 'The operation failed with a permanent error - ExtensionError', ex)
      await deleteById(userJob.id)

    } else if (mailboxNotEnabledForRESTAPI) {
      sendSlackMsg(userJob, 'The operation failed with a permanent error - MailboxNotEnabledForRESTAPI', ex)
      await deleteById(userJob.id)

    } else if (badMailBoxError) {
      sendSlackMsg(userJob, 'The operation failed with a permanent error - BadMailBoxError', ex)
      await deleteById(userJob.id)

    } else if (quotaExceededError) {
      sendSlackMsg(userJob, 'The operation failed with a permanent error - ErrorQuotaExceeded', ex)
      await deleteById(userJob.id)

    } else if (resourceNotFound) {
      await postponeJob(userJob, ex)

    } else {
      await postponeJob(userJob, ex)
    }
  }
}

const microsoftClient = async (credential, userJob) => {
  const { microsoft } = await getMGraphClient(credential)

  if (!microsoft) {
    Slack.send({ channel, text: `Initiate Microsoft Client Failed - ${credential.id}`, emoji: ':skull:' })
    await updateStatus(userJob.id, 'failed')

    return false
  }

  return microsoft
}


module.exports = {
  lockJob,
  reportFailure,
  postpone,
  handleException,
  microsoftClient
}


/*
  GraphError: {
    statusCode: 500,
    code: 'ExtensionError',
    message: 'Operation: Read; Exception: [A device attached to the system is not functioning]',
    requestId: '79739241-2321-42bf-9465-f9923431d93e',
    date: 2020-11-20T14:10:24.000Z,
    body: '{"code":"ExtensionError","message":"Operation: Read; Exception: [A device attached to the system is not functioning.\\r\\n]","innerError":{"date":"2020-11-20T14:10:24","request-id":"79739241-2321-42bf-9465-f9923431d93e","client-request-id":"aee8f031-0baa-16e0-edf8-82b13e1d8106"}}'
  }
*/
