'use strict'

const async = require('async')
const db = require('../lib/utils/db')

const create = 'CREATE MATERIALIZED VIEW listings_filters AS SELECT \
  listings.id as id, \
  listings.status as status, \
  listings.price as price, \
  listings.matrix_unique_id as matrix_unique_id, \
  listings.close_date as close_date, \
  properties.square_meters, \
  properties.bedroom_count, \
  properties.half_bathroom_count, \
  properties.full_bathroom_count, \
  properties.property_type, \
  properties.property_subtype, \
  properties.year_built, \
  properties.pool_yn, \
  properties.lot_square_meters, \
  addresses.location, \
  ( \
    addresses.title || \' \' || \
    addresses.subtitle || \' \' || \
    addresses.street_number || \' \' || \
    addresses.street_name || \' \' || \
    addresses.city || \' \' || \
    addresses.state || \' \' || \
    addresses.state_code || \' \' || \
    addresses.street_suffix || \' \' || \
    addresses.country::text || \' \' || \
    addresses.country_code::text || \' \' || \
    addresses.street_dir_prefix || \' \' || \
    addresses.street_dir_suffix || \' \' || \
    listings.mls_number \
  ) as address \
FROM listings \
JOIN \
  properties ON listings.property_id = properties.id \
JOIN \
  addresses  ON properties.address_id = addresses.id'

const up = [
  'BEGIN',
  'DROP MATERIALIZED VIEW listings_filters',
  create,
  'CREATE UNIQUE INDEX listings_filters_id ON listings_filters(id)',
  'CREATE INDEX listings_filters_location ON listings_filters USING GIST (location)',
  'CREATE INDEX listings_filters_status ON listings_filters (status)',
  'CREATE INDEX listings_filters_address ON listings_filters USING GIN (to_tsvector(\'english\', address))',
  'COMMIT'
]

const down = [
  'DROP MATERIALIZED VIEW listings_filters'
]

const runAll = (sqls, next) => {
  db.conn((err, client) => {
    if (err)
      return next(err)

    async.eachSeries(sqls, client.query.bind(client), err => {
      release()
      next(err)
    })
  })
}

const run = (queries) => {
  return (next) => {
    runAll(queries, next)
  }
}

exports.up = run(up)
exports.down = run(down)
