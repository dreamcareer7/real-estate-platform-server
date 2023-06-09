const db = require('../utils/db')
const squel     = require('@rechat/squel').useFlavour('postgres')
const promisify = require('util').promisify


class NotificationSettingHelper {
  /**
   * @param  {string} tableName, indicates table name that data should be fetched from
   * @param  {string} typeName, indicates the type name which normally is table name without last 's' letter
   * @param  {string} columnName, indicates the name of columns that we store on the table
   */
  constructor(tableName, typeName, columnName, allowedValues) {
    this.tableName = tableName
    this.typeName = typeName
    this.columnName = columnName
    this.allowedValues = allowedValues
  }

  async getAll(ids) {
    const q = squel.select()
      .field('id')
      .field('status')
      .field(`'${this.typeName}' as type`)
      .from(this.tableName)
      .where('id in ?', ids)
    const res = await promisify(db.executeSql)(q.toString(), [])
    return res.rows
  }

  async update(userID, typeID, status) {
    this.validate(status)
    const q = `INSERT INTO ${this.tableName}(status, "user", ${this.columnName})
    VALUES($1, $2, $3)
    ON CONFLICT ("user", ${this.columnName}) DO
    UPDATE SET 
    status = $1
    WHERE ${this.tableName}."user" = $2 AND
    ${this.tableName}.${this.columnName} = $3
    `
    const res = await promisify(db.executeSql)(q, [status, userID, typeID])
    return res.rows
  }

  validate(status) {
    if (!Array.isArray(status)) {
      throw new Error('Status should be of type array')
    }

    for (const s of status) {
      if (!this.allowedValues.includes(s)) {
        throw new Error(`Value ${s} is not allowed for status`)
      }
    }
  }

  async filterUsersWithStatus(userIDs, typeIDs, status) {
    const q = `
      SELECT DISTINCT * FROM(
        SELECT "user" AS id, status from ${this.tableName}
        WHERE "user" = ANY($1) AND
        ${this.columnName} = ANY($2) AND
        status && $3
      ) as sq
    `

    const res = await promisify(db.executeSql)(q, [userIDs, typeIDs, status])
    return res.rows
  }

  async getUsersWithStatus(typeIDs, status) {
    const q = `
      SELECT "user" AS id, status from ${this.tableName}
      WHERE ${this.columnName} = ANY($1) AND
      status && $2
    `
    const res = await promisify(db.executeSql)(q, [typeIDs, status])
    return res.rows
  }
}

module.exports = NotificationSettingHelper
