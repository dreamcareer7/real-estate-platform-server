const range = require('postgres-range')

const db = require('../../../utils/db')
const { get } = require('./get')
const { getShowingTitle } = require('./title')
const ShowingHub = require('../showinghub/events')

/**
 * @param {UUID} showing_id 
 * @param {string} title 
 * @param {boolean=} [emitToShowingHub=true]
 */
async function updateTitle(showing_id, title, emitToShowingHub = true) {
  const result = await db.update(
    'showing/showing/update_title', [showing_id, title]
  )

  if (emitToShowingHub) {
    await ShowingHub.emit.showingUpdated(showing_id)
  }
  
  return result
}

/**
 * @param {import('./types').ShowingInput} data 
 * @param {UUID} user 
 */
async function update(id, data, user) {
  const current = await get(id)

  if ((current.listing || current.deal) && data.address) {
    throw Error.Validation('Cannot change showing to hippocket mode.')
  }

  if (Array.isArray(data.availabilities)) {
    const availabilities = data.availabilities.map(a => ({
      ...a,
      availability: range.serialize(
        new range.Range(a.availability[0], a.availability[1], range.RANGE_LB_INC)
      ),
    }))

    await db.update('showing/availability/delete', [
      id
    ])
    await db.update('showing/availability/insert', [
      id,
      JSON.stringify(availabilities),
    ])
  }

  if (data.address) {
    const title = await getShowingTitle(data)
    await updateTitle(id, title, false)
  }

  const result = await db.update('showing/showing/update', [
    /*  $1 */ id,
    /*  $2 */ user,
    /*  $3 */ data.start_date,
    /*  $4 */ data.end_date,
    /*  $5 */ data.aired_at,
    /*  $6 */ data.duration,
    /*  $7 */ data.same_day_allowed,
    /*  $8 */ data.notice_period,
    /*  $9 */ data.approval_type,
    /* $10 */ data.feedback_template,
    /* $11 */ data.address ? JSON.stringify(data.address) : null,
    /* $12 */ data.allow_appraisal,
    /* $13 */ data.allow_inspection,
    /* $14 */ data.instructions,
  ])

  await ShowingHub.emit.showingUpdated(id)

  return result
}

module.exports = {
  updateTitle,
  update,
}
