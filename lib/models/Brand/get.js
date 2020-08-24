const url = require('url')
const Orm = require('../Orm/context')
const db = require('../../utils/db')
const config = require('../../config')
const Context = require('../Context')

const get = async id => {
  const brands = await getAll([id])

  if (brands.length < 1)
    throw Error.ResourceNotFound(`Brand ${id} not found`)

  return brands[0]
}

const getAll = async ids => {
  const associations = Orm.getEnabledAssociations()

  const res = await db.query.promise('brand/get', [ids, associations])
  const brands = res.rows

  brands.forEach(brand => {
    const hostname = (brand.hostnames && brand.hostnames.length) ? brand.hostnames[0] : config.webapp.hostname

    brand.base_url = url.format({
      protocol: config.webapp.protocol,
      hostname: hostname,
    })
  })

  return brands
}

const getCurrent = () => {
  return Context.get('brand')
}

const getByParent = async parent => {
  const res = await db.query.promise('brand/by_parent', [parent])
  return getAll(res.rows.map(r => r.id))
}

const getParents = async brand_id => {
  const res = await db.query.promise('brand/get_parents', [brand_id])
  return res.rows.map(r => r.parent)
}

module.exports = {
  get,
  getAll,
  getCurrent,
  getByParent,
  getParents
}
