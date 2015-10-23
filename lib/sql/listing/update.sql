UPDATE listings
SET alerting_agent_id = $1,
    listing_agent_id = $2,
    listing_agency_id = $3,
    currency = $4,
    price = $5,
    status = $6,
    original_price = $7,
    last_price = $8,
    low_price = $9,
    association_fee = $10,
    association_fee_frequency = $11,
    association_fee_includes = $12,
    association_type = $13,
    unexempt_taxes = $14,
    financing_proposed = $15,
    list_office_mui = $16,
    list_office_mls_id = $17,
    list_office_name = $18,
    list_office_phone = $19,
    co_list_office_mui = $20,
    co_list_office_mls_id = $21,
    co_list_office_name = $22,
    co_list_office_phone = $23,
    selling_office_mui = $24,
    selling_office_mls_id = $25,
    selling_office_name = $26,
    selling_office_phone = $27,
    co_selling_office_mui = $28,
    co_selling_office_mls_id = $29,
    co_selling_office_name = $30,
    co_selling_office_phone = $31,
    list_agent_mui = $32,
    list_agent_direct_work_phone = $33,
    list_agent_email = $34,
    list_agent_full_name = $35,
    list_agent_mls_id = $36,
    co_list_agent_mui = $37,
    co_list_agent_direct_work_phone = $38,
    co_list_agent_email = $39,
    co_list_agent_full_name = $40,
    co_list_agent_mls_id = $41,
    selling_agent_mui = $42,
    selling_agent_direct_work_phone = $43,
    selling_agent_email = $44,
    selling_agent_full_name = $45,
    selling_agent_mls_id = $46,
    co_selling_agent_mui = $47,
    co_selling_agent_direct_work_phone = $48,
    co_selling_agent_email = $49,
    co_selling_agent_full_name = $50,
    co_selling_agent_mls_id = $51,
    listing_agreement = $52,
    possession = $53,
    capitalization_rate = $54,
    compensation_paid = $55,
    date_available = $56,
    last_status = $57,
    mls_area_major = $58,
    mls_area_minor = $59,
    mls = $60,
    move_in_date = $61,
    permit_address_internet_yn = $62,
    permit_comments_reviews_yn = $63,
    permit_internet_yn = $64,
    price_change_timestamp = CASE WHEN $65 = '' THEN NULL ELSE $65::timestamptz END,
    matrix_modified_dt = CASE WHEN $66 = '' THEN NULL ELSE $66::timestamptz END,
    property_association_fees = $67,
    showing_instructions_type = $68,
    special_notes = $69,
    tax_legal_description = $70,
    total_annual_expenses_include = $71,
    transaction_type = $72,
    virtual_tour_url_branded = $73,
    virtual_tour_url_unbranded = $74,
    active_option_contract_date = $75,
    keybox_type = $76,
    keybox_number = $77,
    close_date = $78,
    back_on_market_date = $79,
    deposit_amount = $80,
    photo_count = $81,
    dom = NOW() - $82 * INTERVAL '1 DAY',
    cdom = NOW() - $83 * INTERVAL '1 DAY',
    updated_at = NOW()
WHERE id = $84
