const _ = require('lodash')

const { peanar } = require('../../../../utils/peanar')

const promisify = require('../../../../utils/promisify')
const Notification = require('../../../Notification')
const Context = require('../../../Context')

const CrmTask = require('../index')

async function send_notification_to_task_assignees({ created_by, assignees }) {
  const task_ids = assignees.map(a => a.crm_task)
  const tasks = await CrmTask.getAll(task_ids)
  const tasks_by_id = _.keyBy(tasks, 'id')

  for (const assignee of assignees) {
    /** @type {INotificationInput} */
    const n = {
      action: 'Assigned',
      subject: created_by,
      subject_class: 'User',
      object: assignee.crm_task,
      object_class: 'CrmTask',
      title: tasks_by_id[assignee.crm_task].title,
      message: '',
      data: {
        assignees: assignee.users
      }
    }

    Context.log('>>> (CrmTask::Assignee::create)', 'Creating UserAssignedCrmTask notification on task', assignee.crm_task)
    await promisify(Notification.issueForUsersExcept)(n, assignee.users, created_by, {})
  }
}

module.exports = {
  send_notification_to_task_assignees: peanar.job({
    handler: send_notification_to_task_assignees,
    name: 'send_notification_to_task_assignees',
    queue: 'crm_tasks',
    exchange: 'crm_tasks'
  })
}
