INSERT INTO
    properties(property_type,
               property_subtype,
               bedroom_count,
               bathroom_count,
               address_id,
               matrix_unique_id,
               description,
               square_meters,
               lot_square_meters,
               year_built,
               parking_spaces,
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
               security_features)
VALUES ($1,
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
        $24) RETURNING id
