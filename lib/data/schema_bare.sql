--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: shortlisted; Type: SCHEMA; Schema: -; Owner: ashkan
--

-- CREATE SCHEMA shortlisted;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: ashkan
--

-- CREATE SCHEMA tiger;

--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner:
--

-- CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner:
--

-- COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner:
--

-- CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner:
--

-- COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner:
--

-- CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner:
--

-- COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: ashkan
--

-- CREATE SCHEMA topology;


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

-- CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

-- COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner:
--

-- CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner:
--

-- COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner:
--

-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner:
--

-- COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

--
-- Name: country_code_3; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE country_code_3 AS ENUM (
    'AFG',
    'ALA',
    'ALB',
    'DZA',
    'ASM',
    'AND',
    'AGO',
    'AIA',
    'ATA',
    'ATG',
    'ARG',
    'ARM',
    'ABW',
    'AUS',
    'AUT',
    'AZE',
    'BHS',
    'BHR',
    'BGD',
    'BRB',
    'BLR',
    'BEL',
    'BLZ',
    'BEN',
    'BMU',
    'BTN',
    'BOL',
    'BES',
    'BIH',
    'BWA',
    'BVT',
    'BRA',
    'IOT',
    'VGB',
    'BRN',
    'BGR',
    'BFA',
    'BDI',
    'KHM',
    'CMR',
    'CAN',
    'CPV',
    'CYM',
    'CAF',
    'TCD',
    'CHL',
    'CHN',
    'CXR',
    'CCK',
    'COL',
    'COM',
    'COG',
    'COD',
    'COK',
    'CRI',
    'HRV',
    'CUB',
    'CUW',
    'CYP',
    'CZE',
    'DNK',
    'DJI',
    'DMA',
    'DOM',
    'ECU',
    'EGY',
    'SLV',
    'GNQ',
    'ERI',
    'EST',
    'ETH',
    'FLK',
    'FRO',
    'FJI',
    'FIN',
    'FRA',
    'GUF',
    'PYF',
    'ATF',
    'GAB',
    'GMB',
    'GEO',
    'DEU',
    'GHA',
    'GIB',
    'GRC',
    'GRL',
    'GRD',
    'GLP',
    'GUM',
    'GTM',
    'GGY',
    'GIN',
    'GNB',
    'GUY',
    'HTI',
    'HMD',
    'VAT',
    'HND',
    'HKG',
    'HUN',
    'ISL',
    'IND',
    'IDN',
    'CIV',
    'IRN',
    'IRQ',
    'IRL',
    'IMN',
    'ISR',
    'ITA',
    'JAM',
    'JPN',
    'JEY',
    'JOR',
    'KAZ',
    'KEN',
    'KIR',
    'KWT',
    'KGZ',
    'LAO',
    'LVA',
    'LBN',
    'LSO',
    'LBR',
    'LBY',
    'LIE',
    'LTU',
    'LUX',
    'MAC',
    'MKD',
    'MDG',
    'MWI',
    'MYS',
    'MDV',
    'MLI',
    'MLT',
    'MHL',
    'MTQ',
    'MRT',
    'MUS',
    'MYT',
    'MEX',
    'FSM',
    'MDA',
    'MCO',
    'MNG',
    'MNE',
    'MSR',
    'MAR',
    'MOZ',
    'MMR',
    'NAM',
    'NRU',
    'NPL',
    'NLD',
    'NCL',
    'NZL',
    'NIC',
    'NER',
    'NGA',
    'NIU',
    'NFK',
    'PRK',
    'MNP',
    'NOR',
    'OMN',
    'PAK',
    'PLW',
    'PSE',
    'PAN',
    'PNG',
    'PRY',
    'PER',
    'PHL',
    'PCN',
    'POL',
    'PRT',
    'PRI',
    'QAT',
    'KOS',
    'REU',
    'ROU',
    'RUS',
    'RWA',
    'BLM',
    'SHN',
    'KNA',
    'LCA',
    'MAF',
    'SPM',
    'VCT',
    'WSM',
    'SMR',
    'STP',
    'SAU',
    'SEN',
    'SRB',
    'SYC',
    'SLE',
    'SGP',
    'SXM',
    'SVK',
    'SVN',
    'SLB',
    'SOM',
    'ZAF',
    'SGS',
    'KOR',
    'SSD',
    'ESP',
    'LKA',
    'SDN',
    'SUR',
    'SJM',
    'SWZ',
    'SWE',
    'CHE',
    'SYR',
    'TWN',
    'TJK',
    'TZA',
    'THA',
    'TLS',
    'TGO',
    'TKL',
    'TON',
    'TTO',
    'TUN',
    'TUR',
    'TKM',
    'TCA',
    'TUV',
    'UGA',
    'UKR',
    'ARE',
    'GBR',
    'USA',
    'UMI',
    'VIR',
    'URY',
    'UZB',
    'VUT',
    'VEN',
    'VNM',
    'WLF',
    'ESH',
    'YEM',
    'ZMB',
    'ZWE'
);


--
-- Name: country_name; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE country_name AS ENUM (
    'Afghanistan',
    'Åland Islands',
    'Albania',
    'Algeria',
    'American Samoa',
    'Andorra',
    'Angola',
    'Anguilla',
    'Antarctica',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Aruba',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bermuda',
    'Bhutan',
    'Bolivia',
    'Bonaire',
    'Bosnia and Herzegovina',
    'Botswana',
    'Bouvet Island',
    'Brazil',
    'British Indian Ocean Territory',
    'British Virgin Islands',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Cape Verde',
    'Cayman Islands',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Christmas Island',
    'Cocos (Keeling) Islands',
    'Colombia',
    'Comoros',
    'Republic of the Congo',
    'DR Congo',
    'Cook Islands',
    'Costa Rica',
    'Croatia',
    'Cuba',
    'Curaçao',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Ethiopia',
    'Falkland Islands',
    'Faroe Islands',
    'Fiji',
    'Finland',
    'France',
    'French Guiana',
    'French Polynesia',
    'French Southern and Antarctic Lands',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Gibraltar',
    'Greece',
    'Greenland',
    'Grenada',
    'Guadeloupe',
    'Guam',
    'Guatemala',
    'Guernsey',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Heard Island and McDonald Islands',
    'Vatican City',
    'Honduras',
    'Hong Kong',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Ivory Coast',
    'Iran',
    'Iraq',
    'Ireland',
    'Isle of Man',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jersey',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Macau',
    'Macedonia',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Martinique',
    'Mauritania',
    'Mauritius',
    'Mayotte',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Montserrat',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Caledonia',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'Niue',
    'Norfolk Island',
    'North Korea',
    'Northern Mariana Islands',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestine',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Pitcairn Islands',
    'Poland',
    'Portugal',
    'Puerto Rico',
    'Qatar',
    'Kosovo',
    'Réunion',
    'Romania',
    'Russia',
    'Rwanda',
    'Saint Barthélemy',
    'Saint Helena, Ascension and Tristan da Cunha',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Martin',
    'Saint Pierre and Miquelon',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'São Tomé and Príncipe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Sint Maarten',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Georgia',
    'South Korea',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Svalbard and Jan Mayen',
    'Swaziland',
    'Sweden',
    'Switzerland',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Timor-Leste',
    'Togo',
    'Tokelau',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Turks and Caicos Islands',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States',
    'United States Minor Outlying Islands',
    'United States Virgin Islands',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Venezuela',
    'Vietnam',
    'Wallis and Futuna',
    'Western Sahara',
    'Yemen',
    'Zambia',
    'Zimbabwe'
);


--
-- Name: currency_code; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE currency_code AS ENUM (
    'AFN',
    'EUR',
    'ALL',
    'DZD',
    'USD',
    'AOA',
    'XCD',
    'ARS',
    'AMD',
    'AWG',
    'AUD',
    'AZN',
    'BSD',
    'BHD',
    'BDT',
    'BBD',
    'BYR',
    'BZD',
    'BMD',
    'BTN',
    'BOB',
    'BAM',
    'BWP',
    'NOK',
    'BRL',
    'BND',
    'BGN',
    'BIF',
    'KHR',
    'XAF',
    'CAD',
    'CVE',
    'KYD',
    'CLF',
    'CNY',
    'COP',
    'KMF',
    'CDF',
    'NZD',
    'CRC',
    'HRK',
    'CUC',
    'ANG',
    'CZK',
    'DJF',
    'DOP',
    'EGP',
    'SVC',
    'ERN',
    'ETB',
    'FKP',
    'DKK',
    'FJD',
    'XPF',
    'GMD',
    'GEL',
    'GHS',
    'GIP',
    'GTQ',
    'GBP',
    'GNF',
    'GYD',
    'HTG',
    'HNL',
    'HKD',
    'HUF',
    'ISK',
    'INR',
    'IDR',
    'IRR',
    'IQD',
    'JMD',
    'JPY',
    'JOD',
    'KZT',
    'KES',
    'KWD',
    'KGS',
    'LAK',
    'LBP',
    'LSL',
    'LRD',
    'LYD',
    'CHF',
    'LTL',
    'MOP',
    'MKD',
    'MGA',
    'MWK',
    'MYR',
    'MVR',
    'MRO',
    'MUR',
    'MXN',
    'MDL',
    'MNT',
    'MZN',
    'MMK',
    'NAD',
    'NPR',
    'NIO',
    'XOF',
    'NGN',
    'KPW',
    'OMR',
    'PKR',
    'ILS',
    'PAB',
    'PGK',
    'PYG',
    'PEN',
    'PHP',
    'PLN',
    'QAR',
    'RON',
    'RUB',
    'RWF',
    'SHP',
    'WST',
    'STD',
    'SAR',
    'RSD',
    'SCR',
    'SLL',
    'SGD',
    'SDB',
    'SOS',
    'ZAR',
    'KRW',
    'SSP',
    'LKR',
    'SDG',
    'SRD',
    'SZL',
    'SEK',
    'CHE',
    'SYP',
    'TWD',
    'TJS',
    'TZS',
    'THB',
    'TOP',
    'TTD',
    'TND',
    'TRY',
    'TMT',
    'UGX',
    'UAH',
    'AED',
    'UYI',
    'UZS',
    'VUV',
    'VEF',
    'VND',
    'MAD',
    'YER',
    'ZMK',
    'ZWL'
);


--
-- Name: listing_status; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE listing_status AS ENUM (
    'Active',
    'Sold',
    'Pending',
    'Temp Off Market',
    'Leased',
    'Active Option Contract',
    'Active Contingent',
    'Active Kick Out',
    'Withdrawn',
    'Expired',
    'Cancelled',
    'Withdrawn Sublisting',
    'Incomplete'
);


--
-- Name: mam_behaviour; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE mam_behaviour AS ENUM (
    'A',
    'N',
    'R'
);


--
-- Name: mam_direction; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE mam_direction AS ENUM (
    'I',
    'O'
);


--
-- Name: message_room_type; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE message_room_type AS ENUM (
    'Shortlist',
    'Comment',
    'GroupMessaging',
    'OneToOneMessaging'
);


--
-- Name: message_type; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE message_type AS ENUM (
    'TopLevel',
    'SubLevel'
);


--
-- Name: notification_action; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE notification_action AS ENUM (
    'Liked',
    'Composed',
    'Edited',
    'Added',
    'Removed',
    'Posted',
    'Favorited',
    'Changed',
    'Created',
    'Shared',
    'Arrived',
    'Toured',
    'Accepted',
    'Declined',
    'Joined',
    'Left',
    'Archived',
    'Deleted',
    'Opened',
    'Closed',
    'Pinned',
    'Sent'
);


--
-- Name: notification_object_class; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE notification_object_class AS ENUM (
    'Recommendation',
    'Listing',
    'Message',
    'Comment',
    'Room',
    'HotSheet',
    'Photo',
    'Video',
    'Document',
    'Tour',
    'Co-Shopper',
    'Price',
    'Status',
    'MessageRoom',
    'Shortlist'
);


--
-- Name: property_subtype; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE property_subtype AS ENUM (
    'MUL-Apartment/5Plex+',
    'MUL-Fourplex',
    'MUL-Full Duplex',
    'MUL-Multiple Single Units',
    'MUL-Triplex',
    'LSE-Apartment',
    'LSE-Condo/Townhome',
    'LSE-Duplex',
    'LSE-Fourplex',
    'LSE-House',
    'LSE-Mobile',
    'LSE-Triplex',
    'LND-Commercial',
    'LND-Farm/Ranch',
    'LND-Residential',
    'RES-Condo',
    'RES-Farm/Ranch',
    'RES-Half Duplex',
    'RES-Single Family',
    'RES-Townhouse',
    'COM-Lease',
    'COM-Sale',
    'COM-Sale or Lease (Either)',
    'COM-Sale/Leaseback (Both)',
    'Unknown'
);


--
-- Name: property_type; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE property_type AS ENUM (
    'Residential',
    'Residential Lease',
    'Multi-Family',
    'Commercial',
    'Lots & Acreage',
    'Unknown'
);


--
-- Name: recommendation_status; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE recommendation_status AS ENUM (
    'Unacknowledged',
    'Pinned',
    'Unpinned'
);


--
-- Name: recommendation_type; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE recommendation_type AS ENUM (
    'Listing',
    'Agent',
    'Bank',
    'Card'
);


--
-- Name: shortlist_status; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE shortlist_status AS ENUM (
    'New',
    'Searching',
    'Touring',
    'OnHold',
    'Closing',
    'ClosedCanceled',
    'ClosedSuccess'
);


--
-- Name: shortlist_type; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE shortlist_type AS ENUM (
    'Shoppers',
    'Sellers'
);


--
-- Name: source_type; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE source_type AS ENUM (
    'MLS',
    'Zillow',
    'RCRRE'
);


--
-- Name: user_on_room_status; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE user_on_room_status AS ENUM (
    'Active',
    'Muted'
);


--
-- Name: user_status; Type: TYPE; Schema: public; Owner: ashkan
--

CREATE TYPE user_status AS ENUM (
    'Deleted',
    'De-Activated',
    'Restricted',
    'Banned',
    'Active'
);


--
-- Name: uuid_timestamp(uuid); Type: FUNCTION; Schema: public; Owner: ashkan
--

CREATE FUNCTION uuid_timestamp(id uuid) RETURNS timestamp with time zone
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  select TIMESTAMP WITH TIME ZONE 'epoch' +
      ( ( ( ('x' || lpad(split_part(id::text, '-', 1), 16, '0'))::bit(64)::bigint) +
      (('x' || lpad(split_part(id::text, '-', 2), 16, '0'))::bit(64)::bigint << 32) +
      ((('x' || lpad(split_part(id::text, '-', 3), 16, '0'))::bit(64)::bigint&4095) << 48) - 122192928000000000) / 10) * INTERVAL '1 microsecond';
$$;


--
-- Name: wipe_everything(); Type: FUNCTION; Schema: public; Owner: ashkan
--

CREATE FUNCTION wipe_everything() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
TRUNCATE TABLE recommendations CASCADE;
TRUNCATE TABLE messages CASCADE;
TRUNCATE TABLE message_rooms_users CASCADE;
TRUNCATE TABLE message_rooms CASCADE;
TRUNCATE TABLE shortlists_users CASCADE;
TRUNCATE TABLE shortlists CASCADE;
TRUNCATE TABLE invitation_records CASCADE;
TRUNCATE TABLE notifications CASCADE;
TRUNCATE TABLE alerts CASCADE;
TRUNCATE TABLE contacts CASCADE;
TRUNCATE TABLE notification_tokens CASCADE;
TRUNCATE TABLE messages_ack CASCADE;END;
$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE addresses (
    title text,
    subtitle text,
    street_number text,
    street_name text,
    city text,
    state text,
    state_code text,
    postal_code text,
    neighborhood text,
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    street_suffix text,
    unit_number text,
    country country_name NOT NULL,
    country_code country_code_3 NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    location geometry(Point,4326),
    matrix_unique_id bigint
);


--
-- Name: agencies; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE agencies (
    name character varying(255),
    phone_number character varying(20),
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    cover_image_url text DEFAULT 'http://emilsedgh.info:8088/agencies/cover.jpg'::text,
    profile_image_url text DEFAULT 'http://emilsedgh.info:8088/agencies/profile.jpg'::text,
    address_id uuid
);


--
-- Name: alerts; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE alerts (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    currency currency_code NOT NULL,
    minimum_price double precision NOT NULL,
    maximum_price double precision NOT NULL,
    minimum_square_meters double precision NOT NULL,
    maximum_square_meters double precision NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    location geometry(Point,4326),
    shortlist uuid NOT NULL,
    min_bedrooms smallint NOT NULL,
    min_bathrooms double precision NOT NULL,
    cover_image_url text,
    title character varying(255),
    property_type property_type NOT NULL,
    property_subtypes property_subtype[] NOT NULL,
    points geometry(Polygon,4326),
    horizontal_distance double precision NOT NULL,
    vertical_distance double precision NOT NULL
);


--
-- Name: clients; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE clients (
    id uuid DEFAULT uuid_generate_v1(),
    version character varying(10),
    response jsonb,
    secret character varying(255),
    name character varying(255)
);


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE contacts (
    id uuid DEFAULT uuid_generate_v4(),
    user_id uuid NOT NULL,
    contact_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: events; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE events (
    action character varying(10),
    "timestamp" timestamp without time zone,
    subject_type character varying(10),
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    subject_id uuid,
    user_id uuid
);


--
-- Name: foo; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE foo (
    property_types property_type[]
);


--
-- Name: invitation_records; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE invitation_records (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    invited_user uuid,
    email character varying(50) NOT NULL,
    resource uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    accepted boolean DEFAULT false,
    inviting_user uuid NOT NULL
);


--
-- Name: last; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE last (
    username character varying(250) NOT NULL,
    seconds integer NOT NULL,
    state text NOT NULL
);


--
-- Name: listings; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE listings (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    property_id uuid,
    alerting_agent_id uuid,
    listing_agent_id uuid,
    listing_agency_id uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    cover_image_url text,
    currency currency_code,
    price double precision,
    gallery_image_urls text[],
    matrix_unique_id bigint NOT NULL,
    original_price double precision,
    last_price double precision,
    low_price double precision,
    status listing_status NOT NULL,
    association_fee double precision,
    mls_number text,
    association_fee_frequency text,
    association_fee_includes text,
    association_type text,
    unexempt_taxes double precision,
    financing_proposed text,
    list_office_mui bigint,
    list_office_mls_id text,
    list_office_name text,
    list_office_phone text,
    possession text,
    co_list_office_mui bigint,
    co_list_office_mls_id text,
    co_list_office_name text,
    co_list_office_phone text,
    selling_office_mui bigint,
    selling_office_mls_id text,
    selling_office_name text,
    selling_office_phone text,
    co_selling_office_mui bigint,
    co_selling_office_mls_id text,
    co_selling_office_name text,
    co_selling_office_phone text,
    list_agent_mui bigint,
    list_agent_direct_work_phone text,
    list_agent_email text,
    list_agent_full_name text,
    list_agent_mls_id text,
    co_list_agent_mui bigint,
    co_list_agent_direct_work_phone text,
    co_list_agent_email text,
    co_list_agent_full_name text,
    co_list_agent_mls_id text,
    selling_agent_mui bigint,
    selling_agent_direct_work_phone text,
    selling_agent_email text,
    selling_agent_full_name text,
    selling_agent_mls_id text,
    co_selling_agent_mui bigint,
    co_selling_agent_direct_work_phone text,
    co_selling_agent_email text,
    co_selling_agent_full_name text,
    co_selling_agent_mls_id text,
    listing_agreement text
);


--
-- Name: logs; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE logs (
    level text,
    message text,
    meta jsonb,
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    "time" timestamp without time zone
);


--
-- Name: mam_config; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE mam_config (
    user_id integer NOT NULL,
    remote_jid character varying(250) NOT NULL,
    behaviour mam_behaviour NOT NULL
);


--
-- Name: mam_message; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE mam_message (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    from_jid character varying(250) NOT NULL,
    remote_bare_jid character varying(250) NOT NULL,
    remote_resource character varying(250) NOT NULL,
    direction mam_direction NOT NULL,
    message bytea NOT NULL
);


--
-- Name: mam_muc_message; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE mam_muc_message (
    id bigint NOT NULL,
    room_id integer NOT NULL,
    nick_name character varying(250) NOT NULL,
    message bytea NOT NULL
);


--
-- Name: mam_server_user; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE mam_server_user (
    id integer NOT NULL,
    server character varying(250) NOT NULL,
    user_name character varying(250) NOT NULL
);


--
-- Name: mam_server_user_id_seq; Type: SEQUENCE; Schema: public; Owner: ashkan
--

CREATE SEQUENCE mam_server_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mam_server_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ashkan
--

ALTER SEQUENCE mam_server_user_id_seq OWNED BY mam_server_user.id;


--
-- Name: mam_user; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE mam_user (
    id integer NOT NULL,
    user_name character varying(250) NOT NULL
);


--
-- Name: mam_user_id_seq; Type: SEQUENCE; Schema: public; Owner: ashkan
--

CREATE SEQUENCE mam_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mam_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ashkan
--

ALTER SEQUENCE mam_user_id_seq OWNED BY mam_user.id;


--
-- Name: message_rooms; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE message_rooms (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    listing uuid,
    shortlist uuid,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    message_room_type message_room_type NOT NULL
);


--
-- Name: message_rooms_users; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE message_rooms_users (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    message_room uuid NOT NULL,
    "user" uuid NOT NULL,
    user_status user_on_room_status DEFAULT 'Active'::user_on_room_status NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: messages; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE messages (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    comment text,
    image_url text,
    document_url text,
    video_url text,
    object uuid,
    author uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    message_room uuid NOT NULL,
    message_type message_type NOT NULL,
    image_thumbnail_url text
);


--
-- Name: messages_ack; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE messages_ack (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    message_id uuid NOT NULL,
    message_room_id uuid NOT NULL,
    read boolean DEFAULT false,
    user_id uuid NOT NULL
);


--
-- Name: notification_tokens; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE notification_tokens (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    "user" uuid NOT NULL,
    device_token text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE notifications (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    object uuid,
    message text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    notified_user uuid NOT NULL,
    shortlist uuid NOT NULL,
    read boolean DEFAULT false,
    action notification_action NOT NULL,
    object_class notification_object_class NOT NULL,
    notifying_user uuid,
    auxiliary_object_class notification_object_class,
    auxiliary_object uuid,
    recommendation uuid
);


--
-- Name: offline_message; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE offline_message (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    expire bigint,
    server character varying(250) NOT NULL,
    username character varying(250) NOT NULL,
    from_jid character varying(250) NOT NULL,
    packet text NOT NULL
);


--
-- Name: offline_message_id_seq; Type: SEQUENCE; Schema: public; Owner: ashkan
--

CREATE SEQUENCE offline_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: offline_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ashkan
--

ALTER SEQUENCE offline_message_id_seq OWNED BY offline_message.id;


--
-- Name: privacy_default_list; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE privacy_default_list (
    username character varying(250) NOT NULL,
    name text NOT NULL
);


--
-- Name: privacy_list; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE privacy_list (
    username character varying(250) NOT NULL,
    name text NOT NULL,
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: privacy_list_data; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE privacy_list_data (
    id bigint,
    t character(1) NOT NULL,
    value text NOT NULL,
    action character(1) NOT NULL,
    ord numeric NOT NULL,
    match_all boolean NOT NULL,
    match_iq boolean NOT NULL,
    match_message boolean NOT NULL,
    match_presence_in boolean NOT NULL,
    match_presence_out boolean NOT NULL
);


--
-- Name: privacy_list_id_seq; Type: SEQUENCE; Schema: public; Owner: ashkan
--

CREATE SEQUENCE privacy_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: privacy_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ashkan
--

ALTER SEQUENCE privacy_list_id_seq OWNED BY privacy_list.id;


--
-- Name: private_storage; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE private_storage (
    username character varying(250) NOT NULL,
    namespace text NOT NULL,
    data text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: properties; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE properties (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    bedroom_count integer,
    bathroom_count double precision,
    address_id uuid,
    description text,
    square_meters double precision,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    matrix_unique_id bigint NOT NULL,
    property_type property_type NOT NULL,
    property_subtype property_subtype NOT NULL,
    lot_square_meters double precision,
    year_built smallint,
    accessibility_features text[],
    commercial_features text[],
    community_features text[],
    energysaving_features text[],
    exterior_features text[],
    interior_features text[],
    farmranch_features text[],
    fireplace_features text[],
    lot_features text[],
    parking_features text[],
    pool_features text[],
    security_features text[],
    bedroom_bathroom_features text[],
    parking_spaces_covered_total double precision,
    half_bathroom_count double precision,
    full_bathroom_count double precision,
    heating text[],
    flooring text[],
    utilities text[],
    utilities_other text[],
    architectural_style text,
    structural_style text,
    number_of_stories smallint,
    number_of_stories_in_building smallint,
    number_of_parking_spaces double precision,
    parking_spaces_carport double precision,
    parking_spaces_garage double precision,
    garage_length double precision,
    garage_width double precision,
    number_of_dining_areas smallint,
    number_of_living_areas smallint,
    fireplaces_total smallint,
    lot_number text,
    soil_type text,
    construction_materials text,
    construction_materials_walls text,
    foundation_details text,
    roof text,
    pool_yn boolean,
    handicap_yn boolean,
    elementary_school_name text,
    intermediate_school_name text,
    high_school_name text,
    junior_high_school_name text,
    middle_school_name text,
    primary_school_name text,
    senior_high_school_name text,
    school_district text,
    subdivision_name text
);


--
-- Name: recommendations; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE recommendations (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    source source_type,
    source_url text,
    referring_user uuid NOT NULL,
    referred_shortlist uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    object uuid NOT NULL,
    message_room uuid,
    recommendation_type recommendation_type,
    favorited boolean DEFAULT false,
    status recommendation_status DEFAULT 'Unacknowledged'::recommendation_status,
    matrix_unique_id bigint NOT NULL,
    referring_alerts uuid[]
);


--
-- Name: roster_version; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE roster_version (
    username character varying(250) NOT NULL,
    version text NOT NULL
);


--
-- Name: rostergroups; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE rostergroups (
    username character varying(250) NOT NULL,
    jid text NOT NULL,
    grp text NOT NULL
);


--
-- Name: rosterusers; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE rosterusers (
    username character varying(250) NOT NULL,
    jid text NOT NULL,
    nick text NOT NULL,
    subscription character(1) NOT NULL,
    ask character(1) NOT NULL,
    askmessage text NOT NULL,
    server character(1) NOT NULL,
    subscribe text,
    type text,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE sessions (
    id uuid DEFAULT uuid_generate_v1(),
    device_uuid uuid,
    device_name character varying(255),
    client_version character varying(30),
    created_time timestamp without time zone DEFAULT now()
);


--
-- Name: shortlists; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE shortlists (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    shortlist_type shortlist_type NOT NULL,
    title text,
    owner uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    status shortlist_status DEFAULT 'New'::shortlist_status,
    alert_index smallint DEFAULT 1
);


--
-- Name: shortlists_users; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE shortlists_users (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    "user" uuid NOT NULL,
    shortlist uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE tokens (
    id uuid DEFAULT uuid_generate_v1(),
    token character varying(60),
    client_id uuid,
    type character varying(10),
    user_id uuid,
    expire_date timestamp without time zone
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE users (
    username text,
    first_name text,
    last_name text,
    email text NOT NULL,
    phone_number text,
    type text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    agency_id uuid,
    password character varying(512) NOT NULL,
    address_id uuid,
    cover_image_url text DEFAULT 'http://emilsedgh.info:8088/users/cover.jpg'::text,
    profile_image_url text DEFAULT 'http://emilsedgh.info:8088/users/profile.jpg'::text,
    updated_at timestamp with time zone DEFAULT now(),
    user_status user_status DEFAULT 'Active'::user_status NOT NULL,
    profile_image_thumbnail_url text,
    cover_image_thumbnail_url text
);


--
-- Name: vcard; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE vcard (
    username character varying(150) NOT NULL,
    server character varying(100) NOT NULL,
    vcard text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: vcard_search; Type: TABLE; Schema: public; Owner: ashkan; Tablespace:
--

CREATE TABLE vcard_search (
    username character varying(150) NOT NULL,
    lusername character varying(100) NOT NULL,
    server character varying(250) NOT NULL,
    fn text NOT NULL,
    lfn text NOT NULL,
    family text NOT NULL,
    lfamily text NOT NULL,
    given text NOT NULL,
    lgiven text NOT NULL,
    middle text NOT NULL,
    lmiddle text NOT NULL,
    nickname text NOT NULL,
    lnickname text NOT NULL,
    bday text NOT NULL,
    lbday text NOT NULL,
    ctry text NOT NULL,
    lctry text NOT NULL,
    locality text NOT NULL,
    llocality text NOT NULL,
    email text NOT NULL,
    lemail text NOT NULL,
    orgname text NOT NULL,
    lorgname text NOT NULL,
    orgunit text NOT NULL,
    lorgunit text NOT NULL
);


SET search_path = tiger, pg_catalog;

--
-- Name: foo; Type: TABLE; Schema: tiger; Owner: ashkan; Tablespace:
--

CREATE TABLE foo (
    geom public.geometry(Point,4326),
    title text
);


SET search_path = public, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY mam_server_user ALTER COLUMN id SET DEFAULT nextval('mam_server_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY mam_user ALTER COLUMN id SET DEFAULT nextval('mam_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY offline_message ALTER COLUMN id SET DEFAULT nextval('offline_message_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY privacy_list ALTER COLUMN id SET DEFAULT nextval('privacy_list_id_seq'::regclass);


--
-- Name: addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: agencies_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY agencies
    ADD CONSTRAINT agencies_pkey PRIMARY KEY (id);


--
-- Name: alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (id);


--
-- Name: contacts_user_id_contact_id_key; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_user_id_contact_id_key UNIQUE (user_id, contact_id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: invitation_records_email_resource_key; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY invitation_records
    ADD CONSTRAINT invitation_records_email_resource_key UNIQUE (email, resource);


--
-- Name: invitation_records_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY invitation_records
    ADD CONSTRAINT invitation_records_pkey PRIMARY KEY (id);


--
-- Name: invitation_records_referring_user_resource_key; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY invitation_records
    ADD CONSTRAINT invitation_records_referring_user_resource_key UNIQUE (invited_user, resource);


--
-- Name: last_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY last
    ADD CONSTRAINT last_pkey PRIMARY KEY (username);


--
-- Name: listings_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (id);


--
-- Name: logs_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: mam_message_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY mam_message
    ADD CONSTRAINT mam_message_pkey PRIMARY KEY (id);


--
-- Name: mam_muc_message_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY mam_muc_message
    ADD CONSTRAINT mam_muc_message_pkey PRIMARY KEY (id);


--
-- Name: mam_server_user_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY mam_server_user
    ADD CONSTRAINT mam_server_user_pkey PRIMARY KEY (id);


--
-- Name: mam_user_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY mam_user
    ADD CONSTRAINT mam_user_pkey PRIMARY KEY (id);


--
-- Name: message_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY message_rooms
    ADD CONSTRAINT message_rooms_pkey PRIMARY KEY (id);


--
-- Name: message_rooms_users_message_room_user_key; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY message_rooms_users
    ADD CONSTRAINT message_rooms_users_message_room_user_key UNIQUE (message_room, "user");


--
-- Name: message_rooms_users_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY message_rooms_users
    ADD CONSTRAINT message_rooms_users_pkey PRIMARY KEY (id);


--
-- Name: messages_ack_message_id_message_room_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY messages_ack
    ADD CONSTRAINT messages_ack_message_id_message_room_id_user_id_key UNIQUE (message_id, message_room_id, user_id);


--
-- Name: messages_ack_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY messages_ack
    ADD CONSTRAINT messages_ack_pkey PRIMARY KEY (id);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: notification_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY notification_tokens
    ADD CONSTRAINT notification_tokens_pkey PRIMARY KEY (id);


--
-- Name: notification_tokens_user_device_token_key; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY notification_tokens
    ADD CONSTRAINT notification_tokens_user_device_token_key UNIQUE ("user", device_token);


--
-- Name: notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: offline_message_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY offline_message
    ADD CONSTRAINT offline_message_pkey PRIMARY KEY (id);


--
-- Name: privacy_default_list_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY privacy_default_list
    ADD CONSTRAINT privacy_default_list_pkey PRIMARY KEY (username);


--
-- Name: privacy_list_id_key; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY privacy_list
    ADD CONSTRAINT privacy_list_id_key UNIQUE (id);


--
-- Name: properties_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY properties
    ADD CONSTRAINT properties_pkey PRIMARY KEY (id);


--
-- Name: recommendations_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY recommendations
    ADD CONSTRAINT recommendations_pkey PRIMARY KEY (id);


--
-- Name: recommendations_referred_shortlist_referring_user_object_key; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY recommendations
    ADD CONSTRAINT recommendations_referred_shortlist_referring_user_object_key UNIQUE (referred_shortlist, referring_user, object);


--
-- Name: roster_version_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY roster_version
    ADD CONSTRAINT roster_version_pkey PRIMARY KEY (username);


--
-- Name: shortlists_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY shortlists
    ADD CONSTRAINT shortlists_pkey PRIMARY KEY (id);


--
-- Name: shortlists_users_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY shortlists_users
    ADD CONSTRAINT shortlists_users_pkey PRIMARY KEY (id);


--
-- Name: unique_user_shortlist_key; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY shortlists_users
    ADD CONSTRAINT unique_user_shortlist_key UNIQUE ("user", shortlist);


--
-- Name: users_email_key; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vcard_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY vcard
    ADD CONSTRAINT vcard_pkey PRIMARY KEY (server, username);


--
-- Name: vcard_search_pkey; Type: CONSTRAINT; Schema: public; Owner: ashkan; Tablespace:
--

ALTER TABLE ONLY vcard_search
    ADD CONSTRAINT vcard_search_pkey PRIMARY KEY (server, lusername);


--
-- Name: i_last_seconds; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_last_seconds ON last USING btree (seconds);


--
-- Name: i_mam_config; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_mam_config ON mam_config USING btree (user_id, remote_jid);


--
-- Name: i_mam_message_username_id; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_mam_message_username_id ON mam_message USING btree (user_id, id);


--
-- Name: i_mam_message_username_jid_id; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_mam_message_username_jid_id ON mam_message USING btree (user_id, remote_bare_jid, id);


--
-- Name: i_mam_muc_message_room_name_added_at; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_mam_muc_message_room_name_added_at ON mam_muc_message USING btree (room_id, id);


--
-- Name: i_mam_server_user_name; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE UNIQUE INDEX i_mam_server_user_name ON mam_server_user USING btree (server, user_name);


--
-- Name: i_mam_user_name; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE UNIQUE INDEX i_mam_user_name ON mam_user USING btree (user_name);


--
-- Name: i_offline_message; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_offline_message ON offline_message USING btree (server, username, id);


--
-- Name: i_privacy_list_username; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_privacy_list_username ON privacy_list USING btree (username);


--
-- Name: i_privacy_list_username_name; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE UNIQUE INDEX i_privacy_list_username_name ON privacy_list USING btree (username, name);


--
-- Name: i_private_storage_username; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_private_storage_username ON private_storage USING btree (username);


--
-- Name: i_private_storage_username_namespace; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE UNIQUE INDEX i_private_storage_username_namespace ON private_storage USING btree (username, namespace);


--
-- Name: i_rosteru_jid; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_rosteru_jid ON rosterusers USING btree (jid);


--
-- Name: i_rosteru_user_jid; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE UNIQUE INDEX i_rosteru_user_jid ON rosterusers USING btree (username, jid);


--
-- Name: i_rosteru_username; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_rosteru_username ON rosterusers USING btree (username);


--
-- Name: i_vcard_search_lbday; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_vcard_search_lbday ON vcard_search USING btree (lbday);


--
-- Name: i_vcard_search_lctry; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_vcard_search_lctry ON vcard_search USING btree (lctry);


--
-- Name: i_vcard_search_lemail; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_vcard_search_lemail ON vcard_search USING btree (lemail);


--
-- Name: i_vcard_search_lfamily; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_vcard_search_lfamily ON vcard_search USING btree (lfamily);


--
-- Name: i_vcard_search_lfn; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_vcard_search_lfn ON vcard_search USING btree (lfn);


--
-- Name: i_vcard_search_lgiven; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_vcard_search_lgiven ON vcard_search USING btree (lgiven);


--
-- Name: i_vcard_search_llocality; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_vcard_search_llocality ON vcard_search USING btree (llocality);


--
-- Name: i_vcard_search_lmiddle; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_vcard_search_lmiddle ON vcard_search USING btree (lmiddle);


--
-- Name: i_vcard_search_lnickname; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_vcard_search_lnickname ON vcard_search USING btree (lnickname);


--
-- Name: i_vcard_search_lorgname; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_vcard_search_lorgname ON vcard_search USING btree (lorgname);


--
-- Name: i_vcard_search_lorgunit; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX i_vcard_search_lorgunit ON vcard_search USING btree (lorgunit);


--
-- Name: pk_rosterg_user_jid; Type: INDEX; Schema: public; Owner: ashkan; Tablespace:
--

CREATE INDEX pk_rosterg_user_jid ON rostergroups USING btree (username, jid);


--
-- Name: agencies_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY agencies
    ADD CONSTRAINT agencies_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(id);


--
-- Name: alerts_shortlist_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY alerts
    ADD CONSTRAINT alerts_shortlist_fkey FOREIGN KEY (shortlist) REFERENCES shortlists(id);


--
-- Name: invitation_records_invited_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY invitation_records
    ADD CONSTRAINT invitation_records_invited_user_fkey FOREIGN KEY (invited_user) REFERENCES users(id);


--
-- Name: invitation_records_inviting_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY invitation_records
    ADD CONSTRAINT invitation_records_inviting_user_fkey FOREIGN KEY (inviting_user) REFERENCES users(id);


--
-- Name: invitation_records_resource_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY invitation_records
    ADD CONSTRAINT invitation_records_resource_fkey FOREIGN KEY (resource) REFERENCES shortlists(id);


--
-- Name: listings_alerting_agent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_alerting_agent_fkey FOREIGN KEY (alerting_agent_id) REFERENCES users(id);


--
-- Name: listings_listing_agency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_listing_agency_id_fkey FOREIGN KEY (listing_agency_id) REFERENCES agencies(id);


--
-- Name: listings_listing_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_listing_agent_id_fkey FOREIGN KEY (listing_agent_id) REFERENCES users(id);


--
-- Name: listings_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_property_id_fkey FOREIGN KEY (property_id) REFERENCES properties(id);


--
-- Name: message_rooms_listing_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY message_rooms
    ADD CONSTRAINT message_rooms_listing_fkey FOREIGN KEY (listing) REFERENCES listings(id);


--
-- Name: message_rooms_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY message_rooms
    ADD CONSTRAINT message_rooms_owner_fkey FOREIGN KEY (owner) REFERENCES users(id);


--
-- Name: message_rooms_shortlist_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY message_rooms
    ADD CONSTRAINT message_rooms_shortlist_fkey FOREIGN KEY (shortlist) REFERENCES shortlists(id);


--
-- Name: message_rooms_users_message_room_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY message_rooms_users
    ADD CONSTRAINT message_rooms_users_message_room_fkey FOREIGN KEY (message_room) REFERENCES message_rooms(id);


--
-- Name: message_rooms_users_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY message_rooms_users
    ADD CONSTRAINT message_rooms_users_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: messages_ack_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY messages_ack
    ADD CONSTRAINT messages_ack_message_id_fkey FOREIGN KEY (message_id) REFERENCES messages(id);


--
-- Name: messages_ack_message_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY messages_ack
    ADD CONSTRAINT messages_ack_message_room_id_fkey FOREIGN KEY (message_room_id) REFERENCES message_rooms(id);


--
-- Name: messages_ack_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY messages_ack
    ADD CONSTRAINT messages_ack_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: messages_author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_author_fkey FOREIGN KEY (author) REFERENCES users(id);


--
-- Name: messages_message_room_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_message_room_fkey FOREIGN KEY (message_room) REFERENCES message_rooms(id);


--
-- Name: messages_object_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_object_fkey FOREIGN KEY (object) REFERENCES listings(id);


--
-- Name: notification_tokens_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY notification_tokens
    ADD CONSTRAINT notification_tokens_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: notifications_notified_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_notified_user_fkey FOREIGN KEY (notified_user) REFERENCES users(id);


--
-- Name: notifications_notifying_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_notifying_user_fkey FOREIGN KEY (notifying_user) REFERENCES users(id);


--
-- Name: notifications_shortlist_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_shortlist_fkey FOREIGN KEY (shortlist) REFERENCES shortlists(id);


--
-- Name: privacy_list_data_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY privacy_list_data
    ADD CONSTRAINT privacy_list_data_id_fkey FOREIGN KEY (id) REFERENCES privacy_list(id) ON DELETE CASCADE;


--
-- Name: properties_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY properties
    ADD CONSTRAINT properties_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(id);


--
-- Name: recommendations_object_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY recommendations
    ADD CONSTRAINT recommendations_object_fkey FOREIGN KEY (object) REFERENCES listings(id);


--
-- Name: recommendations_referring_shortlist_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY recommendations
    ADD CONSTRAINT recommendations_referring_shortlist_fkey FOREIGN KEY (referred_shortlist) REFERENCES shortlists(id);


--
-- Name: recommendations_referring_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY recommendations
    ADD CONSTRAINT recommendations_referring_user_fkey FOREIGN KEY (referring_user) REFERENCES users(id);


--
-- Name: shortlists_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY shortlists
    ADD CONSTRAINT shortlists_owner_fkey FOREIGN KEY (owner) REFERENCES users(id);


--
-- Name: shortlists_users_shortlist_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY shortlists_users
    ADD CONSTRAINT shortlists_users_shortlist_fkey FOREIGN KEY (shortlist) REFERENCES shortlists(id);


--
-- Name: shortlists_users_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY shortlists_users
    ADD CONSTRAINT shortlists_users_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: users_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(id);


--
-- Name: users_agency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ashkan
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_agency_id_fkey FOREIGN KEY (agency_id) REFERENCES agencies(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: ashkan
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM ashkan;
GRANT ALL ON SCHEMA public TO ashkan;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--
