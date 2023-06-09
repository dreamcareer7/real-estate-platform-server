#!/usr/bin/env node

// require('../../connection')
// reqduire('../../../lib/utils/db')
// require('../../../lib/models/index')

const request = require('request-promise-native')
const _ = require('lodash')
const fs = require('fs')

const MLSJob = require('../../../lib/models/MLSJob')
const Context = require('../../../lib/models/Context')

const syncRegions = require('./sync-regions')
const syncOffices = require('./sync-offices')
const syncAgents = require('./sync-agents')
const syncUsers = require('./sync-users')
const getRoot = require('./get-root')

const promisify = require('../../../lib/utils/promisify')
const createContext = require('../../workers/utils/create-context')

const attachModelEventListeners = require('../../../lib/models/Context/events')

const config = {
  url: 'https://webapi.elliman.com/token?username=emil@rechat.com&password=Skiing4-Monetize-Excitable'
}

const getToken = async () => {
  const { token } = await request({
    uri: config.url,
    json: true
  })

  return token
}

const mlses = {
  LIMO: 'REBNY',
  ONEKEY: 'ONEKEY',
  HGMLS: 'ONEKEY',
  SAND: 'SDMLS',
  GFLR: 'RAPB',
  MFR: 'STELLAR',
  
}

const mlsName = name => {
  return mlses[name.toUpperCase()] ?? name
}

const getData = async token => {
  const users = await request({
    uri: 'https://webapi.elliman.com/api/rechat/users',
    headers: {
      Authorization: `Bearer ${token}`
    },
    json: true
  })

  users.forEach(user => {
    user.mlses = [
      {mls: mlsName(user.mlsSystem), id: user.rbnyAgentId ?? user.id}
    ]

    user.additionalIds?.forEach(additional => {
      user.mlses.push({
        mls: mlsName(additional.mlsSystem),
        id: additional.id
      })

      user.offices.push(additional.office)
    })

    return user
  })

  const offices = _.chain(users)
    .map('offices')
    .flatten()
    .uniqBy('id')
    .value()

  const regions = _.chain(offices)
    .map('region')
    .sort()
    .uniq()
    .value()

  fs.writeFileSync('/tmp/users.json', JSON.stringify(users, 4, 4))

  return { users, regions, offices }
}


const sync = async () => {
  /*
   * We save the job first, so if there's an error, it wouldnt retry immediately.
   * Otherwise in case of failure this may fall into a retry loop forever which can be
   * really expensive on db.
   */
  await promisify(MLSJob.insert)({
    name: 'de_users'
  })

  const token = await getToken()
  const { users, regions, offices } = await getData(token)

  try {
    await getRoot() // Ensure root exists
    await syncRegions(regions)
    await syncUsers(users)
    await syncOffices(offices)
    await syncAgents(users)
  } catch(e) {
    Context.log('Error syncing users', e)
  }
}

const run = async() => {
  attachModelEventListeners()
  const { commit, run } = await createContext()

  await run(async () => {
    await sync()
    await commit()
  })
}

run()
  .then(() => {
    process.exit()
  })
  .catch(e => {
    console.log(e)
    process.exit()
  })
