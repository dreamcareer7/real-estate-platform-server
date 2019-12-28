const _ = require('lodash')
const sq = require('../../../utils/squel_extensions')

const db = require('../../../utils/db.js')
const validator = require('../../../utils/validator.js')
const belt = require('../../../utils/belt')

const { reminderSchema: schema } = require('./schemas.js')
const Notification = require('../../Notification')
const Orm = require('../../Orm')

const validate = validator.promise.bind(null, schema)

const Reminder = {
  /**
   * Get a reminder by id
   * @param {UUID} id Reminder id to fetch
   * @returns {Promise<IReminder>}
   */
  async get(id) {
    const reminders = await Reminder.getAll([id])

    if (!reminders || reminders.length < 1) {
      throw Error.ResourceNotFound(`Reminder ${id} not found`)
    }

    return reminders[0]
  },

  /**
   * Get multiple Reminders by id
   * @param {UUID[]} ids Array of Reminder ids to fetch
   * @returns {Promise<IReminder[]>}
   */
  async getAll(ids) {
    const res = await db.query.promise('crm/reminder/get', [
      ids,
    ])

    return res.rows
  },

  /**
   * Create a reminder
   * @param {IReminderInput} reminder Reminder object to add
   * @param {ITask} task Parent task of the Reminder
   * @return {Promise<UUID>}
   */
  async create(reminder, task) {
    await validate(reminder)

    const timestamp = belt.epochToDate(reminder.timestamp)

    return db.insert('crm/reminder/insert', [
      task.id,
      reminder.is_relative,
      timestamp.toISOString(),
      task.status !== 'DONE'
    ])
  },

  /**
   * Create multiple reminders in bulk
   * @param {IReminderInput[]} reminders 
   */
  async createMany(reminders) {
    if (reminders.length < 1) return []

    // task, is_relative, "timestamp", needs_notification
    const data = reminders.map(r => ({
      task: r.task,
      is_relative: r.is_relative,
      timestamp: belt.epochToDate(r.timestamp).toISOString(),
      needs_notification: r.needs_notification
    }))

    const LIBPQ_PARAMETER_LIMIT = 0xFFFF

    const result = await Promise.all(_(data)
      .chunk(Math.floor(LIBPQ_PARAMETER_LIMIT / Object.keys(data[0]).length))
      .map((chunk, i) => {
        const q = sq.insert({ autoQuoteFieldNames: true })
          .into('reminders')
          .setFieldsRows(chunk)
          .returning('id')

        // @ts-ignore
        q.name = `crm/reminder/create_many#${i}`

        return db.selectIds(q)
      })
      .value()
    )

    return result.flat()
  },

  /**
   * Remove a reminder
   * @param {UUID} reminder_id Reminder id to be removed
   * @return {Promise<any>}
   */
  async remove(reminder_id) {
    const reminder = await Reminder.get(reminder_id)

    const res = await db.query.promise('crm/reminder/delete', [
      reminder_id,
    ])

    if (reminder.notification)
      await Notification.remove(reminder.notification)

    return res
  },

  /**
   * Update a reminder
   * @param {IReminderInput} reminder Reminder object with id to be updated
   * @param {ITask} task Parent task data object of the reminder
   */
  async update(reminder, task) {
    await validate(reminder)

    const timestamp = belt.epochToDate(reminder.timestamp)

    return db.update('crm/reminder/update', [
      task.id,
      reminder.id,
      reminder.is_relative,
      timestamp.toISOString(),
      task.status !== 'DONE'
    ])
  }
}

Orm.register('reminder', 'Reminder', Reminder)

module.exports = Reminder
