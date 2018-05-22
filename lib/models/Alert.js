/**
 * @namespace Alert
 */

const validator = require('../utils/validator.js')
const db = require('../utils/db.js')
const async = require('async')
const _u = require('underscore')
const numeral = require('numeral')
require('./AlertSetting')

/**
 * @typedef alert
 * @type {object}
 * @memberof Alert
 * @instance
 * @property {uuid} id - ID of this `alert`
 * @property {string} title - title of this alert
 * @property {float} minimum_price - minimum price of properties matching this alert
 * @property {float} maximum_price - maximum price of properties matching this alert
 * @property {float} minimum_square_meters - minimum square meter of the properties matching this alert
 * @property {float} maximum_square_meters - maximum square meter of the properties matching this alert
 * @property {number} minimum_bedrooms - minimum number of bedrooms a property must have to be a match against this alert
 * @property {number} minimum_bathrooms - minimum number of bathrooms a property must have to be a match against this alert
 * @property {uuid} created_by - ID of the user who created this alert
 * @property {uuid} room - ID of the room this alert belongs to
 * @property {Listing#property_types} property_types - an array of property types of properties to match against this alert
 * @property {Listing#property_subtype[]} property_subtypes - an array of property subtypes to match against this alert
 * @property {Address#point[]} points - an array of geometric points forming a polygon for search area
 * @property {number} minimum_year_built - minimum year built of the property to get matched against this alert
 * @property {number} maximum_year_built - maximum year built of the property to get matched against this alert
 * @property {float} minimum_lot_square_meters - minimum square meter of lot total for properties to get matched against this alert
 * @property {float} maximum_lot_square_meters - maximum square meter of lot total for properties to get matched against this alert
 * @property {boolean} pool - indicates whether pool is mandatory: true means mandatory, false means shouldn't have a pool, null is don't care
 * @property {timestamp} created_at - indicates when this object was created
 * @property {timestamp=} updated_at - indicates when this object was last modified
 * @property {timestamp=} deleted_at - indicates when this object was deleted
 */

Alert = {}

Orm.register('alert', 'Alert')

const schema = {
  type: 'object',
  properties: {
    minimum_price: {
      type: ['null', 'number'],
      minimum: 0,
      required: false
    },

    maximum_price: {
      type: ['null', 'number'],
      minimum: 0,
      required: false
    },

    minimum_bedrooms: {
      type: ['null', 'number'],
      minimum: 0,
      required: false
    },

    minimum_bathrooms: {
      type: ['null', 'number'],
      minimum: 0,
      required: false
    },

    minimum_square_meters: {
      type: ['null', 'number'],
      minimum: 0,
      required: false
    },

    maximum_square_meters: {
      type: ['null', 'number'],
      minimum: 0,
      required: false
    },

    created_by: {
      type: [ 'null', 'string' ],
      uuid: true
    },

    points: {
      required: false,
      type: ['null', 'array'],
      minItems: 4,
      items: {
        type: 'object',
        properties: {
          latitude: {
            type: 'number',
            required: true
          },
          longitude: {
            type: 'number',
            required: true
          }
        }
      }
    },

    minimum_lot_square_meters: {
      type: ['null', 'number'],
      required: false,
      minimum: 0
    },

    maximum_lot_square_meters: {
      type: ['null', 'number'],
      required: false,
      minimum: 0
    },

    minimum_year_built: {
      type: ['null', 'number'],
      required: false,
      minimum: 0
    },

    maximum_year_built: {
      type: ['null', 'number'],
      required: false,
      minimum: 0
    },

    pool: {
      type: ['null', 'boolean'],
      required: false
    },

    pets: {
      type: ['null', 'boolean'],
      required: false
    },

    number_of_pets_allowed: {
      type: ['null', 'number'],
      required: false
    },

    application_fee: {
      type: ['null', 'boolean'],
      required: false
    },

    appliances: {
      type: ['null', 'boolean'],
      required: false
    },

    furnished: {
      type: ['null', 'boolean'],
      required: false
    },

    fenced_yard: {
      type: ['null', 'boolean'],
      required: false
    },

    title: {
      type: [ 'null', 'string' ],
      required: false
    },

    property_types: {
      type: ['array'],
      uniqueItems: true,
      required: true,
      items: {
        enum: [ 'Residential', 'Residential Lease', 'Multi-Family', 'Commercial', 'Lots & Acreage' ]
      }
    },

    property_subtypes: {
      required: true,
      type: ['array'],
      uniqueItems: true,
      items: {
        enum: [
          'MUL-Apartment/5Plex+',
          'MUL-Fourplex',
          'MUL-Full Duplex',
          'MUL-Multiple Single Units',
          'MUL-Triplex',
          'LSE-Apartment',
          'LSE-Condo/Townhome',
          'LSE-Duplex',
          'LSE-Fourplex',
          'LSE-House',
          'LSE-Mobile',
          'LSE-Triplex',
          'LND-Commercial',
          'LND-Farm/Ranch',
          'LND-Residential',
          'RES-Condo',
          'RES-Farm/Ranch',
          'RES-Half Duplex',
          'RES-Single Family',
          'RES-Townhouse',
          'COM-Lease',
          'COM-Sale',
          'COM-Sale or Lease (Either)',
          'COM-Sale/Leaseback (Both)'
        ]
      }
    },

    listing_statuses: {
      required: false,
      type: ['null', 'array'],
      uniqueItems: true,
      minItems: 1,
      items: {
        enum: Listing.status_enum
      }
    },

    open_house: {
      type: [ 'null', 'boolean'],
      required: false
    },

    minimum_sold_date: {
      type: [ 'null', 'number' ],
      required: false
    },

    excluded_listing_ids: {
      type: [ 'null', 'array' ],
      uniqueItems: true,
      minItems: 0,
      items: {
        type: 'string',
        uuid: true
      }
    },

    mls_areas: {
      type: ['null', 'array'],
      required: false
    },

    postal_codes: {
      type: ['null', 'array'],
      required: false
    }
  }
}

const validate = validator.bind(null, schema)

Alert.get = function (alert_id, cb) {
  Alert.getAll([alert_id], (err, alerts) => {
    if(err)
      return cb(err)

    if (alerts.length < 1)
      return cb(Error.ResourceNotFound(`Alert ${alert_id} not found`))

    const alert = alerts[0]

    cb(null, alert)
  })
}

Alert.getAll = function(alert_ids, cb) {
  const user_id = ObjectUtil.getCurrentUser()

  db.query('alert/get', [alert_ids, user_id], (err, res) => {
    if (err)
      return cb(err)

    const alerts = res.rows.map(r => {
      if (r.points) {
        const points = JSON.parse(r.points)
        r.points = points.coordinates[0].map( c => {
          return {
            longitude: c[0],
            latitude: c[1],
            type: 'location'
          }
        })
      }


      r.proposed_title = Alert.proposeTitle(r)

      return r
    })

    return cb(null, alerts)
  })
}

Alert.validatePointsArray = function (alert, cb) {
  const p1 = alert.points[0]
  const p2 = alert.points[alert.points.length - 1]

  if ((p1.longitude !== p2.longitude) ||
     (p1.latitude !== p2.latitude))
    return cb(Error.Validation('Points array must form a closed polygon with at least 4 points'))

  return cb()
}

Alert.create = function (room_id, alert, cb) {
  async.auto({
    room: cb => {
      return Room.get(room_id, cb)
    },
    owner: cb => {
      return User.get(alert.created_by, cb)
    },
    validate: cb => {
      validate(alert, err => {
        if (err)
          return cb(err)

        if (!alert.points)
          return cb()

        return Alert.validatePointsArray(alert, cb)
      })
    },
    insert: [
      'room',
      'owner',
      'validate',
      (cb, results) => {
        const points = alert.points ? Address.getGeomTextFromLocationArray(alert.points) : null

        db.query('alert/insert', [
          alert.minimum_price,
          alert.maximum_price,
          alert.minimum_square_meters,
          alert.maximum_square_meters,
          alert.minimum_bedrooms,
          alert.minimum_bathrooms,
          alert.created_by,
          room_id,
          alert.property_types,
          alert.property_subtypes,
          alert.title,
          points,
          alert.minimum_year_built,
          alert.maximum_year_built,
          alert.pool,
          alert.minimum_lot_square_meters,
          alert.maximum_lot_square_meters,
          alert.listing_statuses,
          alert.open_house,
          alert.minimum_sold_date,
          JSON.stringify(alert.mls_areas),
          alert.list_agents,
          alert.list_offices,
          alert.counties,
          alert.minimum_parking_spaces,
          alert.architectural_styles,
          alert.subdivisions,
          alert.school_districts,
          alert.primary_schools,
          alert.middle_schools,
          alert.elementary_schools,
          alert.senior_high_schools,
          alert.junior_high_schools,
          alert.intermediate_schools,
          alert.sort_order,
          alert.sort_office,
          alert.selling_agents,
          alert.selling_offices,
          alert.offices,
          alert.agents,
          alert.high_schools,
          alert.excluded_listing_ids,
          alert.postal_codes,
          alert.pets,
          alert.number_of_pets_allowed,
          alert.application_fee,
          alert.appliances,
          alert.furnished,
          alert.fenced_yard
        ],
          (err, res) => {
            if (err)
              return cb(err)
              
            return cb(null, res.rows[0].id)
          })
      }
    ],
    alert: [
      'insert',
      (cb, results) => {
        return Alert.get(results.insert, cb)
      }
    ],
    recommend_listings: [
      'alert',
      (cb, results) => {
        return Alert.recommendListings(results.insert, room_id, alert.excluded_listing_ids, cb)
      }
    ],
    notification: [
      'owner',
      'recommend_listings',
      (cb, results) => {
        const notification = {}

        notification.action = 'Created'
        notification.subject = results.owner.id
        notification.subject_class = 'User'
        notification.object = results.insert
        notification.object_class = 'Alert'
        notification.auxiliary_object = room_id
        notification.auxiliary_object_class = 'Room'
        notification.message = '#' + results.room.proposed_title + ': @' + results.owner.first_name + ' added a new Alert, check your new listings'
        notification.room = room_id

        notification.alert_results = {
          listing: (results.recommend_listings && results.recommend_listings.length > 0) ? results.recommend_listings[0] : null,
          count: (results.recommend_listings) ? results.recommend_listings.length : 0
        }

        Notification.issueForRoomExcept(notification, [results.owner.id], cb)
      }
    ],
    activity: [
      'owner',
      'insert',
      (cb, results) => {
        const activity = {
          action: 'UserCreatedAlert',
          object: results.insert,
          object_class: 'alert'
        }
        const intercomActivity = {
          action: results.room.room_type === 'Personal' ? 'UserSavedAlert' : 'UserSharedAlert',
          object: results.insert,
          object_class: 'alert'
        }

        Activity.add(alert.created_by, 'User', activity, (err) => {
          if (err)
            return cb(err)

          Activity.add(alert.created_by, 'User', intercomActivity, cb)
        })
      }
    ]
  }, (err, results) => {
    if (err)
      return cb(err)

    return cb(null, results.alert)
  })
}

Alert.patch = function (room_id, user_id, alert_id, alert, cb) {
  async.auto({
    room: cb => {
      return Room.get(room_id, cb)
    },
    user: cb => {
      return User.get(user_id, cb)
    },
    before: cb => {
      return Alert.get(alert_id, cb)
    },
    update: [
      'room',
      'user',
      'before',
      (cb, results) => {
        const next = results.before

        for (const i in alert)
          next[i] = alert[i]

        next.points = next.points ? Address.getGeomTextFromLocationArray(next.points) : null

        db.query('alert/patch', [
          next.minimum_price,
          next.maximum_price,
          next.minimum_square_meters,
          next.maximum_square_meters,
          next.minimum_bedrooms,
          next.minimum_bathrooms,
          next.property_types,
          next.property_subtypes,
          next.title,
          next.points,
          next.minimum_year_built,
          next.maximum_year_built,
          next.pool,
          next.minimum_lot_square_meters,
          next.maximum_lot_square_meters,
          next.listing_statuses,
          next.open_house,
          next.minimum_sold_date,
          JSON.stringify(next.mls_areas),
          next.list_agents,
          next.list_offices,
          next.counties,
          next.minimum_parking_spaces,
          next.architectural_styles,
          next.subdivisions,
          next.school_districts,
          next.primary_schools,
          next.middle_schools,
          next.elementary_schools,
          next.senior_high_schools,
          next.junior_high_schools,
          next.intermediate_schools,
          next.sort_order,
          next.sort_office,
          next.selling_agents,
          next.selling_offices,
          next.offices,
          next.agents,
          next.high_schools,
          next.excluded_listing_ids,
          next.postal_codes,
          next.pets,
          next.number_of_pets_allowed,
          next.application_fee,
          next.appliances,
          next.furnished,
          next.fenced_yard,
          alert_id
        ], cb)
      }],
    alert: [
      'update',
      (cb, results) => {
        return Alert.get(alert_id, cb)
      }
    ],
    remove_from_recommendations: [
      'alert',
      (cb, results) => {
        Alert.removeFromRecommendationsReferences(alert_id, results.alert.room, cb)
      }
    ],
    hide_orphaned_recommendations: [
      'alert',
      'remove_from_recommendations',
      (cb, results) => {
        Room.hideOrphanedRecommendations(results.alert.room, cb)
      }
    ],
    recommend_listings: [
      'alert',
      (cb, results) => {
        return Alert.recommendListings(alert_id, room_id, alert.excluded_listing_ids, cb)
      }
    ],
    notification: [
      'room',
      'user',
      'recommend_listings',
      (cb, results) => {
        const notification = {}

        notification.action = 'Edited'
        notification.subject = user_id
        notification.subject_class = 'User'
        notification.object = alert_id
        notification.object_class = 'Alert'
        notification.auxiliary_object = room_id
        notification.auxiliary_object_class = 'Room'
        notification.message = '#' + results.room.proposed_title + ': @' + results.user.first_name + ' edited an Alert, check your new listings'
        notification.room = room_id

        Notification.issueForRoomExcept(notification, [user_id], cb)
      }
    ]
  }, (err, results) => {
    if (err)
      return cb(err)

    return cb(null, results.alert)
  })
}

Alert.check = function (alert_ref, cb) {
  const alert = _u.clone(alert_ref)

  alert.title = 'Dummy'
  alert.limit = alert.limit || 50

  async.auto({
    validate: cb => {
      validate(alert, err => {
        if (err)
          return cb(err)

        if (!alert.points)
          return cb()

        return Alert.validatePointsArray(alert, cb)
      })
    },
    matching: [
      'validate',
      (cb, results) => {
        Alert.matchingListingsForAlertData(alert, cb)
      }
    ],
    compact_listings: [
      'matching',
      (cb, results) => {
        let matching = results.matching.listings
        matching = _u.difference(matching, alert.excluded_listing_ids || [])
        const total = results.matching.total - (alert.excluded_listing_ids ? alert.excluded_listing_ids.length : 0)
        const listing_ids = matching.slice(0, alert.limit)

        Listing.getCompacts(listing_ids, (err, listings) => {
          if (err)
            return cb(err)

          if (listings[0])
            listings[0].total = total

          return cb(null, listings)
        })
      }
    ]
  }, (err, results) => {
    if (err)
      return cb(err)

    return cb(null, results.compact_listings)
  })
}

Alert.recommendListings = function (alert_id, room_id, exclude, cb) {
  Alert.matchingListings(alert_id, (err, listings) => {
    if (err)
      return cb(err)

    listings = _u.difference(listings, exclude || [])

    Room.recommendListings(room_id, listings, {ref_alert_id: alert_id}, err => {
      if (err)
        return cb(err)

      return cb(null, listings)
    })
  })
}

Alert.delete = function (alert_id, user, cb) {
  async.auto({
    alert: cb => {
      Alert.get(alert_id, cb)
    },
    deref: [
      'alert',
      (cb, results) => {
        Alert.removeFromRecommendationsReferences(alert_id, results.alert.room, cb)
      }
    ],
    hide: [
      'alert',
      'deref',
      (cb, results) => {
        Room.hideOrphanedRecommendations(results.alert.room, cb)
      }
    ],
    delete: [
      'hide',
      (cb , results) => {
        db.query('alert/delete', [alert_id], cb)
      }
    ],
    message: [
      'alert',
      (cb, results) => {
        const message = {
          comment: `Alert "${Alert.getTitle(results.alert)}" has been deleted by ${user.abbreviated_display_name}`
        }
        return Message.post(results.alert.room, message, false, cb)
      }
    ]
  }, (err, results) => {
    if (err)
      return cb(err)

    return cb()
  })
}

Alert.removeFromRecommendationsReferences = function (alert_id, room_id, cb) {
  db.query('alert/remove_recs_refs', [alert_id, room_id], cb)
}

Alert.matchingListings = function (alert_id, cb) {
  Alert.get(alert_id, (err, alert) => {
    if (err)
      return cb(err)

    return Alert.matchingListingsForAlertData(alert, (err, results) => {
      if (err)
        return cb(err)

      return cb(null, results.listings)
    })
  })
}

Alert.buildQuery = require('../sql/alert/matching.js')

Alert.matchingListingsForAlertData = function (alert, cb) {
  const query = Alert.buildQuery(alert)

  const q = query.toParam()

  db.executeSql(q.text, q.values, (err, res) => {
    if (err)
      return cb(err)

    const listings = res.rows.map(r => r.id)

    return cb(null, {
      listings: listings,
      total: (res.rows[0] ? res.rows[0].total : 0)
    })
  })
}

Alert.getSet = function (set, id, paging, cb) {
  db.query(set, [
    id,
    paging.type,
    paging.timestamp,
    paging.limit
  ], (err, res) => {
    if (err)
      return cb(err)

    if (res.rows.length < 1)
      return cb(null, [])

    const alert_ids = res.rows.map(r => r.id)

    Alert.getAll(alert_ids, (err, alerts) => {
      if (err)
        return cb(err)

      alerts[0].total = res.rows[0].total

      return cb(null, alerts)
    })
  })
}

Alert.getForRoom = function (room_id, paging, cb) {
  return Alert.getSet('alert/room', room_id, paging, cb)
}

Alert.getForUser = function (user_id, paging, cb) {
  return Alert.getSet('alert/user', user_id, paging, cb)
}

Alert.stringSearch = function (user_id, strings, cb) {
  const regexps = ObjectUtil.makeRegexps(strings)

  db.query('alert/search', [user_id, regexps], (err, res) => {
    if (err)
      return cb(err)

    if (res.rows.length < 1)
      return cb(null, [])

    const alert_ids = res.rows.map(r => {
      return r.id
    })

    Alert.getAll(alert_ids, (err, alerts) => {
      if (err)
        return cb(err)

      return cb(null, alerts)
    })
  })
}

Alert.refreshFilters = function (cb) {
  db.query('alert/refresh_filters', [], cb)
}

const formatPrice = function (string) {
  return numeral(string).format('($0a)')
}

const status_groups = {
  'Active': 'Active',
  'Sold': 'Sold',
  'Leased': 'Sold',
  'Pending': 'Pending',
  'Temp Off Market': 'Off Market',
  'Active Option Contract': 'Pending',
  'Active Contingent': 'Pending',
  'Active Kick Out': 'Pending',
  'Withdrawn': 'Off Market',
  'Expired': 'Off Market',
  'Cancelled': 'Off Market',
  'Withdrawn Sublisting': 'Off Market',
  'Incomplete': 'Off Market',
  'Out Of Sync': 'Off Market',
  'Incoming': 'Off Market',
  'Coming Soon': 'Coming Soon'
}

Alert.proposeTitle = function (alert) {
  const features = []

  if(alert.postal_codes && alert.postal_codes.length > 0)
    features.push('In ' + alert.postal_codes.join(','))

  const statuses = new Set()

  if (alert.listing_statuses)
    alert.listing_statuses.forEach(state => statuses.add(status_groups[state]))

  features.push(Array.from(statuses).join(','))

  const price_min = alert.minimum_price > 0
  const price_max = alert.maximum_price > 0

  let price = ''

  if (price_min || price_max) {
    if (price_min > 0)
      price += formatPrice(alert.minimum_price)

    if (price_min && price_max)
      price += '-'

    if (price_min && !price_max)
      price += '+'

    if (!price_min && price_max)
      price += '-'

    if (price_max)
      price += formatPrice(alert.maximum_price)
  }

  if (price)
    features.push(price)

  let area = ''

  const area_min = alert.minimum_square_meters > 0
  const area_max = alert.maximum_square_meters > 0

  if (area_min || area_max) {
    if (area_min > 0)
      area += Listing.getSquareFeet(alert.minimum_square_meters)

    if (area_min && area_max)  // Min-Max
      area += '-'

    if (area_min && !area_max) // Min+
      area += '+'

    if (!area_min && area_max) // -Max
      area += '-'

    if (area_max)
      area += Listing.getSquareFeet(alert.maximum_square_meters)
  }

  if (area)
    features.push(area)

  if (alert.minimum_bedrooms > 0)
    features.push(alert.minimum_bedrooms + '+ Beds')

  if (alert.minimum_bathrooms > 0)
    features.push(alert.minimum_bathrooms + '+ Baths')

  if (features.length < 3 && !price)
    features.push('Any $')

  if (features.length < 3 && !alert.minimum_bedrooms)
    features.push('Any beds')

  if (features.length < 3 && !alert.minimum_bathrooms)
    features.push('Any baths')

  if (features.length < 4)
    return features.join(', ')

  return features.slice(0, 3).join(', ') + ' ...'
}

Alert.getTitle = function (alert) {
  if (alert.title)
    return alert.title

  return Alert.proposeTitle(alert)
}

Alert.setState = async function (userID, alertID, status) {
  return db.query.promise('alert/change_alert_state_for_user', [userID, alertID, status])
}

Alert.userAlertSettingStatusEnum = {
  Enabled: 'Enabled', 
  Disabled: 'Disabled'
}

Alert.getUsersByStatus = async function (alertID, status) {
  return db.query.promise('alert/get_users_for_alert_by_status', [alertID, status])
}

Alert.getUserAndStatus = function (userIDs, alertIDs, status, cb) {
  return db.selectIds('alert/get_user_alert_setting_by_user_and_alert', [userIDs, alertIDs, status]).nodeify(cb)
}

Alert.associations = {
  users: {
    collection: true,
    model: 'User',
  },

  created_by: {
    optional: true,
    model: 'User'
  },

  mls_areas: {
    ids: (a, cb) => {
      if (!a.mls_areas)
        return cb()

      const areas = new Set()

      a.mls_areas.forEach(pair => {
        // [number, parent]
        areas.add(`[${pair[0]},${pair[1]}]`)

        if (pair[1] > 0) { // [number, 0]
          areas.add(`[${pair[1]},0]`)
        }
      })

      return cb(null, Array.from(areas))
    },
    model: 'MLSArea',
    collection: true
  },
  alert_setting: {
    model: 'AlertSetting',
    enabled: false
  }
}

module.exports = Alert
