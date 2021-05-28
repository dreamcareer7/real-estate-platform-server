const _ = require('lodash')

const { expect } = require('../../utils/validator')

const Slack = require('../../models/Slack')
const Brand = require('../../models/Brand')
const Contact = require('../../models/Contact')

const {
  getMatchingIds,
  getCurrentBrand,
  _getFilterFromRequest,
  limitAccess,
} = require('./common')
const { workerize, registerWorker } = require('./worker')

registerWorker(doUpdateContacts)
registerWorker(doDeleteContacts)

async function fastFilter(req, res) {
  const filter_res = await getMatchingIds(req, { limit: 50 })
  const rows = await Contact.getAll(Array.from(filter_res.ids))

  if (rows.length === 0) {
    res.collection([])
  } else {
    // @ts-ignore
    rows[0].total = filter_res.total

    await res.collection(rows)
  }
}

async function addContacts(req, res) {
  if (!Array.isArray(req.body.contacts)) {
    throw Error.Validation('Contacts should be an array.')
  }

  if (req.body.hasOwnProperty('options')) {
    throw Error.BadRequest(
      'options is deprecated and will be removed. Please send options as query arguments.'
    )
  }

  /** @type {UUID} */
  const user_id = req.user.id

  /** @type {UUID} */
  const brand_id = getCurrentBrand()

  /** @type {IContact[]} */
  const contacts = req.body.contacts || []

  /** @type {IAddContactOptions} */
  const options = _(req.query)
    .pick(['get', 'activity', 'relax'])
    .transform((res, value, key) => {
      res[key] = value === 'true'
    }, {})
    .value()

  if (options.relax !== true) {
    for (let i = 0; i < contacts.length; i++) {
      const owner = contacts[i].user
      if (!owner || owner.length !== 36) {
        throw Error.Validation(`Contact #${i} doesn't have a "user" specified.`)
      }

      if (!Array.isArray(contacts[i].attributes)) {
        throw Error.Validation(`Contact #${i} doesn't have a required minimum of one attribute.`)
      }
    }
  }

  const owners = _.uniq(contacts.map((c) => c.user).filter((x) => x))

  for (const owner of owners) {
    await Brand.limitAccess({
      brand: brand_id,
      user: owner,
    })
  }

  try {
    const contact_ids = await Contact.create(contacts, user_id, brand_id, 'direct_request', options)

    if (options.get) {
      const contacts = await Contact.getAll(contact_ids)
      return res.collection(contacts)
    }

    const source_type = contacts[0].attributes.find((a) => a.attribute_type === 'source_type')
    if (source_type && source_type.text === 'ExplicitlyCreated') {
      const n_contacts = contact_ids.length > 0 ? 'a contact' : `${contact_ids.length} contacts`

      Slack.send({
        channel: '6-support',
        text: `${`<mailto:${req.user.email}|${req.user.display_name}>`} created ${n_contacts} manually`,
        emoji: ':busts_in_silhouette:',
      })
    }

    return res.collection(contact_ids)
  } catch (ex) {
    res.error(ex)
  }
}

async function undelete(req, res) {
  const brand_id = getCurrentBrand()
  const { filter, query } = await _getFilterFromRequest(brand_id, req)

  if (!query.deleted_gte && !query.deleted_lte) {
    return res.error(Error.BadRequest('either deleted_gte or deleted_lte params must be present'))
  }

  const affected = await Contact.undelete(brand_id, filter, query)

  res.json({
    code: 'OK',
    info: {
      affected,
    },
  })
}

async function doUpdateContacts(req) {
  const user_id = req.user.id
  const brand_id = getCurrentBrand()

  let { ids: contact_ids } = await getMatchingIds(req)
  let contacts = []
  let owners = []

  if (req.body.contacts) {
    contacts = req.body.contacts
    expect(contacts).to.be.an('array')
    contact_ids = contacts.map((c) => c.id)
    await limitAccess('write', user_id, brand_id, contact_ids)

    owners = _.uniq(contacts.map((c) => c.user).filter((x) => x))
    for (const owner of owners) {
      await Brand.limitAccess({
        brand: brand_id,
        user: owner,
      })
    }
  } else {
    expect(req.body.patch).to.have.any.keys('parked', 'user')
    contacts = contact_ids.map((id) => ({
      id,
      user: req.body.patch.user,
      parked: req.body.patch.parked,
    }))
    if (req.body.patch.user) {
      await Brand.limitAccess({
        brand: brand_id,
        user: req.body.patch.user,
      })
    }
  }

  await Contact.update(contacts, user_id, brand_id, 'direct_request')
}

async function updateContacts(req, res) {
  const user_id = req.user.id
  const brand_id = getCurrentBrand()

  let { ids: contact_ids } = await getMatchingIds(req)
  let contacts = []
  let owners = []

  if (req.body.contacts) {
    contacts = req.body.contacts
    expect(contacts).to.be.an('array')
    contact_ids = contacts.map((c) => c.id)
    await limitAccess('write', user_id, brand_id, contact_ids)

    owners = _.uniq(contacts.map((c) => c.user).filter((x) => x))
    for (const owner of owners) {
      await Brand.limitAccess({
        brand: brand_id,
        user: owner,
      })
    }
  } else {
    expect(req.body.patch).to.have.any.keys('parked', 'user')
    contacts = contact_ids.map((id) => ({
      id,
      user: req.body.patch.user,
      parked: req.body.patch.parked,
    }))
    if (req.body.patch.user) {
      await Brand.limitAccess({
        brand: brand_id,
        user: req.body.patch.user,
      })
    }
  }

  const affected_contacts_ids = await Contact.update(contacts, user_id, brand_id, 'direct_request')

  if (req.query.get === 'true') {
    const affected_contacts = await Contact.getAll(affected_contacts_ids, user_id)
    res.collection(affected_contacts)
  } else {
    res.status(204)
    res.end()
  }
}

async function doDeleteContacts(req) {
  const user = req.user.id
  const { ids } = await getMatchingIds(req)
  await Contact.delete(ids, user)
}

async function deleteContacts(req, res) {
  await workerize(doDeleteContacts)(req)
  res.status(204)
  res.end()
}

async function getContact(req, res) {
  const id = req.params.id
  expect(id).to.be.uuid

  const contact = await Contact.get(id)
  await res.model(contact)
}

async function deleteContact(req, res) {
  const id = req.params.id
  expect(id).to.be.uuid

  await Contact.delete([id], req.user.id)

  res.status(204)
  res.end()
}

async function updateContact(req, res) {
  const user_id = req.user.id
  const brand_id = getCurrentBrand()

  const id = req.params.id
  expect(id).to.be.uuid

  const owner = req.body.user

  if (owner) {
    expect(owner).to.be.uuid
  
    await Brand.limitAccess({
      brand: brand_id,
      user: owner
    })
  }

  await Contact.update([{
    ...req.body,
    id,
  }], user_id, brand_id, 'direct_request')

  const contact = await Contact.get(id)
  await res.model(contact)
}

module.exports = {
  fastFilter,
  addContacts,
  undelete,
  updateContacts,
  deleteContacts,
  getContact,
  updateContact,
  deleteContact
}
