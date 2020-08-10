const { expect } = require('chai')
const PropertyRoom = require('../../../lib/models/PropertyRoom')

const { createContext } = require('../helper')

const json = require('./json/room')

const saveRoom = async () => {
  const id = await PropertyRoom.create(json)
  expect(id).to.be.a('string')
}

describe('MLS Room', () => {
  createContext()

  it('should save a room', saveRoom)
})
