const Context = require('../Context')
const Orm = {
  ...require('../Orm/registry'),
  ...require('../Orm/context'),
}

const { getAll, getCompacts, getMlsAreas } = require('./get')

function publicizeSensitive (l) {
  const user = Context.get('user')
  const type = user ? user.user_type : 'Guest'
  const conditions = Orm.getAssociationConditions('property.address') || {}

  if (conditions.get_private_address === false && l.is_address_public === false) {
    if (l.property) l.property.address = {
      title: '',
      subtitle: '',
      street_number: '',
      street_name: '',
      city: '',
      state: '',
      state_code: '',
      postal_code: '',
      neighborhood: '',
      id: l.property.address.id,
      street_suffix: '',
      unit_number: '',
      country: '',
      country_code: '',
      created_at: '',
      updated_at: '',
      location_google: '',
      matrix_unique_id: l.matrix_unique_id,
      geocoded: true,
      geo_source: '',
      partial_match_google: null,
      county_or_parish: '',
      direction: null,
      street_dir_prefix: '',
      street_dir_suffix: '',
      street_number_searchable: '',
      geo_source_formatted_address_google: '',
      geocoded_google: true,
      geocoded_bing: true,
      location_bing: '',
      geo_source_formatted_address_bing: '',
      geo_confidence_google: '',
      geo_confidence_bing: '',
      location: {
        type: 'location',
        longitude: null,
        latitude: null,
      },
      approximate: false,
      corrupted: false,
      corrupted_google: false,
      corrupted_bing: false,
      deleted_at: null,
      mls: l.mls,
      type: 'address',
      full_address: '',
      street_address: '',
    }
  }

  const properties = {
    //     sub_agency_commission:              ['Agent', 'Brokerage'],
    //     close_price:                        ['Agent', 'Brokerage'],
    //     buyers_agency_commission:           ['Agent', 'Brokerage'],
    //     listing_agreement:                  ['Agent', 'Brokerage'],
    //     list_agent_mls_id:                  ['Agent', 'Brokerage'],
    //     private_remarks:                    ['Agent', 'Brokerage'],
    //     appointment_call:                   ['Agent', 'Brokerage'],
    //     appointment_phone:                  ['Agent', 'Brokerage'],
    //     owner_name:                         ['Agent', 'Brokerage'],
    //     keybox_number:                      ['Agent', 'Brokerage'],
    //     keybox_type:                        ['Agent', 'Brokerage'],
    //     showing_instructions:               ['Agent', 'Brokerage'],
    //     occupancy:                          ['Agent', 'Brokerage'],
    //     seller_type:                        ['Agent', 'Brokerage'],
    //     list_agent_direct_work_phone:       ['Agent', 'Brokerage'],
    //     list_agent_email:                   ['Agent', 'Brokerage'],
    //     co_list_agent_direct_work_phone:    ['Agent', 'Brokerage'],
    //     co_list_agent_email:                ['Agent', 'Brokerage'],
    //     selling_agent_direct_work_phone:    ['Agent', 'Brokerage'],
    //     selling_agent_email:                ['Agent', 'Brokerage'],
    //     co_selling_agent_direct_work_phone: ['Agent', 'Brokerage'],
    //     co_selling_agent_email:             ['Agent', 'Brokerage'],
    //     list_office_phone:                  ['Agent', 'Brokerage'],
    //     co_list_office_phone:               ['Agent', 'Brokerage'],
    //     selling_office_phone:               ['Agent', 'Brokerage'],
    //     co_selling_office_phone:            ['Agent', 'Brokerage']
  }

  Object.keys(properties).forEach(name => {
    const allowed = properties[name]

    if (allowed.indexOf(type) < 0)
      delete l[name]
  })
}

function calculateDom (listing) {
  const actives = [
    'Active',
    'Pending',
    'Temp Off Market',
    'Active Option Contract',
    'Active Contingent',
    'Active Kick Out'
  ]

  if (actives.indexOf(listing.status) < 0)
    return

  listing.dom = Math.trunc(((new Date()).getTime() - (listing.list_date * 1000)) / 86400000)
}

Orm.register('listing', 'Listing', {
  getAll,
  publicize(model) {
    publicizeSensitive(model)
    calculateDom(model)
  
    return model
  },
  
  associations: {
    list_agent: {
      optional: true,
      model: 'Agent'
    },
  
    proposed_agent: {
      optional: true,
      model: 'User',
      enabled: false
    },
  
    user_listing_notification_setting: {
      model: 'UserListingNotificationSetting',
      enabled: true,
    }
  }
})


Orm.register('compact_listing', 'CompactListing', {
  getAll: getCompacts,
  publicize(model) {
    if (model.total) delete model.total
  
    publicizeSensitive(model)
    calculateDom(model)
  
    return model
  },
  associations: {
    list_agent: {
      optional: true,
      model: 'Agent',
      enabled: false
    },
  
    selling_agent: {
      optional: true,
      model: 'Agent',
      enabled: false
    },
  
    proposed_agent: {
      optional: true,
      model: 'User',
      enabled: false
    },
  
    user_listing_notification_setting: {
      model: 'UserListingNotificationSetting',
      enabled: true,
    }
  }
})
Orm.register('mls_area', 'MLSArea', {
  getAll: getMlsAreas,
})