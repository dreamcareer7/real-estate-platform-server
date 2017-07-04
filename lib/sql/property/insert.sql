INSERT INTO properties (
  property_type,
  property_subtype,
  bedroom_count,
  bathroom_count,
  address_id,
  matrix_unique_id,
  description,
  square_meters,
  building_square_meters,
  lot_square_meters,
  year_built,
  parking_spaces_covered_total,
  accessibility_features,
  bedroom_bathroom_features,
  commercial_features,
  community_features,
  energysaving_features,
  exterior_features,
  interior_features,
  farmranch_features,
  fireplace_features,
  lot_features,
  parking_features,
  pool_features,
  security_features,
  half_bathroom_count,
  full_bathroom_count,
  heating,
  flooring,
  utilities,
  utilities_other,
  architectural_style,
  structural_style,
  number_of_stories,
  number_of_stories_in_building,
  number_of_parking_spaces,
  parking_spaces_carport,
  parking_spaces_garage,
  garage_length,
  garage_width,
  number_of_dining_areas,
  number_of_living_areas,
  fireplaces_total,
  lot_number,
  soil_type,
  construction_materials,
  construction_materials_walls,
  foundation_details,
  roof,
  pool_yn,
  handicap_yn,
  elementary_school_name,
  intermediate_school_name,
  high_school_Name,
  junior_high_school_name,
  middle_school_name,
  primary_school_name,
  senior_high_school_name,
  school_district,
  subdivision_name,
  appliances_yn,
  building_number,
  ceiling_height,
  green_building_certification,
  green_energy_efficient,
  lot_size,
  lot_size_area,
  lot_size_dimensions,
  map_coordinates,
  number_of_pets_allowed,
  number_of_units,
  pets_yn,
  photo_count,
  room_count,
  subdivided_yn,
  surface_rights,
  unit_count,
  year_built_details,
  zoning,
  security_system_yn,
  furnished_yn,
  fenced_yard_yn
) VALUES (
  $1,
  $2,
  $3,
  $4,
  $5,
  $6,
  $7,
  $8,
  $9,
  $10,
  $11,
  $12,
  $13,
  $14,
  $15,
  $16,
  $17,
  $18,
  $19,
  $20,
  $21,
  $22,
  $23,
  $24,
  $25,
  $26,
  $27,
  $28,
  $29,
  $30,
  $31,
  $32,
  $33,
  $34,
  $35,
  $36,
  $37,
  $38,
  $39,
  $40,
  $41,
  $42,
  $43,
  $44,
  $45,
  $46,
  $47,
  $48,
  $49,
  $50,
  $51,
  $52,
  $53,
  $54,
  $55,
  $56,
  $57,
  $58,
  $59,
  $60,
  $61,
  $62,
  $63,
  $64,
  $65,
  $66,
  $67,
  $68,
  $69,
  $70,
  $71,
  $72,
  $73,
  $74,
  $75,
  $76,
  $77,
  $78,
  $79,
  $80,
  $81,
  $82
)

ON CONFLICT (matrix_unique_id) DO UPDATE SET
  property_type = $1,
  property_subtype = $2,
  bedroom_count = $3,
  bathroom_count = $4,
  description = $7,
  square_meters = $8,
  building_square_meters = $9,
  lot_square_meters = $10,
  year_built = $11,
  parking_spaces_covered_total = $12,
  accessibility_features = $13,
  bedroom_bathroom_features = $14,
  commercial_features = $15,
  community_features = $16,
  energysaving_features = $17,
  exterior_features = $18,
  interior_features = $19,
  farmranch_features = $20,
  fireplace_features = $21,
  lot_features = $22,
  parking_features = $23,
  pool_features = $24,
  security_features = $25,
  half_bathroom_count = $26,
  full_bathroom_count = $27,
  heating = $28,
  flooring = $29,
  utilities = $30,
  utilities_other = $31,
  architectural_style = $32,
  structural_style = $33,
  number_of_stories = $34,
  number_of_stories_in_building = $35,
  number_of_parking_spaces = $36,
  parking_spaces_carport = $37,
  parking_spaces_garage = $38,
  garage_length = $39,
  garage_width = $40,
  number_of_dining_areas = $41,
  number_of_living_areas = $42,
  fireplaces_total = $43,
  lot_number = $44,
  soil_type = $45,
  construction_materials = $46,
  construction_materials_walls = $47,
  foundation_details = $48,
  roof = $49,
  pool_yn = $50,
  handicap_yn = $51,
  elementary_school_name = $52,
  intermediate_school_name = $53,
  high_school_Name = $54,
  junior_high_school_name = $55,
  middle_school_name = $56,
  primary_school_name = $57,
  senior_high_school_name = $58,
  school_district = $59,
  subdivision_name = $60,
  appliances_yn = $61,
  building_number = $62,
  ceiling_height = $63,
  green_building_certification = $64,
  green_energy_efficient = $65,
  lot_size = $66,
  lot_size_area = $67,
  lot_size_dimensions = $68,
  map_coordinates = $69,
  number_of_pets_allowed = $70,
  number_of_units = $71,
  pets_yn = $72,
  photo_count = $73,
  room_count = $74,
  subdivided_yn = $75,
  surface_rights = $76,
  unit_count = $77,
  year_built_details = $78,
  zoning = $79,
  security_system_yn = $80,
  furnished_yn = $81,
  fenced_yard_yn = $82,
  updated_at = CLOCK_TIMESTAMP()

WHERE properties.matrix_unique_id = $6

RETURNING id
