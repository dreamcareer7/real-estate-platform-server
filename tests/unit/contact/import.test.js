const fs = require('fs')
const path = require('path')
const { expect } = require('chai')

const { createContext, handleJobs } = require('../helper')

const AttachedFile = require('../../../lib/models/AttachedFile')
const Contact = require('../../../lib/models/Contact')
const ImportWorker = require('../../../lib/models/Contact/worker/import')
const Context = require('../../../lib/models/Context')
const User = require('../../../lib/models/User/get')

const BrandHelper = require('../brand/helper')

const mappings = require('../../functional/suites/data/csv_mappings')
const contacts_json = require('../analytics/data/contacts')

let user, brand

async function setup() {
  user = await User.getByEmail('test@rechat.com')

  brand = await BrandHelper.create({
    roles: {
      Admin: [user.id]
    },
    checklists: [],
    contexts: []
  })
  Context.set({ user, brand })
}

async function testImportFromCsv() {
  const file = await AttachedFile.saveFromStream({
    stream: fs.createReadStream(path.resolve(__dirname, '../../functional/suites/data/contacts.csv')),
    filename: 'contacts.csv',
    user,
    path: user.id + '-' + Date.now().toString(),
    relations: [
      {
        role: 'Brand',
        role_id: brand.id
      }
    ],
    public: false
  })

  ImportWorker.import_csv(user.id, brand.id, file.id, user.id, mappings)

  await handleJobs()

  const { total } = await Contact.filter(brand.id, [], { limit: 1 })
  expect(total).to.be.equal(192)
}

async function testImportFromJson() {
  ImportWorker.import_json(contacts_json.map(c => ({ ...c, user: user.id })), user.id, brand.id)

  await handleJobs()

  const contacts = await Contact.getForBrand(brand.id, [], {})
  expect(contacts).to.have.length(3)
}

describe('Contact', () => {
  createContext()
  beforeEach(setup)

  describe('Import', () => {
    it('should import contacts from csv', testImportFromCsv)
    it('should import contacts from json', testImportFromJson)
  })
})
