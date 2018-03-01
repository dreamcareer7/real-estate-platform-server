'use strict'

const async = require('async')

const db = require('../lib/utils/db')

const sqls = [
  'DROP TABLE IF EXISTS mam_config',
  'DROP TABLE IF EXISTS mam_message',
  'DROP TABLE IF EXISTS mam_message',
  'DROP TABLE IF EXISTS mam_server_user',
  'DROP TABLE IF EXISTS mam_user',
  'DROP TABLE IF EXISTS mam_muc_message',
  'DROP TABLE IF EXISTS privacy_default_list',
  'DROP TABLE IF EXISTS privacy_list_data',
  'DROP TABLE IF EXISTS privacy_list',
  'DROP TABLE IF EXISTS offline_message',
  'DROP TABLE IF EXISTS private_storage',
  'DROP TABLE IF EXISTS roster_version',
  'DROP TABLE IF EXISTS rostergroups',
  'DROP TABLE IF EXISTS rosterusers',
  'DROP TABLE IF EXISTS vcard',
  'DROP TABLE IF EXISTS vcard_search',
  'DROP TABLE IF EXISTS logs',
  'DROP TABLE IF EXISTS tokens',
  'DROP TABLE IF EXISTS events',
  'DROP TABLE IF EXISTS last',
  'ALTER TABLE users DROP CONSTRAINT IF EXISTS users_agency_id_fkey',
  'ALTER TABLE users DROP IF EXISTS agency_id',
  'DROP TABLE IF EXISTS agencies',
  'DROP EXTENSION IF EXISTS postgis_tiger_geocoder',
  'DROP EXTENSION IF EXISTS postgis_topology',
  'DROP EXTENSION IF EXISTS fuzzystrmatch',
  'DROP SCHEMA IF EXISTS shortlisted CASCADE',
  'DROP SCHEMA IF EXISTS tiger_data CASCADE',
  'DROP SCHEMA IF EXISTS tiger CASCADE'
]

const runAll = (next) => {
  db.conn((err, client) => {
    if (err)
      return next(err)

    async.eachSeries(sqls, client.query.bind(client), err => {
      client.release()
      next(err)
    })
  })
}

exports.up = runAll

exports.down = () => {} // Hard to downgrade this change.
