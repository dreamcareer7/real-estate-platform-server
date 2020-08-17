const MicrosoftWorker = require('../../../lib/models/Microsoft/workers')
const { poll } = require('../poll')
require('./entrypoint')

poll({
  fn: MicrosoftWorker.Calendar.syncDue,
  name: 'MicrosoftWorker.calendar.syncDue',
  wait: 60000
})

poll({
  fn: MicrosoftWorker.Contacts.syncDue,
  name: 'MicrosoftWorker.contacts.syncDue',
  wait: 60000
})

poll({
  fn: MicrosoftWorker.Outlook.parseNotifications,
  name: 'MicrosoftWorker.Outlook.parseNotifications',
  wait: 5000
})

poll({
  fn: MicrosoftWorker.Outlook.syncDue,
  name: 'MicrosoftWorker.outlook.syncDue',
  wait: 60000
})