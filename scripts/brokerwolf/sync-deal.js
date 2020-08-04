#!/usr/bin/env node

require('../connection.js')
const Deal = require('../../lib/models/Deal')
const promisify = require('../../lib/utils/promisify')

const sync = async () => {
  const deal = await promisify(Deal.get)(process.argv[2])
  await Deal.BrokerWolf.sync(deal)
  process.exit()
}

sync()
  .catch(e => {
    console.log(e)
    process.exit()
  })
