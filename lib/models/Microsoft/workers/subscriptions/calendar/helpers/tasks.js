const _ = require('lodash')

const Orm     = require('../../../../../Orm')
const Context = require('../../../../../Context')
const User    = require('../../../../../User')
const CrmTask = require('../../../../../CRM/Task/index')
const CalendarIntegration = require('../../../../../CalendarIntegration')


const retrieveTasks = async function (credential, taskIds) {
  const associations = ['crm_task.associations', 'crm_task.assignees', 'crm_task.reminders', 'crm_association.contact']

  // Find old crm_tasks
  const user = await User.get(credential.user)
  Context.set({ user })
  Orm.setEnabledAssociations(associations)

  const models = await CrmTask.getAll(taskIds)
  const tasks  = await Orm.populate({ models, associations })

  return tasks
}

const getTasksByMicrosoftID = async function (credential, microsoft_event_ids) {
  const records = await CalendarIntegration.getByMicrosoftIds(microsoft_event_ids)

  const taskIds   = records.map(record => record.crm_task)
  const byCrmTask = _.keyBy(records, 'crm_task')

  const tasks = await retrieveTasks(credential, taskIds)

  const refinedTasks = tasks.map(task => {
    return {
      ...task,
      microsoft_event_id: byCrmTask[task.id].microsoft_id
    }
  })

  return _.keyBy(refinedTasks, 'microsoft_event_id')
}


module.exports = {
  retrieveTasks,
  getTasksByMicrosoftID
}