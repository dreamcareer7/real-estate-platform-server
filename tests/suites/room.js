const raw = require('./data/room.js')
const room_response = require('./expected_objects/room.js')
const info_response = require('./expected_objects/info.js')
const uuid = require('node-uuid')

registerSuite('user', ['create'])

const updated_room = 'updated_title'

const room = JSON.parse(JSON.stringify(raw))
delete room.emails
delete room.phone_numbers

const create = (cb) => {
  return frisby.create('create room')
    .post('/rooms', raw)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: room
    })
    .expectJSONTypes({
      code: String,
      data: room_response
    })
}

const createDirect = cb => {
  return frisby.create('create a direct room')
    .post('/rooms', {
      room_type: 'Direct',
      users: [ ],
      emails: [
        'another@rechat.com'
      ],
      phone_numbers: [ ]
    })
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: {
        room_type: 'Direct',
      }
    })
    .expectJSONTypes({
      code: String,
      data: room_response
    }).
    expectJSONLength('data.users', 2)
}

const create400 = (cb) => {
  return frisby.create('expect 400 with empty model when creating a room')
    .post('/rooms')
    .after(cb)
    .expectStatus(400)
}

const getRoom = (cb) => {
  const room = JSON.parse(JSON.stringify(results.room.create.data))
  delete room.latest_message

  return frisby.create('get room')
    .get('/rooms/' + results.room.create.data.id)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: room
    })
    .expectJSONTypes({
      code: String,
      data: room_response
    })
}

const getRoom404 = (cb) => {
  return frisby.create('expect 404 with invalid room id when getting a room')
    .get('/rooms/' + uuid.v1())
    .after(cb)
    .expectStatus(404)
}

const getUserRooms = (cb) => {
  return frisby.create('get a user\'s rooms')
    .get('/rooms')
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: []
    })
    .expectJSONTypes({
      code: String,
      data: [room_response],
      info: info_response
    })
}

const getReferencedUserRooms = (cb) => {
  return frisby.create('get a user\'s rooms in referenced format')
    .addHeader('X-RECHAT-FORMAT', 'references')
    .get('/rooms')
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: []
    })
    .expectJSONTypes({
      code: String,
      data: [room_response],
      info: info_response
    })
}

const addUser = (cb) => {
  return frisby.create('add user to a room')
    .post('/rooms/' + results.room.create.data.id + '/users', {users: [
      results.user.create.data.id
    ]})
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: room
    })
    .expectJSONTypes({
      code: String,
      data: room_response
    })
}

const addUser400 = (cb) => {
  return frisby.create('expect 400 with empty model when adding user to a room')
    .post('/rooms/' + results.room.create.data.id + '/users')
    .after(cb)
    .expectStatus(400)
}

const search = (cb) => {
  return frisby.create('search room by email')
    .get('/rooms/search?q[]=' + results.room.create.data.title) //Sampleroom
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: [room]
    })
    .expectJSONTypes({
      code: String,
      data: [room_response],
      info: info_response
    })
}

const searchParties = (cb) => {
  const users = results.room.search.data[0].users

  let url = '/rooms/search?'

  // Here we have to provide emails and phone numbers for other users in the room

  users.forEach(user => {
    if (user.id === results.authorize.token.data.id)
      return // This is me. No need to include myself in the search

    if (user.phone_number)
      url += `phone_numbers[]=${encodeURIComponent(user.phone_number)}&`

    if (!user.fake_email)
      url += `emails[]=${user.email}&`
  })

  return frisby.create('search room by parties')
    .get(url)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: [room]
    })
    .expectJSONTypes({
      code: String,
      data: [room_response],
      info: info_response
    })
}

const removeUserFromPersonal = (cb) => {
  return frisby.create('remove user from his personal room')
    .delete('/rooms/' + results.user.create.data.personal_room + '/users/' + results.authorize.token.data.id)
    .after(cb)
    .expectStatus(406)
}

const patchRoom = (cb) => {
  room.title = updated_room
  return frisby.create('patch a room')
    .put('/rooms/' + results.room.create.data.id, room)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: room
    })
    .expectJSONTypes({
      code: String,
      data: room_response
    })
}

const patchRoom404 = (cb) => {
  return frisby.create('expect 404 with invalid room id when updating a room')
    .put('/rooms/' + uuid.v1(), room)
    .after(cb)
    .expectStatus(404)
}

const patchRoomWorked = (cb) => {
  room.title = updated_room
  return frisby.create('make sure patching worked')
    .get('/rooms/' + results.room.create.data.id)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: {
        title: updated_room
      }
    })
    .expectJSONTypes({
      code: String,
      data: room_response
    })
}

const removeUser = (cb) => {
  return frisby.create('remove user from a room')
    .delete('/rooms/' + results.room.create.data.id + '/users/' + results.authorize.token.data.id)
    .expectStatus(204)
    .after(cb)
}

const removeUserWorked = (cb) => {
  return frisby.create('make sure that we left the room')
    .get('/rooms/' + results.room.create.data.id)
    .expectStatus(403)
    .after(cb)
}

const removeUser404 = (cb) => {
  return frisby.create('expect 404 with invalid user id when removing a user from a room')
    .delete('/rooms/' + results.room.create.data.id + '/users/' + uuid.v1())
    .expectStatus(404)
    .after(cb)
}

const archiveRoom = (cb) => {
  return frisby.create('archive a room')
    .delete('/rooms/' + results.room.create.data.id)
    .expectStatus(204)
    .after(cb)
}

module.exports = {
  create,
  createDirect,
  create400,
  getRoom,
  getRoom404,
  getUserRooms,
  getReferencedUserRooms,
  addUser,
  addUser400,
  search,
  searchParties,
  patchRoom404,
  patchRoom,
  patchRoomWorked,
  removeUser404,
  removeUser,
  removeUserWorked,
  removeUserFromPersonal,
  archiveRoom
}
