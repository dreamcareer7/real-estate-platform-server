const { strict: assert } = require('assert')
const { promisify } = require('util')
const render = require('../Template/thumbnail/render')
const AttachedFile = require('../AttachedFile')
const Template = require('../Template/get')
const User = require('../User/get')
const Brand = {
  ...require('../Brand/get'),
  ...require('../Brand/constants'),
}
const { asyncMap } = require('../../utils/belt')

/**
 * @param {object} options
 * @param {UUID} options.templateId
 * @param {IContact[]} options.contacts
 * @param {UUID} options.brandId
 * @param {UUID} options.userId
 * @returns {Promise<string[]>}
 */
async function renderTemplate ({ templateId, contacts, brandId, userId }) {
  if (!contacts.length) { return [] }
  
  const template = await Template.get(templateId)
  const user = await User.get(userId)

  const parents = await Brand.getParents(brandId).then(Brand.getAll)
  const brokerageBrand = parents.find(p => p.brand_type === Brand.BROKERAGE)
  assert(brokerageBrand, `brokerage brand not found for brand ${brandId}`)

  const download = promisify(/** @type {any} */(AttachedFile).download)
  const html = (await download(template.file)).toString()

  const renderUsing = (/** @type {any} */ variables) => render({
    html,
    template,
    brand: brokerageBrand,
    variables,
    palette: undefined,
  })

  if (!template.inputs.includes('contact')) {
    const rendered = await renderUsing({ user })
    return contacts.map(() => rendered)
  }

  return asyncMap(contacts, contact => renderUsing({ user, contact }))
}

module.exports = { renderTemplate }
