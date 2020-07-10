const { expect } = require('chai')
const { createContext } = require('../helper')

const Context          = require('../../../lib/models/Context')
const User             = require('../../../lib/models/User/get')
const BrandHelper      = require('../brand/helper')
const GoogleContact    = require('../../../lib/models/Google/contact')

const { createGoogleMessages } = require('./helper')

const google_contacts_offline       = require('./data/google_contacts.json')
const google_contact_groups_offline = require('./data/google_contact_groups.json')

let user, brand



async function setup() {
  user  = await User.getByEmail('test@rechat.com')
  brand = await BrandHelper.create({ roles: { Admin: [user.id] } })

  Context.set({ user, brand })
}

async function create() {
  const { credential } = await createGoogleMessages(user, brand)

  const records = []

  for (const gContact of google_contacts_offline) {
    records.push({ google_credential: credential.id, entry_id: gContact.entry_id, entry: JSON.stringify(gContact.entry) })
  }

  const createdGoogleContacts = await GoogleContact.create(records)

  for (const createdGoogleContact of createdGoogleContacts) {
    expect(createdGoogleContact.google_credential).to.be.equal(credential.id)

    const googleContact = await GoogleContact.get(createdGoogleContact.entry_id, createdGoogleContact.google_credential)

    expect(googleContact.type).to.be.equal('google_contact')
    expect(googleContact.google_credential).to.be.equal(createdGoogleContact.google_credential)
    expect(googleContact.entry_id).to.be.equal(createdGoogleContact.entry_id)
    expect(googleContact.entry.names.fullName).to.be.equal(createdGoogleContact.entry.names.fullName)
  }

  return createdGoogleContacts
}

async function getByEntryId() {
  const googleContacts = await create()

  for (const gContact of googleContacts) {

    const googleContact = await GoogleContact.get(gContact.entry_id, gContact.google_credential)

    expect(googleContact.type).to.be.equal('google_contact')
    expect(googleContact.google_credential).to.be.equal(gContact.google_credential)
    expect(googleContact.entry_id).to.be.equal(gContact.entry_id)
    expect(googleContact.entry.names.fullName).to.be.equal(gContact.entry.names.fullName)
  }
}

async function getByEntryIdFailed() {
  const bad_id = user.id

  const googleContact = await GoogleContact.get(bad_id, bad_id)

  expect(googleContact).to.be.equal(null)
}

async function getGCredentialContactsNum() {
  const googleContacts = await create()

  const result = await GoogleContact.getGCredentialContactsNum(googleContacts[0]['google_credential'])

  expect(result[0]['count']).to.be.equal(googleContacts.length)
}

async function addContactGroup() {
  const { credential } = await createGoogleMessages(user, brand)

  const contactGroups = []

  for (const record of google_contact_groups_offline) {
    contactGroups.push({
      entry_id: record.entry_id,
      entry: record.entry
    })
  }

  for (const contactGroup of contactGroups) {
    const result = await GoogleContact.addContactGroup(credential, contactGroup)
    expect(result).to.be.uuid
  }
}

async function getRefinedContactGroups() {
  const googleContacts = await create()
  const { credential } = await createGoogleMessages(user, brand)

  const contactGroups = []

  for (const record of google_contact_groups_offline) {
    contactGroups.push({
      entry_id: record.entry_id,
      entry: record.entry
    })
  }

  for (const contactGroup of contactGroups) {
    await GoogleContact.addContactGroup(credential, contactGroup)
  }

  const result = await GoogleContact.getRefinedContactGroups(googleContacts[0]['google_credential'])

  const arr = ['Coworkers', 'Contacts']

  for ( const key in result ) {
    expect(arr.includes(result[key])).to.be.equal(true)
  }
}



describe('Google', () => {
  describe('Google Contacts', () => {
    createContext()
    beforeEach(setup)

    it('should create some google-contacts', create)
    it('should return google-contact by entry_id', getByEntryId)
    it('should handle failure of google-contact get by entry_id', getByEntryIdFailed)
    it('should return number of contacts of specific credential', getGCredentialContactsNum)
    it('should handle add contact group', addContactGroup)
    it('should return number of contacts of specific credential', getRefinedContactGroups)
  })
})
