const moment = require('moment-timezone')
const { expect } = require('chai')

const db = require('../../../lib/utils/db.js')
const Trigger = require('../../../lib/models/Trigger/filter.js')
const BrandTrigger = {
  ...require('../../../lib/models/Trigger/brand_trigger/workers').test,
  ...require('../../../lib/models/Trigger/brand_trigger/create'),
  ...require('../../../lib/models/Trigger/brand_trigger/get'),
}
const Campaign = require('../../../lib/models/Email/campaign/get.js')
const Contact = {
  ...require('../../../lib/models/Contact/manipulate'),
  ...require('../../../lib/models/Contact/get'),
}
const Context = require('../../../lib/models/Context')
// const sql = require('../../../lib/utils/sql')

const BrandHelper = require('../brand/helper')
const { attributes } = require('../contact/helper')
const UserHelper = require('../user/helper')

const { createContext, handleJobs } = require('../helper')
const BrandTemplate = require('../../../lib/models/Template/brand/get')

const BIRTHDAY = moment.utc().add(3, 'days').startOf('day').add(-20, 'years')

let brand
let template

const createBrand = async () => {
  template = {
    name: 'fake-template-brand-trigger-test',
    variant: 'Template40',
    inputs: ['listing', 'user'],
    template_type: 'JustSold',
    medium: 'Email',
    html: '<div>fakeTemplate</div>',
    mjml: false,
  }
  const user = await UserHelper.TestUser()
  return BrandHelper.create({
    roles: {
      Admin: [user.id],
    },
    checklists: [],
    contexts: [],
    templates: [template],
  })
}

async function setup() {
  const user = await UserHelper.TestUser()
  brand = await createBrand()

  Context.set({ user, brand })

  await handleJobs()
}

async function createContact() {
  const user = await UserHelper.TestUser()

  const [id] = await Contact.create(
    [
      {
        user: user.id,
        attributes: attributes({
          first_name: 'John',
          last_name: 'Doe',
          email: 'john@doe.com',
          birthday: BIRTHDAY.unix(),
        }),
      },
    ],
    user.id,
    brand.id
  )

  await handleJobs()

  return Contact.get(id)
}

async function updateNonExistingBrandTrigger() {
  const result = await BrandTrigger.updateTriggersHandler('nonExistingBrandTriggerId')
  expect(result).to.be.undefined
}

async function createBrandTrigger() {
  const user = await UserHelper.TestUser()
  await createContact()
  // @ts-ignore
  const brandTemplates = await BrandTemplate.getForBrands({ brands: [brand.id] })
  const bt = {
    template: brandTemplates[0].id,
    brand: brand.id,
    created_by: user.id,
    event_type: 'birthday',
    wait_for: -86400,
    subject: 'birthday mail',
    id: 'fakeBrandTriggerForTest',
    type: 'birthday',
    created_at: Number(new Date()),
    updated_at: 0,
  }
  const brandTriggerId = await db.insert('trigger/brand_trigger/upsert', [
    bt.brand,
    bt.created_by,
    bt.template,
    bt.template_instance,
    bt.event_type,
    bt.wait_for,
    bt.subject,
  ])

  await BrandTrigger.updateTriggersHandler(brandTriggerId, true)
  const brandTrigger = await BrandTrigger.get(brandTriggerId)
  expect(brandTrigger.id).to.be.eql(brandTriggerId)
  const triggers = await Trigger.filter({
    brand: brand.id,
    event_type: 'birthday',
  })
  expect(triggers.length).to.be.eql(1)
  const campaigns = await Campaign.getByBrand(brand.id, { havingDueAt: null })
  expect(campaigns.length).to.eql(1)
}

describe('Trigger', () => {
  createContext()
  beforeEach(setup)

  it('should return undefined', updateNonExistingBrandTrigger)
  it('should create a brand trigger successfully', createBrandTrigger)

  // it('should create a trigger successfully', createTrigger)
  // it('should identify due tiggers', testDueTrigger)
  // it('should execute triggers 3 days before due', testExecuteTrigger)
  // it('should delete associated campaign if not executed yet', testDeleteExecutedTrigger)
  // it('should create another trigger after recurring trigger is executed', testExecuteRecurringTrigger)
})
