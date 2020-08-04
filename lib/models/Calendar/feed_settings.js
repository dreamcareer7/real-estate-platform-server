const db = require('../../utils/db.js')

const Orm = require('../Orm/registry')

class CalendarFeedSetting {
  /**
   * Creates a calendar feed setting record
   * @param {UUID} user_id 
   * @param {ICalendarFeedSettingInput} data 
   */
  static async create(user_id, data) {
    return db.query.promise('calendar/create_feed_setting', [user_id, data.types, data.filter])
  }

  /**
   * Fetches the single calendar feed setting record for user id
   * @param {UUID} user_id 
   * @returns {Promise<ICalendarFeedSetting | undefined>}
   */
  static async get(user_id) {
    return db.selectOne('calendar/get_feed_setting', [user_id])
  }
}

Orm.register('calendar_feed_setting', 'CalendarFeedSetting', CalendarFeedSetting)

module.exports = CalendarFeedSetting
