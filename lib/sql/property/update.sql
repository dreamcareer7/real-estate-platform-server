UPDATE properties
SET property_type = $1,
    property_subtype = $2,
    bedroom_count = $3,
    bathroom_count = $4,
    description = $5,
    square_meters = $6,
    lot_square_meters = $7,
    year_built = $8,
    parking_spaces_covered_total = $9,
    accessibility_features = $10,
    bedroom_bathroom_features = $11,
    commercial_features = $12,
    community_features = $13,
    energysaving_features = $14,
    exterior_features = $15,
    interior_features = $16,
    farmranch_features = $17,
    fireplace_features = $18,
    lot_features = $19,
    parking_features = $20,
    pool_features = $21,
    security_features = $22,
    half_bathroom_count = $23,
    full_bathroom_count = $24,
    heating = $25,
    flooring = $26,
    utilities = $27,
    utilities_other = $28,
    architectural_style = $29,
    structural_style = $30,
    number_of_stories = $31,
    number_of_stories_in_building = $32,
    number_of_parking_spaces = $33,
    parking_spaces_carport = $34,
    parking_spaces_garage = $35,
    garage_length = $36,
    garage_width = $37,
    number_of_dining_areas = $38,
    number_of_living_areas = $39,
    fireplaces_total = $40,
    lot_number = $41,
    soil_type = $42,
    construction_materials = $43,
    construction_materials_walls = $44,
    foundation_details = $45,
    roof = $46,
    pool_yn = $47,
    handicap_yn = $48,
    elementary_school_name = $49,
    intermediate_school_name = $50,
    high_school_Name = $51,
    junior_high_school_name = $52,
    middle_school_name = $53,
    primary_school_name = $54,
    senior_high_school_name = $55,
    school_district = $56,
    subdivision_name = $57,
    appliances_yn = $58,
    building_number = $59,
    ceiling_height = $60,
    green_building_certification = $61,
    green_energy_efficient = $62,
    lot_size = $63,
    lot_size_area = $64,
    lot_size_dimensions = $65,
    map_coordinates = $66,
    number_of_pets_allowed = $67,
    number_of_units = $68,
    pets_yn = $69,
    photo_count = $70,
    room_count = $71,
    subdivided_yn = $72,
    surface_rights = $73,
    unit_count = $74,
    year_built_details = $75,
    zoning = $76,
    security_system_yn = $77,
    updated_at = NOW()
WHERE id = $78
