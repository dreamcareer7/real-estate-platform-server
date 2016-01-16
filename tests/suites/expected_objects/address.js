var v = require('../../../lib/utils/response_validation.js');

module.exports = {
  "title": v.optionalString,
  "subtitle": v.optionalString,
  "street_number": v.optionalString,
  "street_name": v.optionalString,
  "city": v.optionalString,
  "state": v.optionalString,
  "state_code": v.optionalString,
  "postal_code": v.optionalString,
  "neighborhood": v.optionalString,
  "id": String,
  "street_suffix": v.optionalString,
  "unit_number": v.optionalString,
  "country": v.optionalString,
  "country_code": v.optionalString,
  "created_at": Number,
  "updated_at": Number,
  "location_google": v.optionalString,
  "matrix_unique_id": String,
  "geocoded": v.optionalBoolean,
  "geo_source": v.optionalString,
  "partial_match_google": v.optionalBoolean,
  "county_or_parish": v.optionalString,
  "direction": v.optionalString,
  "street_dir_prefix": v.optionalString,
  "street_dir_suffix": v.optionalString,
  "street_number_searchable": v.optionalString,
  "geo_source_formatted_address_google": v.optionalString,
  "geocoded_google": v.optionalBoolean,
  "geocoded_bing": v.optionalBoolean,
  "location_bing": v.optionalString,
  "geo_source_formatted_address_bing": v.optionalString,
  "geo_confidence_google": v.optionalString,
  "geo_confidence_bing": v.optionalString,
  "location": v.optionalLocation,
  "approximate": v.optionalBoolean,
  "corrupted": v.optionalBoolean,
  "corrupted_google": v.optionalBoolean,
  "corrupted_bing": v.optionalBoolean,
  "deleted_at": v.optionalNumber,
  "type": String
};
