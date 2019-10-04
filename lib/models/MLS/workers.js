const config = require('../../config')
const promisify = require('../../utils/promisify')
const { peanar } = require('../../utils/peanar')

const Agent = require('../Agent')
const Photo = require('../Photo')
const Office = require('../Office')
const OpenHouse = require('../OpenHouse')
const PropertyRoom = require('../PropertyRoom')
const PropertyUnit = require('../PropertyUnit')
const { Listing } = require('../Listing')

/** @typedef {'HAR' | 'NTREIS' | 'CRMLS'} TMlsName */

/** @type {TMlsName[]} */
const enabled_mls = config.mls.enabled || []

function filter_mls(fn) {
  return data => {
    if (enabled_mls.includes(data.processed.mls)) {
      return fn(data)
    }
  }
}

async function mls_unit(data) {
  return PropertyUnit.create(data.processed)
}

async function mls_openhouse(data) {
  return OpenHouse.create(data.processed)
}

async function mls_room(data) {
  return PropertyRoom.create(data.processed)
}

async function mls_agent(data) {
  return Agent.create(data.processed)
}

async function mls_office(data) {
  return Office.create(data.processed)
}

async function mls_photo(data) {
  return Photo.create({
    ...data.processed,
    revision: data.revision
  })
}

async function mls_listing(data) {
  if (!enabled_mls.includes(data.processed.listing.mls)) return

  return promisify(Listing.create)({
    ...data.processed,
    revision: data.revision
  })
}

async function mls_validate_listing_photos(data) {
  if (!enabled_mls.includes(data.mls)) return

  return Photo.deleteMissing(data.listing, data.mls, data.present)
}

function jobDef(overrides) {
  return Object.assign(
    {
      exchange: 'mls',
      max_retries: 1000,
      retry_delay: 10000,
      error_exchange: `${overrides.queue}.error`,
      retry_exchange: `${overrides.queue}.retry`
    },
    overrides
  )
}

module.exports = {
  mls_unit: peanar.job(jobDef({ handler: filter_mls(mls_unit), name: 'mls_unit', queue: 'MLS.Unit' })),
  mls_openhouse: peanar.job(
    jobDef({ handler: filter_mls(mls_openhouse), name: 'mls_openhouse', queue: 'MLS.OpenHouse' })
  ),
  mls_room: peanar.job(jobDef({ handler: filter_mls(mls_room), name: 'mls_room', queue: 'MLS.Room' })),
  mls_agent: peanar.job(jobDef({ handler: filter_mls(mls_agent), name: 'mls_agent', queue: 'MLS.Agent' })),
  mls_office: peanar.job(jobDef({ handler: filter_mls(mls_office), name: 'mls_office', queue: 'MLS.Office' })),
  mls_photo: peanar.job(jobDef({ handler: filter_mls(mls_photo), name: 'mls_photo', queue: 'MLS.Photo' })),
  mls_listing: peanar.job(jobDef({ handler: mls_listing, name: 'mls_listing', queue: 'MLS.Listing' })),
  mls_validate_listing_photos: peanar.job(
    jobDef({
      handler: mls_validate_listing_photos,
      name: 'mls_validate_listing_photos',
      queue: 'MLS.Listing.Photos.Validate'
    })
  )
}