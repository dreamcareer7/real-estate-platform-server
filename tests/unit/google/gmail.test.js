const { expect } = require('chai')
const { createContext, handleJobs } = require('../helper')

const Context       = require('../../../lib/models/Context')
const GmailAuthLink = require('../../../lib/models/Google/gmail_auth_link')
const Gmail         = require('../../../lib/models/Google/gmail')
const User          = require('../../../lib/models/User')
const Brand         = require('../../../lib/models/Brand')
const Job           = require('../../../lib/models/Job')
const BrandHelper   = require('../brand/helper')

let user, brand
const GMAIL_ADDRESS = 'saeed.uni68@gmail.com'

const google_tokens_json = require('./data/google_tokens')
const google_auth_json   = require('./data/google_auth')
const gmail_profile_json = require('./data/gmail_profile.json')




async function setup() {
  user = await User.getByEmail('test@rechat.com')
  brand = await BrandHelper.create({ roles: { Admin: [user.id] } })

  Context.set({ user, brand })
}

async function requestGmailAccess() {
  const authUrl = await GmailAuthLink.requestGmailAccess(user.id, brand.id, GMAIL_ADDRESS)
  
  expect(authUrl).to.be.not.null

  return authUrl
}

async function duplicateRequestGmailAccess() {
  const authUrl_1 = await GmailAuthLink.requestGmailAccess(user.id, brand.id, GMAIL_ADDRESS)
  const authUrl_2 = await GmailAuthLink.requestGmailAccess(user.id, brand.id, GMAIL_ADDRESS)
  
  expect(authUrl_1).to.be.not.null
  expect(authUrl_2).to.be.not.null
  expect(authUrl_2).to.be.equal(authUrl_2)
}

async function getByLink() {
  const authUrl = await requestGmailAccess()
  const gmailAuthLink = await GmailAuthLink.getByLink(authUrl)
  
  expect(authUrl).to.be.equal(gmailAuthLink.url)

  return authUrl
}

async function getByUser() {
  await requestGmailAccess()
  const gmailAuthLink = await GmailAuthLink.getByUser(user.id, brand.id)

  expect(gmailAuthLink.user).to.be.equal(user.id)
  expect(gmailAuthLink.brand).to.be.equal(brand.id)
}


async function createGmail() {
  google_auth_json.user  = user.id
  google_auth_json.brand = brand.id
  google_auth_json.email = GMAIL_ADDRESS

  gmail_profile_json.emailAddress = GMAIL_ADDRESS

  const body = {
    gmailAuthLink: google_auth_json,
    profile: gmail_profile_json,
    tokens: google_tokens_json
  }

  const gmailRecordId = await Gmail.create(body)
  const gmailRecord   = await Gmail.get(gmailRecordId)

  expect(gmailRecord.user).to.be.equal(user.id)
  expect(gmailRecord.brand).to.be.equal(brand.id)
  expect(gmailRecord.email).to.be.equal(body.profile.emailAddress)
  expect(gmailRecord.access_token).to.be.equal(body.tokens.access_token)

  return gmailRecord
}

async function getGmailByUser() {
  const createdGmail = await createGmail()
  const gmailRecord  = await Gmail.getByUser(createdGmail.user, createdGmail.brand)

  expect(createdGmail.user).to.be.equal(gmailRecord.user)
  expect(createdGmail.brand).to.be.equal(gmailRecord.brand)
  expect(createdGmail.email).to.be.equal(gmailRecord.email)
}

async function getGmailByEmail() {
  const createdGmail = await createGmail()
  const gmailRecord  = await Gmail.getByEmail(createdGmail.email)

  expect(createdGmail.email).to.be.equal(gmailRecord.email)
}

async function updateGmailTokens() {
  const createdGmail = await createGmail()
  const TS = new Date()

  const tokens = {
    access_token: 'new-access-token',
    refresh_token: 'new-refresh-token',
    expiry_date: TS
  }
  await Gmail.updateTokens(createdGmail.id, tokens)

  const updatedGmail = await Gmail.get(createdGmail.id)

  expect(createdGmail.id).to.be.equal(updatedGmail.id)
  expect(updatedGmail.access_token).to.be.equal(tokens.access_token)
}

async function updateGmailAsRevoked() {
  const createdGmail = await createGmail()
  expect(createdGmail.revoked).to.be.equal(false)

  await Gmail.updateAsRevoked(createdGmail.user, createdGmail.brand)
  const updatedGmail = await Gmail.get(createdGmail.id)
  expect(updatedGmail.revoked).to.be.equal(true)
}

async function updateGmailProfile() {
  const createdGmail = await createGmail()

  const profile = {
    messagesTotal: 100,
    threadsTotal: 15
  }
  await Gmail.updateProfile(createdGmail.id, profile)

  const updatedGmail = await Gmail.get(createdGmail.id)

  expect(createdGmail.id).to.be.equal(updatedGmail.id)
  expect(updatedGmail.messages_total).to.be.equal(profile.messagesTotal)
}



describe('Google', () => {
  describe('Google Auth Link', () => {
    createContext()
    beforeEach(setup)

    it('should create a google auth link', requestGmailAccess)
    it('should handle duplicate create-google-auth-link request', duplicateRequestGmailAccess)
    it('should return auth-link record by link', getByLink)
    it('should return auth-link record by user', getByUser)
  })

  describe('Google Gmail', () => {
    createContext()
    beforeEach(setup)

    it('should create a gmail record (semi-grant-a)', createGmail)
    it('should return a gmail record by user', getGmailByUser)
    it('should return a gmail record by email', getGmailByEmail)
    it('should update a gmail record tokens', updateGmailTokens)
    it('should revoke a gmail record', updateGmailAsRevoked)
    it('should update a gmail record profile', updateGmailProfile)
  })
})