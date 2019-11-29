const expect = require('../utils/validator.js').expect
const am = require('../utils/async_middleware.js')
const promisify = require('../utils/promisify.js')

const AttachedFile = require('../models/AttachedFile')
const ContactList = require('../models/Contact/list')
const Email = require('../models/Email')
const EmailCampaign = require('../models/Email/campaign')
const EmailCampaignEmail = require('../models/Email/campaign/email')

const recipientAccessControl = async (campaign) => {
  const {
    to = [],
    cc = [],
    bcc = []
  } = campaign

  const all = [].concat(to, cc, bcc)

  const lists = all
    .filter(r => r.list)
    .map(t => t.list)

  const access = await ContactList.hasAccess(campaign.brand, 'read', lists)

  if (Array.prototype.some.call(access.values(), x => !x))
    throw Error.Unauthorized('Access denied to one or more of the specified lists.')
}

const postEmails = async (req, res) => {
  const campaign = req.body

  campaign.created_by = req.user.id
  campaign.brand = Brand.getCurrent().id

  expect(campaign.brand).to.be.uuid
  expect(campaign.from).to.be.uuid

  await Brand.limitAccess({
    brand: campaign.brand,
    user: req.user.id
  })

  await Brand.limitAccess({
    brand: campaign.brand,
    user: campaign.from
  })

  const { to } = campaign

  // https://app.mailgun.com/app/support/947351
  expect(to, 'To recipient is required').to.be.an('array').to.have.length.above(0)

  await recipientAccessControl(campaign)

  const [ id ] = await EmailCampaign.createMany([campaign])
  const saved = await EmailCampaign.get(id)

  res.model(saved)
}

const postIndividualEmails = async (req, res) => {
  const campaign = req.body

  campaign.created_by = req.user.id
  campaign.brand = Brand.getCurrent().id

  expect(campaign.brand).to.be.uuid
  expect(campaign.from).to.be.uuid

  expect(campaign.to).to.be.an('array')

  expect(campaign.cc).to.be.undefined
  expect(campaign.bcc).to.be.undefined

  campaign.individual = true

  await Brand.limitAccess({
    brand: campaign.brand,
    user: req.user.id
  })

  await Brand.limitAccess({
    brand: campaign.brand,
    user: campaign.from
  })

  await recipientAccessControl(campaign)

  const [ id ] = await EmailCampaign.createMany([campaign])
  const saved = await EmailCampaign.get(id)

  res.model(saved)
}

const addEvent = async (req, res) => {
  expect(req.body).to.be.an('object')

  const e = req.body['event-data'] || {}
  const { message = {} } = e
  const { headers = {} } = message
  const email = headers['message-id']

  /*
   * https://app.mailgun.com/app/support/1000782
   * Sometimes they have no id!
   */
  if (!email)
    throw Error.Validation({
      slack: false,
      message: 'Cannot save event with no message id'
    })

  const event = {
    email: e.message.headers['message-id'],
    event: e.event,
    created_at: e.timestamp,
    recipient: e.recipient
  }

  await Email.addEvent(event)

  res.end()
}

const attach = async (req, res) => {
  const { file } = await promisify(AttachedFile.saveFromRequest)({
    path: req.user.id,
    req,
    relations: [
      {
        role: 'User',
        role_id: req.user.id
      }
    ],
    public: false
  })

  res.model(file)
}


const getCampaign = async (req, res) => {
  const campaign = await EmailCampaign.get(req.params.id)

  await Brand.limitAccess({
    user: req.user.id,
    brand: campaign.brand
  })

  res.model(campaign)
}

const updateCampaign = async (req, res) => {
  expect(req.params.id).to.be.uuid

  const campaign = req.body

  const updated = await EmailCampaign.update({
    ...campaign,
    id: req.params.id
  })

  await Brand.limitAccess({
    user: req.user.id,
    brand: updated.brand
  })


  res.model(updated)
}

const deleteCampaign = async (req, res) => {
  const id = req.params.id
  expect(id).to.be.uuid

  const campaign = await EmailCampaign.get(id)

  await Brand.limitAccess({
    user: req.user.id,
    brand: campaign.brand
  })

  await EmailCampaign.deleteMany([id], req.user, campaign.brand)

  res.status(204)
  return res.end()
}

const getCampaigns = async (req, res) => {
  await Brand.limitAccess({
    user: req.user.id,
    brand: req.params.brand
  })

  const campaigns = await EmailCampaign.getByBrand(req.params.brand)

  res.collection(campaigns)
}

const getEmail = async(req, res) => {
  const email = await EmailCampaignEmail.get(req.params.email)

  expect(email.campaign).to.equal(req.params.id)

  const campaign = await EmailCampaign.get(email.campaign)

  await Brand.limitAccess({
    user: req.user.id,
    brand: campaign.brand
  })

  res.model(email)
}

const router = function (app) {
  const auth = app.auth.bearer.middleware

  app.get('/brands/:brand/emails/campaigns', auth, am(getCampaigns))
  app.post('/emails', auth, am(postEmails))
  app.get('/emails/:id', auth, am(getCampaign))
  app.get('/emails/:id/emails/:email', auth, am(getEmail))
  app.put('/emails/:id', auth, am(updateCampaign))
  app.delete('/emails/:id', auth, am(deleteCampaign))
  app.post('/emails/individual', auth, am(postIndividualEmails))
  app.post('/emails/attachments', auth, am(attach))
  app.post('/emails/events', am(addEvent))
}

module.exports = router
