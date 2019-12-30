const format = require('util').format
const db = require('../../../utils/db')
const expect = require('../../../utils/validator').expect
const { peanar } = require('../../../utils/peanar')

const Contact = require('../index')
const Slack = require('../../Slack')
const User = require('../../User')

const { sendFailureSocketEvent, sendSuccessSocketEvent } = require('./socket')

const SOCKET_EVENT = 'contact:import'

/**
 * @param {IContactDuplicateClusterInput[]} clusters
 * @param {UUID} user_id
 * @param {UUID} brand_id
 * @this {import('peanar/dist/job').default}
 */
async function merge(clusters, user_id, brand_id) {
  expect(clusters).to.be.an('array')

  try {
    for (const cl of clusters) {
      await Contact.merge(cl.sub_contacts, cl.parent, user_id, brand_id)
    }

    await sendSlackSupportMessage(user_id, clusters.length)
    sendSuccessSocketEvent(SOCKET_EVENT, this.id, user_id)
  } catch (ex) {
    sendFailureSocketEvent(SOCKET_EVENT, this.id, user_id, ex)
  }
}

/**
 * @param {UUID} brand_id
 * @param {UUID[]} contact_ids
 */
async function add_vertices(brand_id, contact_ids) {
  await db.query.promise('contact/duplicate/add', [brand_id, contact_ids])
}

/**
 * @param {UUID} brand_id
 * @param {UUID[]} contact_ids
 */
async function update_edges(brand_id, contact_ids) {
  await db.query.promise('contact/duplicate/update', [brand_id, contact_ids])
}

/**
 * @param {UUID[]} contact_ids
 */
async function remove_vertices(contact_ids) {
  await db.query.promise('contact/duplicate/remove', [contact_ids])
}

/**
 * @param {UUID} user_id
 * @param {number} n_clusters
 */
async function sendSlackSupportMessage(user_id, n_clusters) {
  const user = await User.get(user_id)

  const text = format('<mailto:%s|%s> merged %d duplicate clusters', user.email, user.display_name, n_clusters)

  Slack.send({
    channel: '6-support',
    text: text,
    emoji: ':busts_in_silhouette:'
  })
}

module.exports = {
  merge: peanar.job({
    handler: merge,
    exchange: 'contacts',
    queue: 'contact_duplicates',
    error_exchange: 'contact_duplicates.error'
  }),
  add_vertices: peanar.job({
    handler: add_vertices,
    exchange: 'contacts',
    queue: 'contact_duplicates',
    error_exchange: 'contact_duplicates.error'
  }),
  update_edges: peanar.job({
    handler: update_edges,
    exchange: 'contacts',
    queue: 'contact_duplicates',
    error_exchange: 'contact_duplicates.error'
  }),
  remove_vertices: peanar.job({
    handler: remove_vertices,
    exchange: 'contacts',
    queue: 'contact_duplicates',
    error_exchange: 'contact_duplicates.error'
  })
}
