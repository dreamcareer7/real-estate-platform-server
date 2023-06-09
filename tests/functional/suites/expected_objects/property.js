const address = require('./address.js')
const v = require('./validation.js')

module.exports = {
  'type': String,
  'id': String,
  'bedroom_count': v.optionalNumber,
  'bathroom_count': v.optionalNumber,
  'description': v.optionalString,
  'square_meters': Number,
  'created_at': Number,
  'updated_at': Number,
  'matrix_unique_id': Number,
  'property_type': String,
  'property_subtype': String,
  'lot_square_meters': v.optionalNumber,
  'year_built': v.optionalNumber,
  'exterior_features': v.optionalArray,
  'interior_features': v.optionalArray,
  'fireplace_features': v.optionalArray,
  'lot_features': v.optionalArray,
  'parking_features': v.optionalArray,
  'pool_features': v.optionalArray,
  'security_features': v.optionalArray,
  'parking_spaces_covered_total': v.optionalNumber,
  'half_bathroom_count': v.optionalNumber,
  'full_bathroom_count': v.optionalNumber,
  'heating': v.optionalArray,
  'flooring': v.optionalArray,
  'utilities': v.optionalArray,
  'utilities_other': v.optionalArray,
  'architectural_style': v.optionalArray,
  'number_of_stories': v.optionalNumber,
  'number_of_parking_spaces': v.optionalNumber,
  'garage_length': v.optionalNumber,
  'garage_width': v.optionalNumber,
  'number_of_dining_areas': v.optionalNumber,
  'number_of_living_areas': v.optionalNumber,
  'fireplaces_total': v.optionalNumber,
  'lot_number': v.optionalString,
  'soil_type': v.optionalString,
  'construction_materials': v.optionalString,
  'foundation_details': v.optionalString,
  'roof': v.optionalString,
  'pool_yn': v.optionalBoolean,
  'handicap_yn': v.optionalBoolean,
  'elementary_school_name': v.optionalString,
  'intermediate_school_name': v.optionalString,
  'high_school_name': v.optionalString,
  'junior_high_school_name': v.optionalString,
  'middle_school_name': v.optionalString,
  'primary_school_name': v.optionalString,
  'senior_high_school_name': v.optionalString,
  'school_district': v.optionalString,
  'subdivision_name': v.optionalString,
  'appliances_yn': v.optionalBoolean,
  'green_building_certification': v.optionalString,
  'green_energy_efficient': v.optionalString,
  'lot_size': v.optionalNumber,
  'lot_size_area': v.optionalNumber,
  'lot_size_dimensions': v.optionalString,
  'number_of_pets_allowed': v.optionalNumber,
  'number_of_units': v.optionalNumber,
  'pets_yn': v.optionalBoolean,
  'deleted_at': v.optionalNumber,
  'address': address
}
