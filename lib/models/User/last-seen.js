const db = require('../../utils/db.js')
const { peanar } = require('../../utils/peanar')

const handler = function({ user_id, client_id, time }) {
  return db.query.promise('user/seen', [user_id, client_id, time])
}

const markAsSeen = peanar.job({
  handler,
  name: 'users_last_seen',
  queue: 'users_last_seen',
  exchange: 'userss_last_seen',
  max_retries: 50,
  retry_exchange: 'users_last_seen.retry',
  error_exchange: 'users_last_seen.error'
})

module.exports = {
  markAsSeen
}
