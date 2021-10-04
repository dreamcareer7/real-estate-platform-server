const moment = require('moment-timezone')
const { expect } = require('chai')

const ContactAttribute = require('../../../../lib/models/Contact/attribute/index')

const BrandTrigger = {
  ...require('../../../../lib/models/Trigger/brand_trigger/workers'), 
  ...require('../../../../lib/models/Trigger/brand_trigger/create'), 
  ...require('../../../../lib/models/Trigger/brand_trigger/get'),
}
const Campaign = {
  ...require('../../../../lib/models/Email/campaign/get.js'),
  ...require('../../../../lib/models/Email/create.js'),
}
const Contact = {
  ...require('../../../../lib/models/Contact/manipulate'),
  ...require('../../../../lib/models/Contact/get'),
}
const Context = require('../../../../lib/models/Context')

const BrandHelper = require('../../brand/helper')
const { attributes } = require('../../contact/helper')
const UserHelper = require('../../user/helper')
const { createContext, handleJobs } = require('../../helper')
const BrandTemplate = require('../../../../lib/models/Template/brand/get')

const Trigger = {
  ...require('../../../../lib/models/Trigger/filter.js'),
  ...require('../../../../lib/models/Trigger/get'),
  ...require('../../../../lib/models/Trigger/create'),
  ...require('../../../../lib/models/Trigger/execute'),
}
  
const BIRTHDAY = moment.utc().add(3, 'days').startOf('day').add(-20, 'years')




let brand
const template = {
  name: 'fake-template-brand-trigger-test',
  variant: 'Template40',
  inputs: ['listing', 'user'],
  template_type: 'JustSold',
  medium: 'Email',
  html: '<div>fakeTemplate</div>',
  mjml: false,
}

const createBrand = async () => {
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
}

async function createUserAndContact(birthdayBool) {
  const user = await UserHelper.TestUser()

  const [id] = await Contact.create(
    [
      {
        user: user.id,
        attributes: attributes({
          first_name: 'John',
          last_name: 'Doe',
          email: 'john@doe.com',
          ...(birthdayBool ? { birthday: BIRTHDAY.unix() } : null),
        }),
      },
    ],
    user.id,
    brand.id
  )

  const contact = await Contact.get(id)
  return { user, contact }
}

describe('BrandTrigger/workers', () => {
  createContext()
  beforeEach(setup)
  
  context('.dateAttributesCreated()', () => {
    // lib/models/Trigger/brand_trigger/workers.js:229-232
    it('doesn\'t throw when brand trigger ID is missing', async () => {
      await BrandTrigger.dateAttributesCreated({brand: brand.id, attributes: []})
    })
  
    // lib/models/Trigger/brand_trigger/workers.js:229-232
    context('doesn\'t create campaign for...', () => {
      it('attributes having active trigger', async () => {
        const { user, contact } = await createUserAndContact(true)
        await handleJobs()
        // @ts-ignore
        const brandTemplates = await BrandTemplate.getForBrands({ brands: [brand.id] })
        const bt = {
          template: brandTemplates[0].id,
          brand: brand.id,
          created_by: user.id,
          event_type: 'birthday',
          wait_for: -86400,
          subject: 'birthday mail',
        }
        await BrandTrigger.upsert(bt, true)
        await handleJobs()
        const campaignsThen = await Campaign.getByBrand(brand.id, { havingDueAt: null })
        await BrandTrigger.dateAttributesCreated({
          brand: brand.id, attributes: [{
            attribute_type: 'birthday', 
            contact: contact.id, 
            created_by: user.id, 
            date: BIRTHDAY.add(6, 'days').unix()
          }]
        })
        await handleJobs()
        const campaignsNow = await Campaign.getByBrand(brand.id, { havingDueAt: null })
        expect(campaignsNow).to.eql(campaignsThen)
      })
  
      it('attribute types having no related brand trigger', async () => {
        const { user, contact } = await createUserAndContact(false)
        await handleJobs()
        // @ts-ignore
        const brandTemplates = await BrandTemplate.getForBrands({ brands: [brand.id] })
        const bt = {
          template: brandTemplates[0].id,
          brand: brand.id,
          created_by: user.id,
          event_type: 'birthday',
          wait_for: -86400,
          subject: 'birthday mail',
        }
        await BrandTrigger.upsert(bt, true)
        await handleJobs()
        await BrandTrigger.dateAttributesCreated({
          brand: brand.id, attributes: [{
            attribute_type: 'wedding anniversary', 
            contact: contact.id, 
            created_by: user.id, 
            date: BIRTHDAY.unix()
          }]
        })
        await handleJobs()
        const campaigns = await Campaign.getByBrand(brand.id, { havingDueAt: null })
        expect(campaigns.length).to.be.eql(0)
      })
    })
  
    // lib/models/Trigger/brand_trigger/workers.js:243-246
    it('creates triggers and campaigns for contacts having desired attribute type', async() => {
      const { user, contact } = await createUserAndContact(false)
      await handleJobs()
      const attributes = [{
        attribute_type: 'birthday', 
        contact: contact.id, 
        created_by: user.id, 
        date: BIRTHDAY.unix()
      }]
      // @ts-ignore
      const brandTemplates = await BrandTemplate.getForBrands({ brands: [brand.id] })
      const bt = {
        template: brandTemplates[0].id,
        brand: brand.id,
        created_by: user.id,
        event_type: 'birthday',
        wait_for: -86400,
        subject: 'birthday mail',
      }
      await BrandTrigger.upsert(bt, true)
      await handleJobs()
      await ContactAttribute.create(attributes, user.id, brand.id)
      await handleJobs()
      const campaigns = await Campaign.getByBrand(brand.id, { havingDueAt: null })
      const triggerIds = await Trigger.filter({
        deleted_at: null,
        brand: brand.id,
        event_type: ['birthday'],
      })
      expect(campaigns.length).to.eql(1)
      const trigger = await Trigger.get(triggerIds[0])
      expect(trigger.deleted_at).to.be.null
    })
  })
})  