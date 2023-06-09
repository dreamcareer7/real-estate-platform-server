registerSuite('mls', ['saveAlert', 'addListing'])

// const notification_response = require('./expected_objects/notification.js')
// const info_response = require('./expected_objects/info.js')
const user_response = require('./expected_objects/user.js')
const uuid = require('uuid')

const getUsersNotification = (cb) => {
  return frisby.create('get all notifications for a user')
    .get('/notifications')
    .after(cb)
    .expectStatus(200)
}

const getNotification = (cb) => {
  return frisby.create('get a notification by id')
    .get(`/notifications/${results.notification.getUsersNotification.data[0].id}`)
    .after(cb)
    .expectStatus(200)
}

const getNotification404 = (cb) => {
  return frisby.create('expect 404 with invalid notification id')
    .get(`/notifications/${uuid.v1()}`)
    .after(cb)
    .expectStatus(404)
}

const seenNotification = (cb) => {
  return frisby.create('mark a notification as seen')
    .patch(`/notifications/${results.notification.getUsersNotification.data[0].id}/seen`)
    .after(cb)
    .expectStatus(204)
}

const ackSingleNotification = (cb) => {
  return frisby.create('acknowledge a single notification')
    .delete(`/notifications/${results.notification.getUsersNotification.data[0].id}`)
    .after(cb)
    .expectStatus(204)
}

const acknowledgeNotification = (cb) => {
  return frisby.create('acknowledge notification')
    .delete('/notifications/')
    .after(cb)
    .expectStatus(204)
}

const acknowledgeRoomNotification = (cb) => {
  return frisby.create('acknowledge room notifications')
    .delete(`/rooms/${results.room.create.data.id}/notifications`)
    .after(cb)
    .expectStatus(204)
}

const pushNotification = (cb) => {
  const token = require('./data/token.js')
  const token_model = JSON.parse(JSON.stringify(token))
  return frisby.create('register push')
    .post('/notifications/tokens', token_model)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: {
        type: 'user'
      }

    })
    .expectJSONLength(2)
    .expectJSONTypes({
      code: String,
      data: user_response
    })
}

const cancelPushNotificationWithoutApp = (cb) => {
  return frisby.create('cancel push without app')
    .delete('/notifications/tokens/' + results.notification.pushNotification.data.id)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: {
        type: 'user'
      }

    })
    .expectJSONLength(2)
    .expectJSONTypes({
      code: String,
      data: user_response
    })
}

const cancelPushNotification = (cb) => {
  const app = 'rechat'
  const token = results.notification.pushNotification.data.id
  
  return frisby.create('cancel push')
    .delete(`/notifications/tokens/${app}/${token}`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: { type: 'user' },
    })
    .expectJSONLength(2)
    .expectJSONTypes({ code: String, data: user_response })
}

const patchNotificationSettings = (cb) => {
  return frisby.create('update notification settings')
    .patch('/rooms/' + results.room.create.data.id + '/notifications', {
      setting: 'N_MENTIONS'
    })
    .after(cb)
    .expectStatus(200)
}

const patchNotificationSettingsInvalid = (cb) => {
  return frisby.create('update notification settings with invalid properties')
    .patch('/rooms/' + results.room.create.data.id + '/notifications', {
      setting: 'N_BOGUS'
    })
    .after(cb)
    .expectStatus(400)
}

const patchNotificationSettings404 = (cb) => {
  return frisby.create('expect 404 with invalid notification id')
    .patch('/room/' + uuid.v1() + '/notifications', {
      notification: true
    })
    .after(cb)
    .expectStatus(404)
}


module.exports = {
  getUsersNotification,
  getNotification,
  getNotification404,
  seenNotification,
  ackSingleNotification,
  acknowledgeNotification,
  acknowledgeRoomNotification,
  pushNotification,
  cancelPushNotificationWithoutApp,
  cancelPushNotification,
  patchNotificationSettings,
  patchNotificationSettingsInvalid,
  patchNotificationSettings404
}
