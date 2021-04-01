const range = require('postgres-range')
const db = require('../../../utils/db')

/**
 * @param {import('./types').ShowingInput} showing
 * @param {UUID} user
 * @param {UUID} brand
 */
async function insert(showing, user, brand) {
  const availabilities = (showing.availabilities ?? []).map(a => ({
    ...a,
    availability: range.serialize(new range.Range(a.availability[0], a.availability[1], range.RANGE_LB_INC))
  }))

  return db.insert('showing/showing/insert', [
    /*  $1 */ JSON.stringify(showing.roles ?? []),
    /*  $2 */ JSON.stringify(availabilities),
    /*  $3 */ user,
    /*  $4 */ brand,
    /*  $5 */ showing.start_date,
    /*  $6 */ showing.end_date,
    /*  $7 */ showing.aired_at,
    /*  $8 */ showing.duration,
    /*  $9 */ showing.notice_period,
    /* $10 */ showing.approval_type,
    /* $11 */ showing.feedback_template,
    /* $12 */ showing.deal,
    /* $13 */ showing.listing,
    /* $14 */ showing.address,
    /* $15 */ showing.gallery,
  ])
}

/**
 * @param {import('./types').ShowingInput} showing
 * @param {UUID} user
 * @param {UUID} brand
 */
async function create(showing, user, brand) {
  try {
    return await insert(showing, user, brand)
  } catch (ex) {
    switch (ex.constraint) {
      case 'showings_listing_fkey':
        throw Error.Validation('Provided listing does not exist')
      case 'showings_deal_fkey':
        throw Error.Validation('Provided deal does not exist')
      case 'showings_feedback_template_fkey':
        throw Error.Validation('Provided template instance does not exist')
      case 'showings_gallery_fkey':
        throw Error.Validation('Provided gallery does not exist')
      case 'sr_no_overlap':
        throw Error.Validation('Availability items should not overlap with each other')
      case 'sr_enforce_bounds':
        throw Error.Validation('Availability time range is invalid')
      case 'sr_confirm_notification_type':
        throw Error.Validation('At least one notification type is required for roles who can approve an appointment')
      case 's_end_date':
        throw Error.Validation('End date must either be empty or after start date')
      case 's_listing_exclusion':
        throw Error.Validation('Only one of deal, listing or address must be specified')
      default:
        throw ex
    }
  }
}

module.exports = {
  create,
}