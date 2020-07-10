const expect = require('../utils/validator.js').expect
const am = require('../utils/async_middleware.js')
const Notification = require('../models/Notification')
const Room = require('../models/Room/notification')


function getNotification (req, res) {
  const notification_id = req.params.id

  expect(notification_id).to.be.uuid

  Notification.get(notification_id, (err, notification) => {
    if (err)
      return res.error(err)

    return res.model(notification)
  })
}

function getNotifications (req, res) {
  const user_id = req.user.id
  const paging = {}
  req.pagination(paging)

  // FIXME: temprary fix until we have paging on web
  if(!paging.limit)
    paging.limit = 20

  Notification.getForUser(user_id, paging, (err, notifications) => {
    if (err)
      return res.error(err)

    return res.collection(notifications)
  })
}

function patchSeen (req, res) {
  const user_id = req.user.id
  const notification_id = req.params.id

  expect(notification_id).to.be.uuid
  expect(user_id).to.be.uuid

  Notification.patchSeen(user_id, notification_id, err => {
    if (err)
      return res.error(err)

    res.status(204)
    return res.end()
  })
}

function registerForPush (req, res) {
  const user_id = req.user.id
  const channel = req.body.channel

  expect(user_id).to.be.uuid
  expect(channel).to.be.a('string')

  Notification.registerForPush(user_id, channel, (err, user) => {
    if (err)
      return res.error(err)

    return res.model(user)
  })
}

function unregisterForPush (req, res) {
  const user_id = req.user.id
  const channel = req.params.token

  Notification.unregisterForPush(user_id, channel, (err, user) => {
    if (err)
      return res.error(err)

    return res.model(user)
  })
}

function patchNotificationSettings (req, res) {
  const user_id = req.user.id
  const room_id = req.params.id
  const setting = req.body.setting

  expect(room_id).to.be.uuid
  expect(setting).to.be.a('string')

  Room.setNotificationSettings(user_id, room_id, setting, (err, room) => {
    if (err)
      return res.error(err)

    return res.model(room)
  })
}

function ackRoom (req, res) {
  const user_id = req.user.id
  const room_id = req.params.id

  expect(room_id).to.be.uuid
  expect(user_id).to.be.uuid

  Notification.ackRoom(user_id, room_id, err => {
    if (err)
      return res.error(err)

    res.status(204)
    return res.end()
  })
}

function ackPersonal (req, res) {
  const user_id = req.user.id
  const notifications = req.body.notifications

  expect(user_id).to.be.uuid

  Notification.ackPersonal(user_id, notifications, err => {
    if (err)
      return res.error(err)

    res.status(204)
    return res.end()
  })
}

async function ackSingle(req, res) {
  const user_id = req.user.id
  const notification_id = req.params.id

  expect(notification_id).to.be.uuid

  await Notification.ackSingle(user_id, notification_id)
  res.status(204)
  res.end()
}

async function patchAllSeen(req, res) {
  const user_id = req.user.id
  expect(user_id).to.be.uuid

  Notification.patchSeen(user_id, null, err => {
    if (err)
      return res.error(err)

    res.status(204)
    return res.end()
  })
}

const router = function (app) {
  const b = app.auth.bearer

  app.post('/notifications/tokens', b(registerForPush))
  app.delete('/notifications/tokens/:token', b(unregisterForPush))
  app.patch('/rooms/:id/notifications', b(patchNotificationSettings))
  app.get('/notifications/:id', b(getNotification))
  app.patch('/notifications/:id/seen', b(patchSeen))
  app.patch('/notifications/seen', b(patchAllSeen))
  app.delete('/rooms/:id/notifications', b(ackRoom))
  app.delete('/notifications', b(ackPersonal))
  app.delete('/notifications/:id', b.middleware, am(ackSingle))
  app.get('/notifications', b(getNotifications))
}

module.exports = router
