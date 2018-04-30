CREATE OR REPLACE VIEW analytics.deals AS
  WITH ct AS (
    SELECT * FROM
    crosstab($$
      WITH real_deals AS (
        SELECT
          deals.*
        FROM
          deals
          JOIN brands ON brands.id = deals.brand
        WHERE
          deals.brand NOT IN(
            SELECT
              brand_children(id)
            FROM
              brands
            WHERE
              training IS TRUE
          )
          AND brands.deleted_at IS NULL
          AND deals.deleted_at IS NULL
      ),
      contexts AS (
        SELECT
          ctx.*,
          real_deals.deal_type,
          real_deals.brand
        FROM
          current_deal_context as ctx
          INNER JOIN real_deals
            ON real_deals.id = ctx.deal
        WHERE key IN (
          'full_address',
          'sales_price',
          'leased_price',
          'original_price',
          'list_date',
          'expiration_date',
          'contract_date',
          'option_period',
          'financing_due',
          'title_due',
          't47_due',
          'closing_date',
          'possession_date',
          'lease_executed',
          'lease_application_date',
          'lease_begin',
          'lease_end',
          'year_built',
          'listing_status'
        )
      )
      SELECT id, deal_type, brand, "key", "value"
      FROM  (
        SELECT ctx.deal AS id, ctx.deal_type, ctx.brand, ctx.key, COALESCE(ctx.text, ctx.number::text, ctx.date::text) as "value"
        FROM   contexts AS ctx
      ) sub
      ORDER  BY id
    $$, $$ VALUES
      ('full_address'),
      ('sales_price'),
      ('leased_price'),
      ('original_price'),
      ('list_date'),
      ('expiration_date'),
      ('contract_date'),
      ('option_period'),
      ('financing_due'),
      ('title_due'),
      ('t47_due'),
      ('closing_date'),
      ('possession_date'),
      ('lease_executed'),
      ('lease_application_date'),
      ('lease_begin'),
      ('lease_end'),
      ('year_built'),
      ('listing_status')
    $$) t(
      id uuid,
      deal_type deal_type,
      brand uuid,
      full_address text,
      sales_price double precision,
      leased_price double precision,
      original_price double precision,
      list_date timestamptz,
      expiration_date timestamptz,
      contract_date timestamptz,
      option_period timestamptz,
      financing_due timestamptz,
      title_due timestamptz,
      t47_due timestamptz,
      closing_date timestamptz,
      possession_date timestamptz,
      lease_executed timestamptz,
      lease_application_date timestamptz,
      lease_begin timestamptz,
      lease_end timestamptz,
      year_built double precision,
      listing_status text
    )
  )
  SELECT ct.id,
    ct.deal_type,
    ct.brand,
    ct.full_address,
    ct.sales_price,
    ct.leased_price,
    ct.original_price,
    ct.list_date,
    ct.expiration_date,
    ct.contract_date,
    ct.option_period,
    ct.financing_due,
    ct.title_due,
    ct.t47_due,
    ct.closing_date,
    date_trunc('year', ct.closing_date) AS closing_date_year,
    date_trunc('quarter', ct.closing_date) AS closing_date_quarter,
    date_trunc('month', ct.closing_date) AS closing_date_month,
    date_trunc('week', ct.closing_date) AS closing_date_week,
    date_trunc('day', ct.closing_date) AS closing_date_day,
    ct.possession_date,
    ct.lease_executed,
    ct.lease_application_date,
    ct.lease_begin,
    ct.lease_end,
    ct.year_built,
    ct.listing_status,
    (dwrs.id IS NOT NULL) AS has_rejection
  FROM
    ct
    LEFT JOIN deals_with_rejected_submissions dwrs USING (id)