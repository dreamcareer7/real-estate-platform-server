'use strict'

const async = require('async')
const db = require('../lib/utils/db')

const up = [
  'CREATE OR REPLACE FUNCTION wipe_everything() RETURNS VOID AS $$\
BEGIN\
    TRUNCATE TABLE messages_acks CASCADE;\
    TRUNCATE TABLE messages CASCADE;\
    TRUNCATE TABLE notifications_acks CASCADE;\
    TRUNCATE TABLE notifications CASCADE;\
    TRUNCATE TABLE recommendations_eav CASCADE;\
    TRUNCATE TABLE recommendations CASCADE;\
    TRUNCATE TABLE rooms_users CASCADE;\
    TRUNCATE TABLE rooms CASCADE;\
    TRUNCATE TABLE invitation_records CASCADE;\
    TRUNCATE TABLE alerts CASCADE;\
    TRUNCATE TABLE contacts CASCADE;\
    TRUNCATE TABLE notification_tokens CASCADE;\
    TRUNCATE TABLE password_recovery_records CASCADE;\
    TRUNCATE TABLE email_verifications CASCADE;\
    TRUNCATE TABLE phone_verifications CASCADE;\
    TRUNCATE TABLE attachments_eav CASCADE;\
    TRUNCATE TABLE attachments CASCADE;\
    TRUNCATE TABLE important_dates CASCADE;\
    TRUNCATE TABLE notes CASCADE;\
    TRUNCATE TABLE task_contacts CASCADE;\
    TRUNCATE TABLE tasks CASCADE;\
    TRUNCATE TABLE transaction_contact_roles CASCADE;\
    TRUNCATE TABLE transaction_contacts CASCADE;\
    TRUNCATE TABLE transactions CASCADE;\
END;\
$$ LANGUAGE plpgsql;'
]

const down = [
  'UNDO SOMETHING',
  'UNDO SOMETHING ELSE',
  'UNDO EVEN MORE'
]

const runAll = (sqls, next) => {
  db.conn((err, client) => {
    if (err)
      return next(err)

    async.eachSeries(sqls, client.query.bind(client), err => {
      client.release()
      next(err)
    })
  })
}

const run = (queries) => {
  return (next) => {
    runAll(queries, next)
  }
}

exports.up = run(up)
exports.down = run(down)
