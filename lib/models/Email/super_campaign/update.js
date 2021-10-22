const { strict: assert } = require('assert')
const difference = require('lodash/difference')

const db = require('../../../utils/db')
const { get } = require('./get')
const { updateEligibility } = require('./eligibility')

/**
 * @param {UUID} super_campaign
 * @param {Omit<import('./types').SuperCampaignApiInput, 'eligibility' | 'tags'>} data 
 */
function update(super_campaign, data) {
  return db.update('email/super_campaign/update', [
    super_campaign,
    data.subject,
    data.description,
    data.due_at,
    data.template_instance
  ])
}

/**
 * @param {UUID} super_campaign
 * @param {string[]} tags
 */
async function updateTags(super_campaign, tags) {
  await db.update('email/super_campaign/update_tags', [
    super_campaign,
    tags
  ])

  // TODO: update enrollments
}

/**
 * @param {UUID} super_campaign 
 * @param {UUID[]} brands 
 */
async function updateBrands(super_campaign, brands) {
  const { eligible_brands } = await get(super_campaign)

  const to_delete = difference(eligible_brands, brands)
  const to_insert = difference(brands, eligible_brands)

  return updateEligibility(
    super_campaign,
    to_delete,
    to_insert,
  )
}

/** @param {UUID} superCampaignId */
async function markAsExecuted (superCampaignId) {
  const affectedRows = await db.update(
    'email/super_campaign/mark_as_executed',
    [superCampaignId]
  )

  assert(affectedRows === 1, `Super campaign ${superCampaignId} is not exist or already executed`)
}

module.exports = {
  update,
  updateTags,
  updateBrands,
  markAsExecuted,
}