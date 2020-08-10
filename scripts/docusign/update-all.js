#!/usr/bin/env node

require('../connection.js')
const Envelope = require('../../lib/models/Envelope')

const promisify = require('../../lib/utils/promisify')
const db = require('../../lib/utils/db')
const Context = require('../../lib/models/Context')


const save = async () => {
  await db.executeSql.promise('BEGIN')

  const res = await db.executeSql.promise('SELECT id FROM envelopes')
  const ids = res.rows.map(r => r.id)

  const envelopes = await promisify(Envelope.getAll)(ids)

  let i = 0

  for(const envelope of envelopes) {
    console.log('Saving', ++i, envelopes.length, envelope.id)

    try {
      await promisify(Envelope.update)(envelope.id)
    } catch (e) {
      Context.log('Error'.red, e.message)
      continue
    }

    Context.log('Success'.green)
  }

  await db.executeSql.promise('COMMIT')

  process.exit()
}

save()
  .catch(e => {
    console.log(e)
    process.exit()
  })
