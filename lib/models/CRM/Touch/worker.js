const _ = require('lodash')
const db = require('../../../utils/db')
const sql = require('../../../utils/sql')
const { peanar } = require('../../../utils/peanar')

const Context = require('../../Context')
const CrmAssociation = require('../Association')
const Contact = require('../../Contact')
const EmailCampaignEmail = require('../../Email/campaign/email')
const GoogleThread = require('../../Google/thread')
const MicrosoftThread = require('../../Microsoft/thread')
const ListMember = require('../../Contact/list_members')
const Socket = require('../../Socket')

/**
 * Main data manipulation function
 * @param {{ contacts: UUID[]; brand?: UUID; }} job 
 */
async function update_touch_times_for_contacts({ contacts, brand }) {
  await db.selectIds('crm/touch/update_touch_times_for_contacts', [
    contacts
  ])

  if (!brand) {
    /** @type {{ brand: UUID; contacts: UUID[] }[]} */
    const contact_brands = await sql.select(`
      SELECT
        brand, array_agg(id) AS contacts
      FROM
        contacts
      WHERE
        id = ANY($1::uuid[])
      GROUP BY
        brand
    `, [contacts])
  
    for (const item of contact_brands) {
      Socket.send(
        'contact:touch',
        item.brand,
        [{ contacts: item.contacts }],
    
        err => {
          if (err) Context.error('>>> (Socket) Error sending contact:touch socket event.', err)
        }
      )
    }
  } else {
    Socket.send(
      'contact:touch',
      brand,
      [{ contacts }],
  
      err => {
        if (err) Context.error('>>> (Socket) Error sending contact:touch socket event.', err)
      }
    )
  }
}

async function update_touch_times_for_task({ task_id, brand }) {
  const contacts = await sql.selectIds(`
    SELECT DISTINCT
      contact AS id
    FROM
      crm_associations
    WHERE
      deleted_at IS NULL
      AND association_type = 'contact'
      AND crm_task = $1::uuid
  `, [
    task_id
  ])

  return update_touch_times_for_contacts({ contacts, brand })
}

async function update_touch_times_for_contact_associations_per_user(user_id, ids) {
  const original_user = Context.get('user')
  Context.set({ user: { id: user_id } })
  const associations = await CrmAssociation.getAll(ids)
  Context.set({ user: original_user })

  const groups = _.groupBy(associations, 'brand')

  for (const brand in groups) {
    const contacts = groups[brand].filter(a => a.contact && a.crm_task).map(a => a.contact)
    await update_touch_times_for_contacts({ contacts, brand })
  }
}

async function update_touch_times_for_contact_associations({ associations }) {
  const by_user = _.groupBy(associations, 'created_by')

  for (const user in by_user) {
    await update_touch_times_for_contact_associations_per_user(user, by_user[user].map(a => a.id))
  }
}

async function update_next_touch_for_list_members({ list_id }) {
  const membership_records = await ListMember.findByListId(list_id)
  const contacts = _.uniq(membership_records.map(mr => mr.contact))

  const { brand } = await sql.selectOne(
    'SELECT brand FROM crm_lists WHERE id = $1::uuid',
    [ list_id ]
  )

  await update_touch_times_for_contacts({ contacts, brand })
}

async function update_touch_times_for_tag({ tag, brand }) {
  const { ids } = await Contact.fastFilter(brand, [{
    attribute_type: 'tag',
    value: tag
  }])

  await update_touch_times_for_contacts({ contacts: ids, brand })
}

async function update_touch_times_for_google_threads({ threads: thread_keys }) {
  const all_threads = await GoogleThread.getAll(thread_keys)
  const threads_by_brand = _.groupBy(all_threads, 'brand')

  for (const [brand, threads] of Object.entries(threads_by_brand)) {
    const { ids } = await Contact.fastFilter(brand, [{
      attribute_type: 'email',
      operator: 'any',
      value: _.uniq(threads.flatMap(t => t.recipients))
    }])

    await update_touch_times_for_contacts({ contacts: ids, brand })
  }
}

async function update_touch_times_for_microsoft_threads({ threads: thread_keys }) {
  const all_threads = await MicrosoftThread.getAll(thread_keys)
  const threads_by_brand = _.groupBy(all_threads, 'brand')

  for (const [brand, threads] of Object.entries(threads_by_brand)) {
    const { ids } = await Contact.fastFilter(brand, [{
      attribute_type: 'email',
      operator: 'any',
      value: _.uniq(threads.flatMap(t => t.recipients))
    }])

    await update_touch_times_for_contacts({ contacts: ids, brand })
  }
}

/**
 * @param {{ brand: UUID; emails: string[]; }} param0 
 */
async function update_touch_times_for_emails({ brand, emails }) {
  const campaign_emails = await EmailCampaignEmail.getAll(emails)

  const { ids } = await Contact.fastFilter(brand, [{
    attribute_type: 'email',
    operator: 'any',
    value: campaign_emails.map(e => e.email_address)
  }])

  await update_touch_times_for_contacts({ contacts: ids, brand })
}

function job(opts) {
  return peanar.job({
    ...opts,
    queue: 'touches',
    exchange: 'touches',
    error_exchange: 'touches.error',
    retry_exchange: 'touches.retry',
    max_retries: 10,
    retry_delay: 2
  })
}

module.exports = {
  update_touch_times_for_task: job({
    handler: update_touch_times_for_task,
    name: 'update_touch_times_for_task',
  }),

  update_touch_times_for_tag: job({
    handler: update_touch_times_for_tag,
    name: 'update_touch_times_for_tag',
  }),

  update_touch_times_for_contacts: job({
    handler: update_touch_times_for_contacts,
    name: 'update_touch_times_for_contacts',
  }),
  update_touch_times_for_contact_associations: job({
    handler: update_touch_times_for_contact_associations,
    name: 'update_touch_times_for_contact_associations',
  }),
  update_next_touch_for_list_members: job({
    handler: update_next_touch_for_list_members,
    name: 'update_next_touch_for_list_members',
  }),

  update_touch_times_for_emails: job({
    handler: update_touch_times_for_emails,
    name: 'update_touch_times_for_emails',
  }),
  update_touch_times_for_google_threads: job({
    handler: update_touch_times_for_google_threads,
    name: 'update_touch_times_for_google_threads',
  }),
  update_touch_times_for_microsoft_threads: job({
    handler: update_touch_times_for_microsoft_threads,
    name: 'update_touch_times_for_microsoft_threads',
  })
}
