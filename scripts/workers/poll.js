const promisify = require('../../lib/utils/promisify')
const createContext = require('./create-context')
const Slack = require('../../lib/models/Slack')

const Notification = require('../../lib/models/Notification')
const CrmTaskWorker = require('../../lib/models/CRM/Task/worker/notification')
const CalendarWorker = require('../../lib/models/Calendar/worker/notification')
const EmailCampaign = require('../../lib/models/Email/campaign')
const ShowingsCredential = require('../../lib/models/Showings/credential')
const GoogleWorker = require('../../lib/models/Google/workers')
const MicrosoftWorker = require('../../lib/models/Microsoft/workers')
const Task = require('../../lib/models/Task')


let i = 1

const poll = async ({fn, name}) => {
  const id = `${name}-${++i}`

  const { commit, rollback } = await createContext({
    id
  })

  try {
    await fn()
  } catch(err) {
    Slack.send({
      channel: '7-server-errors',
      text: `Notifications worker: '${err}'`,
      emoji: ':skull:'
    })

    rollback(err)
    return
  }


  await commit()

  const again = async () => {
    poll({
      fn,
      name
    })
  }

  setTimeout(again, 5000)
}

const notifications = async () => {
  /*
   * These two need to run in this specific order.
   * Otherwise, we might send email messages before push notifications.
   */
  await Notification.sendForUnread()
  await promisify(Message.sendEmailForUnread)
}

// poll({
//   fn: notifications,
//   name: 'notifications'
// })

// poll({
//   fn: CrmTaskWorker.sendNotifications.bind(CrmTaskWorker),
//   name: 'CrmTaskWorker.sendNotifications'
// })

// poll({
//   fn: CalendarWorker.sendEmailForUnread.bind(CalendarWorker),
//   name: 'CalendarWorker.sendEmailForUnread'
// })

// poll({
//   fn: Task.sendNotifications,
//   name: 'Task.sendNotifications'
// })

// poll({
//   fn: EmailCampaign.sendDue,
//   name: 'EmailCampaign.sendDue'
// })

// poll({
//   fn: EmailCampaign.updateStats,
//   name: 'EmailCampaign.updateStats'
// })

// poll({
//   fn: ShowingsCredential.crawlerJob,
//   name: 'ShowingsCredential.crawlerJob'
// })

// poll({
//   fn: GoogleWorker.syncDue,
//   name: 'GoogleWorker.syncDue'
// })

poll({
  fn: MicrosoftWorker.syncDue,
  name: 'MicrosoftWorker.syncDue'
})
