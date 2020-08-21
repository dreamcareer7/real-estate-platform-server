const db = require('../../utils/db')
const Brand = require('./index')

const BrandHostname = {}

BrandHostname.addHostname = async ({brand, hostname, is_default}) => {
  await db.query.promise('brand/hostname/add', [
    brand,
    hostname,
    is_default
  ])

  return Brand.get(brand)
}

BrandHostname.removeHostname = async (brand, hostname) => {
  await db.query.promise('brand/hostname/remove', [
    brand,
    hostname
  ])

  return Brand.get(brand)
}

BrandHostname.getByHostname = async hostname => {
  const res = await db.query.promise('brand/hostname/get', [hostname])

  if (res.rows.length < 1)
    throw new Error.ResourceNotFound('Brand ' + hostname + ' not found')

  return Brand.get(res.rows[0].brand)
}

module.exports = BrandHostname
