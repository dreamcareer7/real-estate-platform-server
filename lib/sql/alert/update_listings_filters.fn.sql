CREATE OR REPLACE FUNCTION update_listings_filters()
  RETURNS trigger AS
$$
  BEGIN
    DELETE FROM listings_filters WHERE matrix_unique_id = NEW.matrix_unique_id;

    INSERT INTO listings_filters
    SELECT
      listings.id AS id,
      listings.status AS status,
      listings.price AS price,
      listings.matrix_unique_id AS matrix_unique_id,
      listings.close_date AS close_date,
      listings.list_office_mls_id,
      listings.co_list_office_mls_id,
      listings.list_agent_mls_id,
      listings.co_list_agent_mls_id,
      listings.selling_office_mls_id,
      listings.co_selling_office_mls_id,
      listings.selling_agent_mls_id,
      listings.co_selling_agent_mls_id,
      listings.close_price AS close_price,
      listings.created_at AS created_at,
      listings.mls_number,
      listings.application_fee_yn,
      -- Areas are stored as something like this: MCKINNEY AREA (53)
      -- When filteting, we only want the number (53). So we extract it.
      (regexp_matches(listings.mls_area_major, E'[0-9]+'))[1]::int as mls_area_major,
      (regexp_matches(listings.mls_area_minor, E'[0-9]+'))[1]::int as mls_area_minor,
      properties.square_meters,
      properties.bedroom_count,
      properties.half_bathroom_count,
      properties.full_bathroom_count,
      properties.property_type,
      properties.property_subtype,
      properties.year_built,
      properties.pool_yn,
      properties.pets_yn,
      properties.lot_square_meters,
      properties.parking_spaces_covered_total,
      properties.architectural_style,
      properties.subdivision_name,
      properties.school_district,
      properties.elementary_school_name,
      properties.intermediate_school_name,
      properties.junior_high_school_name,
      properties.middle_school_name,
      properties.primary_school_name,
      properties.high_school_name,
      properties.senior_high_school_name,
      properties.appliances_yn,
      properties.furnished_yn,
      properties.fenced_yard_yn,
      properties.number_of_pets_allowed,
      addresses.location,
      addresses.county_or_parish,
      addresses.postal_code,
      ARRAY_TO_STRING(
        ARRAY[
          addresses.title,
          addresses.subtitle,
          addresses.street_number,
          addresses.street_dir_prefix,
          addresses.street_name,
          addresses.street_suffix,
          addresses.street_dir_suffix,
          addresses.city,
          addresses.state,
          addresses.state_code,
          addresses.postal_code,
          addresses.country::text,
          addresses.country_code::text,
          (
            CASE WHEN addresses.unit_number = '' THEN NULL
            ELSE
            'Unit ' || addresses.unit_number
            END
          )
        ], ' ', NULL
      ) as address
    FROM addresses
    JOIN
      properties ON addresses.matrix_unique_id = properties.matrix_unique_id
    JOIN
      listings   ON addresses.matrix_unique_id = listings.matrix_unique_id

    WHERE addresses.matrix_unique_id = NEW.matrix_unique_id;

    RETURN NEW;
  END;
$$
LANGUAGE PLPGSQL;
