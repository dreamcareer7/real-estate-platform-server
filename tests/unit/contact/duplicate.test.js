const _ = require('lodash')
const { expect } = require('chai')

const { createContext, handleJobs } = require('../helper')
const contactsData = require('./data/duplicate.json')

const Contact = require('../../../lib/models/Contact')
const Duplicates = require('../../../lib/models/Contact/duplicate')
const Context = require('../../../lib/models/Context')
const sql = require('../../../lib/utils/sql')

const BrandHelper = require('../brand/helper')
const UserHelper = require('../user/helper')

let user, brand, contact_ids

async function setup() {
  user = await UserHelper.TestUser()

  brand = await BrandHelper.create({
    roles: {
      Admin: [user.id]
    },
    checklists: [],
    contexts: []
  })
  Context.set({ user, brand })

  await sql.query('ALTER SEQUENCE contact_duplicate_cluster_seq RESTART WITH 1')
  await createContact()
}

async function createContact() {
  contact_ids = await Contact.create(
    contactsData.map(c => ({ ...c, user: user.id })),
    user.id,
    brand.id,
    'direct_request',
    { activity: false, get: false, relax: false }
  )

  await handleJobs()
}

async function testDuplicateClusters() {
  const duplicates = await Duplicates.findForBrand(brand.id)

  expect(duplicates).to.have.length(1)
}

async function testContactDuplicateCluster() {
  const duplicate = await Duplicates.findForContact(brand.id, contact_ids[0])

  expect(duplicate.contacts).to.have.length(3)
  expect(duplicate.contacts).to.have.members(contact_ids)
}

async function testRemoveContactFromCluster() {
  const contacts = await Contact.getAll(contact_ids)
  const thomas = contacts.find(c => c.first_name === 'Thomas')
  if (!thomas) throw new Error('Thomas not found!')

  const duplicate = await Duplicates.findForContact(brand.id, contact_ids[0])

  await Duplicates.ignoreContactFromCluster(brand.id, duplicate.id, thomas.id)
  await handleJobs()

  const new_clusters = await Duplicates.findForBrand(brand.id)
  expect(new_clusters).to.have.length(1)
  expect(new_clusters[0].contacts).to.have.members(_.without(contact_ids, thomas.id))
}

async function testRemoveWholeCluster() {
  let clusters = await Duplicates.findForBrand(brand.id)

  await Duplicates.ignoreCluster(brand.id, clusters[0].id)
  await handleJobs()

  clusters = await Duplicates.findForBrand(brand.id)
  expect(clusters).to.be.empty
}

describe('Contact', () => {
  createContext()
  beforeEach(setup)

  describe('Duplicates', () => {
    it('mark duplicates', testDuplicateClusters)
    it('find duplicate cluster for contact', testContactDuplicateCluster)
    it('remove contact from cluster', testRemoveContactFromCluster)
    it('remove the whole cluster', testRemoveWholeCluster)
  })
})
