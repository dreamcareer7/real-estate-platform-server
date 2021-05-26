#!/usr/bin/env node

const request = require('request-promise-native')
const moment = require('moment')
const _ = require('lodash')

const db = require('../../../lib/utils/db')
const promisify = require('../../../lib/utils/promisify')

const MLSJob = require('../../../lib/models/MLSJob')
const Context = require('../../../lib/models/Context')
const Contact = require('../../../lib/models/Contact/manipulate')
const ContactAttribute = require('../../../lib/models/Contact/attribute/get')

const createContext = require('../../workers/create-context')

const map = require('./map')

const config = {
  url: 'https://applicationservice.crm.gabriels.net/api/contacts/8356484'
}

const SAVE = `INSERT INTO de.contacts (id, object)
 SELECT (ar->>'contactId')::int as id, ar FROM json_array_elements($1) ar
 ON CONFLICT (id) DO UPDATE SET object = EXCLUDED.object
 RETURNING *`

const FIND_AGENTS = `SELECT de.users.user, LOWER(de.users.object->>'email') as email, de.agents_offices.brand FROM de.users
  JOIN de.agents_offices ON de.users.username = de.agents_offices.username
  WHERE de.users.object->>'email' IN(
    SELECT LOWER(UNNEST($1::text[]))
  )`

const SET_IDS = `
UPDATE de.contacts
SET contact = pairs.contact
FROM json_populate_recordset(NULL::de.contacts, $1) pairs
WHERE de.contacts.id = pairs.id`

const timeout = ms => {
  return new Promise(resolve => {
    setTimeout(resolve, ms)
  })
}

const ExternalAuthenticationToken = 'YwBc4k2U5P75bdQreeGxqv6P'

const groupByAgent = async contacts => {
  const emails = _.chain(contacts).map('object.agentEmail').uniq().filter(Boolean).value()
  const { rows } = await db.executeSql.promise(FIND_AGENTS, [emails])
  const grouped = _.chain(contacts).filter('object.agentEmail').groupBy('object.agentEmail').value()

  return { grouped, agents: _.keyBy(rows, 'email') }
}

const insertContacts = async contacts => {
  const { grouped, agents } = await groupByAgent(contacts)

  const pairs = []

  for(const email of Object.keys(grouped)) {
    if (!agents[email])
      continue

    const { brand, user } = agents[email]

    const agent_contacts = grouped[email]

    const mapped = agent_contacts.map(c => map(c)).map(contact => {
      return { ...contact, user }
    })

    const created = await Contact.create(mapped, user, brand, 'lts_lead', {
      activity: false
    })

    for(const i in agent_contacts)
      pairs.push({
        id: agent_contacts[i].id, // Studio ID
        contact: created[i]       // Rechat ID
      })
  }

  await db.executeSql.promise(SET_IDS, [JSON.stringify(pairs)])
}

const updateContacts = async contacts => {
  const { grouped, agents } = await groupByAgent(contacts)

  const attributes = await ContactAttribute.getForContacts(contacts.map(c => c.contact))
  const indexed_attributes = _.groupBy(attributes, 'contact')

  for(const email of Object.keys(grouped)) {
    if (!agents[email])
      continue

    const { brand, user } = agents[email]

    const agent_contacts = grouped[email]

    const mapped = agent_contacts.map(contact => {
      const attributes = indexed_attributes[contact.contact]

      const mapped = map(contact, attributes)

      return {
        ...mapped,
        id: contact.contact,
        user
      }
    })

    await Contact.update(mapped, user, brand, 'lts_lead')
  }
}

const save = async contacts => {
  const { rows } = await db.executeSql.promise(SAVE, [ JSON.stringify(contacts) ])

  const updated = rows.filter(record => Boolean(record.contact))
  const inserted = rows.filter(record => !record.contact)

  return { updated, inserted }
}

const sync = async opts => {
  const res = await request(opts)
  const { Data } = res

  const { inserted, updated } = await save(Data)

  await insertContacts(inserted)
  await updateContacts(updated)

  return res
}

const paginate = async({
  ScrollId
}) => {
  const opts = {
    url: config.url,
    qs: {
      ExternalAuthenticationToken,
      ScrollId
    },
    json: true
  }

  const res = await sync(opts)
  return res
}

const dateSync = async ({
  StartDate,
  EndDate,
  From,
  Size
}) => {

  const opts = {
    url: config.url,
    qs: {
      ExternalAuthenticationToken,
      StartDate,
      EndDate,
      From,
      Size
    },
    json: true
  }

  let results = 0

  Context.log('Date', StartDate, EndDate, From, Size)

  const res = await sync(opts)
  results += res.Data.length

  let lastPage = res

  while(lastPage.Data.length >= Size) {
    await timeout(2000)
    Context.log('Pagination', results, '/', lastPage.TotalContacts)
    lastPage = await paginate({
      ScrollId: lastPage.ScrollId
    })

    results += lastPage.Data.length
  }

  return results
}

const run = async() => {
  const { commit, run } = await createContext()

  const name = 'de_contacts'
  const step = 20
  const limit = 50

  await run(async () => {
    const last = await promisify(MLSJob.getLastRun)(name) || {
      query: '2012-12-29',
      offset: 0,
      results: 0
    }

    const format = 'YYYY-MM-DD'

    const StartDate = moment(last.query).format(format)
    const EndDate = moment(last.query).add(step, 'day').format(format)
    const From = 0

    const opts = {
      StartDate,
      EndDate,
      Size: limit,
      From
    }

    const results = await dateSync(opts)

    Context.log('Synced', StartDate, EndDate, results, 'results')

    await promisify(MLSJob.insert)({
      name,
      query: EndDate,
      offset: From,
      results
    })

    await commit()
  })
}

run()
  .then(() => {
    process.exit()
  })
  .catch(e => {
    Context.log(e)
    process.exit()
  })