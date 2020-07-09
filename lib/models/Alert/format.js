const numeral = require('numeral')

const { getSquareFeet } = require('../Listing/format')

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

const proposeTitle = function (alert) {
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
    if (area_min)
      area += getSquareFeet(alert.minimum_square_meters)

    if (area_min && area_max) // Min-Max
      area += '-'

    if (area_min && !area_max) // Min+
      area += '+'

    if (!area_min && area_max) // -Max
      area += '-'

    if (area_max)
      area += getSquareFeet(alert.maximum_square_meters)
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

module.exports = {
  proposeTitle,
}
