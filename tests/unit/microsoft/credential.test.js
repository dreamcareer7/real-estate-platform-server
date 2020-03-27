const { expect }        = require('chai')
const { createContext } = require('../helper')

const Context             = require('../../../lib/models/Context')
const User                = require('../../../lib/models/User')
const BrandHelper         = require('../brand/helper')
const MicrosoftCredential = require('../../../lib/models/Microsoft/credential')

const { createMicrosoftCredential } = require('./helper')


let user, brand


async function setup() {
  user  = await User.getByEmail('test@rechat.com')
  brand = await BrandHelper.create({ roles: { Admin: [user.id] } })

  Context.set({ user, brand })
}

async function create() {
  const { credential, body } = await createMicrosoftCredential(user, brand)

  expect(credential.type).to.be.equal('microsoft_credential')
  expect(credential.user).to.be.equal(user.id)
  expect(credential.brand).to.be.equal(brand.id)
  expect(credential.email).to.be.equal(body.profile.email)
  expect(credential.access_token).to.be.equal(body.tokens.access_token)

  return credential
}

async function publicize() {
  const createdCredential = await create()
  const updatedCredential = await MicrosoftCredential.publicize(createdCredential)

  expect(updatedCredential.access_token).to.be.equal(undefined)
  expect(updatedCredential.refresh_token).to.be.equal(undefined)
  expect(updatedCredential.id_token).to.be.equal(undefined)
  expect(updatedCredential.expires_in).to.be.equal(undefined)
  expect(updatedCredential.ext_expires_in).to.be.equal(undefined)
}

async function getByUser() {
  const createdCredential = await create()
  const credentials       = await MicrosoftCredential.getByUser(createdCredential.user, createdCredential.brand)

  expect(credentials.length).not.to.be.equal(0)

  for (const record of credentials) {
    expect(record.type).to.be.equal('microsoft_credential')
    expect(record.user).to.be.equal(createdCredential.user)
    expect(record.brand).to.be.equal(createdCredential.brand)
  }
}

async function getByUserFailed() {
  const credentials = await MicrosoftCredential.getByUser(user.id, user.id)

  expect(credentials.length).to.be.equal(0)
}

async function getById() {
  const createdCredential = await create()
  const credential        = await MicrosoftCredential.get(createdCredential.id)

  expect(credential.type).to.be.equal('microsoft_credential')
  expect(credential.user).to.be.equal(createdCredential.user)
  expect(credential.brand).to.be.equal(createdCredential.brand)
}

async function getByIdFailed() {
  try {
    const not_exist_credential_id = user.id
    await MicrosoftCredential.get(not_exist_credential_id)

  } catch (ex) {
    const message = `Microsoft-Credential ${user.id} not found`

    expect(ex.message).to.be.equal(message)
  }
}

async function updateTokens() {
  const createdCredential = await create()

  const tokens = {
    access_token: 'new-access-token',
    refresh_token: 'new-refresh-token',
    id_token: 'id_token',
    expires_in: 0,
    ext_expires_in: 0
  }

  await MicrosoftCredential.updateTokens(createdCredential.id, tokens)

  const updatedCredential = await MicrosoftCredential.get(createdCredential.id)

  expect(createdCredential.id).to.be.equal(updatedCredential.id)
  expect(updatedCredential.access_token).to.be.equal(tokens.access_token)
}

async function updateAsRevoked() {
  const createdCredential = await create()
  expect(createdCredential.revoked).to.be.equal(false)

  await MicrosoftCredential.updateAsRevoked(createdCredential.id)
  const updatedCredential = await MicrosoftCredential.get(createdCredential.id)

  expect(updatedCredential.revoked).to.be.equal(true)
}

async function updateLastSync() {
  const createdCredential = await create()

  const duration = 100
  await MicrosoftCredential.updateLastSync(createdCredential.id, duration)

  const updatedCredential = await MicrosoftCredential.get(createdCredential.id)

  expect(createdCredential.id).to.be.equal(updatedCredential.id)
  expect(updatedCredential.last_sync_duration).to.be.equal(duration)
}

async function updateSyncStatus() {
  const createdCredential = await create()

  const status = 'success'

  await MicrosoftCredential.updateSyncStatus(createdCredential.id, status)

  const updatedCredential_1 = await MicrosoftCredential.get(createdCredential.id)

  expect(createdCredential.id).to.be.equal(updatedCredential_1.id)
  expect(updatedCredential_1.sync_status).to.be.equal(status)


  await MicrosoftCredential.updateSyncStatus(createdCredential.id, null)

  const updatedCredential_2 = await MicrosoftCredential.get(createdCredential.id)

  expect(createdCredential.id).to.be.equal(updatedCredential_2.id)
  expect(updatedCredential_2.sync_status).to.be.equal(null)
}

async function updateSendEmailAfter() {
  const createdCredential = await create()

  const ts = new Date().getTime()

  await MicrosoftCredential.updateSendEmailAfter(createdCredential.id, ts)

  const updatedCredential = await MicrosoftCredential.get(createdCredential.id)

  expect(createdCredential.id).to.be.equal(updatedCredential.id)
  expect(Number(updatedCredential.send_email_after)).to.be.equal(ts)
}

async function postponeOutlookSync() {
  const createdCredential = await create()

  await MicrosoftCredential.postponeOutlookSync(createdCredential.id)

  const updatedCredential = await MicrosoftCredential.get(createdCredential.id)

  expect(createdCredential.id).to.be.equal(updatedCredential.id)
  expect(updatedCredential.sync_status).to.be.equal('failed')
  expect(updatedCredential.last_sync_duration).to.be.equal(0)
}

async function disableEnableSync() {
  const createdCredential = await create()

  await MicrosoftCredential.disableEnableSync(createdCredential.id, 'disable')
  const updatedCredential_1 = await MicrosoftCredential.get(createdCredential.id)
  expect(updatedCredential_1.deleted_at).not.to.be.equal(null)


  await MicrosoftCredential.disableEnableSync(createdCredential.id, 'enable')
  const updatedCredential_2 = await MicrosoftCredential.get(createdCredential.id)
  expect(updatedCredential_2.deleted_at).to.be.equal(null)
}

async function disableEnableSyncFailed() {
  const not_exist_credential_id = user.id

  try {
    await MicrosoftCredential.disableEnableSync(not_exist_credential_id, 'disable')

  } catch (ex) {
    const message = `Microsoft-Credential ${user.id} not found`

    expect(ex.message).to.be.equal(message)
  }
}

async function forceSync() {
  const createdCredential = await create()

  await MicrosoftCredential.updateLastSync(createdCredential.id)
  await MicrosoftCredential.forceSync(createdCredential.id)

  const updatedCredential = await MicrosoftCredential.get(createdCredential.id)

  expect(createdCredential.id).to.be.equal(updatedCredential.id)
  expect(updatedCredential.sync_status).to.be.equal(null)
  expect(updatedCredential.last_sync_at).to.be.equal(null)
  expect(updatedCredential.last_sync_duration).to.be.equal(null)
}

async function updateProfile() {
  const createdCredential = await create()

  const profile = {
    displayName: 'displayName',
    givenName: 'givenName',
    surname: 'surname',
    photo: 'http://....'
  }
  await MicrosoftCredential.updateProfile(createdCredential.id, profile)

  const updatedCredential = await MicrosoftCredential.get(createdCredential.id)

  expect(createdCredential.id).to.be.equal(updatedCredential.id)
  expect(updatedCredential.display_name).to.be.equal(profile.displayName)
}

async function updateContactsLastSyncAt() {
  const createdCredential = await create()

  await MicrosoftCredential.updateContactsLastSyncAt(createdCredential.id)

  const updatedCredential = await MicrosoftCredential.get(createdCredential.id)

  expect(createdCredential.id).to.be.equal(updatedCredential.id)
  expect(updatedCredential.contacts_last_sync_at).not.to.be.equal(null)
}

async function updateContactsLastExtractAt() {
  const createdCredential = await create()

  await MicrosoftCredential.updateContactsLastExtractAt(createdCredential.id)

  const updatedCredential = await MicrosoftCredential.get(createdCredential.id)

  expect(createdCredential.id).to.be.equal(updatedCredential.id)
  expect(updatedCredential.contacts_last_extract_at).not.to.be.equal(null)
}

async function updateMessagesLastSyncAt() {
  const createdCredential = await create()

  await MicrosoftCredential.updateMessagesLastSyncAt(createdCredential.id)

  const updatedCredential = await MicrosoftCredential.get(createdCredential.id)

  expect(createdCredential.id).to.be.equal(updatedCredential.id)
  expect(updatedCredential.messages_last_sync_at).not.to.be.equal(null)
}


describe('Microsoft', () => {
  describe('Microsoft Account', () => {
    createContext()
    beforeEach(setup)

    it('should create a microsoft credential', create)
    it('should publicize a microsoft-credential', publicize)

    it('should return a microsoft credential by user-brand', getByUser)
    it('should handle returned exception from microsoft-credential by user-brand', getByUserFailed)

    it('should return a microsoft credential by id', getById)
    it('should handle returned exception from microsoft-credential by id', getByIdFailed)
    
    it('should update a microsoft-credential tokens', updateTokens)
    it('should revoke a microsoft-credential', updateAsRevoked)
    it('should update a microsoft-credential last sync status', updateLastSync)
    it('should update a microsoft-credential sync status', updateSyncStatus)
    it('should update a microsoft-credential send_email_after', updateSendEmailAfter)
    it('should postpone a microsoft-credential sync', postponeOutlookSync)

    it('should disable/enable a microsoft-credential', disableEnableSync)
    it('should handle returned exception from disable/enable microsoft-credential', disableEnableSyncFailed)

    it('should handle force sync request', forceSync)
    it('should update a microsoft-credential profile', updateProfile)

    it('should update a microsoft-credential contacts_last_sync_At', updateContactsLastSyncAt)
    it('should update a microsoft-credential contacts_last_extract_At', updateContactsLastExtractAt)
    it('should update a microsoft-credential messages_last_sync_At', updateMessagesLastSyncAt)
  })
})
