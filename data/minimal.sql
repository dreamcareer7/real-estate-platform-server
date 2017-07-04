--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: shortlisted; Type: SCHEMA; Schema: -; Owner: emilsedgh
--

CREATE SCHEMA shortlisted;


ALTER SCHEMA shortlisted OWNER TO emilsedgh;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: emilsedgh
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO emilsedgh;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: emilsedgh
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO emilsedgh;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

--
-- Name: activity_type; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE activity_type AS ENUM (
    'UserViewedAlert',
    'UserViewedListing',
    'UserFavoritedListing',
    'UserSharedListing',
    'UserCreatedAlert',
    'UserCommentedRoom',
    'UserOpenedIOSApp',
    'UserCalledContact',
    'UserCreatedContact',
    'UserSignedUp'
);


ALTER TYPE activity_type OWNER TO emilsedgh;

--
-- Name: client_type; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE client_type AS ENUM (
    'Buyer',
    'Seller',
    'Unknown'
);


ALTER TYPE client_type OWNER TO emilsedgh;

--
-- Name: contact_source_type; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE contact_source_type AS ENUM (
    'BrokerageWidget',
    'IOSAddressBook',
    'SharesRoom',
    'ExplicitlyCreated'
);


ALTER TYPE contact_source_type OWNER TO emilsedgh;

--
-- Name: country_code_3; Type: TYPE; Schema: public; Owner: emilsedgh
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


ALTER TYPE country_code_3 OWNER TO emilsedgh;

--
-- Name: country_name; Type: TYPE; Schema: public; Owner: emilsedgh
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


ALTER TYPE country_name OWNER TO emilsedgh;

--
-- Name: currency_code; Type: TYPE; Schema: public; Owner: emilsedgh
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


ALTER TYPE currency_code OWNER TO emilsedgh;

--
-- Name: deal_role; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE deal_role AS ENUM (
    'BuyerAgent',
    'CoBuyerAgent',
    'SellerAgent',
    'CoSellerAgent',
    'Buyer',
    'Seller',
    'Title',
    'Lawyer',
    'Lender',
    'TeamLead',
    'Appraiser',
    'Inspector',
    'Tenant',
    'Landlord'
);


ALTER TYPE deal_role OWNER TO emilsedgh;

--
-- Name: deal_type; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE deal_type AS ENUM (
    'Buying',
    'Selling'
);


ALTER TYPE deal_type OWNER TO emilsedgh;

--
-- Name: envelope_recipient_status; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE envelope_recipient_status AS ENUM (
    'Sent',
    'Delivered',
    'Completed',
    'Declined',
    'AuthenticationFailed',
    'AutoResponded'
);


ALTER TYPE envelope_recipient_status OWNER TO emilsedgh;

--
-- Name: envelope_status; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE envelope_status AS ENUM (
    'sent',
    'Sent',
    'Delivered',
    'Completed',
    'Declined',
    'Voided'
);


ALTER TYPE envelope_status OWNER TO emilsedgh;

--
-- Name: form_revision_status; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE form_revision_status AS ENUM (
    'Draft',
    'Fair'
);


ALTER TYPE form_revision_status OWNER TO emilsedgh;

--
-- Name: geo_confidence; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE geo_confidence AS ENUM (
    'Google_ROOFTOP',
    'Google_RANGE_INTERPOLATED',
    'Google_GEOMETRIC_CENTER',
    'Google_APPROXIMATE',
    'Bing_High',
    'Bing_Medium',
    'Bing_Low',
    'OSM_NA'
);


ALTER TYPE geo_confidence OWNER TO emilsedgh;

--
-- Name: geo_confidence_bing; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE geo_confidence_bing AS ENUM (
    'High',
    'Medium',
    'Low'
);


ALTER TYPE geo_confidence_bing OWNER TO emilsedgh;

--
-- Name: geo_confidence_google; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE geo_confidence_google AS ENUM (
    'APPROXIMATE',
    'RANGE_INTERPOLATED',
    'GEOMETRIC_CENTER',
    'ROOFTOP'
);


ALTER TYPE geo_confidence_google OWNER TO emilsedgh;

--
-- Name: geo_source; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE geo_source AS ENUM (
    'OSM',
    'Google',
    'Yahoo',
    'Bing',
    'Geonames',
    'Unknown',
    'None'
);


ALTER TYPE geo_source OWNER TO emilsedgh;

--
-- Name: listing_status; Type: TYPE; Schema: public; Owner: emilsedgh
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
    'Incomplete',
    'Unknown',
    'Out Of Sync',
    'Incoming',
    'Coming Soon'
);


ALTER TYPE listing_status OWNER TO emilsedgh;

--
-- Name: mam_behaviour; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE mam_behaviour AS ENUM (
    'A',
    'N',
    'R'
);


ALTER TYPE mam_behaviour OWNER TO emilsedgh;

--
-- Name: mam_direction; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE mam_direction AS ENUM (
    'I',
    'O'
);


ALTER TYPE mam_direction OWNER TO emilsedgh;

--
-- Name: message_room_status; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE message_room_status AS ENUM (
    'Active',
    'Inactive',
    'Restricted',
    'Blocked'
);


ALTER TYPE message_room_status OWNER TO emilsedgh;

--
-- Name: message_type; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE message_type AS ENUM (
    'TopLevel',
    'SubLevel'
);


ALTER TYPE message_type OWNER TO emilsedgh;

--
-- Name: note_types; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE note_types AS ENUM (
    'Transaction'
);


ALTER TYPE note_types OWNER TO emilsedgh;

--
-- Name: notification_action; Type: TYPE; Schema: public; Owner: emilsedgh
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
    'Sent',
    'Invited',
    'PriceDropped',
    'StatusChanged',
    'BecameAvailable',
    'TourRequested',
    'IsDue',
    'Assigned',
    'Withdrew',
    'Attached',
    'Detached',
    'Available',
    'CreatedFor',
    'ReactedTo'
);


ALTER TYPE notification_action OWNER TO emilsedgh;

--
-- Name: notification_object_class; Type: TYPE; Schema: public; Owner: emilsedgh
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
    'Shortlist',
    'User',
    'Alert',
    'Invitation',
    'Task',
    'Transaction',
    'Contact',
    'Attachment',
    'CMA',
    'OpenHouse',
    'CreatedFor',
    'Recipient',
    'Envelope',
    'EnvelopeRecipient'
);


ALTER TYPE notification_object_class OWNER TO emilsedgh;

--
-- Name: office_status; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE office_status AS ENUM (
    'N',
    'Deceased',
    '',
    'Terminated',
    'Active',
    'Inactive'
);


ALTER TYPE office_status OWNER TO emilsedgh;

--
-- Name: property_subtype; Type: TYPE; Schema: public; Owner: emilsedgh
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


ALTER TYPE property_subtype OWNER TO emilsedgh;

--
-- Name: property_type; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE property_type AS ENUM (
    'Residential',
    'Residential Lease',
    'Multi-Family',
    'Commercial',
    'Lots & Acreage',
    'Unknown'
);


ALTER TYPE property_type OWNER TO emilsedgh;

--
-- Name: recommendation_eav_action; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE recommendation_eav_action AS ENUM (
    'Favorited',
    'Read',
    'TourRequested',
    'Hid'
);


ALTER TYPE recommendation_eav_action OWNER TO emilsedgh;

--
-- Name: recommendation_last_update; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE recommendation_last_update AS ENUM (
    'New',
    'PriceDrop',
    'StatusChange',
    'OpenHouseAvailable'
);


ALTER TYPE recommendation_last_update OWNER TO emilsedgh;

--
-- Name: recommendation_status; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE recommendation_status AS ENUM (
    'Unacknowledged',
    'Pinned',
    'Unpinned'
);


ALTER TYPE recommendation_status OWNER TO emilsedgh;

--
-- Name: recommendation_type; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE recommendation_type AS ENUM (
    'Listing',
    'Agent',
    'Bank',
    'Card',
    'User'
);


ALTER TYPE recommendation_type OWNER TO emilsedgh;

--
-- Name: reference_type; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE reference_type AS ENUM (
    'User',
    'Contact'
);


ALTER TYPE reference_type OWNER TO emilsedgh;

--
-- Name: review_state; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE review_state AS ENUM (
    'Pending',
    'Rejected',
    'Approved'
);


ALTER TYPE review_state OWNER TO emilsedgh;

--
-- Name: room_status; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE room_status AS ENUM (
    'New',
    'Searching',
    'Touring',
    'OnHold',
    'Closing',
    'ClosedCanceled',
    'ClosedSuccess',
    'Archived'
);


ALTER TYPE room_status OWNER TO emilsedgh;

--
-- Name: room_type; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE room_type AS ENUM (
    'Group',
    'Direct',
    'Personal'
);


ALTER TYPE room_type OWNER TO emilsedgh;

--
-- Name: source_type; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE source_type AS ENUM (
    'MLS',
    'Zillow',
    'RCRRE',
    'Trulia',
    'Realtor'
);


ALTER TYPE source_type OWNER TO emilsedgh;

--
-- Name: tag_types; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE tag_types AS ENUM (
    'contact',
    'room',
    'listing',
    'user',
    'Contact',
    'Room',
    'Listing',
    'User'
);


ALTER TYPE tag_types OWNER TO emilsedgh;

--
-- Name: task_status; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE task_status AS ENUM (
    'New',
    'Done',
    'Later'
);


ALTER TYPE task_status OWNER TO emilsedgh;

--
-- Name: transaction_type; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE transaction_type AS ENUM (
    'Buyer',
    'Seller',
    'Buyer/Seller',
    'Lease'
);


ALTER TYPE transaction_type OWNER TO emilsedgh;

--
-- Name: user_image_type; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE user_image_type AS ENUM (
    'Profile',
    'Cover'
);


ALTER TYPE user_image_type OWNER TO emilsedgh;

--
-- Name: user_on_room_status; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE user_on_room_status AS ENUM (
    'Active',
    'Muted'
);


ALTER TYPE user_on_room_status OWNER TO emilsedgh;

--
-- Name: user_status; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE user_status AS ENUM (
    'Deleted',
    'De-Activated',
    'Restricted',
    'Banned',
    'Active'
);


ALTER TYPE user_status OWNER TO emilsedgh;

--
-- Name: user_type; Type: TYPE; Schema: public; Owner: emilsedgh
--

CREATE TYPE user_type AS ENUM (
    'Client',
    'Agent',
    'Brokerage',
    'Admin'
);


ALTER TYPE user_type OWNER TO emilsedgh;

SET search_path = shortlisted, pg_catalog;

--
-- Name: message_room_status; Type: TYPE; Schema: shortlisted; Owner: emilsedgh
--

CREATE TYPE message_room_status AS ENUM (
    'Active',
    'Inactive',
    'Restricted',
    'Blocked'
);


ALTER TYPE message_room_status OWNER TO emilsedgh;

SET search_path = public, pg_catalog;

--
-- Name: agent_exp(text); Type: FUNCTION; Schema: public; Owner: emilsedgh
--

CREATE FUNCTION agent_exp(mlsid text) RETURNS text
    LANGUAGE plpgsql
    AS $$  BEGIN    CASE substring(mlsid from 0 for 3)      WHEN '02' THEN RETURN '25-40';      WHEN '03' THEN RETURN '15-25';      WHEN '04' THEN RETURN '10-15';      WHEN '05' THEN RETURN '5-10';      WHEN '06' THEN RETURN '0-5';      ELSE RETURN '20+';    END CASE;  END;  $$;


ALTER FUNCTION public.agent_exp(mlsid text) OWNER TO emilsedgh;

--
-- Name: brand_children(uuid); Type: FUNCTION; Schema: public; Owner: emilsedgh
--

CREATE FUNCTION brand_children(id uuid) RETURNS SETOF uuid
    LANGUAGE sql
    AS $_$
  WITH RECURSIVE get_brand_children AS (
    SELECT brand, parent FROM brands_parents WHERE parent = $1
    UNION
    SELECT a.brand, a.parent FROM brands_parents a JOIN get_brand_children b ON (a.parent = b.brand)
  )

  SELECT $1 AS brand UNION SELECT brand FROM get_brand_children
$_$;


ALTER FUNCTION public.brand_children(id uuid) OWNER TO emilsedgh;

--
-- Name: falsify_email_confirmed(); Type: FUNCTION; Schema: public; Owner: emilsedgh
--

CREATE FUNCTION falsify_email_confirmed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$                BEGIN                UPDATE users                SET email_confirmed = false                WHERE id = NEW.id;                RETURN NEW;                END;                $$;


ALTER FUNCTION public.falsify_email_confirmed() OWNER TO emilsedgh;

--
-- Name: falsify_phone_confirmed(); Type: FUNCTION; Schema: public; Owner: emilsedgh
--

CREATE FUNCTION falsify_phone_confirmed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$                BEGIN                UPDATE users                SET phone_confirmed = false                WHERE id = NEW.id;                RETURN NEW;                END;                $$;


ALTER FUNCTION public.falsify_phone_confirmed() OWNER TO emilsedgh;

--
-- Name: fix_geocodes(); Type: FUNCTION; Schema: public; Owner: emilsedgh
--

CREATE FUNCTION fix_geocodes() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE addresses SET geocoded = NULL, location = NULL, corrupted = NULL, approximate = NULL, geo_source = 'None';
UPDATE addresses SET geocoded = TRUE, geo_source = 'Google', approximate = FALSE, corrupted = FALSE, location = location_google WHERE geo_confidence_google = 'ROOFTOP';
UPDATE addresses SET geocoded = TRUE, geo_source = 'Bing', approximate = FALSE, corrupted = FALSE, location = location_bing WHERE geo_confidence_bing = 'High' AND geocoded IS NOT TRUE;
UPDATE addresses SET geocoded = TRUE, geo_source = 'Google', approximate = FALSE, corrupted = FALSE, location = location_google WHERE geo_confidence_google = 'RANGE_INTERPOLATED' AND geocoded IS NOT TRUE;
UPDATE addresses SET geocoded = TRUE, geo_source = 'Google', approximate = FALSE, corrupted = FALSE, location = location_google WHERE geo_confidence_google = 'GEOMETRIC_CENTER' AND geocoded IS NOT TRUE AND (STRPOS(LOWER(geo_source_formatted_address_google), LOWER(postal_code)) > 0 AND STRPOS(LOWER(geo_source_formatted_address_google), LOWER(street_name)) > 0);
UPDATE addresses SET geocoded = TRUE, geo_source = 'Google', approximate = TRUE, corrupted = FALSE, location = location_google WHERE geo_confidence_google = 'GEOMETRIC_CENTER' AND geocoded IS NOT TRUE;
UPDATE addresses SET geocoded = TRUE, geo_source = 'Bing', approximate = TRUE, corrupted = FALSE, location = location_bing WHERE geo_confidence_google = 'APPROXIMATE' AND geocoded IS NOT TRUE AND (STRPOS(LOWER(geo_source_formatted_address_bing), LOWER(postal_code)) > 0 AND STRPOS(LOWER(geo_source_formatted_address_bing), LOWER(street_name)) > 0);
UPDATE addresses SET geocoded = TRUE, geo_source = 'Google', approximate = TRUE, corrupted = FALSE, location = location_google WHERE geo_confidence_google = 'APPROXIMATE' AND geocoded IS NOT TRUE AND (STRPOS(LOWER(geo_source_formatted_address_google), LOWER(postal_code)) > 0 AND STRPOS(LOWER(geo_source_formatted_address_google), LOWER(street_name)) > 0);
UPDATE addresses SET geocoded = TRUE, geo_source = 'Bing', approximate = TRUE, corrupted = FALSE, location = location_bing WHERE geo_confidence_google = 'APPROXIMATE' AND geocoded IS NOT TRUE AND (STRPOS(LOWER(geo_source_formatted_address_bing), LOWER(postal_code)) > 0);
UPDATE addresses SET geocoded = TRUE, geo_source = 'Google', approximate = TRUE, corrupted = FALSE, location = location_google WHERE geo_confidence_google = 'APPROXIMATE' AND geocoded IS NOT TRUE AND (STRPOS(LOWER(geo_source_formatted_address_google), LOWER(postal_code)) > 0);
UPDATE addresses SET geocoded = TRUE, geo_source = 'Bing', approximate = TRUE, corrupted = FALSE, location = location_bing WHERE geocoded IS NOT TRUE AND geocoded_bing IS TRUE;
END; 
$$;


ALTER FUNCTION public.fix_geocodes() OWNER TO emilsedgh;

--
-- Name: get_brand_agents(uuid); Type: FUNCTION; Schema: public; Owner: emilsedgh
--

CREATE FUNCTION get_brand_agents(id uuid) RETURNS SETOF uuid
    LANGUAGE sql
    AS $_$
  SELECT DISTINCT agents.id AS id FROM agents
    LEFT JOIN users          ON agents.id = users.agent
    LEFT JOIN offices        ON agents.office_mui = offices.matrix_unique_id
    LEFT JOIN brands_offices ON offices.id = brands_offices.office
    LEFT JOIN brands_agents  ON agents.id = brands_agents.agent
    LEFT JOIN brands_users   ON users.id = brands_users.user
  WHERE (
    (
      brands_offices.brand = $1
    )
    OR
    (
      brands_agents.brand = $1
    )
    OR
    (
      brands_users.brand = $1
    )
  )
$_$;


ALTER FUNCTION public.get_brand_agents(id uuid) OWNER TO emilsedgh;

--
-- Name: get_brand_users(uuid); Type: FUNCTION; Schema: public; Owner: emilsedgh
--

CREATE FUNCTION get_brand_users(id uuid) RETURNS SETOF uuid
    LANGUAGE sql
    AS $_$
  WITH brand_users AS (
    SELECT DISTINCT users.id FROM users
      LEFT JOIN agents         ON users.agent = agents.id
      LEFT JOIN offices        ON agents.office_mui = offices.matrix_unique_id
      LEFT JOIN brands_offices ON offices.id = brands_offices.office
      LEFT JOIN brands_agents  ON agents.id = brands_agents.agent
      LEFT JOIN brands_users   ON users.id = brands_users.user
    WHERE (
      (
        brands_offices.brand = $1
      )
      OR
      (
        brands_agents.brand = $1
      )
      OR
      (
        brands_users.brand = $1
      )
    )
  )

  SELECT * FROM brand_users
$_$;


ALTER FUNCTION public.get_brand_users(id uuid) OWNER TO emilsedgh;

--
-- Name: order_listings(listing_status); Type: FUNCTION; Schema: public; Owner: emilsedgh
--

CREATE FUNCTION order_listings(listing_status) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT CASE $1
      WHEN 'Coming Soon'::listing_status            THEN 0
      WHEN 'Active'::listing_status                 THEN 1

      WHEN 'Active Option Contract'::listing_status THEN 2
      WHEN 'Active Contingent'::listing_status      THEN 2
      WHEN 'Active Kick Out'::listing_status        THEN 2

      WHEN 'Pending'::listing_status         THEN 3
      WHEN 'Sold'::listing_status            THEN 3
      WHEN 'Leased'::listing_status          THEN 3

      ELSE 4
    END$_$;


ALTER FUNCTION public.order_listings(listing_status) OWNER TO emilsedgh;

--
-- Name: toggle_phone_confirmed(); Type: FUNCTION; Schema: public; Owner: emilsedgh
--

CREATE FUNCTION toggle_phone_confirmed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$                BEGIN                UPDATE users                SET phone_confirmed = false                WHERE id = NEW.id;                RETURN NEW;                END;                $$;


ALTER FUNCTION public.toggle_phone_confirmed() OWNER TO emilsedgh;

--
-- Name: uuid_timestamp(uuid); Type: FUNCTION; Schema: public; Owner: emilsedgh
--

CREATE FUNCTION uuid_timestamp(id uuid) RETURNS timestamp with time zone
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  select TIMESTAMP WITH TIME ZONE 'epoch' +
      ( ( ( ('x' || lpad(split_part(id::text, '-', 1), 16, '0'))::bit(64)::bigint) +
      (('x' || lpad(split_part(id::text, '-', 2), 16, '0'))::bit(64)::bigint << 32) +
      ((('x' || lpad(split_part(id::text, '-', 3), 16, '0'))::bit(64)::bigint&4095) << 48) - 122192928000000000) / 10) * INTERVAL '1 microsecond';    
$$;


ALTER FUNCTION public.uuid_timestamp(id uuid) OWNER TO emilsedgh;

--
-- Name: wipe_everything(); Type: FUNCTION; Schema: public; Owner: emilsedgh
--

CREATE FUNCTION wipe_everything() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    TRUNCATE TABLE messages_acks CASCADE;
    TRUNCATE TABLE messages CASCADE;
    TRUNCATE TABLE notifications_acks CASCADE;
    TRUNCATE TABLE notifications CASCADE;
    TRUNCATE TABLE notifications_deliveries;
    TRUNCATE TABLE notifications_users;
    TRUNCATE TABLE recommendations_eav CASCADE;
    TRUNCATE TABLE recommendations CASCADE;
    TRUNCATE TABLE rooms_users CASCADE;
    TRUNCATE TABLE rooms CASCADE;
    TRUNCATE TABLE invitation_records CASCADE;
    TRUNCATE TABLE alerts CASCADE;
    TRUNCATE TABLE contacts CASCADE;
    TRUNCATE TABLE notification_tokens CASCADE;
    TRUNCATE TABLE password_recovery_records CASCADE;
    TRUNCATE TABLE email_verifications CASCADE;
    TRUNCATE TABLE phone_verifications CASCADE;
    TRUNCATE TABLE attachments_eav CASCADE;
    TRUNCATE TABLE attachments CASCADE;
    TRUNCATE TABLE important_dates CASCADE;
    TRUNCATE TABLE notes CASCADE;
    TRUNCATE TABLE task_contacts CASCADE;
    TRUNCATE TABLE tasks CASCADE;
    TRUNCATE TABLE transaction_contact_roles CASCADE;
    TRUNCATE TABLE transaction_contacts CASCADE;
    TRUNCATE TABLE transactions CASCADE;
    TRUNCATE TABLE cmas CASCADE;
    TRUNCATE TABLE sessions CASCADE;
    TRUNCATE TABLE tags CASCADE;
    TRUNCATE TABLE tags_contacts CASCADE;
END;
$$;


ALTER FUNCTION public.wipe_everything() OWNER TO emilsedgh;

SET search_path = shortlisted, pg_catalog;

--
-- Name: wipe_everything(); Type: FUNCTION; Schema: shortlisted; Owner: emilsedgh
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
TRUNCATE TABLE messages_ack CASCADE;
END; 
$$;


ALTER FUNCTION shortlisted.wipe_everything() OWNER TO emilsedgh;

SET search_path = tiger, pg_catalog;

--
-- Name: exec(text); Type: FUNCTION; Schema: tiger; Owner: emilsedgh
--

CREATE FUNCTION exec(text) RETURNS text
    LANGUAGE plpgsql
    AS $_$ BEGIN EXECUTE $1; RETURN $1; END; $_$;


ALTER FUNCTION tiger.exec(text) OWNER TO emilsedgh;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE activities (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    reference uuid NOT NULL,
    reference_type reference_type NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    object uuid,
    object_class notification_object_class,
    object_sa jsonb,
    action activity_type
);


ALTER TABLE activities OWNER TO emilsedgh;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: emilsedgh
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
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    location_google geometry(Point,4326),
    matrix_unique_id bigint,
    geocoded boolean DEFAULT false,
    geo_source geo_source DEFAULT 'None'::geo_source,
    partial_match_google boolean DEFAULT false,
    county_or_parish text,
    direction text,
    street_dir_prefix text,
    street_dir_suffix text,
    street_number_searchable text,
    geo_source_formatted_address_google text,
    geocoded_google boolean,
    geocoded_bing boolean,
    location_bing geometry(Point,4326),
    geo_source_formatted_address_bing text,
    geo_confidence_google geo_confidence_google,
    geo_confidence_bing geo_confidence_bing,
    location geometry(Point,4326),
    approximate boolean,
    corrupted boolean,
    corrupted_google boolean,
    corrupted_bing boolean,
    deleted_at timestamp with time zone
);


ALTER TABLE addresses OWNER TO emilsedgh;

--
-- Name: agents; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE agents (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    email text,
    mlsid text NOT NULL,
    fax text,
    full_name text,
    first_name text,
    last_name text,
    middle_name text,
    phone_number text,
    nar_number text,
    office_mui integer,
    status text,
    office_mlsid text,
    work_phone text,
    generational_name text,
    matrix_unique_id integer NOT NULL,
    matrix_modified_dt timestamp with time zone,
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT clock_timestamp()
);


ALTER TABLE agents OWNER TO emilsedgh;

--
-- Name: listings; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE listings (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    property_id uuid,
    alerting_agent_id uuid,
    listing_agent_id uuid,
    listing_agency_id uuid,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    cover_image_url text,
    currency currency_code,
    price double precision,
    gallery_image_urls text[],
    matrix_unique_id integer NOT NULL,
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
    listing_agreement text,
    capitalization_rate text,
    compensation_paid text,
    date_available text,
    last_status listing_status,
    mls_area_major text,
    mls_area_minor text,
    mls text,
    move_in_date text,
    permit_address_internet_yn boolean,
    permit_comments_reviews_yn boolean,
    permit_internet_yn boolean,
    price_change_timestamp timestamp with time zone,
    matrix_modified_dt timestamp with time zone,
    property_association_fees text,
    showing_instructions_type text,
    special_notes text,
    tax_legal_description text,
    total_annual_expenses_include text,
    transaction_type text,
    virtual_tour_url_branded text,
    virtual_tour_url_unbranded text,
    active_option_contract_date text,
    keybox_type text,
    keybox_number text,
    close_date timestamp with time zone,
    close_price double precision,
    back_on_market_date text,
    deposit_amount double precision,
    photo_count smallint,
    deleted_at timestamp with time zone,
    dom smallint,
    cdom smallint,
    buyers_agency_commission text,
    sub_agency_commission text,
    list_date timestamp with time zone,
    showing_instructions text,
    appointment_phone text,
    appointment_phone_ext text,
    appointment_call text,
    owner_name text,
    seller_type text,
    occupancy text,
    private_remarks text,
    photos_checked_at timestamp with time zone
);


ALTER TABLE listings OWNER TO emilsedgh;

--
-- Name: agents_emails; Type: MATERIALIZED VIEW; Schema: public; Owner: emilsedgh
--

CREATE MATERIALIZED VIEW agents_emails AS
 WITH stated_emails AS (
         SELECT ('email_'::text || agents.id) AS id,
            agents.matrix_unique_id AS mui,
            agents.email,
            agents.matrix_modified_dt AS date
           FROM agents
          WHERE (agents.email <> ''::text)
        ), list_agents AS (
         SELECT ('list_agents_'::text || listings.id) AS id,
            listings.list_agent_mui AS mui,
            listings.list_agent_email AS email,
            listings.list_date AS date
           FROM listings
          WHERE (listings.list_agent_email <> ''::text)
        ), co_list_agents AS (
         SELECT ('co_list_agents_'::text || listings.id) AS id,
            listings.co_list_agent_mui AS mui,
            listings.co_list_agent_email AS email,
            listings.list_date AS date
           FROM listings
          WHERE (listings.co_list_agent_email <> ''::text)
        ), selling_agents AS (
         SELECT ('selling_agents_'::text || listings.id) AS id,
            listings.selling_agent_mui AS mui,
            listings.selling_agent_email AS email,
            listings.list_date AS date
           FROM listings
          WHERE (listings.selling_agent_email <> ''::text)
        ), co_selling_agents AS (
         SELECT ('co_selling_agents_'::text || listings.id) AS id,
            listings.co_selling_agent_mui AS mui,
            listings.co_selling_agent_email AS email,
            listings.list_date AS date
           FROM listings
          WHERE (listings.co_selling_agent_email <> ''::text)
        )
 SELECT stated_emails.id,
    stated_emails.mui,
    stated_emails.email,
    stated_emails.date
   FROM stated_emails
UNION ALL
 SELECT list_agents.id,
    list_agents.mui,
    list_agents.email,
    list_agents.date
   FROM list_agents
UNION ALL
 SELECT co_list_agents.id,
    co_list_agents.mui,
    co_list_agents.email,
    co_list_agents.date
   FROM co_list_agents
UNION ALL
 SELECT selling_agents.id,
    selling_agents.mui,
    selling_agents.email,
    selling_agents.date
   FROM selling_agents
UNION ALL
 SELECT co_selling_agents.id,
    co_selling_agents.mui,
    co_selling_agents.email,
    co_selling_agents.date
   FROM co_selling_agents
  WITH NO DATA;


ALTER TABLE agents_emails OWNER TO emilsedgh;

--
-- Name: agents_images; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE agents_images (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    mui bigint,
    url text,
    image_type user_image_type,
    date timestamp with time zone
);


ALTER TABLE agents_images OWNER TO emilsedgh;

--
-- Name: agents_phones; Type: MATERIALIZED VIEW; Schema: public; Owner: emilsedgh
--

CREATE MATERIALIZED VIEW agents_phones AS
 WITH stated_phones AS (
         SELECT ('phone_number_'::text || agents.id) AS id,
            agents.matrix_unique_id AS mui,
            agents.phone_number AS phone,
            agents.matrix_modified_dt AS date
           FROM agents
          WHERE (agents.phone_number <> ''::text)
        ), stated_work_phones AS (
         SELECT ('work_phone'::text || agents.id) AS id,
            agents.matrix_unique_id AS mui,
            agents.work_phone AS phone,
            agents.matrix_modified_dt AS date
           FROM agents
          WHERE (agents.work_phone <> ''::text)
        ), list_agents AS (
         SELECT ('list_agents_'::text || listings.id) AS id,
            listings.list_agent_mui AS mui,
            listings.list_agent_direct_work_phone AS phone,
            listings.list_date AS date
           FROM listings
          WHERE (listings.list_agent_direct_work_phone <> ''::text)
        ), co_list_agents AS (
         SELECT ('co_list_agents_'::text || listings.id) AS id,
            listings.co_list_agent_mui AS mui,
            listings.co_list_agent_direct_work_phone AS phone,
            listings.list_date AS date
           FROM listings
          WHERE (listings.co_list_agent_direct_work_phone <> ''::text)
        ), selling_agents AS (
         SELECT ('selling_agents_'::text || listings.id) AS id,
            listings.selling_agent_mui AS mui,
            listings.selling_agent_direct_work_phone AS phone,
            listings.list_date AS date
           FROM listings
          WHERE (listings.selling_agent_direct_work_phone <> ''::text)
        ), co_selling_agents AS (
         SELECT ('co_selling_agents_'::text || listings.id) AS id,
            listings.co_selling_agent_mui AS mui,
            listings.co_selling_agent_direct_work_phone AS phone,
            listings.list_date AS date
           FROM listings
          WHERE (listings.co_selling_agent_direct_work_phone <> ''::text)
        )
 SELECT stated_phones.id,
    stated_phones.mui,
    stated_phones.phone,
    stated_phones.date
   FROM stated_phones
UNION ALL
 SELECT stated_work_phones.id,
    stated_work_phones.mui,
    stated_work_phones.phone,
    stated_work_phones.date
   FROM stated_work_phones
UNION ALL
 SELECT list_agents.id,
    list_agents.mui,
    list_agents.phone,
    list_agents.date
   FROM list_agents
UNION ALL
 SELECT co_list_agents.id,
    co_list_agents.mui,
    co_list_agents.phone,
    co_list_agents.date
   FROM co_list_agents
UNION ALL
 SELECT selling_agents.id,
    selling_agents.mui,
    selling_agents.phone,
    selling_agents.date
   FROM selling_agents
UNION ALL
 SELECT co_selling_agents.id,
    co_selling_agents.mui,
    co_selling_agents.phone,
    co_selling_agents.date
   FROM co_selling_agents
  WITH NO DATA;


ALTER TABLE agents_phones OWNER TO emilsedgh;

--
-- Name: alerts; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE alerts (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    minimum_price double precision,
    maximum_price double precision,
    minimum_square_meters double precision,
    maximum_square_meters double precision,
    created_by uuid NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    room uuid NOT NULL,
    minimum_bedrooms smallint,
    minimum_bathrooms double precision,
    property_subtypes property_subtype[],
    points geometry(Polygon,4326),
    minimum_year_built smallint,
    pool boolean,
    title text,
    minimum_lot_square_meters double precision,
    maximum_lot_square_meters double precision,
    maximum_year_built smallint,
    deleted_at timestamp with time zone,
    listing_statuses listing_status[],
    open_house boolean,
    minimum_sold_date timestamp with time zone,
    property_types property_type[],
    list_agents text[],
    list_offices text[],
    counties text[],
    minimum_parking_spaces smallint,
    architectural_styles text[],
    subdivisions text[],
    school_districts text[],
    primary_schools text[],
    elementary_schools text[],
    senior_high_schools text[],
    junior_high_schools text[],
    intermediate_schools text[],
    sort_order text[],
    sort_office uuid,
    selling_offices text[],
    selling_agents text[],
    mls_areas jsonb,
    middle_schools text[],
    offices text[],
    agents text[],
    high_schools text[],
    excluded_listing_ids uuid[],
    postal_codes text[]
);


ALTER TABLE alerts OWNER TO emilsedgh;

--
-- Name: attachments; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE attachments (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    "user" uuid,
    url text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    info jsonb,
    private boolean DEFAULT false,
    attributes jsonb
);


ALTER TABLE attachments OWNER TO emilsedgh;

--
-- Name: attachments_eav; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE attachments_eav (
    id uuid DEFAULT uuid_generate_v4(),
    object uuid NOT NULL,
    attachment uuid NOT NULL
);


ALTER TABLE attachments_eav OWNER TO emilsedgh;

--
-- Name: brands; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE brands (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    palette jsonb,
    assets jsonb,
    messages jsonb
);


ALTER TABLE brands OWNER TO emilsedgh;

--
-- Name: brands_agents; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE brands_agents (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    brand uuid NOT NULL,
    agent uuid NOT NULL
);


ALTER TABLE brands_agents OWNER TO emilsedgh;

--
-- Name: brands_hostnames; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE brands_hostnames (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    brand uuid NOT NULL,
    hostname text,
    "default" boolean DEFAULT false NOT NULL
);


ALTER TABLE brands_hostnames OWNER TO emilsedgh;

--
-- Name: brands_offices; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE brands_offices (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    brand uuid NOT NULL,
    office uuid NOT NULL
);


ALTER TABLE brands_offices OWNER TO emilsedgh;

--
-- Name: brands_parents; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE brands_parents (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    brand uuid NOT NULL,
    parent uuid NOT NULL
);


ALTER TABLE brands_parents OWNER TO emilsedgh;

--
-- Name: brands_users; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE brands_users (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    brand uuid NOT NULL,
    "user" uuid NOT NULL,
    role text
);


ALTER TABLE brands_users OWNER TO emilsedgh;

--
-- Name: clients; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE clients (
    id uuid DEFAULT uuid_generate_v1(),
    version character varying(10),
    response jsonb,
    secret character varying(255),
    name character varying(255)
);


ALTER TABLE clients OWNER TO emilsedgh;

--
-- Name: cmas; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE cmas (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    "user" uuid NOT NULL,
    room uuid NOT NULL,
    suggested_price double precision,
    comment text,
    listings text[] NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    lowest_price double precision DEFAULT 0 NOT NULL,
    average_price double precision DEFAULT 0 NOT NULL,
    highest_price double precision DEFAULT 0 NOT NULL,
    lowest_dom integer DEFAULT 0 NOT NULL,
    average_dom integer DEFAULT 0 NOT NULL,
    highest_dom integer DEFAULT 0 NOT NULL,
    main_listing uuid NOT NULL
);


ALTER TABLE cmas OWNER TO emilsedgh;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE contacts (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    "user" uuid NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    refs uuid[],
    merged boolean DEFAULT false NOT NULL,
    ios_address_book_id text,
    android_address_book_id text
);


ALTER TABLE contacts OWNER TO emilsedgh;

--
-- Name: contacts_attributes; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE contacts_attributes (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    contact uuid NOT NULL,
    attribute_type text NOT NULL,
    attribute jsonb,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone
);


ALTER TABLE contacts_attributes OWNER TO emilsedgh;

--
-- Name: contacts_emails; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE contacts_emails (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    contact uuid NOT NULL,
    email text,
    data jsonb,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone
);


ALTER TABLE contacts_emails OWNER TO emilsedgh;

--
-- Name: contacts_phone_numbers; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE contacts_phone_numbers (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    contact uuid NOT NULL,
    phone_number text,
    data jsonb,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone
);


ALTER TABLE contacts_phone_numbers OWNER TO emilsedgh;

--
-- Name: counties; Type: MATERIALIZED VIEW; Schema: public; Owner: emilsedgh
--

CREATE MATERIALIZED VIEW counties AS
 SELECT DISTINCT addresses.county_or_parish AS title
   FROM addresses
  ORDER BY addresses.county_or_parish
  WITH NO DATA;


ALTER TABLE counties OWNER TO emilsedgh;

--
-- Name: deals; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE deals (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    listing uuid,
    created_by uuid,
    brand uuid,
    context jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE deals OWNER TO emilsedgh;

--
-- Name: deals_roles; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE deals_roles (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    created_by uuid NOT NULL,
    role deal_role NOT NULL,
    deal uuid NOT NULL,
    "user" uuid NOT NULL
);


ALTER TABLE deals_roles OWNER TO emilsedgh;

--
-- Name: docusign_users; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE docusign_users (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    "user" uuid NOT NULL,
    access_token text NOT NULL,
    refresh_token text NOT NULL,
    base_url text NOT NULL,
    account_id uuid NOT NULL
);


ALTER TABLE docusign_users OWNER TO emilsedgh;

--
-- Name: email_verifications; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE email_verifications (
    id uuid DEFAULT uuid_generate_v1(),
    code text NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    email text
);


ALTER TABLE email_verifications OWNER TO emilsedgh;

--
-- Name: envelopes; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE envelopes (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    created_by uuid NOT NULL,
    deal uuid NOT NULL,
    docusign_id uuid,
    status envelope_status,
    title text,
    webhook_token uuid DEFAULT uuid_generate_v1()
);


ALTER TABLE envelopes OWNER TO emilsedgh;

--
-- Name: envelopes_documents; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE envelopes_documents (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    envelope uuid NOT NULL,
    title text,
    document_id smallint,
    submission_revision uuid
);


ALTER TABLE envelopes_documents OWNER TO emilsedgh;

--
-- Name: envelopes_recipients; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE envelopes_recipients (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    signed_at timestamp with time zone,
    envelope uuid NOT NULL,
    role deal_role NOT NULL,
    "user" uuid NOT NULL,
    status envelope_recipient_status
);


ALTER TABLE envelopes_recipients OWNER TO emilsedgh;

--
-- Name: files; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE files (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    created_by uuid NOT NULL,
    path text NOT NULL,
    name text NOT NULL
);


ALTER TABLE files OWNER TO emilsedgh;

--
-- Name: files_relations; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE files_relations (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    file uuid NOT NULL,
    role text NOT NULL,
    role_id uuid NOT NULL
);


ALTER TABLE files_relations OWNER TO emilsedgh;

--
-- Name: foo; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE foo (
    value jsonb
);


ALTER TABLE foo OWNER TO emilsedgh;

--
-- Name: forms; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE forms (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    formstack_id integer,
    fields json DEFAULT '{}'::json,
    name text
);


ALTER TABLE forms OWNER TO emilsedgh;

--
-- Name: forms_data; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE forms_data (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    submission uuid,
    form uuid,
    author uuid,
    "values" json,
    formstack_response json,
    state form_revision_status DEFAULT 'Draft'::form_revision_status NOT NULL
);


ALTER TABLE forms_data OWNER TO emilsedgh;

--
-- Name: forms_submissions; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE forms_submissions (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    form uuid,
    formstack_id integer,
    deal uuid NOT NULL
);


ALTER TABLE forms_submissions OWNER TO emilsedgh;

--
-- Name: godaddy_domains; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE godaddy_domains (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    name text,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    owner uuid,
    order_id integer,
    hosted_zone text
);


ALTER TABLE godaddy_domains OWNER TO emilsedgh;

--
-- Name: godaddy_shoppers; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE godaddy_shoppers (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    "user" uuid NOT NULL,
    shopper_id text,
    email text NOT NULL,
    password text NOT NULL
);


ALTER TABLE godaddy_shoppers OWNER TO emilsedgh;

--
-- Name: invitation_records; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE invitation_records (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    invited_user uuid,
    email character varying(50),
    room uuid,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    accepted boolean DEFAULT false,
    inviting_user uuid NOT NULL,
    deleted_at timestamp with time zone,
    phone_number text,
    url text NOT NULL,
    invitee_first_name text,
    invitee_last_name text
);


ALTER TABLE invitation_records OWNER TO emilsedgh;

--
-- Name: properties; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE properties (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    bedroom_count integer,
    bathroom_count double precision,
    address_id uuid,
    description text,
    square_meters double precision,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
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
    architectural_style text[],
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
    subdivision_name text,
    appliances_yn boolean,
    building_number text,
    ceiling_height double precision,
    green_building_certification text,
    green_energy_efficient text,
    lot_size double precision,
    lot_size_area double precision,
    lot_size_dimensions text,
    map_coordinates text,
    number_of_pets_allowed smallint,
    number_of_units smallint,
    pets_yn boolean,
    photo_count smallint,
    room_count smallint,
    subdivided_yn boolean,
    surface_rights text,
    unit_count smallint,
    year_built_details text,
    zoning text,
    security_system_yn boolean,
    deleted_at timestamp with time zone,
    building_square_meters double precision
);


ALTER TABLE properties OWNER TO emilsedgh;

--
-- Name: listings_filters; Type: MATERIALIZED VIEW; Schema: public; Owner: emilsedgh
--

CREATE MATERIALIZED VIEW listings_filters AS
 SELECT listings.id,
    listings.status,
    listings.price,
    listings.matrix_unique_id,
    listings.close_date,
    listings.list_office_mls_id,
    listings.co_list_office_mls_id,
    listings.list_agent_mls_id,
    listings.co_list_agent_mls_id,
    listings.selling_office_mls_id,
    listings.co_selling_office_mls_id,
    listings.selling_agent_mls_id,
    listings.co_selling_agent_mls_id,
    listings.close_price,
    listings.created_at,
    listings.mls_number,
    ((regexp_matches(listings.mls_area_major, '[0-9]+'::text))[1])::integer AS mls_area_major,
    ((regexp_matches(listings.mls_area_minor, '[0-9]+'::text))[1])::integer AS mls_area_minor,
    properties.square_meters,
    properties.bedroom_count,
    properties.half_bathroom_count,
    properties.full_bathroom_count,
    properties.property_type,
    properties.property_subtype,
    properties.year_built,
    properties.pool_yn,
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
    properties.senior_high_school_name,
    addresses.location,
    addresses.county_or_parish,
    addresses.postal_code,
    ((((((((((((((((((((((((addresses.title || ' '::text) || addresses.subtitle) || ' '::text) || addresses.street_number) || ' '::text) || addresses.street_dir_prefix) || ' '::text) || addresses.street_name) || ' '::text) || addresses.street_suffix) || ' '::text) || addresses.street_dir_suffix) || ' '::text) || addresses.city) || ' '::text) || addresses.state) || ' '::text) || addresses.state_code) || ' '::text) || addresses.postal_code) || ' '::text) || (addresses.country)::text) || ' '::text) || (addresses.country_code)::text) AS address
   FROM ((listings
     JOIN properties ON ((listings.property_id = properties.id)))
     JOIN addresses ON ((properties.address_id = addresses.id)))
  WITH NO DATA;


ALTER TABLE listings_filters OWNER TO emilsedgh;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE messages (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    comment text,
    image_url text,
    document_url text,
    video_url text,
    recommendation uuid,
    author uuid,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    room uuid NOT NULL,
    message_type message_type NOT NULL,
    image_thumbnail_url text,
    deleted_at timestamp with time zone,
    notification uuid,
    reference uuid,
    mentions uuid[]
);


ALTER TABLE messages OWNER TO emilsedgh;

--
-- Name: messages_acks; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE messages_acks (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    message uuid NOT NULL,
    room uuid NOT NULL,
    "user" uuid NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp()
);


ALTER TABLE messages_acks OWNER TO emilsedgh;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE migrations (
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    state jsonb
);


ALTER TABLE migrations OWNER TO emilsedgh;

--
-- Name: mls_areas; Type: MATERIALIZED VIEW; Schema: public; Owner: emilsedgh
--

CREATE MATERIALIZED VIEW mls_areas AS
 SELECT DISTINCT ON (listings.mls_area_major) (regexp_matches(listings.mls_area_major, '(.+)\s\((\d+)\)$'::text))[1] AS title,
    ((regexp_matches(listings.mls_area_major, '(.+)\s\((\d+)\)$'::text))[2])::integer AS number,
    0 AS parent
   FROM listings
UNION
 SELECT DISTINCT ON (listings.mls_area_major, listings.mls_area_minor) (regexp_matches(listings.mls_area_minor, '(.+)\s\((\d+)\)$'::text))[1] AS title,
    ((regexp_matches(listings.mls_area_minor, '(.+)\s\((\d+)\)$'::text))[2])::integer AS number,
    ((regexp_matches(listings.mls_area_major, '(.+)\s\((\d+)\)$'::text))[2])::integer AS parent
   FROM listings
  WITH NO DATA;


ALTER TABLE mls_areas OWNER TO emilsedgh;

--
-- Name: mls_data; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE mls_data (
    id uuid DEFAULT uuid_generate_v1(),
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    value jsonb,
    class character varying,
    resource character varying,
    matrix_unique_id integer
);


ALTER TABLE mls_data OWNER TO emilsedgh;

--
-- Name: mls_jobs; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE mls_jobs (
    id uuid DEFAULT uuid_generate_v1(),
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    last_modified_date timestamp without time zone,
    last_id bigint,
    results integer,
    query text,
    is_initial_completed boolean DEFAULT false,
    name text,
    "limit" integer,
    "offset" integer
);


ALTER TABLE mls_jobs OWNER TO emilsedgh;

--
-- Name: notifications; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE notifications (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    object uuid NOT NULL,
    message text,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    room uuid,
    action notification_action NOT NULL,
    object_class notification_object_class NOT NULL,
    subject uuid NOT NULL,
    auxiliary_object_class notification_object_class,
    auxiliary_object uuid,
    recommendation uuid,
    auxiliary_subject uuid,
    subject_class notification_object_class NOT NULL,
    auxiliary_subject_class notification_object_class,
    extra_subject_class notification_object_class,
    extra_object_class notification_object_class,
    deleted_at timestamp with time zone,
    exclude uuid,
    specific uuid
);


ALTER TABLE notifications OWNER TO emilsedgh;

--
-- Name: notifications_deliveries; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE notifications_deliveries (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    "user" uuid NOT NULL,
    notification uuid NOT NULL,
    device_token text,
    type text,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone
);


ALTER TABLE notifications_deliveries OWNER TO emilsedgh;

--
-- Name: notifications_tokens; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE notifications_tokens (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    "user" uuid NOT NULL,
    device_token text NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    device_id text
);


ALTER TABLE notifications_tokens OWNER TO emilsedgh;

--
-- Name: notifications_users; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE notifications_users (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    "user" uuid NOT NULL,
    notification uuid NOT NULL,
    acked_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    seen_at timestamp with time zone
);


ALTER TABLE notifications_users OWNER TO emilsedgh;

--
-- Name: offices; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE offices (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    board text,
    email text,
    fax text,
    office_mui integer,
    office_mls_id text,
    license_number text,
    address text,
    care_of text,
    city text,
    postal_code text,
    postal_code_plus4 text,
    state text,
    matrix_unique_id integer NOT NULL,
    matrix_modified_dt timestamp with time zone,
    mls text,
    mls_id text,
    mls_provider text,
    nar_number text,
    contact_mui text,
    contact_mls_id text,
    long_name text,
    name text,
    status office_status,
    phone text,
    other_phone text,
    st_address text,
    st_city text,
    st_country text,
    st_postal_code text,
    st_postal_code_plus4 text,
    st_state text,
    url text,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp()
);


ALTER TABLE offices OWNER TO emilsedgh;

--
-- Name: open_houses; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE open_houses (
    id uuid DEFAULT uuid_generate_v1(),
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    description text,
    listing_mui integer,
    refreshments text,
    type text,
    matrix_unique_id integer,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone
);


ALTER TABLE open_houses OWNER TO emilsedgh;

--
-- Name: password_recovery_records; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE password_recovery_records (
    id uuid DEFAULT uuid_generate_v1(),
    email text NOT NULL,
    "user" uuid NOT NULL,
    token text NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    expires_at timestamp with time zone DEFAULT (now() + ((2)::double precision * '1 day'::interval)) NOT NULL
);


ALTER TABLE password_recovery_records OWNER TO emilsedgh;

--
-- Name: phone_verifications; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE phone_verifications (
    id uuid DEFAULT uuid_generate_v1(),
    code character(5),
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    phone_number text NOT NULL
);


ALTER TABLE phone_verifications OWNER TO emilsedgh;

--
-- Name: photos; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE photos (
    id uuid DEFAULT uuid_generate_v1(),
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    processed_at timestamp with time zone,
    error text,
    matrix_unique_id integer NOT NULL,
    listing_mui integer NOT NULL,
    description text,
    url text,
    "order" integer,
    exif jsonb,
    deleted_at timestamp with time zone,
    revision smallint DEFAULT 0 NOT NULL,
    to_be_processed_at timestamp with time zone DEFAULT clock_timestamp()
);


ALTER TABLE photos OWNER TO emilsedgh;

--
-- Name: property_rooms; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE property_rooms (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    matrix_unique_id bigint,
    matrix_modified_dt timestamp with time zone,
    description text,
    length integer,
    width integer,
    features text,
    listing_mui bigint,
    level integer,
    room_type text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE property_rooms OWNER TO emilsedgh;

--
-- Name: property_units; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE property_units (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    dining_length integer,
    dining_width integer,
    kitchen_length integer,
    kitchen_width integer,
    lease integer,
    listing_mui bigint,
    living_length integer,
    living_width integer,
    master_length integer,
    master_width integer,
    matrix_unique_id bigint,
    matrix_modified_dt timestamp with time zone,
    full_bath integer,
    half_bath integer,
    beds integer,
    units integer,
    square_feet integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE property_units OWNER TO emilsedgh;

--
-- Name: recommendations; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE recommendations (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    source source_type,
    source_url text,
    room uuid NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    listing uuid NOT NULL,
    recommendation_type recommendation_type,
    matrix_unique_id bigint NOT NULL,
    referring_objects uuid[],
    deleted_at timestamp with time zone,
    hidden boolean DEFAULT false,
    last_update recommendation_last_update DEFAULT 'New'::recommendation_last_update
);


ALTER TABLE recommendations OWNER TO emilsedgh;

--
-- Name: recommendations_eav; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE recommendations_eav (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    "user" uuid NOT NULL,
    action recommendation_eav_action NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    recommendation uuid NOT NULL
);


ALTER TABLE recommendations_eav OWNER TO emilsedgh;

--
-- Name: reviews; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE reviews (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    deleted_at timestamp with time zone,
    deal uuid NOT NULL,
    file uuid,
    envelope_document uuid
);


ALTER TABLE reviews OWNER TO emilsedgh;

--
-- Name: reviews_history; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE reviews_history (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    created_by uuid NOT NULL,
    review uuid NOT NULL,
    state review_state NOT NULL,
    comment text
);


ALTER TABLE reviews_history OWNER TO emilsedgh;

--
-- Name: rooms; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE rooms (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    title text,
    owner uuid,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    room_type room_type NOT NULL
);


ALTER TABLE rooms OWNER TO emilsedgh;

--
-- Name: rooms_room_code_seq; Type: SEQUENCE; Schema: public; Owner: emilsedgh
--

CREATE SEQUENCE rooms_room_code_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rooms_room_code_seq OWNER TO emilsedgh;

--
-- Name: rooms_users; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE rooms_users (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    room uuid NOT NULL,
    "user" uuid NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    push_enabled boolean DEFAULT true,
    phone_handler uuid,
    archived boolean DEFAULT false,
    reference text
);


ALTER TABLE rooms_users OWNER TO emilsedgh;

--
-- Name: schools; Type: MATERIALIZED VIEW; Schema: public; Owner: emilsedgh
--

CREATE MATERIALIZED VIEW schools AS
 SELECT DISTINCT properties.elementary_school_name AS name,
    count(*) AS appearances,
    properties.school_district AS district,
    'elementary_school'::text AS school_type
   FROM properties
  WHERE (length(properties.elementary_school_name) > 0)
  GROUP BY properties.elementary_school_name, properties.school_district
UNION
 SELECT DISTINCT properties.intermediate_school_name AS name,
    count(*) AS appearances,
    properties.school_district AS district,
    'intermediate_school'::text AS school_type
   FROM properties
  WHERE (length(properties.intermediate_school_name) > 0)
  GROUP BY properties.intermediate_school_name, properties.school_district
UNION
 SELECT DISTINCT properties.high_school_name AS name,
    count(*) AS appearances,
    properties.school_district AS district,
    'high_school'::text AS school_type
   FROM properties
  WHERE (length(properties.high_school_name) > 0)
  GROUP BY properties.high_school_name, properties.school_district
UNION
 SELECT DISTINCT properties.junior_high_school_name AS name,
    count(*) AS appearances,
    properties.school_district AS district,
    'junior_high_school'::text AS school_type
   FROM properties
  WHERE (length(properties.junior_high_school_name) > 0)
  GROUP BY properties.junior_high_school_name, properties.school_district
UNION
 SELECT DISTINCT properties.middle_school_name AS name,
    count(*) AS appearances,
    properties.school_district AS district,
    'middle_school'::text AS school_type
   FROM properties
  WHERE (length(properties.middle_school_name) > 0)
  GROUP BY properties.middle_school_name, properties.school_district
UNION
 SELECT DISTINCT properties.senior_high_school_name AS name,
    count(*) AS appearances,
    properties.school_district AS district,
    'senior_high_school'::text AS school_type
   FROM properties
  WHERE (length(properties.senior_high_school_name) > 0)
  GROUP BY properties.senior_high_school_name, properties.school_district
  WITH NO DATA;


ALTER TABLE schools OWNER TO emilsedgh;

--
-- Name: seamless_phone_pool; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE seamless_phone_pool (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    phone_number text NOT NULL,
    enabled boolean DEFAULT true
);


ALTER TABLE seamless_phone_pool OWNER TO emilsedgh;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE sessions (
    id uuid DEFAULT uuid_generate_v1(),
    device_id character varying(255),
    device_name character varying(255),
    client_version character varying(30),
    created_at timestamp without time zone DEFAULT clock_timestamp()
);


ALTER TABLE sessions OWNER TO emilsedgh;

--
-- Name: stripe_charges; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE stripe_charges (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    "user" uuid NOT NULL,
    customer uuid NOT NULL,
    amount integer,
    charge jsonb
);


ALTER TABLE stripe_charges OWNER TO emilsedgh;

--
-- Name: stripe_customers; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE stripe_customers (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    owner uuid NOT NULL,
    customer_id text NOT NULL,
    source jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone
);


ALTER TABLE stripe_customers OWNER TO emilsedgh;

--
-- Name: subdivisions; Type: MATERIALIZED VIEW; Schema: public; Owner: emilsedgh
--

CREATE MATERIALIZED VIEW subdivisions AS
 SELECT DISTINCT properties.subdivision_name AS title,
    count(*) AS appearances
   FROM properties
  GROUP BY properties.subdivision_name
  ORDER BY properties.subdivision_name
  WITH NO DATA;


ALTER TABLE subdivisions OWNER TO emilsedgh;

--
-- Name: users; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE users (
    username text,
    first_name text,
    last_name text,
    email text NOT NULL,
    phone_number text,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    password character varying(512) NOT NULL,
    address_id uuid,
    cover_image_url text,
    profile_image_url text,
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    user_status user_status DEFAULT 'Active'::user_status NOT NULL,
    profile_image_thumbnail_url text,
    cover_image_thumbnail_url text,
    email_confirmed boolean DEFAULT false,
    timezone text DEFAULT 'America/Chicago'::text,
    user_type user_type DEFAULT 'Client'::user_type NOT NULL,
    deleted_at timestamp with time zone,
    phone_confirmed boolean DEFAULT false,
    agent uuid,
    secondary_password text DEFAULT md5((random())::text) NOT NULL,
    is_shadow boolean DEFAULT false,
    personal_room uuid,
    brand uuid,
    fake_email boolean DEFAULT false,
    facebook_access_token text,
    features jsonb
);


ALTER TABLE users OWNER TO emilsedgh;

--
-- Name: users_user_code_seq; Type: SEQUENCE; Schema: public; Owner: emilsedgh
--

CREATE SEQUENCE users_user_code_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_code_seq OWNER TO emilsedgh;

--
-- Name: websites; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE websites (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    "user" uuid NOT NULL
);


ALTER TABLE websites OWNER TO emilsedgh;

--
-- Name: websites_hostnames; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE websites_hostnames (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    website uuid NOT NULL,
    hostname text,
    "default" boolean DEFAULT false NOT NULL
);


ALTER TABLE websites_hostnames OWNER TO emilsedgh;

--
-- Name: websites_snapshots; Type: TABLE; Schema: public; Owner: emilsedgh
--

CREATE TABLE websites_snapshots (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    website uuid NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    brand uuid,
    template text,
    attributes jsonb
);


ALTER TABLE websites_snapshots OWNER TO emilsedgh;

--
-- Name: words; Type: MATERIALIZED VIEW; Schema: public; Owner: emilsedgh
--

CREATE MATERIALIZED VIEW words AS
 SELECT ts_stat.word,
    ts_stat.ndoc AS occurances
   FROM ts_stat('SELECT to_tsvector(''simple'', address) FROM listings_filters'::text) ts_stat(word, ndoc, nentry)
  WITH NO DATA;


ALTER TABLE words OWNER TO emilsedgh;

SET search_path = tiger, pg_catalog;

--
-- Name: foo; Type: TABLE; Schema: tiger; Owner: emilsedgh
--

CREATE TABLE foo (
    geom public.geometry(Point,4326),
    title text
);


ALTER TABLE foo OWNER TO emilsedgh;

SET search_path = public, pg_catalog;

--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY activities (id, reference, reference_type, created_at, updated_at, deleted_at, object, object_class, object_sa, action) FROM stdin;
\.


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY addresses (title, subtitle, street_number, street_name, city, state, state_code, postal_code, neighborhood, id, street_suffix, unit_number, country, country_code, created_at, updated_at, location_google, matrix_unique_id, geocoded, geo_source, partial_match_google, county_or_parish, direction, street_dir_prefix, street_dir_suffix, street_number_searchable, geo_source_formatted_address_google, geocoded_google, geocoded_bing, location_bing, geo_source_formatted_address_bing, geo_confidence_google, geo_confidence_bing, location, approximate, corrupted, corrupted_google, corrupted_bing, deleted_at) FROM stdin;
		5743	Prospect	Dallas	Texas	TX	75206		f96d7c9c-c1ea-11e5-bcc6-f23c91c841bd		A	United States	USA	2016-01-23 17:04:25.587646+01	2016-01-29 12:14:16.161126+01	0101000020E610000094D74AE82E3158C09869FB5756684040	2047261	t	Google	t	Dallas	\N			5743	5743 Prospect Ave, Dallas, TX 75206, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E610000094D74AE82E3158C09869FB5756684040	f	f	f	\N	\N
		4411	Bowser	Dallas	Texas	TX	75219		71a39b6a-b48a-11e5-b2ad-f23c91c841bd		209	United States	USA	2016-01-06 16:30:40.969728+01	2016-01-14 15:04:37.572972+01	0101000020E61000000D164ED2FC3358C0D7DEA7AAD0684040	58913859	t	Google	t	Dallas	\N			4411	4411 Bowser Ave, Dallas, TX 75219, USA	t	t	0101000020E6100000000000E0FC3358C0000000A0D0684040	4411 Bowser Ave, Dallas, TX 75219	ROOFTOP	High	0101000020E61000000D164ED2FC3358C0D7DEA7AAD0684040	f	f	f	f	\N
		4502	Holland	Dallas	Texas	TX	75219		a0611040-b88b-11e5-9643-f23c91c841bd	Avenue	104	United States	USA	2016-01-11 18:49:13.534434+01	2016-01-22 17:04:17.134403+01	0101000020E61000003AC780ECF53358C02B4F20EC14694040	58982003	t	Google	\N	Dallas	\N			4502	4502 Holland Ave, Dallas, TX 75219, USA	t	t	0101000020E6100000000000E0F53358C0000000E014694040	4502 Holland Ave, Dallas, TX 75219	ROOFTOP	High	0101000020E61000003AC780ECF53358C02B4F20EC14694040	f	f	f	f	\N
		4502	Holland	Dallas	Texas	TX	75219		68410c8c-b88c-11e5-a56f-f23c91c841bd	Avenue	202	United States	USA	2016-01-11 18:54:48.869005+01	2016-01-22 17:04:17.220249+01	0101000020E61000003AC780ECF53358C02B4F20EC14694040	58982074	t	Google	\N	Dallas	\N			4502	4502 Holland Ave, Dallas, TX 75219, USA	t	t	0101000020E6100000828DEBDFF53358C08A5759DB14694040	4502 Holland Ave, Dallas, TX 75219	ROOFTOP	High	0101000020E61000003AC780ECF53358C02B4F20EC14694040	f	f	f	f	\N
		7106	Aspen Creek	Dallas	Texas	TX	75252		ff122ea8-c23b-11e5-8f6a-f23c91c841bd	Lane		United States	USA	2016-01-24 02:44:24.290647+01	2016-01-24 02:51:16.10975+01	0101000020E6100000EFFCA204FD3158C044FAEDEBC07F4040	2245733	t	Google	\N	Collin	\N			7106	7106 Aspen Creek Ln, Dallas, TX 75252, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000EFFCA204FD3158C044FAEDEBC07F4040	f	f	f	\N	\N
		4240	Prescott	Dallas	Texas	TX	75219		019db172-a9c0-11e5-8893-f23c91c841bd	Avenue	7E	United States	USA	2015-12-23 22:56:23.059131+01	2016-02-08 18:38:35.950087+01	0101000020E61000007C629D2A5F3358C02149FF8128694040	58731414	t	Google	\N	Dallas	\N			4240	4240 Prescott Ave, Dallas, TX 75219, USA	t	t	0101000020E61000000000508C6E3358C0000000792B694040	4240 Prescott Ave, Dallas, TX 75219	ROOFTOP	High	0101000020E61000007C629D2A5F3358C02149FF8128694040	f	f	f	f	\N
		11459	Glen Cross	Dallas	Texas	TX	75228		68cb2f16-3317-11e5-92b3-0a995b070205	Drive		United States	USA	2015-07-25 23:52:14.007715+02	2015-09-18 16:32:52.41609+02	0101000020E61000009885764EB32958C0923CD7F7E16C4040	55864068	\N	None	\N	Dallas	\N			11459	11459 Glen Cross Drive, Dallas, TX 75228, USA	t	t	0101000020E610000000000020B32958C0000000E0E06C4040	11459 Glen Cross Dr, Dallas, TX 75228	\N	\N	\N	\N	\N	f	f	\N
		4240	Prescott	Dallas	Texas	TX	75219		c5ba66b0-a40f-11e5-a8b8-f23c91c841bd	Avenue	7D	United States	USA	2015-12-16 17:12:15.345664+01	2016-02-08 18:33:09.201511+01	0101000020E61000007C629D2A5F3358C02149FF8128694040	58615835	t	Google	\N	Dallas	\N			4240	4240 Prescott Ave, Dallas, TX 75219, USA	t	t	0101000020E61000000000508C6E3358C0000000792B694040	4240 Prescott Ave, Dallas, TX 75219	ROOFTOP	High	0101000020E61000007C629D2A5F3358C02149FF8128694040	f	f	f	f	\N
		2408	Victory Park	Dallas	Texas	TX	75219		2f265020-9eb9-11e5-a82d-f23c91c841bd	Lane	842	United States	USA	2015-12-09 22:09:50.184389+01	2016-02-02 18:13:16.441882+01	0101000020E6100000283B472EC93358C05721E527D5644040	58544147	t	Google	\N	Dallas	\N			2408	2408 Victory Park Ln, Dallas, TX 75219, USA	t	t	0101000020E61000000000901BCC3358C000008072D4644040	2408 Victory Park Ln, Dallas, TX 75219	ROOFTOP	High	0101000020E6100000283B472EC93358C05721E527D5644040	f	f	f	f	\N
		3723	Wendelkin	Dallas	Texas	TX	75215		2e153c0e-c2d2-11e5-84f5-f23c91c841bd	Street		United States	USA	2016-01-24 20:39:27.67306+01	2016-01-26 16:22:08.593772+01	0101000020E6100000E8AD70813A3158C0DC9BDF30D1604040	1375600	t	Google	\N	Dallas	\N			3723	3723 Wendelkin St, Dallas, TX 75215, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000E8AD70813A3158C0DC9BDF30D1604040	f	f	f	\N	\N
		4323	Gilbert	Dallas	Texas	TX	75219		ff3f4080-d36d-11e5-89e7-f23c91c841bd	Avenue	4	United States	USA	2016-02-14 23:55:09.189391+01	2016-02-16 07:05:17.136887+01	0101000020E610000068D311C0CD3358C0A33F34F3E4684040	59698128	t	Google	\N	Dallas	\N			4323	4323 Gilbert Ave, Dallas, TX 75219, USA	t	t	0101000020E6100000000000C0CD3358C000000000E5684040	4323 Gilbert Ave, Dallas, TX 75219	ROOFTOP	High	0101000020E610000068D311C0CD3358C0A33F34F3E4684040	f	f	f	f	\N
		3701	Commerce	Dallas	Texas	TX	75226		b9ea9ae0-c2cc-11e5-aa15-f23c91c841bd	Street		United States	USA	2016-01-24 20:00:25.294221+01	2016-01-27 05:39:56.951601+01	0101000020E6100000AD156D8E733158C048A3A76D68644040	1289260	t	Google	\N	Dallas	\N			3701	3701 Commerce St, Dallas, TX 75226, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000AD156D8E733158C048A3A76D68644040	f	f	f	\N	\N
		2408	Victory Park	Dallas	Texas	TX	75219		d6361666-d41a-11e5-bf12-f23c91c841bd	Lane	836	United States	USA	2016-02-15 20:32:23.277281+01	2016-02-18 13:17:42.200202+01	0101000020E6100000283B472EC93358C05721E527D5644040	59709556	t	Google	\N	Dallas	\N			2408	2408 Victory Park Ln, Dallas, TX 75219, USA	t	t	0101000020E61000000000901BCC3358C000008072D4644040	2408 Victory Park Ln, Dallas, TX 75219	ROOFTOP	High	0101000020E6100000283B472EC93358C05721E527D5644040	f	f	f	f	\N
		1748	Glenlivet	Dallas	Texas	TX	75218		6c5bbf54-bc12-11e5-9fef-f23c91c841bd	Drive		United States	USA	2016-01-16 06:31:41.805159+01	2016-02-01 01:29:10.93365+01	0101000020E61000000FB8AE98112E58C035CF11F92E674040	2360683	t	Google	\N	Dallas	\N			1748	1748 Glenlivet Dr, Dallas, TX 75218, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000000FB8AE98112E58C035CF11F92E674040	f	f	f	\N	\N
		7320	Walling	Dallas	Texas	TX	75231		76d726ca-c1f9-11e5-9b8c-f23c91c841bd	Lane		United States	USA	2016-01-23 18:48:08.949445+01	2016-01-29 02:47:39.233992+01	0101000020E6100000115FDCFCF52E58C09BE3DC26DC6D4040	2034018	t	Google	\N	Dallas	\N			7320	7320 Walling Ln, Dallas, TX 75231, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000115FDCFCF52E58C09BE3DC26DC6D4040	f	f	f	\N	\N
		2323	Houston	Dallas	Texas	TX	75219		7dee0712-b326-11e5-9d3c-f23c91c841bd	Street	509	United States	USA	2016-01-04 22:02:40.754586+01	2016-02-15 19:43:41.409326+01	0101000020E610000016461F98C83358C01BB4FC659C644040	58870994	t	Google	\N	Dallas	\N	N		2323	2323 N Houston St, Dallas, TX 75219, USA	t	t	0101000020E610000000004065C33358C00000A059A0644040	2323 N Houston St, Dallas, TX 75219	ROOFTOP	High	0101000020E610000016461F98C83358C01BB4FC659C644040	f	f	f	f	\N
		6806	CHARADE DR	Dallas	Texas	TX	75214		da554a56-c1f4-11e5-9606-f23c91c841bd			United States	USA	2016-01-23 18:15:08.38695+01	2016-01-29 10:24:55.471323+01	0101000020E610000003B2D7BB3F2F58C0C2C073EFE16A4040	1462373	t	Google	\N	Dallas	\N			6806	6806 Charade Dr, Dallas, TX 75214, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E610000003B2D7BB3F2F58C0C2C073EFE16A4040	f	f	f	\N	\N
		6516	Vanderbilt	Dallas	Texas	TX	75214		f58e13c2-ba9a-11e5-87de-f23c91c841bd	Avenue		United States	USA	2016-01-14 09:44:01.212478+01	2016-01-31 02:11:58.416258+01	0101000020E61000004D66BCADF42F58C0506EDBF7A8694040	50791870	t	Google	\N	Dallas	\N			6516	6516 Vanderbilt Ave, Dallas, TX 75214, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000004D66BCADF42F58C0506EDBF7A8694040	f	f	f	\N	\N
		6009	Palo Pinto	Dallas	Texas	TX	75206		c9c064a6-ba5f-11e5-a555-f23c91c841bd	Avenue		United States	USA	2016-01-14 02:40:27.415479+01	2016-01-31 06:14:37.325989+01	0101000020E610000038A0A52BD83058C0FD8282F7FA684040	51490207	t	Google	\N	Dallas	\N			6009	6009 Palo Pinto Ave, Dallas, TX 75206, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E610000038A0A52BD83058C0FD8282F7FA684040	f	f	f	\N	\N
		7621	Dentcrest	Dallas	Texas	TX	75254		752c5384-c2d2-11e5-84f5-f23c91c841bd	Drive		United States	USA	2016-01-24 20:41:26.942489+01	2016-01-26 12:58:54.473043+01	0101000020E61000007F03498EAA3158C0D4635B069C794040	1399174	t	Google	\N	Dallas	\N			7621	7621 Dentcrest Dr, Dallas, TX 75254, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000007F03498EAA3158C0D4635B069C794040	f	f	f	\N	\N
		4216	Delmar	Dallas	Texas	TX	75206		5356ee40-c1f1-11e5-bc6c-f23c91c841bd	Avenue		United States	USA	2016-01-23 17:49:53.415112+01	2016-01-29 11:26:30.265353+01	0101000020E6100000DF13EB54F93058C067EF8CB62A6B4040	1383273	t	Google	\N	Dallas	\N			4216	4216 Delmar Ave, Dallas, TX 75206, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000DF13EB54F93058C067EF8CB62A6B4040	f	f	f	\N	\N
		4935	Victor	Dallas	Texas	TX	75214		7b7b206e-ba9c-11e5-b276-f23c91c841bd	Street		United States	USA	2016-01-14 09:54:55.399781+01	2016-01-31 02:05:05.237134+01	0101000020E6100000BD715298F73058C067D5E76A2B664040	50830245	t	Google	\N	Dallas	\N			4935	4935 Victor St, Dallas, TX 75214, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000BD715298F73058C067D5E76A2B664040	f	f	f	\N	\N
		4308	Holland	Dallas	Texas	TX	75219		827b4abe-ba34-11e5-849e-f23c91c841bd	Avenue		United States	USA	2016-01-13 21:30:39.48485+01	2016-02-18 13:14:03.415009+01	0101000020E610000019028063CF3358C06116DA39CD684040	59052080	t	Google	\N	Dallas	\N			4308	4308 Holland Ave, Dallas, TX 75219, USA	t	t	0101000020E610000031444E5FCF3358C06116DA39CD684040	4308 Holland Ave, Dallas, TX 75219	ROOFTOP	High	0101000020E610000019028063CF3358C06116DA39CD684040	f	f	f	f	\N
		1001	Belleview	Dallas	Texas	TX	75215		fdd6678e-ba52-11e5-acec-f23c91c841bd	Street	507	United States	USA	2016-01-14 01:08:51.34287+01	2016-01-31 07:02:36.129072+01	0101000020E61000006F9A3E3BE03258C0C08CCE9E70624040	50547026	t	Google	\N	Dallas	\N			1001	1001 Belleview St, Dallas, TX 75215, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000006F9A3E3BE03258C0C08CCE9E70624040	f	f	f	\N	\N
		6950	Aspen Creek	Dallas	Texas	TX	75252		ff66bfa6-325b-11e5-b020-0a995b070205	Lane		United States	USA	2015-07-25 01:30:41.300251+02	2015-08-31 21:48:26.884381+02	0101000020E610000082FE428F183258C0628731E9EF7F4040	55789812	\N	None	\N	Collin	\N			6950	6950 Aspen Creek Lane, Dallas, TX 75252, USA	t	t	0101000020E610000000000080183258C0000000E0EF7F4040	6950 Aspen Creek Ln, Dallas, TX 75252	\N	\N	\N	\N	\N	f	f	\N
		9840	Crocker	Dallas	Texas	TX	75217		b4195f4c-c30e-11e5-9a55-f23c91c841bd	Drive		United States	USA	2016-01-25 03:52:42.318641+01	2016-01-26 04:10:14.396385+01	0101000020E6100000973446EBA82958C0511553E927584040	1933053	t	Google	\N	Dallas	\N			9840	9840 Crocker Dr, Dallas, TX 75217, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000973446EBA82958C0511553E927584040	f	f	f	\N	\N
		3617	Granbury	Dallas	Texas	TX	75287		5625cff0-c260-11e5-9530-f23c91c841bd	Drive		United States	USA	2016-01-24 07:04:32.2634+01	2016-01-31 16:32:44.449124+01	0101000020E6100000BCE47FF2773658C0AE28CA4A38804040	2025784	t	Google	\N	Denton	\N			3617	3617 Granbury Dr, Dallas, TX 75287, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000BCE47FF2773658C0AE28CA4A38804040	f	f	f	\N	\N
		6900	SKILLMAN	Dallas	Texas	TX	75231		f3725702-c269-11e5-ba2b-f23c91c841bd		704G	United States	USA	2016-01-24 08:13:21.637726+01	2016-01-28 05:44:49.424179+01	0101000020E61000003AB01C21032F58C02C216981876F4040	1657963	t	Google	t	Dallas	\N			6900	6900 Skillman St, Dallas, TX 75231, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000003AB01C21032F58C02C216981876F4040	f	f	f	\N	\N
		6050	Melody	Dallas	Texas	TX	75231		4461609a-c21f-11e5-8149-f23c91c841bd	Lane	179P	United States	USA	2016-01-23 23:18:45.167342+01	2016-01-23 23:24:33.428045+01	0101000020E6100000F2FE89DBB23058C0CA0C65F2176F4040	2356489	t	Google	\N	Dallas	\N			6050	6050 Melody Ln, Dallas, TX 75231, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000F2FE89DBB23058C0CA0C65F2176F4040	f	f	f	\N	\N
		6215	MIMOSA	Dallas	Texas	TX	75230		0347f1ca-c1f5-11e5-9606-f23c91c841bd			United States	USA	2016-01-23 18:16:17.085961+01	2016-01-29 09:06:17.838435+01	0101000020E6100000C3D66CE5253358C0410FB56D18714040	1569942	t	Google	t	Dallas	\N			6215	6215 Mimosa Ln, Dallas, TX 75230, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000C3D66CE5253358C0410FB56D18714040	f	f	f	\N	\N
		6845	Southridge	Dallas	Texas	TX	75214		83516ca8-c1f9-11e5-9b8c-f23c91c841bd	Drive		United States	USA	2016-01-23 18:48:29.883318+01	2016-01-29 02:23:16.168756+01	0101000020E61000003048FAB48A2F58C0F7E6374C346A4040	2062249	t	Google	\N	Dallas	\N			6845	6845 Southridge Dr, Dallas, TX 75214, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000003048FAB48A2F58C0F7E6374C346A4040	f	f	f	\N	\N
		2430	Victory Park	Dallas	Texas	TX	75219		cd160c18-cb9a-11e5-b4c2-f23c91c841bd	Lane	3001	United States	USA	2016-02-05 00:55:43.084243+01	2016-02-05 09:02:48.813746+01	0101000020E6100000FDFD1829CA3358C033C74D68ED644040	59505817	t	Google	\N	Dallas	\N			2430	2430 Victory Park Ln, Dallas, TX 75219, USA	t	t	0101000020E61000000000C0ADCD3358C00000E0DBEC644040	2430 Victory Park Ln, Dallas, TX 75219	ROOFTOP	High	0101000020E6100000FDFD1829CA3358C033C74D68ED644040	f	f	f	f	\N
		1505	ELM ST	Dallas	Texas	TX	75201		09ebb8ac-c2c9-11e5-96da-f23c91c841bd		204	United States	USA	2016-01-24 19:34:01.532353+01	2016-01-27 11:24:30.536544+01	0101000020E61000002B44D14D2C3358C087C66EFA0E644040	1137861	t	Google	\N	Dallas	\N			1505	1505 Elm St, Dallas, TX 75201, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000002B44D14D2C3358C087C66EFA0E644040	f	f	f	\N	\N
		4103	Throckmorton	Dallas	Texas	TX	75219		b9c79116-c1fb-11e5-9ed4-f23c91c841bd	Avenue		United States	USA	2016-01-23 19:04:20.248144+01	2016-01-28 22:28:47.268442+01	0101000020E61000008251499D803358C0A19DD32CD0684040	2317178	t	Google	\N	Dallas	\N			4103	4103 Throckmorton St, Dallas, TX 75219, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000008251499D803358C0A19DD32CD0684040	f	f	f	\N	\N
		11221	Drummond	Dallas	Texas	TX	75228		5532f5f2-c281-11e5-a984-f23c91c841bd	Drive		United States	USA	2016-01-24 11:00:44.063806+01	2016-01-31 16:15:21.033233+01	0101000020E61000009B8BBFED092A58C0DE21C500896C4040	2248275	t	Google	\N	Dallas	\N			11221	11221 Drummond Dr, Dallas, TX 75228, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000009B8BBFED092A58C0DE21C500896C4040	f	f	f	\N	\N
		3316	Dothan	Dallas	Texas	TX	75229		017b87e2-c2f1-11e5-9af8-f23c91c841bd	Lane		United States	USA	2016-01-25 00:20:07.244492+01	2016-01-26 08:24:28.958871+01	0101000020E6100000E4A7716F7E3758C00DC2DCEEE5724040	1219390	t	Google	\N	Dallas	\N			3316	3316 Dothan Ln, Dallas, TX 75229, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000E4A7716F7E3758C00DC2DCEEE5724040	f	f	f	\N	\N
		3525	Turtle Creek	Dallas	Texas	TX	75219		6463e77e-bce7-11e5-aa38-f23c91c841bd	Boulevard	7E	United States	USA	2016-01-17 07:56:11.240237+01	2016-01-17 13:39:59.585976+01	0101000020E6100000772AE09E673358C06E43D664D7674040	2445371	t	Google	\N	Dallas	\N			3525	3525 Turtle Creek Blvd, Dallas, TX 75219, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000772AE09E673358C06E43D664D7674040	f	f	f	\N	\N
		5020	Junius	Dallas	Texas	TX	75214		e8207750-f7ec-11e4-b937-0a95648eeb58	Street		United States	USA	2015-05-11 16:49:20.671007+02	2015-08-03 22:43:19.212481+02	0101000020E6100000E3344415FE3058C028EFE3688E664040	52656456	\N	None	\N	Dallas	\N			5020	5020 Junius Street, Dallas, TX 75214, USA	t	f	\N	\N	\N	\N	\N	\N	\N	f	\N	\N
		6532	CHICORY	Dallas	Texas	TX	75214		a4b751e8-c2ce-11e5-beb0-f23c91c841bd	Court		United States	USA	2016-01-24 20:14:08.71953+01	2016-01-27 01:46:43.629048+01	0101000020E61000002BBEA1F0D92F58C0CDCB61F71D6D4040	1320842	t	Google	\N	Dallas	\N			6532	6532 Chicory Ct, Dallas, TX 75214, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000002BBEA1F0D92F58C0CDCB61F71D6D4040	f	f	f	\N	\N
		8424	Creekbluff	Dallas	Texas	TX	75249		1a486268-c16b-11e5-8832-f23c91c841bd	Drive		United States	USA	2016-01-23 01:49:05.127884+01	2016-01-30 04:59:27.345659+01	0101000020E61000004B5CC7B8E23D58C09702D2FE07524040	2203370	t	Google	\N	Dallas	\N			8424	8424 Creekbluff Dr, Dallas, TX 75249, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000004B5CC7B8E23D58C09702D2FE07524040	f	f	f	\N	\N
		4240	Prescott	Dallas	Texas	TX	75219		50be8f1a-a50b-11e5-89c6-f23c91c841bd	Avenue	7F	United States	USA	2015-12-17 23:12:52.255484+01	2016-01-03 14:01:20.349905+01	0101000020E61000007C629D2A5F3358C02149FF8128694040	58665269	t	Google	\N	Dallas	\N			4240	4240 Prescott Ave, Dallas, TX 75219, USA	t	t	0101000020E61000000000508C6E3358C0000000792B694040	4240 Prescott Ave, Dallas, TX 75219	ROOFTOP	High	0101000020E61000007C629D2A5F3358C02149FF8128694040	f	f	f	f	\N
		3030	Bryan	Dallas	Texas	TX	75204		6bc0a696-c16b-11e5-8832-f23c91c841bd	Street	404	United States	USA	2016-01-23 01:51:21.8114+01	2016-01-23 01:52:28.02493+01	0101000020E610000046CB811E6A3258C0257497C459654040	2272071	t	Google	\N	Dallas	\N			3030	3030 Bryan St, Dallas, TX 75204, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E610000046CB811E6A3258C0257497C459654040	f	f	f	\N	\N
		3800	Holland	Dallas	Texas	TX	75219		dad9743e-bb28-11e5-b7d3-f23c91c841bd	Avenue	11	United States	USA	2016-01-15 02:39:44.943611+01	2016-01-30 17:28:18.848648+01	0101000020E610000090D78349713358C068DB1FDE29684040	37919010	t	Google	\N	Dallas	\N			3800	3800 Holland Ave, Dallas, TX 75219, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E610000090D78349713358C068DB1FDE29684040	f	f	f	\N	\N
		2323	Houston	Dallas	Texas	TX	75219		731948f2-c1fd-11e5-a990-f23c91c841bd	Street	207	United States	USA	2016-01-23 19:16:40.65895+01	2016-01-28 22:15:13.507857+01	0101000020E610000016461F98C83358C01BB4FC659C644040	1380895	t	Google	\N	Dallas	\N	N		2323	2323 N Houston St, Dallas, TX 75219, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E610000016461F98C83358C01BB4FC659C644040	f	f	f	\N	\N
		4432	Bowser	Dallas	Texas	TX	75219		05f8566e-be10-11e5-a85f-f23c91c841bd	Avenue	B	United States	USA	2016-01-18 19:19:33.358095+01	2016-01-19 08:04:00.149763+01	0101000020E6100000A2A47675FD3358C062A1D634EF684040	59095666	t	Google	\N	Dallas	\N			4432	4432 Bowser Ave, Dallas, TX 75219, USA	t	t	0101000020E61000003D80457EFD3358C0321D3A3DEF684040	4432 Bowser Ave, Dallas, TX 75219	ROOFTOP	High	0101000020E6100000A2A47675FD3358C062A1D634EF684040	f	f	f	f	\N
		8507	Charing Cross	Dallas	Texas	TX	75238		ecac6710-c2cc-11e5-aa15-f23c91c841bd	Lane		United States	USA	2016-01-24 20:01:50.450223+01	2016-01-27 04:14:43.66832+01	0101000020E61000005B6FE5362B2C58C055DD239BAB6E4040	1298515	t	Google	\N	Dallas	\N			8507	8507 Charing Cross Ln, Dallas, TX 75238, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000005B6FE5362B2C58C055DD239BAB6E4040	f	f	f	\N	\N
		7420	GLENSHANNON	Dallas	Texas	TX	75225		0e9f74e4-c1f5-11e5-9606-f23c91c841bd	Circle		United States	USA	2016-01-23 18:16:36.114485+01	2016-01-29 08:42:30.543936+01	0101000020E6100000D2FE0758AB3158C08F17D2E121704040	1600249	t	Google	\N	Dallas	\N			7420	7420 Glenshannon Cir, Dallas, TX 75225, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000D2FE0758AB3158C08F17D2E121704040	f	f	f	\N	\N
		949	Hannah Way	Dallas	Texas	TX	75253		89b06f84-c368-11e5-92b3-f23c91c841bd			United States	USA	2016-01-25 14:35:45.872276+01	2016-01-25 15:08:40.524062+01	0101000020E610000075012F336C2558C0CAE2FE23D3574040	1988905	t	Google	\N	Dallas	\N			949	949 Hannah Way, Dallas, TX 75253, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E610000075012F336C2558C0CAE2FE23D3574040	f	f	f	\N	\N
		9634	LAKEMONT DR	Dallas	Texas	TX	75220		db2b568c-c1f4-11e5-9606-f23c91c841bd			United States	USA	2016-01-23 18:15:09.789741+01	2016-01-31 17:34:09.413923+01	0101000020E61000007B34D593F93558C0711C78B5DC6F4040	1463691	t	Google	\N	Dallas	\N			9634	9634 Lakemont Dr, Dallas, TX 75220, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000007B34D593F93558C0711C78B5DC6F4040	f	f	f	\N	\N
		4432	Bowser	Dallas	Texas	TX	75219		8d4bdf72-be11-11e5-aac7-f23c91c841bd	Avenue	C	United States	USA	2016-01-18 19:30:29.8946+01	2016-01-19 08:04:00.151129+01	0101000020E6100000A2A47675FD3358C062A1D634EF684040	59096317	t	Google	\N	Dallas	\N			4432	4432 Bowser Ave, Dallas, TX 75219, USA	t	t	0101000020E610000000000080FD3358C000000040EF684040	4432 Bowser Ave, Dallas, TX 75219	ROOFTOP	High	0101000020E6100000A2A47675FD3358C062A1D634EF684040	f	f	f	f	\N
		7407	Wellcrest	Dallas	Texas	TX	75230		6ec90d46-c1e9-11e5-af0e-f23c91c841bd	Drive		United States	USA	2016-01-23 16:53:23.487701+01	2016-01-23 17:01:53.50969+01	0101000020E6100000471E882CD23158C06ECACB50CB714040	2083889	t	Google	\N	Dallas	\N			7407	7407 Wellcrest Dr, Dallas, TX 75230, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000471E882CD23158C06ECACB50CB714040	f	f	f	\N	\N
		6708	Dupper	Dallas	Texas	TX	75252		5f45ec02-c146-11e5-8192-f23c91c841bd	Drive		United States	USA	2016-01-22 21:26:09.495444+01	2016-01-23 01:47:10.744393+01	0101000020E6100000450F7C0C563258C08F34B8AD2D804040	2175635	t	Google	\N	Collin	\N			6708	6708 Dupper Dr, Dallas, TX 75252, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000450F7C0C563258C08F34B8AD2D804040	f	f	f	\N	\N
		902	Edgefield	Dallas	Texas	TX	75208		0c491220-bc39-11e5-b04f-f23c91c841bd	Avenue		United States	USA	2016-01-16 11:08:10.993945+01	2016-01-17 01:37:39.349364+01	0101000020E610000011FDDAFAE93558C021AD31E884604040	2529072	t	Google	\N	Dallas	\N	N		902	902 N Edgefield Ave, Dallas, TX 75208, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E610000011FDDAFAE93558C021AD31E884604040	f	f	f	\N	\N
		3720	Kimballdale	Dallas	Texas	TX	75233		573e24a4-c171-11e5-a880-f23c91c841bd	Drive		United States	USA	2016-01-23 02:33:44.382025+01	2016-01-29 17:08:30.363368+01	0101000020E6100000C98FF8156B3858C0DBC4C9FD0E594040	2351891	t	Google	\N	Dallas	\N			3720	3720 Kimballdale Dr, Dallas, TX 75233, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000C98FF8156B3858C0DBC4C9FD0E594040	f	f	f	\N	\N
		5407	Bryan	Dallas	Texas	TX	75206		8402e3c6-ba8c-11e5-a6ab-f23c91c841bd	Street	B207	United States	USA	2016-01-14 08:00:37.763558+01	2016-01-31 03:10:09.541141+01	0101000020E6100000D7D182610A3158C0332EC14E56674040	50557280	t	Google	\N	Dallas	\N			5407	5407 Bryan St, Dallas, TX 75206, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000D7D182610A3158C0332EC14E56674040	f	f	f	\N	\N
		193	Creek Cove	Dallas	Texas	TX	75217		2a4e9f68-bb2d-11e5-b859-f23c91c841bd	Drive		United States	USA	2016-01-15 03:10:36.238412+01	2016-01-30 17:07:49.877157+01	0101000020E61000005AF2785A7E2D58C02CBCCB457C5B4040	49605397	t	Google	\N	Dallas	\N			193	193 Creek Cove Dr, Dallas, TX 75217, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000005AF2785A7E2D58C02CBCCB457C5B4040	f	f	f	\N	\N
		8547	Vista Grande	Dallas	Texas	TX	75249		8b229390-bc99-11e5-936d-f23c91c841bd	Drive		United States	USA	2016-01-16 22:38:55.498344+01	2016-01-31 21:02:43.181014+01	0101000020E61000000CE36E10AD3C58C0B5334C6DA9534040	2497853	t	Google	\N	Dallas	\N			8547	8547 Vista Grande Dr, Dallas, TX 75249, USA	t	t	0101000020E610000000000000AD3C58C000000040A9534040	8547 Vista Grande Dr, Dallas, TX 75249	ROOFTOP	High	0101000020E61000000CE36E10AD3C58C0B5334C6DA9534040	f	f	f	f	\N
		6904	Hickory Creek	Dallas	Texas	TX	75252		e31e4e70-bcc8-11e5-b3df-f23c91c841bd	Lane		United States	USA	2016-01-17 04:17:49.456114+01	2016-01-17 18:18:07.858599+01	0101000020E6100000D45E44DB313258C0BAA3FFE55A804040	2450807	t	Google	\N	Collin	\N			6904	6904 Hickory Creek Ln, Dallas, TX 75252, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000D45E44DB313258C0BAA3FFE55A804040	f	f	f	\N	\N
		6322	Linden	Dallas	Texas	TX	75230		0f0bd75c-c1e5-11e5-a301-f23c91c841bd	Lane		United States	USA	2016-01-23 16:22:04.877208+01	2016-01-29 12:55:19.204758+01	0101000020E610000076244D72F63258C07CD6355A0E764040	2065316	t	Google	\N	Dallas	\N			6322	6322 Linden Ln, Dallas, TX 75230, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E610000076244D72F63258C07CD6355A0E764040	f	f	f	\N	\N
		5815	Reiger	Dallas	Texas	TX	75214		c7dde498-ba9f-11e5-bb20-f23c91c841bd	Avenue		United States	USA	2016-01-14 10:18:32.044032+01	2016-01-31 01:48:04.430143+01	0101000020E61000003A92CB7F483058C0A79A594B01674040	49874310	t	Google	\N	Dallas	\N			5815	5815 Reiger Ave, Dallas, TX 75214, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000003A92CB7F483058C0A79A594B01674040	f	f	f	\N	\N
		4212	Hall	Dallas	Texas	TX	75219		63334408-c219-11e5-b5d8-f23c91c841bd	Street	23	United States	USA	2016-01-23 22:36:39.894122+01	2016-01-28 19:58:36.586947+01	0101000020E6100000BDA59C2FF63358C038DC476E4D684040	1379463	t	Google	t	Dallas	\N			4212	4212 N Hall St, Dallas, TX 75219, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000BDA59C2FF63358C038DC476E4D684040	f	f	f	\N	\N
		6944	STEFANI	Dallas	Texas	TX	75225		55bece4a-c1f7-11e5-8b8e-f23c91c841bd	Drive		United States	USA	2016-01-23 18:32:54.43166+01	2016-01-29 05:31:18.723911+01	0101000020E610000022E527D53E3258C0E453008C67704040	1863063	t	Google	\N	Dallas	\N			6944	6944 Stefani Dr, Dallas, TX 75225, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E610000022E527D53E3258C0E453008C67704040	f	f	f	\N	\N
		2511	El Capitan	Dallas	Texas	TX	75228		85dace6e-c367-11e5-93fd-f23c91c841bd	Drive		United States	USA	2016-01-25 14:28:29.942342+01	2016-01-25 15:44:07.064526+01	0101000020E6100000D2C3D0EAE42A58C03F8F519E796D4040	1991939	t	Google	\N	Dallas	\N			2511	2511 El Capitan Dr, Dallas, TX 75228, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000D2C3D0EAE42A58C03F8F519E796D4040	f	f	f	\N	\N
		9641	INWOOD	Dallas	Texas	TX	75220		f2e796e6-c1f4-11e5-9606-f23c91c841bd	Road		United States	USA	2016-01-23 18:15:49.611074+01	2016-01-29 09:40:30.50744+01	0101000020E6100000C5E23785953458C00FB8AE9811704040	1528396	t	Google	\N	Dallas	\N			9641	9641 Inwood Rd, Dallas, TX 75220, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000C5E23785953458C00FB8AE9811704040	f	f	f	\N	\N
		8904	SHORELARK	Dallas	Texas	TX	75217		19161474-c31b-11e5-913c-f23c91c841bd	Drive		United States	USA	2016-01-25 05:21:25.707583+01	2016-01-26 00:26:47.441522+01	0101000020E61000003CE6F2D5C42A58C08BFA2477D85E4040	1640052	t	Google	\N	Dallas	\N			8904	8904 Shorelark Dr, Dallas, TX 75217, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000003CE6F2D5C42A58C08BFA2477D85E4040	f	f	f	\N	\N
		4502	Holland	Dallas	Texas	TX	75219		3079aa9c-b88d-11e5-9634-f23c91c841bd	Avenue	208	United States	USA	2016-01-11 19:00:24.784193+01	2016-01-22 17:04:17.386527+01	0101000020E61000003AC780ECF53358C02B4F20EC14694040	58982325	t	Google	\N	Dallas	\N			4502	4502 Holland Ave, Dallas, TX 75219, USA	t	t	0101000020E6100000000000E0F53358C0000000E014694040	4502 Holland Ave, Dallas, TX 75219	ROOFTOP	High	0101000020E61000003AC780ECF53358C02B4F20EC14694040	f	f	f	f	\N
		9011	Rockbrook	Dallas	Texas	TX	75220		eaedf0de-ba2e-11e5-af60-f23c91c841bd	Drive		United States	USA	2016-01-13 20:50:37.738995+01	2016-01-31 09:03:03.272351+01	0101000020E61000009E5A7D75553558C07E3672DD946E4040	50633269	t	Google	\N	Dallas	\N			9011	9011 Rockbrook Dr, Dallas, TX 75220, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000009E5A7D75553558C07E3672DD946E4040	f	f	f	\N	\N
		5716	Charlestown	Dallas	Texas	TX	75230		8932e808-bcbe-11e5-b338-f23c91c841bd	Drive		United States	USA	2016-01-17 03:03:43.628847+01	2016-01-31 19:40:48.265489+01	0101000020E6100000C4AD8218E83358C00053060E68754040	2435482	t	Google	\N	Dallas	\N			5716	5716 Charlestown Dr, Dallas, TX 75230, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000C4AD8218E83358C00053060E68754040	f	f	f	\N	\N
		2430	Victory Park	Dallas	Texas	TX	75219		7f58e562-cc63-11e5-913f-f23c91c841bd	Lane	2508	United States	USA	2016-02-06 00:52:21.502539+01	2016-02-08 16:09:22.433267+01	0101000020E6100000FDFD1829CA3358C033C74D68ED644040	59529693	t	Google	\N	Dallas	\N			2430	2430 Victory Park Ln, Dallas, TX 75219, USA	t	t	0101000020E61000000000C0ADCD3358C00000E0DBEC644040	2430 Victory Park Ln, Dallas, TX 75219	ROOFTOP	High	0101000020E6100000FDFD1829CA3358C033C74D68ED644040	f	f	f	f	\N
		9033	Guildhall	Dallas	Texas	TX	75238		3531a3d2-bbc1-11e5-9490-f23c91c841bd	Drive		United States	USA	2016-01-15 20:50:20.019295+01	2016-01-30 09:12:37.063843+01	0101000020E610000002603C83862D58C0289B7285776F4040	43529959	t	Google	\N	Dallas	\N			9033	9033 Guildhall Dr, Dallas, TX 75238, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E610000002603C83862D58C0289B7285776F4040	f	f	f	\N	\N
		5619	WORTH	Dallas	Texas	TX	75214		0f26c704-c2cd-11e5-aa15-f23c91c841bd	Street		United States	USA	2016-01-24 20:02:48.294907+01	2016-01-24 20:04:08.135787+01	0101000020E61000005D78149D9B3058C04A7F2F8507674040	1311841	t	Google	\N	Dallas	\N			5619	5619 Worth St, Dallas, TX 75214, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000005D78149D9B3058C04A7F2F8507674040	f	f	f	\N	\N
		2408	Victory Park	Dallas	Texas	TX	75219		9bc473ca-bcc7-11e5-914b-f23c91c841bd	Lane	734	United States	USA	2016-01-17 04:08:40.252271+01	2016-01-17 18:36:16.670748+01	0101000020E6100000283B472EC93358C05721E527D5644040	2442473	t	Google	\N	Dallas	\N			2408	2408 Victory Park Ln, Dallas, TX 75219, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000283B472EC93358C05721E527D5644040	f	f	f	\N	\N
		3024	Tennessee	Dallas	Texas	TX	75224		0a2afef4-b49b-11e5-a450-f23c91c841bd	Avenue		United States	USA	2016-01-06 18:29:28.818488+01	2016-01-27 20:35:41.684429+01	0101000020E61000003A55BE67243658C0ED9DD156255B4040	58900413	t	Google	\N	Dallas	\N			3024	3024 Tennessee Ave, Dallas, TX 75224, USA	t	t	0101000020E610000000000060243658C000000040255B4040	3024 Tennessee Ave, Dallas, TX 75224	ROOFTOP	High	0101000020E61000003A55BE67243658C0ED9DD156255B4040	f	f	f	f	\N
		4712	Baldwin	Dallas	Texas	TX	75210		674b3270-0f23-11e5-a2e0-0a95648eeb58	Street		United States	USA	2015-06-10 05:47:23.591936+02	2015-10-02 15:16:33.965178+02	0101000020E6100000C360FE0A992F58C074CEF4B7A9634040	47867079	\N	None	\N	Dallas	\N			4712	4712 Baldwin Street, Dallas, TX 75210, USA	t	f	\N	\N	\N	\N	\N	\N	\N	f	\N	\N
		2430	Victory Park	Dallas	Texas	TX	75219		665270d0-c293-11e5-8bcd-f23c91c841bd	Lane	1908	United States	USA	2016-01-24 13:10:03.732561+01	2016-01-27 19:33:10.576525+01	0101000020E6100000FDFD1829CA3358C033C74D68ED644040	1354359	t	Google	\N	Dallas	\N			2430	2430 Victory Park Ln, Dallas, TX 75219, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000FDFD1829CA3358C033C74D68ED644040	f	f	f	\N	\N
		7118	Meadow	Dallas	Texas	TX	75230		4ac35a68-bc95-11e5-92d4-f23c91c841bd	Road		United States	USA	2016-01-16 22:08:29.513145+01	2016-01-16 23:09:33.126138+01	0101000020E6100000242713B70A3258C04301DBC188714040	1101151	t	Google	\N	Dallas	\N			7118	7118 Meadow Rd, Dallas, TX 75230, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000242713B70A3258C04301DBC188714040	f	f	f	\N	\N
		4242	Lomo Alto	Highland Park	Texas	TX	75219		8ad20322-9ecf-11e5-8199-f23c91c841bd		N76	United States	USA	2015-12-10 00:49:52.910279+01	2016-01-04 15:53:38.085379+01	0101000020E6100000B4BCBC4A083458C0CCEEC9C342694040	58545058	t	Google	t	Dallas	\N			4242	4242 Lomo Alto Dr, Dallas, TX 75219, USA	t	t	0101000020E610000000003055103458C00000803C42694040	4242 Lomo Alto Dr, Highland Park, TX 75219	ROOFTOP	Medium	0101000020E6100000B4BCBC4A083458C0CCEEC9C342694040	f	f	f	f	\N
		4432	Bowser	Dallas	Texas	TX	75219		fc4ff4fc-be12-11e5-a1cd-f23c91c841bd	Avenue	D	United States	USA	2016-01-18 19:40:45.644871+01	2016-01-19 08:04:00.152838+01	0101000020E6100000A2A47675FD3358C062A1D634EF684040	59097482	t	Google	\N	Dallas	\N			4432	4432 Bowser Ave, Dallas, TX 75219, USA	t	t	0101000020E610000000000080FD3358C000000040EF684040	4432 Bowser Ave, Dallas, TX 75219	ROOFTOP	High	0101000020E6100000A2A47675FD3358C062A1D634EF684040	f	f	f	f	\N
		5720	VICKERY	Dallas	Texas	TX	75206		6b09f186-c2d2-11e5-84f5-f23c91c841bd	Boulevard		United States	USA	2016-01-24 20:41:09.940077+01	2016-01-26 13:34:13.023074+01	0101000020E61000004D486B0C3A3158C0603B18B14F694040	1396847	t	Google	\N	Dallas	\N			5720	5720 Vickery Blvd, Dallas, TX 75206, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000004D486B0C3A3158C0603B18B14F694040	f	f	f	\N	\N
		2026	Chevella	Dallas	Texas	TX	75232		2d7fc43c-c31b-11e5-913c-f23c91c841bd	Drive		United States	USA	2016-01-25 05:21:59.95476+01	2016-01-25 05:24:25.073382+01	0101000020E61000006BF294D5743658C09D67EC4B36544040	2119751	t	Google	\N	Dallas	\N			2026	2026 Chevella Dr, Dallas, TX 75232, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000006BF294D5743658C09D67EC4B36544040	f	f	f	\N	\N
		2430	Victory Park	Dallas	Texas	TX	75219		7a65575c-a814-11e5-8e1e-f23c91c841bd	Lane	2301	United States	USA	2015-12-21 19:56:01.093733+01	2016-01-22 17:02:43.084921+01	0101000020E6100000FDFD1829CA3358C033C74D68ED644040	58705917	t	Google	\N	Dallas	\N			2430	2430 Victory Park Ln, Dallas, TX 75219, USA	t	t	0101000020E61000000000C0ADCD3358C00000E0DBEC644040	2430 Victory Park Ln, Dallas, TX 75219	ROOFTOP	High	0101000020E6100000FDFD1829CA3358C033C74D68ED644040	f	f	f	f	\N
		2354	Peavy	Dallas	Texas	TX	75228		56ea26d4-c175-11e5-8a87-f23c91c841bd	Place		United States	USA	2016-01-23 03:02:21.818669+01	2016-01-23 03:47:55.433165+01	0101000020E6100000513BB2A8BE2B58C00795B88E71694040	2412482	t	Google	\N	Dallas	\N			2354	2354 Peavy Pl, Dallas, TX 75228, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000513BB2A8BE2B58C00795B88E71694040	f	f	f	\N	\N
		2430	Victory Park	Dallas	Texas	TX	75219		5252dfd2-9f54-11e5-a0f8-f23c91c841bd	Lane	1908	United States	USA	2015-12-10 16:40:21.189599+01	2015-12-13 22:56:33.237778+01	0101000020E6100000FDFD1829CA3358C033C74D68ED644040	58554075	t	Google	\N	Dallas	\N			2430	2430 Victory Park Ln, Dallas, TX 75219, USA	t	t	0101000020E61000000000C0ADCD3358C00000E0DBEC644040	2430 Victory Park Ln, Dallas, TX 75219	ROOFTOP	High	0101000020E6100000FDFD1829CA3358C033C74D68ED644040	f	f	f	f	\N
		4123	Wycliff	Dallas	Texas	TX	75219		46ace298-af4b-11e5-a878-f23c91c841bd	Avenue		United States	USA	2015-12-31 00:15:54.78096+01	2016-02-10 06:05:14.076355+01	0101000020E6100000ADCBDF73963358C0A67D737FF5684040	58804924	t	Google	\N	Dallas	\N			4123	4123 Wycliff Ave, Dallas, TX 75219, USA	t	t	0101000020E6100000000000A0963358C000000080F5684040	4123 Wycliff Ave, Dallas, TX 75219	ROOFTOP	High	0101000020E6100000ADCBDF73963358C0A67D737FF5684040	f	f	f	f	\N
		4135	Buena Vista	Dallas	Texas	TX	75204		271a5b9e-c171-11e5-a880-f23c91c841bd	Street		United States	USA	2016-01-23 02:32:23.616942+01	2016-01-29 18:23:43.085373+01	0101000020E6100000F3C98AE1EA3258C0B5C2F4BD86684040	2339947	t	Google	\N	Dallas	\N			4135	4135 Buena Vista St, Dallas, TX 75204, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000F3C98AE1EA3258C0B5C2F4BD86684040	f	f	f	\N	\N
		7832	Royal	Dallas	Texas	TX	75230		923f9f5a-c23a-11e5-92d3-f23c91c841bd	Lane	102a	United States	USA	2016-01-24 02:34:12.220103+01	2016-01-28 14:27:13.037113+01	0101000020E610000023D51CC55E3158C041704B9AF5724040	2228463	t	Google	\N	Dallas	\N			7832	7832 Royal Ln, Dallas, TX 75230, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E610000023D51CC55E3158C041704B9AF5724040	f	f	f	\N	\N
		5447	Ridgedale	Dallas	Texas	TX	75206		3b1ca3a4-c171-11e5-a880-f23c91c841bd	Avenue		United States	USA	2016-01-23 02:32:57.186215+01	2016-01-29 17:56:28.020873+01	0101000020E61000002C47C8409E3158C093E2E313B2694040	2343937	t	Google	\N	Dallas	\N			5447	5447 Ridgedale Ave, Dallas, TX 75206, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000002C47C8409E3158C093E2E313B2694040	f	f	f	\N	\N
		2430	Victory Park	Dallas	Texas	TX	75219		32d3b42a-d0db-11e5-b351-f23c91c841bd	Lane	2003	United States	USA	2016-02-11 17:19:17.381029+01	2016-02-15 06:51:57.265398+01	0101000020E6100000FDFD1829CA3358C033C74D68ED644040	59616961	t	Google	\N	Dallas	\N			2430	2430 Victory Park Ln, Dallas, TX 75219, USA	t	t	0101000020E61000000000C0ADCD3358C00000E0DBEC644040	2430 Victory Park Ln, Dallas, TX 75219	ROOFTOP	High	0101000020E6100000FDFD1829CA3358C033C74D68ED644040	f	f	f	f	\N
		9109	BRYSON	Dallas	Texas	TX	75238		2b2d6954-c2c7-11e5-a9d7-f23c91c841bd	Drive		United States	USA	2016-01-24 19:20:38.334323+01	2016-01-27 14:18:36.999357+01	0101000020E610000006BB61DBA22C58C037AAD381AC6F4040	1119877	t	Google	\N	Dallas	\N			9109	9109 Bryson Dr, Dallas, TX 75238, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E610000006BB61DBA22C58C037AAD381AC6F4040	f	f	f	\N	\N
		5337	Lawnview	Dallas	Texas	TX	75227		20e8bdec-c22f-11e5-bacf-f23c91c841bd	Avenue		United States	USA	2016-01-24 01:12:17.604088+01	2016-01-28 16:33:23.898025+01	0101000020E61000008098840B792E58C06D8FDE701F654040	1164904	t	Google	\N	Dallas	\N			5337	5337 Lawnview Ave, Dallas, TX 75227, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000008098840B792E58C06D8FDE701F654040	f	f	f	\N	\N
		2028	Vatican	Dallas	Texas	TX	75224		1e464ac0-bb43-11e5-bcc2-f23c91c841bd	Lane		United States	USA	2016-01-15 05:47:44.979229+01	2016-01-30 15:25:26.197535+01	0101000020E61000005890662C9A3658C0DAC534D3BD584040	44370476	t	Google	\N	Dallas	\N			2028	2028 Vatican Ln, Dallas, TX 75224, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000005890662C9A3658C0DAC534D3BD584040	f	f	f	\N	\N
		6016	BARRINGTON CT	Dallas	Texas	TX	75252		2a07f510-bcb6-11e5-84b0-f23c91c841bd	Court		United States	USA	2016-01-17 02:03:47.989878+01	2016-01-17 02:08:46.487412+01	0101000020E610000047E350BF0B3358C02DDAD2591C804040	1090971	t	Google	t	Collin	\N			6016	Dallas, TX 75252, USA	t	\N	\N	\N	APPROXIMATE	\N	0101000020E610000047E350BF0B3358C02DDAD2591C804040	t	f	f	\N	\N
		4438	SANTA BARBARA	Dallas	Texas	TX	75214		cf275f34-c1f4-11e5-9606-f23c91c841bd			United States	USA	2016-01-23 18:14:49.631083+01	2016-01-29 10:38:30.451235+01	0101000020E6100000828C800A472F58C0AC19BE2ABC6B4040	1441103	t	Google	t	Dallas	\N			4438	4438 Santa Barbara Dr, Dallas, TX 75214, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000828C800A472F58C0AC19BE2ABC6B4040	f	f	f	\N	\N
		19603	Bent Brook	Dallas	Texas	TX	75252		297ab5a6-c1f7-11e5-8b8e-f23c91c841bd	Court		United States	USA	2016-01-23 18:31:40.165604+01	2016-01-29 06:53:19.131771+01	0101000020E6100000ACFD9DEDD13358C09CFBABC77D814040	1753662	t	Google	\N	Collin	\N			19603	19603 Bent Brook Ct, Dallas, TX 75252, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E6100000ACFD9DEDD13358C09CFBABC77D814040	f	f	f	\N	\N
		1717	ANNEX	Dallas	Texas	TX	75204		60b86750-ba74-11e5-8082-f23c91c841bd	Avenue	301	United States	USA	2016-01-14 05:07:50.633516+01	2016-01-31 04:56:05.443644+01	0101000020E6100000FA5BA736DD3158C02AFD29FAE8664040	51177813	t	Google	\N	Dallas	\N			1717	1717 Annex Ave, Dallas, TX 75204, USA	t	\N	\N	\N	RANGE_INTERPOLATED	\N	0101000020E6100000FA5BA736DD3158C02AFD29FAE8664040	f	f	f	\N	\N
		4103	Avondale	Dallas	Texas	TX	75219		93e27ad0-c1e0-11e5-bc01-f23c91c841bd	Avenue	4	United States	USA	2016-01-23 15:50:00.259377+01	2016-01-23 15:54:49.988624+01	0101000020E610000064B4E963993358C019D9DF23AC684040	2388816	t	Google	\N	Dallas	\N			4103	4103 Avondale Ave, Dallas, TX 75219, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E610000064B4E963993358C019D9DF23AC684040	f	f	f	\N	\N
		6606	R L Thornton	Dallas	Texas	TX	75232		e458a71a-c2ca-11e5-9f0d-f23c91c841bd			United States	USA	2016-01-24 19:47:17.486282+01	2016-01-27 08:20:40.192282+01	0101000020E61000006A2FA2ED983458C0738577B988554040	1157723	t	Google	t	Dallas	\N	S		6606	6606 S R. L. Thornton Fwy, Dallas, TX 75232, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000006A2FA2ED983458C0738577B988554040	f	f	f	\N	\N
		6215	Glennox	Dallas	Texas	TX	75214		6e8fb45a-c1f9-11e5-9b8c-f23c91c841bd	Lane		United States	USA	2016-01-23 18:47:55.059427+01	2016-01-29 03:07:49.365118+01	0101000020E61000001F300F99723058C03225EDA1D86C4040	2015306	t	Google	\N	Dallas	\N			6215	6215 Glennox Ln, Dallas, TX 75214, USA	t	\N	\N	\N	ROOFTOP	\N	0101000020E61000001F300F99723058C03225EDA1D86C4040	f	f	f	\N	\N
\.


--
-- Data for Name: agents; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY agents (id, email, mlsid, fax, full_name, first_name, last_name, middle_name, phone_number, nar_number, office_mui, status, office_mlsid, work_phone, generational_name, matrix_unique_id, matrix_modified_dt, updated_at, deleted_at, created_at) FROM stdin;
\.


--
-- Data for Name: agents_images; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY agents_images (id, mui, url, image_type, date) FROM stdin;
\.


--
-- Data for Name: alerts; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY alerts (id, minimum_price, maximum_price, minimum_square_meters, maximum_square_meters, created_by, created_at, updated_at, room, minimum_bedrooms, minimum_bathrooms, property_subtypes, points, minimum_year_built, pool, title, minimum_lot_square_meters, maximum_lot_square_meters, maximum_year_built, deleted_at, listing_statuses, open_house, minimum_sold_date, property_types, list_agents, list_offices, counties, minimum_parking_spaces, architectural_styles, subdivisions, school_districts, primary_schools, elementary_schools, senior_high_schools, junior_high_schools, intermediate_schools, sort_order, sort_office, selling_offices, selling_agents, mls_areas, middle_schools, offices, agents, high_schools, excluded_listing_ids, postal_codes) FROM stdin;
\.


--
-- Data for Name: attachments; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY attachments (id, "user", url, metadata, created_at, updated_at, deleted_at, info, private, attributes) FROM stdin;
\.


--
-- Data for Name: attachments_eav; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY attachments_eav (id, object, attachment) FROM stdin;
\.


--
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY brands (id, created_at, updated_at, palette, assets, messages) FROM stdin;
\.


--
-- Data for Name: brands_agents; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY brands_agents (id, brand, agent) FROM stdin;
\.


--
-- Data for Name: brands_hostnames; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY brands_hostnames (id, brand, hostname, "default") FROM stdin;
\.


--
-- Data for Name: brands_offices; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY brands_offices (id, brand, office) FROM stdin;
\.


--
-- Data for Name: brands_parents; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY brands_parents (id, brand, parent) FROM stdin;
\.


--
-- Data for Name: brands_users; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY brands_users (id, brand, "user", role) FROM stdin;
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY clients (id, version, response, secret, name) FROM stdin;
bf0da47e-7226-11e4-905b-0024d71b10fc	1.0.0	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeRequired"}	secret	iOS App - 1.0.0
bf0da47e-7226-11e4-905b-0024d71b10fc	1.0.1	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeRequired"}	secret	iOS App - 1.0.1
bf0da47e-7226-11e4-905b-0024d71b10fc	1.0.2	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeRequired"}	secret	iOS App - 1.0.2
bf0da47e-7226-11e4-905b-0024d71b10fc	1.0.3	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeRequired"}	secret	iOS App - 1.0.3
bf0da47e-7226-11e4-905b-0024d71b10fc	1.0.4	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeRequired"}	secret	iOS App - 1.0.4
bf0da47e-7226-11e4-905b-0024d71b10fc	1.0.5	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeRequired"}	secret	iOS App - 1.0.5
bf0da47e-7226-11e4-905b-0024d71b10fc	1.0.6	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeRequired"}	secret	iOS App - 1.0.6
bf0da47e-7226-11e4-905b-0024d71b10fc	1.0.7	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeUnavailable"}	secret	iOS App - 1.0.7
36e583c6-7812-11e5-9e16-f23c91c841bd	1.0.8	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeRequired"}	secret	iOS App - 1.0.8
36e583c6-7812-11e5-9e16-f23c91c841bd	2.0.0	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeRequired"}	secret	iOS App - 2.0.0
36e583c6-7812-11e5-9e16-f23c91c841bd	2.0.1	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeRequired"}	secret	iOS App - 2.0.1
36e583c6-7812-11e5-9e16-f23c91c841bd	2.0.2	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeRequired"}	secret	iOS App - 2.0.2
36e583c6-7812-11e5-9e16-f23c91c841bd	2.0.3	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeRequired"}	secret	iOS App - 2.0.3
36e583c6-7812-11e5-9e16-f23c91c841bd	2.0.4	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeRequired"}	secret	iOS App - 2.0.4
36e583c6-7812-11e5-9e16-f23c91c841bd	2.1.0	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeRequired"}	secret	iOS App - 2.1.0
60e11c82-d689-11e5-94f8-f23c91c841bd	2.2.1	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeUnavailable"}	secret	iOS App - 2.2.1
36e583c6-7812-11e5-9e16-f23c91c841bd	2.2.0	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeRequired"}	secret	iOS App - 2.2.0
44b8de5e-13bb-11e6-89ca-0242ac110007	2.5.0	{"type": "session", "api_base_url": "http://boer.d.rechat.com", "client_version_status": "UpgradeUnavailable"}	secret	\N
2a1dc090-7465-11e6-8365-0242ac110006	2.8.0	{"type": "session", "api_base_url": "https://api.rechat.co:443", "client_version_status": "UpgradeInProgress"}	secret	iOS App - 2.8.0
\.


--
-- Data for Name: cmas; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY cmas (id, "user", room, suggested_price, comment, listings, created_at, updated_at, deleted_at, lowest_price, average_price, highest_price, lowest_dom, average_dom, highest_dom, main_listing) FROM stdin;
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY contacts (id, "user", created_at, updated_at, deleted_at, refs, merged, ios_address_book_id, android_address_book_id) FROM stdin;
\.


--
-- Data for Name: contacts_attributes; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY contacts_attributes (id, contact, attribute_type, attribute, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: contacts_emails; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY contacts_emails (id, contact, email, data, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: contacts_phone_numbers; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY contacts_phone_numbers (id, contact, phone_number, data, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: deals; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY deals (id, created_at, updated_at, deleted_at, listing, created_by, brand, context) FROM stdin;
\.


--
-- Data for Name: deals_roles; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY deals_roles (id, created_at, updated_at, deleted_at, created_by, role, deal, "user") FROM stdin;
\.


--
-- Data for Name: docusign_users; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY docusign_users (id, "user", access_token, refresh_token, base_url, account_id) FROM stdin;
\.


--
-- Data for Name: email_verifications; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY email_verifications (id, code, created_at, email) FROM stdin;
\.


--
-- Data for Name: envelopes; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY envelopes (id, created_at, updated_at, created_by, deal, docusign_id, status, title, webhook_token) FROM stdin;
\.


--
-- Data for Name: envelopes_documents; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY envelopes_documents (id, envelope, title, document_id, submission_revision) FROM stdin;
\.


--
-- Data for Name: envelopes_recipients; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY envelopes_recipients (id, created_at, updated_at, signed_at, envelope, role, "user", status) FROM stdin;
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY files (id, created_at, updated_at, deleted_at, created_by, path, name) FROM stdin;
\.


--
-- Data for Name: files_relations; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY files_relations (id, created_at, updated_at, deleted_at, file, role, role_id) FROM stdin;
\.


--
-- Data for Name: foo; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY foo (value) FROM stdin;
{"a": 1, "b": 1, "c": "12373.3674"}
\.


--
-- Data for Name: forms; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY forms (id, created_at, updated_at, deleted_at, formstack_id, fields, name) FROM stdin;
\.


--
-- Data for Name: forms_data; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY forms_data (id, created_at, updated_at, deleted_at, submission, form, author, "values", formstack_response, state) FROM stdin;
\.


--
-- Data for Name: forms_submissions; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY forms_submissions (id, created_at, updated_at, deleted_at, form, formstack_id, deal) FROM stdin;
\.


--
-- Data for Name: godaddy_domains; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY godaddy_domains (id, name, created_at, updated_at, owner, order_id, hosted_zone) FROM stdin;
\.


--
-- Data for Name: godaddy_shoppers; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY godaddy_shoppers (id, created_at, updated_at, "user", shopper_id, email, password) FROM stdin;
\.


--
-- Data for Name: invitation_records; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY invitation_records (id, invited_user, email, room, created_at, updated_at, accepted, inviting_user, deleted_at, phone_number, url, invitee_first_name, invitee_last_name) FROM stdin;
\.


--
-- Data for Name: listings; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY listings (id, property_id, alerting_agent_id, listing_agent_id, listing_agency_id, created_at, updated_at, cover_image_url, currency, price, gallery_image_urls, matrix_unique_id, original_price, last_price, low_price, status, association_fee, mls_number, association_fee_frequency, association_fee_includes, association_type, unexempt_taxes, financing_proposed, list_office_mui, list_office_mls_id, list_office_name, list_office_phone, possession, co_list_office_mui, co_list_office_mls_id, co_list_office_name, co_list_office_phone, selling_office_mui, selling_office_mls_id, selling_office_name, selling_office_phone, co_selling_office_mui, co_selling_office_mls_id, co_selling_office_name, co_selling_office_phone, list_agent_mui, list_agent_direct_work_phone, list_agent_email, list_agent_full_name, list_agent_mls_id, co_list_agent_mui, co_list_agent_direct_work_phone, co_list_agent_email, co_list_agent_full_name, co_list_agent_mls_id, selling_agent_mui, selling_agent_direct_work_phone, selling_agent_email, selling_agent_full_name, selling_agent_mls_id, co_selling_agent_mui, co_selling_agent_direct_work_phone, co_selling_agent_email, co_selling_agent_full_name, co_selling_agent_mls_id, listing_agreement, capitalization_rate, compensation_paid, date_available, last_status, mls_area_major, mls_area_minor, mls, move_in_date, permit_address_internet_yn, permit_comments_reviews_yn, permit_internet_yn, price_change_timestamp, matrix_modified_dt, property_association_fees, showing_instructions_type, special_notes, tax_legal_description, total_annual_expenses_include, transaction_type, virtual_tour_url_branded, virtual_tour_url_unbranded, active_option_contract_date, keybox_type, keybox_number, close_date, close_price, back_on_market_date, deposit_amount, photo_count, deleted_at, dom, cdom, buyers_agency_commission, sub_agency_commission, list_date, showing_instructions, appointment_phone, appointment_phone_ext, appointment_call, owner_name, seller_type, occupancy, private_remarks, photos_checked_at) FROM stdin;
f382544c-c1f4-11e5-9606-f23c91c841bd	f33a27ee-c1f4-11e5-9606-f23c91c841bd	\N	\N	\N	2016-01-23 18:15:50.624909+01	2016-01-23 18:15:50.624909+01	\N	USD	1299000	\N	1528396	1495000	1485000	\N	Sold	\N	10018693			None	22349	Cash,Conventional	15506092	GRFF01	David Griffin & Company	(214) 526-5626	Negotiable	-1				15503553	COOK01	Virginia Cook, REALTORS	(214) 696-8877	-1				15526928	(214) 520-8350	dnichols@mathews-nichols.com	David Nichols	0412178	-1					15517216	(214) 770-0695	vawim@swbell.net	Victoria Wiman	0182321	-1					Exclusive Right to Sell/Lease				Pending	DALLAS NORTH (11)	NORTH DALLAS (12)	North Texas Real Estate Information Systems		t	t	t	2004-05-17 23:20:00+02	2012-10-05 15:25:31+02		Agent Or Owner Present		INWOOD PARK ESTATES		For Sale					0	2004-07-13 02:00:00+02	1275000		0	\N	\N	\N	\N	3%	0%	2003-12-15 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
040876b6-c1f5-11e5-9606-f23c91c841bd	03b3b586-c1f5-11e5-9606-f23c91c841bd	\N	\N	\N	2016-01-23 18:16:18.347319+01	2016-01-23 18:16:18.347319+01	\N	USD	975000	\N	1569942	975000	\N	\N	Sold	\N	10111723			None	\N	Conventional	15504628	EBBY09	Ebby Halliday, REALTORS	(214) 528-1441	Negotiable	-1				15504628	EBBY09	Ebby Halliday, REALTORS	(214) 528-1441	-1				15517105	(214) 906-4788	dodobell@aol.com	Dorothy Bell	0177645	-1					15521862	(214) 217-3511	ralph@daveperrymiller.com	Ralph Randall	0322774	-1					Exclusive Right to Sell/Lease				Pending	DALLAS NORTH (11)	NORTH DALLAS (10)	North Texas Real Estate Information Systems		t	t	t	\N	2012-10-05 15:25:27+02		Appointment (Appt Svc only),Call-Key Box				For Sale					4959718	2004-08-05 02:00:00+02	975000		0	\N	\N	\N	\N	3%	0%	2004-05-27 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
2bb89d4e-c2c7-11e5-a9d7-f23c91c841bd	2b716938-c2c7-11e5-a9d7-f23c91c841bd	\N	\N	\N	2016-01-24 19:20:39.245939+01	2016-01-24 19:20:39.245939+01	\N	USD	1450	\N	1119877	1850	1850	\N	Leased	\N	10126129			None	\N		15502007	BHGW01	Better Homes & Gardens, Winans	(972) 774-9888		-1				15502007	BHGW01	Better Homes & Gardens, Winans	(972) 774-9888	-1				15517131	(214) 707-4230	earl@texasloancenter.com	Earl Lynn	0178903	-1					15517131	(214) 707-4230	earl@texasloancenter.com	Earl Lynn	0178903	-1					Exclusive Right to Sell/Lease				Active	DALLAS NORTHEAST (18)	NORTHEAST DALLAS (5)	North Texas Real Estate Information Systems	2004-10-01T00:00:00.000	t	t	t	2004-09-05 15:41:00+02	2011-03-08 16:33:58+01				THE HIGHLANDS							11	2004-10-01 02:00:00+02	2450		2000	\N	\N	\N	\N	.4	.4	2004-06-22 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
0f36f8c8-c1f5-11e5-9606-f23c91c841bd	0ef2bad2-c1f5-11e5-9606-f23c91c841bd	\N	\N	\N	2016-01-23 18:16:37.107275+01	2016-01-23 18:16:37.107275+01	\N	USD	1389000	\N	1600249	1449000	1449000	\N	Sold	390	10183366	Monthly	Front Yard Maintenance,Full Use of Facilities,Management Fees,Security	Mandatory	43609	Cash,Conventional	15507965	KWPC01	Keller Williams - Park Cities	(214) 526-4663	Negotiable	-1				15502864	CBRB57	Coldwell Banker Residential	(972) 931-2400	-1				15517415	(214) 686-7351	maryjaneyoung1@gmail.com	Mary Jane Young	0190405	-1					15517024	(214) 315-9386	kaye.geiser@cbdfw.com	Kaye Geiser	0174369	-1					Exclusive Right to Sell/Lease				Pending	DALLAS NORTH (11)	NORTH DALLAS (15)	North Texas Real Estate Information Systems		t	t	t	2005-01-11 21:13:00+01	2012-10-05 15:24:51+02		Agent Or Owner Present,Appointment (Appt Svc only)		GLEN LAKES  SIXTH SECTION		For Sale					4972135	2005-03-08 01:00:00+01	1334000		0	\N	\N	\N	\N	3	0	2004-09-27 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
1a5b7270-c31b-11e5-913c-f23c91c841bd	19c42550-c31b-11e5-913c-f23c91c841bd	\N	\N	\N	2016-01-25 05:21:27.839528+01	2016-01-25 05:21:27.839528+01	\N	USD	84500	\N	1640052	89000	89000	\N	Sold	\N	10271929		None	None	2730	Conventional	15511645	RMNO01	RE/MAX Premier	(972) 991-1616	Closing/Funding	-1				15510822	PRUD11	Prudential Texas Properties	(214) 696-1200	-1				15527482	(214) 929-7356	TJ@TJMcCormack.com	Tj Mccormack	0419194	-1					15540161	(972) 733-4475	cody@codyfarris.com	Cody Farris	0484136	-1					Exclusive Right to Sell/Lease				Pending	DALLAS SOUTHEAST (13)	SOUTHEAST DALLAS (4)	North Texas Real Estate Information Systems		t	t	t	2005-07-11 20:15:00+02	2010-08-09 15:08:43+02		Go (Appt Svc Only)		LAKE EAST ESTS BLK 3/6324 LT 1		For Sale					0	2005-10-03 02:00:00+02	86500		0	\N	\N	\N	\N	2.5%	0%	2005-03-11 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
f412e082-c269-11e5-ba2b-f23c91c841bd	f3c44814-c269-11e5-ba2b-f23c91c841bd	\N	\N	\N	2016-01-24 08:13:22.688753+01	2016-01-24 08:13:22.688753+01	\N	USD	57500	\N	1657963	57500	\N	\N	Sold	179	10309158	Monthly	Electric,Exterior Maintenance,Front Yard Maintenance,Full Use of Facilities,Reserves,Sprinkler System,Trash,Water/Sewer	Mandatory	\N	Cash,Conventional,FHA	15504656	EBBY34	Ebby Halliday, REALTORS	(214) 826-0316	Closing/Funding	-1				15504627	EBBY08	Ebby Halliday, REALTORS	(972) 783-0000	-1				15515493	(214) 824-3784	dickclements@ebby.com	Dick Clements	0078757	-1					15554521	(214) 538-6835	keith@ebby.com	Keith Redelsperger	0533081	-1					Exclusive Right to Sell/Lease				Pending	DALLAS NORTHEAST (18)	NORTHEAST DALLAS (12)	North Texas Real Estate Information Systems		t	t	t	\N	2011-12-12 22:03:35+01		Call-Key Box,Courtesy Call (Appt Svc Only)				For Sale					7706131	2005-07-15 02:00:00+02	54000		0	\N	\N	\N	\N	3%	0%	2005-05-10 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
6ba21114-c2d2-11e5-84f5-f23c91c841bd	6b53219e-c2d2-11e5-84f5-f23c91c841bd	\N	\N	\N	2016-01-24 20:41:10.936763+01	2016-01-24 20:41:10.936763+01	\N	USD	345000	\N	1396847	345000	\N	\N	Sold	\N	10376117			None	6745	Conventional	15503601	COST01	Costello & Associates	(214) 887-9848	Closing/Funding	-1				15503518	COMM01	Community Realty Group	(214) 906-4919	-1				15549207	(214) 476-8125	warren@costellorealtors.com	Warren Christie	0514172	-1					15531850	(214) 683-4648	Realtor.community@gmail.com	Moses Harry	0452110	-1					Exclusive Right to Sell/Lease	0.00			Pending	DALLAS EAST (12)	EAST DALLAS (6)	North Texas Real Estate Information Systems		t	t	t	\N	2011-03-08 16:33:58+01		Agent Or Owner Present		DELMAR HEIGHTS BLK 9/1919 LOT							2532532	2005-12-01 01:00:00+01	328000		0	\N	\N	\N	\N	3%	0%	2005-08-19 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
0a95434a-c2c9-11e5-96da-f23c91c841bd	0a39ec70-c2c9-11e5-96da-f23c91c841bd	\N	\N	\N	2016-01-24 19:34:02.64233+01	2016-01-24 19:34:02.64233+01	\N	USD	2350	\N	1137861	2500	2500	\N	Leased	\N	10439524			None	\N		15502710	CARZ01	Carolyn Shamis, REALTORS	(214) 369-1123		-1				15514652	WORT01	Local Dwelling	(214) 522-9100	-1				15516367	(214) 369-1123	angie@carolynshamis.com	Carolyn Shamis	0147862	-1					15523043	(214) 929-2040	worth@worthross.com	Worth Ross	0346944	-1					Exclusive Right to Sell/Lease		On execution		Active	DALLAS OAK LAWN (17)	OAKLAWN (11)	North Texas Real Estate Information Systems	2006-12-12T00:00:00.000	t	t	t	2006-05-25 17:51:00+02	2011-03-08 16:33:58+01		Appointment Service										2006-12-06 01:00:00+01	1950		2350	\N	\N	\N	\N	50%	0%	2005-12-07 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
2a95cee4-c1f7-11e5-8b8e-f23c91c841bd	2a158482-c1f7-11e5-8b8e-f23c91c841bd	\N	\N	\N	2016-01-23 18:31:42.020769+01	2016-01-23 18:31:42.020769+01	\N	USD	495000	\N	1753662	495000	\N	\N	Sold	\N	10523426			Voluntary	\N	Cash,Conventional	15515154	KELL01	Keller Williams Realty	(972) 732-6000	Closing/Funding,Negotiable	-1				15509853	NMLS00NM	NON MLS	(999) 999-9999	-1				15533233	(972) 333-8855	sophiatolk@aol.com	Sophia Tolk	0458685	-1					15583813			Non-Mls Member	99999999	-1					Exclusive Right to Sell/Lease				Pending	ADDISON/FAR NORTH DALLAS AREA (10)	ADDISON (2)	North Texas Real Estate Information Systems		t	t	t	\N	2012-10-05 15:25:35+02		Appointment Service,Courtesy Call (Appt Svc Only)				For Sale		www.vrguild.net/c/stnd.pl?U=0605081931375454			0	2006-10-10 02:00:00+02	495000		0	\N	\N	\N	\N	3%	0%	2006-04-28 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
0fc1991e-c2cd-11e5-aa15-f23c91c841bd	0f6e002e-c2cd-11e5-aa15-f23c91c841bd	\N	\N	\N	2016-01-24 20:02:49.309319+01	2016-01-24 20:02:49.309319+01	\N	USD	1495	\N	1311841	1495	\N	\N	Leased	\N	10662184			None	\N		15508092	LAUA01	Laura Beazley Realtors	(214) 821-1080		-1				15508092	LAUA01	Laura Beazley Realtors	(214) 821-1080	-1				15536392	(214) 797-0158	chaddock@hotmail.com	Christine Haddock	0470556	-1					15536392	(214) 797-0158	chaddock@hotmail.com	Christine Haddock	0470556	-1					Exclusive Right to Sell/Lease				Active	DALLAS EAST (12)	EAST DALLAS (12)	North Texas Real Estate Information Systems	2006-12-08T00:00:00.000	t	t	t	\N	2011-03-08 16:35:06+01		Courtesy Call (Appt Svc Only)		JUNIUS HEIGHTS BLK 2/1590 LOT		For Sale/Lease						2006-12-08 01:00:00+01	1495		1495	\N	\N	\N	\N	$400	0%	2006-11-16 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
5674c6d2-c1f7-11e5-8b8e-f23c91c841bd	561a689a-c1f7-11e5-8b8e-f23c91c841bd	\N	\N	\N	2016-01-23 18:32:55.624024+01	2016-01-23 18:32:55.624024+01	\N	USD	529900	\N	1863063	529900	\N	\N	Sold	\N	10783132			Voluntary	14080		15505528	GALE01	Arthur P. Gale, REALTORS	(214) 363-4409	Closing/Funding	-1				15505528	GALE01	Arthur P. Gale, REALTORS	(214) 363-4409	-1				15523895	(214) 957-5383	joegall@ebby.com	Joe Gall	0361869	-1					15516626	(214) 908-9511	apgrealtors@sbcglobal.net	Arthur Gale	0157968	-1					Exclusive Right to Sell/Lease				Pending	DALLAS NORTH (11)	NORTH DALLAS (15)	North Texas Real Estate Information Systems		t	t	t	\N	2012-10-05 15:25:12+02		Appointment Service		WINDSOR PARK BLK K/5454 LOT 13		For Sale					51922993	2007-09-17 02:00:00+02	529900		0	\N	\N	\N	\N	3%	0%	2007-05-23 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
a55ee1e2-c2ce-11e5-beb0-f23c91c841bd	a507cefc-c2ce-11e5-beb0-f23c91c841bd	\N	\N	\N	2016-01-24 20:14:09.817408+01	2016-01-24 20:14:09.817408+01	\N	USD	1095	\N	1320842	1095	\N	\N	Leased	\N	10790490			None	\N		15512362	SIGN01	Signature Leasing & Management	(214) 750-5675		-1				15507945	KWDC01	Dallas City Center Realtors	(214) 515-9888	-1				15524407	(214) 507-2993	kyle@signatureleasing.net	Kyle Flesher	0370990	-1					15540685	(214) 697-2896	scott@dallaseliteleasing.com	Scott Wilkinson	0485852	-1					Exclusive Right to Sell/Lease		Move-in 5	2007-06-01T00:00:00.000	Active	DALLAS EAST (12)	EAST DALLAS (3)	North Texas Real Estate Information Systems	2007-06-28T00:00:00.000	t	t	t	\N	2011-03-08 16:35:06+01		Combo Lock Box		LOUANN #3 BLK A/5430 LT 16A 54		For Lease						2007-06-24 02:00:00+02	1095		1095	\N	\N	\N	\N	50%	50%	2007-06-01 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
75d514c4-c2d2-11e5-84f5-f23c91c841bd	75829fc8-c2d2-11e5-84f5-f23c91c841bd	\N	\N	\N	2016-01-24 20:41:28.048212+01	2016-01-24 20:41:28.048212+01	\N	USD	264000	\N	1399174	264000	\N	\N	Sold	\N	10879225			None	7066		15503038	CEJF13	CENTURY 21 Judge Fite Co.	(972) 234-3694	Negotiable	-1				15503038	CEJF13	CENTURY 21 Judge Fite Co.	(972) 234-3694	-1				15525617	(972) 468-5127	cheryl.jones@kw.com	Cheryl Jones	0393621	-1					15525617	(972) 468-5127	cheryl.jones@kw.com	Cheryl Jones	0393621	-1					Exclusive Right to Sell/Lease	0.00			Pending	ADDISON/FAR NORTH DALLAS AREA (10)	ADDISON (8)	North Texas Real Estate Information Systems		t	t	t	\N	2011-03-08 16:35:06+01		Agent Or Owner Present		Northwood Park Blk R/8041 Lot							9999999	2007-10-10 02:00:00+02	259000		0	\N	\N	\N	\N	4%	0%	2007-07-27 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
e4f9ed78-c2ca-11e5-9f0d-f23c91c841bd	e4a358dc-c2ca-11e5-9f0d-f23c91c841bd	\N	\N	\N	2016-01-24 19:47:18.543004+01	2016-01-24 19:47:18.543004+01	\N	USD	144900	\N	1157723	154900	154900	\N	Sold	\N	10916961				4140		15514049	UNRA01	Meirrak Realty	(972) 293-9556	Closing/Funding	-1				15514049	UNRA01	Meirrak Realty	(972) 293-9556	-1				15531709	(214) 734-1125	fkarriem@sbcglobal.net	Fatima Karriem	0451376	-1					15531709	(214) 734-1125	fkarriem@sbcglobal.net	Fatima Karriem	0451376	-1					Exclusive Right to Sell/Lease				Pending	DALLAS SOUTH OAK CLIFF (15)	SOUTH OAKCLIFF (4)	North Texas Real Estate Information Systems		t	t	t	2008-05-07 19:56:00+02	2011-03-08 16:34:17+01		Agent Or Owner Present		Parnian No 2 Blk B/6627 Lt 1a							999999	2008-06-25 02:00:00+02	130000		0	\N	\N	\N	\N	3%	0%	2007-12-26 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
b4c2b38a-c30e-11e5-9a55-f23c91c841bd	b46a7bd4-c30e-11e5-9a55-f23c91c841bd	\N	\N	\N	2016-01-25 03:52:43.428089+01	2016-01-25 03:52:43.428089+01	\N	USD	135815	\N	1933053	135815	\N	\N	Sold	\N	10967540		None	None	578	Cash,Conventional,FHA,VA	15504401	DOWN01	Blake Richards Realty	(214) 870-5251	Closing/Funding	-1				15504401	DOWN01	Blake Richards Realty	(214) 870-5251	-1				15546037	(832) 338-9997	blkrichards@yahoo.com	Blake Richards	0503652	-1					15546037	(832) 338-9997	blkrichards@yahoo.com	Blake Richards	0503652	-1					Exclusive Right to Sell/Lease				Pending	DALLAS SOUTHEAST (13)	SOUTHEAST DALLAS (5)	North Texas Real Estate Information Systems		t	t	t	\N	2010-09-13 15:18:02+02		Agent Or Owner Present		Brierwood Heights Ph 2 Blk 6/8		For Sale					0	2008-10-17 02:00:00+02	109990		0	\N	\N	\N	\N	3%	0%	2008-03-19 06:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
8a756fb4-c368-11e5-92b3-f23c91c841bd	8a18124c-c368-11e5-92b3-f23c91c841bd	\N	\N	\N	2016-01-25 14:35:47.162879+01	2016-01-25 14:35:47.162879+01	\N	USD	89900	\N	1988905	89900	\N	\N	Sold	\N	11118797			None	\N	Cash,Conventional,FHA	15504646	ebby26	Ebby Halliday, REALTORS	(972) 771-8163	Closing/Funding	-1				15511565	RMAT01	RE/MAX About Dallas	(214) 523-3300	-1				15525576	(972) 407-4687	sandytapp@ebby.com	Sandy Tapp	0392879	-1					15551882	(214) 870-4378	calljaetoday@gmail.com	Jeanie Nixon	0523717	-1					Exclusive Right to Sell/Lease				Pending	DALLAS SOUTHEAST (13)	SOUTHEAST DALLAS (7)	North Texas Real Estate Information Systems		t	t	t	\N	2009-01-30 22:16:28+01		Combo Lock Box				For Sale					0	2009-01-28 01:00:00+01	81000		0	\N	\N	\N	\N	4.5%	0%	2008-12-05 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
862da4ae-c367-11e5-93fd-f23c91c841bd	8609903c-c367-11e5-93fd-f23c91c841bd	\N	\N	\N	2016-01-25 14:28:30.48498+01	2016-01-25 14:28:30.48498+01	\N	USD	50000	\N	1991939	65000	54900	\N	Sold	\N	11127333			None	1849		15507748	KEWS02	Keller Williams Dallas Premier	(214) 739-5500	Closing/Funding	-1				15502747	CBAP01	Coldwell Banker Apex	(972) 840-1400	-1				15533803	(214) 673-1740	ces-3@kw.com	Clarence Sebastian	0461005	-1					15559528	(214) 418-8506	dianaperry123@gmail.com	Diana Perry	0551421	-1					Exclusive Right to Sell/Lease				Pending	DALLAS EAST (12)	EAST DALLAS (10)	North Texas Real Estate Information Systems		t	t	t	2009-03-05 06:04:00+01	2009-05-07 06:17:30+02		Centralized Showing Service		Casa View Heights Blk A/7470 L		For Sale					1	2009-04-28 02:00:00+02	40000		0	\N	\N	\N	\N	3%	0%	2009-01-04 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
66e41ca6-c293-11e5-8bcd-f23c91c841bd	66971532-c293-11e5-8bcd-f23c91c841bd	\N	\N	\N	2016-01-24 13:10:04.68699+01	2016-01-24 13:10:04.68699+01	\N	USD	5000	\N	1354359	5000	\N	\N	Leased	\N	11130963			None	\N		15510831	PRUD18AR	Prudential Texas Properties	(817) 226-4920		-1				15510831	PRUD18AR	Prudential Texas Properties	(817) 226-4920	-1				15523689	(817) 235-4535	jamie@jamieadams.com	Jamie Adams	0358381	-1					15523689	(817) 235-4535	jamie@jamieadams.com	Jamie Adams	0358381	-1					Exclusive Right to Sell/Lease			2009-02-01T00:00:00.000	Active	DALLAS OAK LAWN (17)	OAKLAWN (11)	North Texas Real Estate Information Systems	2009-02-06T00:00:00.000	t	t	t	\N	2011-08-05 07:05:16+02		Agent Or Owner Present		Block C Condominiums Blk J/384							0000000	2009-02-05 01:00:00+01	5000		5000	\N	\N	\N	\N	20%	0%	2009-01-09 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
6f3da1b4-c1f9-11e5-9b8c-f23c91c841bd	6ee3d4f4-c1f9-11e5-9b8c-f23c91c841bd	\N	\N	\N	2016-01-23 18:47:56.199117+01	2016-01-23 18:47:56.199117+01	\N	USD	274126	\N	2015306	345000	299000	\N	Sold	\N	11187777			None	\N		15504656	EBBY34	Ebby Halliday, REALTORS	(214) 826-0316	Closing/Funding	-1				15511565	RMAT01	RE/MAX About Dallas	(214) 523-3300	-1				15565791	(214) 460-5456	kimnikolis@ebby.com	Kim Nikolis	0576938	-1					15535303	(214) 641-7168	darrenorr@sbcglobal.net	Darren Orr	0466737	-1					Exclusive Right to Sell/Lease				Pending	DALLAS EAST (12)	EAST DALLAS (2)	North Texas Real Estate Information Systems		t	t	t	2009-10-27 22:35:00+01	2012-10-05 15:25:30+02		Centralized Showing Service,Combo Lock Box,Courtesy Call (Appt Svc Only)				For Sale					0	2010-02-04 01:00:00+01	250000		0	\N	\N	\N	\N	3%	0%	2009-04-20 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
56d1c3a0-c260-11e5-9530-f23c91c841bd	5680bac8-c260-11e5-9530-f23c91c841bd	\N	\N	\N	2016-01-24 07:04:33.389924+01	2016-01-24 07:04:33.389924+01	\N	USD	160000	\N	2025784	160000	\N	\N	Sold	81	11212876	Monthly	Other	Mandatory	\N		15504653	ebby31	Ebby Halliday, REALTORS	(972) 608-0300	Closing/Funding	-1				15507747	KEWS01	Keller Williams Realty	(972) 240-4416	-1				15527724	(214) 357-3281	samantha_reid@sbcglobal.net	Samantha Reid	0421892	-1					15525817	(214) 552-0549	dlsukhu@gmail.com	Dilip Sukhu	0396901	-1					Exclusive Right to Sell/Lease				Pending	ADDISON/FAR NORTH DALLAS AREA (10)	ADDISON (1)	North Texas Real Estate Information Systems		t	f	t	\N	2012-01-10 07:19:15+01		Combo Lock Box				For Sale					9999	2009-07-10 02:00:00+02	153900		0	\N	\N	\N	\N	2.5%	0%	2009-06-01 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
778bed58-c1f9-11e5-9b8c-f23c91c841bd	77358c56-c1f9-11e5-9b8c-f23c91c841bd	\N	\N	\N	2016-01-23 18:48:10.133742+01	2016-01-23 18:48:10.133742+01	\N	USD	374900	\N	2034018	389900	389900	\N	Sold	\N	11233191			None	\N		15506092	GRFF01	David Griffin & Company	(214) 526-5626	Closing/Funding	-1				15512254	SGRN01	Susan Griffin	(214) 641-8231	-1				15520664	(214) 536-8517	dcollier41@hotmail.com	David Collier	0294413	-1					15533958	(214) 641-8231	susangriffin@sbcglobal.net	Susan Griffin	0461636	-1					Exclusive Right to Sell/Lease				Pending	DALLAS NORTHEAST (18)	NORTHEAST DALLAS (13)	North Texas Real Estate Information Systems		t	t	t	2009-08-28 22:54:00+02	2012-10-05 15:25:19+02		Centralized Showing Service		University Manor Blk F/5440 Lt		For Sale					0	2009-10-22 02:00:00+02	360000		0	\N	\N	\N	\N	3%	0%	2009-07-06 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
fa045cde-c1ea-11e5-bcc6-f23c91c841bd	f9b40374-c1ea-11e5-bcc6-f23c91c841bd	\N	\N	\N	2016-01-23 17:04:26.575857+01	2016-01-23 17:04:26.575857+01	\N	USD	239000	\N	2047261	239000	\N	\N	Sold	155	11267000	Monthly	Blanket Insurance,Exterior Maintenance	Mandatory	\N	Cash,Conventional	15501995	BGRE01	Bill Griffin Real Estate	(214) 742-2424	Closing/Funding	-1				15504412	DPMA02	Dave Perry-Miller & Associates	(214) 526-6600	-1				15565377	(940) 902-9138	jamiea1121@aol.com	Jamie Allen	0575200	-1					15540461	(214) 403-4444	bonniebauer@ebby.com	Bonnie Bauer	0485134	-1					Exclusive Right to Sell/Lease				Pending	DALLAS EAST (12)	EAST DALLAS (11)	North Texas Real Estate Information Systems		t	t	t	\N	2012-10-29 06:26:58+01		Centralized Showing Service				For Sale					0000000	2010-04-29 02:00:00+02	239000		0	\N	\N	\N	\N	3%	0%	2009-09-01 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
02d7823a-c2f1-11e5-9af8-f23c91c841bd	022f23c4-c2f1-11e5-9af8-f23c91c841bd	\N	\N	\N	2016-01-25 00:20:09.524769+01	2016-01-25 00:20:09.524769+01	\N	USD	65500	\N	1219390	65500	60500	65000	Expired	\N	11269397			None	1630	Owner Carry First	15514052	UNRE01	Fdez Realty Inc.	(972) 303-6700	Closing/Funding	-1				-1				-1				15529414	(214) 642-7382	hernandez.fidencio@gmail.com	Fidencio Hernandez	0437330	-1					-1					-1					Exclusive Right to Sell/Lease				Temp Off Market	DALLAS NORTHWEST (16)	NORTHWEST DALLAS (4)	North Texas Real Estate Information Systems		t	t	t	2010-05-23 02:17:00+02	2010-12-10 07:05:24+01				Webster Grove Lot 11 Dothan Dr							0000	\N	\N		0	\N	\N	\N	\N	3.000%	3.000 %	2009-09-03 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
2f2e3c94-c2d2-11e5-84f5-f23c91c841bd	2ea54e2a-c2d2-11e5-84f5-f23c91c841bd	\N	\N	\N	2016-01-24 20:39:29.514349+01	2016-01-24 20:39:29.514349+01	\N	USD	425	\N	1375600	450	450	\N	Leased	\N	11302753			None	\N		15507999	KYAS01	KY II Realtors	(972) 283-8254		-1				15507999	KYAS01	KY II Realtors	(972) 283-8254	-1				15564409	(214) 622-3933	leah_whiten@yahoo.com	Leah Whiten	0571086	-1					15564409	(214) 622-3933	leah_whiten@yahoo.com	Leah Whiten	0571086	-1					Exclusive Right to Sell/Lease		Other		Active	DALLAS NORTH OAK CLIFF (14)	OAKCLIFF (6)	North Texas Real Estate Information Systems	2010-01-01T00:00:00.000	t	t	t	2009-11-19 19:42:00+01	2011-03-08 16:34:17+01		Go - Key Box		J C Hugules & Clouds Wendelkin							3131	2009-12-23 01:00:00+01	425		100	\N	\N	\N	\N	25%	25%	2009-11-10 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
83e83cb4-c1f9-11e5-9b8c-f23c91c841bd	839bd89c-c1f9-11e5-9b8c-f23c91c841bd	\N	\N	\N	2016-01-23 18:48:30.871549+01	2016-01-23 18:48:30.871549+01	\N	USD	299000	\N	2062249	299000	\N	\N	Sold	\N	11305811	Annual		Voluntary	8368	Cash,Conventional	15502855	CBRB49	Coldwell Banker Residential	(214) 828-4300	Closing/Funding	-1				15502855	CBRB49	Coldwell Banker Residential	(214) 828-4300	-1				15529680	(972) 733-9470	nancy.wilson@cbdfw.com	Nancy Wilson	0439434	-1					15529680	(972) 733-9470	nancy.wilson@cbdfw.com	Nancy Wilson	0439434	-1					ER with Reservations				Pending	DALLAS EAST (12)	EAST DALLAS (7)	North Texas Real Estate Information Systems		t	t	t	\N	2012-10-05 15:24:54+02		Centralized Showing Service,Courtesy Call (Appt Svc Only)		Burke S R Lot 15 South Ridge D		For Sale					6852619	2009-12-28 01:00:00+01	289000		0	\N	\N	\N	\N	3%	3%	2009-11-17 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
0f9aa842-c1e5-11e5-a301-f23c91c841bd	0f4cdde2-c1e5-11e5-a301-f23c91c841bd	\N	\N	\N	2016-01-23 16:22:05.812901+01	2016-01-23 16:22:05.812901+01	\N	USD	258500	\N	2065316	259900	259900	\N	Sold	\N	11313176			Voluntary	\N		15502862	CBRB55	Coldwell Banker Residential	(214) 521-0044	Closing/Funding	-1				15511745	ROGE01	Rogers Healy and Associates	(214) 368-4663	-1				15521604	(972) 960-6272	vallala1@airmail.net	Linda Vallala	0316864	-1					15560770	(214) 794-0306	bburgett@gmail.com	Bonnie Burgett	0556321	-1					Exclusive Right to Sell/Lease				Pending	DALLAS NORTH (11)	NORTH DALLAS (3)	North Texas Real Estate Information Systems		t	t	t	2010-02-16 16:52:00+01	2012-11-17 07:25:23+01		Courtesy Call (Appt Svc Only)		Huffhines Hill Blk 9/7445 Lt 3		For Sale					0	2010-05-17 02:00:00+02	237500		0	\N	\N	\N	\N	3%	0%	2009-12-02 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
63d2e760-c219-11e5-b5d8-f23c91c841bd	63824fc6-c219-11e5-b5d8-f23c91c841bd	\N	\N	\N	2016-01-23 22:36:40.939999+01	2016-01-23 22:36:40.939999+01	\N	USD	2100	\N	1379463	2100	\N	\N	Leased	\N	11330232			None	\N		15507945	KWDC01	Dallas City Center Realtors	(214) 515-9888		-1				15509697	NCRG96	Life Cirque Real Estate	(214) 732-1610	-1				15570177	(214) 542-2575	brianbleeker@yahoo.com	Brian Bleeker	0595894	-1					15546369	(214) 732-1610	erinsperry@swbell.net	Erin Sperry	0504816	-1					Exclusive Right to Sell/Lease		Move-in	2010-01-14T00:00:00.000	Pending	DALLAS OAK LAWN (17)	OAKLAWN (7)	North Texas Real Estate Information Systems	2010-02-13T00:00:00.000	t	f	t	\N	2012-08-01 07:06:50+02		Centralized Showing Service		Palo Alto Townhomes Condominiu		For Lease						2010-02-01 01:00:00+01	2100		2100	\N	\N	\N	\N	50%	50%	2010-01-14 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
73ae5348-c1fd-11e5-a990-f23c91c841bd	735fbdd2-c1fd-11e5-a990-f23c91c841bd	\N	\N	\N	2016-01-23 19:16:41.635297+01	2016-01-23 19:16:41.635297+01	\N	USD	1250	\N	1380895	1295	1295	\N	Leased	\N	11343519			None	\N		15501143	ALCK01	Al Coker & Associates, L.L.C.	(214) 443-9300		-1				15502303	BREC01	3B Real Estate Company	(214) 793-1133	-1				15524374	(214) 704-6024	gary.tinsley@luinc.com	Gary Tinsley	0370421	-1					15556940	(214) 708-5363	chad@cjbrec.com	Chad Brozovich	0541593	-1					Exclusive Right to Sell/Lease		Move-in 5		Pending	DALLAS OAK LAWN (17)	OAKLAWN (11)	North Texas Real Estate Information Systems	2010-04-09T00:00:00.000	t	t	t	2010-03-06 00:39:00+01	2012-10-01 07:56:31+02		Key in Office		Terrace Condos Blk F/389 Lt 4a								2010-04-01 02:00:00+02	1200		1295	\N	\N	\N	\N	50%	0%	2010-02-06 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
6f72b634-c1e9-11e5-af0e-f23c91c841bd	6f241cc2-c1e9-11e5-af0e-f23c91c841bd	\N	\N	\N	2016-01-23 16:53:24.599032+01	2016-01-23 16:53:24.599032+01	\N	USD	178000	\N	2083889	189000	189000	\N	Sold	\N	11352855			None	\N		15504411	dpma01	Dave Perry-Miller & Associates	(214) 369-6000	Negotiable	-1				15507748	KEWS02	Keller Williams Dallas Premier	(214) 739-5500	-1				15534944	(214) 354-1523	dawn@daveperrymiller.com	Dawn Rejebian	0465400	-1					15547900	(214) 668-1783	reggie@reggiewalker.com	Reggie Walker	0509658	-1					Exclusive Right to Sell/Lease				Pending	DALLAS NORTH (11)	NORTH DALLAS (11)	North Texas Real Estate Information Systems		t	f	t	2010-03-30 16:01:00+02	2012-11-04 06:08:17+01		Call-Key Box				For Sale					0	2010-05-04 02:00:00+02	170000		0	\N	\N	\N	\N	3%	0%	2010-02-23 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
54704286-c1f1-11e5-bc6c-f23c91c841bd	53e4c01c-c1f1-11e5-bc6c-f23c91c841bd	\N	\N	\N	2016-01-23 17:49:55.258612+01	2016-01-23 17:49:55.258612+01	\N	USD	2300	\N	1383273	2300	\N	\N	Leased	\N	11363754			None	\N		15511711	RNSD01	Net Worth Realty of Dallas/Ft.	(214) 373-9000		-1				15511711	RNSD01	Net Worth Realty of Dallas/Ft.	(214) 373-9000	-1				15562535	(214) 727-6656	mark@networthrealtyusa.com	Mark Bloom	0563188	-1					15562535	(214) 727-6656	mark@networthrealtyusa.com	Mark Bloom	0563188	-1					Exclusive Right to Sell/Lease		Move-in 5		Active	DALLAS EAST (12)	EAST DALLAS (2)	North Texas Real Estate Information Systems	2010-04-22T00:00:00.000	t	t	t	\N	2012-10-15 07:09:29+02		Agent Or Owner Present		Stonewall Park Blk B/4853 Lot		For Lease						2010-04-15 02:00:00+02	2300		2300	\N	\N	\N	\N	40%	40%	2010-03-05 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
2e0d4a78-c31b-11e5-913c-f23c91c841bd	2dbdbd5a-c31b-11e5-913c-f23c91c841bd	\N	\N	\N	2016-01-25 05:22:00.882003+01	2016-01-25 05:22:00.882003+01	\N	USD	139000	\N	2119751	139000	\N	\N	Sold	40	11423461	Monthly	Management Fees	Mandatory	4415		15514583	WLLR01	Waller Group LLC	(214) 736-1500	Closing/Funding	-1				15502939	CCR01C	Complete Circle Realty	(214) 614-8160	-1				15538769	(214) 736-1500	logan@loganwaller.com	Logan Waller	0479147	-1					15559998	(214) 755-2741	brendarobwilliams@gmail.com	Brenda Williams	0553223	-1					Exclusive Right to Sell/Lease				Pending	DALLAS SOUTH OAK CLIFF (15)	SOUTH OAKCLIFF (8)	North Texas Real Estate Information Systems		t	t	t	\N	2010-08-09 20:17:48+02		Centralized Showing Service,Go (Appt Svc Only)		Enchanted Villas Blk E/7570 Lt		For Sale					123456	2010-07-28 02:00:00+02	141000		0	\N	\N	\N	\N	3%	0%	2010-06-16 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
bb1e274c-c2cc-11e5-aa15-f23c91c841bd	ba8632fc-c2cc-11e5-aa15-f23c91c841bd	\N	\N	\N	2016-01-24 20:00:27.309471+01	2016-01-24 20:00:27.309471+01	\N	USD	2100	\N	1289260	2100	1950	\N	Leased	\N	11454269			None	\N		15514652	WORT01	Local Dwelling	(214) 522-9100		-1				15514652	WORT01	Local Dwelling	(214) 522-9100	-1				15553181	(469) 441-0512	chris@greenercitygroup.com	Christopher Vogel	0528361	-1					15553181	(469) 441-0512	chris@greenercitygroup.com	Christopher Vogel	0528361	-1					Exclusive Right to Sell/Lease		Move-in 5		Active	DALLAS EAST (12)	EAST DALLAS (11)	North Texas Real Estate Information Systems	2010-09-15T00:00:00.000	t	t	t	2010-09-13 18:36:00+02	2011-03-08 16:35:06+01		Centralized Showing Service		Gaston Homestead Blk 4/818 Lot								2010-09-15 02:00:00+02	2100		1750	\N	\N	\N	\N	50%	50%	2010-08-06 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
ed850e9e-c2cc-11e5-aa15-f23c91c841bd	ed0fefce-c2cc-11e5-aa15-f23c91c841bd	\N	\N	\N	2016-01-24 20:01:51.870047+01	2016-01-24 20:01:51.870047+01	\N	USD	1100	\N	1298515	1250	1250	\N	Leased	\N	11500226			None	\N		15507748	KEWS02	Keller Williams Dallas Premier	(214) 739-5500		-1				15507748	KEWS02	Keller Williams Dallas Premier	(214) 739-5500	-1				15529063	(214) 837-4995	KWL08@aol.com	Nicolas Delacretaz	0434856	-1					15529063	(214) 837-4995	KWL08@aol.com	Nicolas Delacretaz	0434856	-1					Exclusive Right to Sell/Lease		Move-in	2010-11-16T00:00:00.000	Pending	DALLAS NORTHEAST (18)	NORTHEAST DALLAS (5)	North Texas Real Estate Information Systems	2011-02-01T00:00:00.000	t	t	t	2010-12-03 16:19:00+01	2011-03-08 16:34:34+01		Call-Key Box		Barkley Square Inst#2 Blk 13/7		For Lease				Blue iBox		2011-01-12 01:00:00+01	1000		1250	\N	\N	\N	\N	35%	35%	2010-11-04 06:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
5fd31866-c146-11e5-8192-f23c91c841bd	5f8f8290-c146-11e5-8192-f23c91c841bd	\N	\N	\N	2016-01-22 21:26:10.420121+01	2016-01-22 21:26:10.420121+01	\N	USD	279900	\N	2175635	279900	\N	\N	Cancelled	175	11511118	Annual	Management Fees	Mandatory	\N	Cash,Conventional,FHA,VA	15511597	RMDF05	Re/Max Dfw Associates V	(972) 312-9000	Negotiable	-1				-1				-1				15529286	(214) 557-9656	jeannes@rmdfw.com	Jeanne Kuhn Slay	0436371	-1					-1					-1					Exclusive Right to Sell/Lease				Active	ADDISON/FAR NORTH DALLAS AREA (10)	ADDISON (3)	North Texas Real Estate Information Systems		t	t	t	\N	2013-02-05 10:14:31+01		Centralized Showing Service	Verify Tax Exemptions	Preston Highlands #04, Block 1		For Sale				Blue iBox	0000000	\N	\N		0	\N	\N	\N	\N	3%	0%	2010-12-01 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
1b8fc04e-c16b-11e5-8832-f23c91c841bd	1aeef592-c16b-11e5-8832-f23c91c841bd	\N	\N	\N	2016-01-23 01:49:07.272943+01	2016-01-23 01:49:07.272943+01	\N	USD	134900	\N	2203370	134900	\N	\N	Sold	\N	11551656			None	4287	Cash,Conventional,FHA,Other,VA	15511847	RRG01	RE/MAX Realty Group	(972) 935-0095	Closing/Funding	-1				15514393	WDR02	WILLIAM DAVIS REALTY FRISCO	(214) 705-1000	-1				15548698	(972) 515-8111	dalehorton@remax.net	Dale Horton	0512313	-1					15555568	(214) 641-4667	gregory.douglas9@verizon.net	Greg Douglas	0536654	-1					Exclusive Right to Sell/Lease				Pending	DUNCANVILLE AREA (28)	DUNCANVILLE (2)	North Texas Real Estate Information Systems		t	t	t	\N	2013-02-05 10:11:30+01		Centralized Showing Service	Other,Res. Service Contract,Survey Available	Mountain Creek Meadows 1 Ph 1		For Sale		www.propertypanorama.com/137513		Combo	21427016	2011-04-29 02:00:00+02	132000		0	\N	\N	\N	\N	3%	0%	2011-03-01 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
92d49416-c23a-11e5-92d3-f23c91c841bd	92940c52-c23a-11e5-92d3-f23c91c841bd	\N	\N	\N	2016-01-24 02:34:13.196072+01	2016-01-24 02:34:13.196072+01	\N	USD	75000	\N	2228463	84500	78000	\N	Expired	441	11586489	Monthly	All Utilities,Back Yard Maintenance,Electric,Exterior Maintenance,Front Yard Maintenance,Management Fees,Sprinkler System,Trash,Water/Sewer	Mandatory	1981	Cash,Conventional,FHA	15503008	CEGA01	Century 21 Galloway-Herron	(214) 467-4000	Closing/Funding	-1				-1				-1				15567658	(214) 718-7736	thebryants44@att.net	Cherri Bryant	0585310	-1					-1					-1					Exclusive Right to Sell/Lease				Active	DALLAS NORTH (11)	NORTH DALLAS (11)	North Texas Real Estate Information Systems		t	t	t	2011-08-12 05:02:00+02	2012-05-01 07:54:13+02		Appointment Service,Contact Agent,No Lock Box		Royal Oaks Condominiums Blk 2/		For Sale				None	0000	\N	\N		0	\N	\N	\N	\N	3%	0%	2011-05-01 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
ffc6e3ca-c23b-11e5-8f6a-f23c91c841bd	ff6ed78e-c23b-11e5-8f6a-f23c91c841bd	\N	\N	\N	2016-01-24 02:44:25.474659+01	2016-01-24 02:44:25.474659+01	\N	USD	240000	\N	2245733	250000	245000	\N	Cancelled	\N	11611892	Annual	Management Fees	Mandatory	6143		15515154	KELL01	Keller Williams Realty	(972) 732-6000	Closing/Funding	-1				-1				-1				15539434	(972) 527-1400	Homes@marvinjolly.com	Marvin Jolly	0481620	-1					-1					-1					Exclusive Right to Sell/Lease				Active	ADDISON/FAR NORTH DALLAS AREA (10)	ADDISON (4)	North Texas Real Estate Information Systems		t	t	t	2011-09-04 00:54:00+02	2012-04-26 07:09:30+02		Appointment (Appt Svc only),Centralized Showing Service,Go - Key Box		Highland Creek Manor (Cda), Bl		For Sale		www.tourfactory.com/idxr752271		Blue iBox	52522858	\N	\N		0	\N	\N	\N	\N	3%	0%	2011-06-15 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
223912a0-c22f-11e5-bacf-f23c91c841bd	219a00de-c22f-11e5-bacf-f23c91c841bd	\N	\N	\N	2016-01-24 01:12:19.807965+01	2016-01-24 01:12:19.807965+01	\N	USD	225000	\N	1164904	225000	\N	\N	Withdrawn Sublisting	\N	11613221				\N		15503361	CLES01	Clements, REALTORS	(214) 824-8173	Subject to Lease	-1				-1				-1				15521115	(972) 380-3427	sharon@clementsrealtors.com	Sharon Clements	0304876	-1					-1					-1					Exclusive Right to Sell/Lease				Active	DALLAS EAST (12)	EAST DALLAS (13)	North Texas Real Estate Information Systems		t	t	t	\N	2012-06-01 23:00:17+02		Agent Or Owner Present,Contact Agent		Blk 5800 Tr 27 Acs 4.324 Int20						None	00000	\N	\N		0	\N	\N	\N	\N	3%	0%	2009-08-04 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
55ce912e-c281-11e5-a984-f23c91c841bd	5580dd58-c281-11e5-a984-f23c91c841bd	\N	\N	\N	2016-01-24 11:00:45.083387+01	2016-01-24 11:00:45.083387+01	\N	USD	75900	\N	2248275	79900	79900	\N	Sold	\N	11615805			None	3495	Cash,Not Assumable	15502864	CBRB57	Coldwell Banker Residential	(972) 931-2400	Closing/Funding	-1				15502864	CBRB57	Coldwell Banker Residential	(972) 931-2400	-1				15522952	(972) 741-0770	stampley@ont.com	Patricia Stampley	0344967	-1					15522952	(972) 741-0770	stampley@ont.com	Patricia Stampley	0344967	-1					Exclusive Right to Sell/Lease				Pending	DALLAS EAST (12)	EAST DALLAS (10)	North Texas Real Estate Information Systems		t	t	t	2011-08-04 19:22:00+02	2011-09-29 07:00:32+02		Centralized Showing Service	Special Contracts/Provisions	Braeburn Glen Blk C/8571 Lot 1		For Sale				Blue iBox	0	2011-08-30 02:00:00+02	69000		0	\N	\N	\N	\N	3%	3%	2011-06-22 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
6c6e8f68-c16b-11e5-8832-f23c91c841bd	6c16d084-c16b-11e5-8832-f23c91c841bd	\N	\N	\N	2016-01-23 01:51:22.950832+01	2016-01-23 01:51:22.950832+01	\N	USD	560000	\N	2272071	560000	\N	\N	Cancelled	499	11651067	Monthly	Back Yard Maintenance,Blanket Insurance,Exterior Maintenance,Front Yard Maintenance,Full Use of Facilities,Gas,Management Fees,Security,Sprinkler System,Trash,Water/Sewer	Mandatory	12492	Cash,Conventional	15515154	KELL01	Keller Williams Realty	(972) 732-6000	Negotiable	-1				-1				-1				15565445	(214) 221-2345	jkalka@kw.com	Joseph Kalka	0575471	-1					-1					-1					Exclusive Right to Sell/Lease				Active	DALLAS EAST (12)	EAST DALLAS (11)	North Texas Real Estate Information Systems		t	f	t	\N	2013-02-05 10:15:50+01		Appointment Service,Centralized Showing Service,No Sign on Lot		Thirty Thirty Bryan Condominiu		For Sale/Lease		vt.realbiz360.com/MLS-812558.html		Blue iBox	53341952	\N	\N		0	\N	\N	\N	\N	3%	0%	2011-08-29 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
ba681604-c1fb-11e5-9ed4-f23c91c841bd	ba173518-c1fb-11e5-9ed4-f23c91c841bd	\N	\N	\N	2016-01-23 19:04:21.299856+01	2016-01-23 19:04:21.299856+01	\N	USD	537500	\N	2317178	537500	\N	\N	Sold	\N	11721921			None	\N	Cash,Conventional	15500889	ABAR01	Allie Beth Allman & Assoc.	(214) 521-7355	Closing/Funding,Negotiable	-1				15504412	DPMA02	Dave Perry-Miller & Associates	(214) 526-6600	-1				15529332	(214) 520-8310	fhalum@mathews-nichols.com	Faisal Halum	0436754	-1					15521862	(214) 217-3511	ralph@daveperrymiller.com	Ralph Randall	0322774	-1					Exclusive Right to Sell/Lease				Pending	DALLAS OAK LAWN (17)	OAKLAWN (8)	North Texas Real Estate Information Systems		t	f	t	\N	2012-10-05 15:25:25+02		Agent Or Owner Present,Centralized Showing Service		ENTRUSCA BLK A/1586 LT 14B ACS		For Sale		www.vrguild.net/c/star.pl?Q=1202062244219111		Blue iBox	0000	2012-03-30 02:00:00+02	520000		0	\N	\N	\N	\N	3%	0%	2012-02-14 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
2916bdac-c171-11e5-a880-f23c91c841bd	281c2270-c171-11e5-a880-f23c91c841bd	\N	\N	\N	2016-01-23 02:32:26.948378+01	2016-01-23 02:32:26.948378+01	\N	USD	369000	\N	2339947	375000	375000	\N	Cancelled	\N	11754161			None	\N	Not Assumable	15506092	GRFF01	David Griffin & Company	(214) 526-5626	Closing/Funding	-1				-1				-1				15551008	(214) 235-3452	lericsson@davidgriffin.com	Lori Ericsson	0520607	-1					-1					-1					Exclusive Right to Sell/Lease				Active	DALLAS OAK LAWN (17)	OAKLAWN (10)	North Texas Real Estate Information Systems		t	t	t	2012-08-22 14:52:00+02	2013-02-05 10:11:10+01		Agent Or Owner Present		The Villa Subdn Blk 2/1521 Lt		For Sale				Blue iBox	0	\N	\N		0	\N	\N	\N	\N	3%	0%	2012-04-13 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
3bd8f7fc-c171-11e5-a880-f23c91c841bd	3b6d57ea-c171-11e5-a880-f23c91c841bd	\N	\N	\N	2016-01-23 02:32:58.419707+01	2016-01-23 02:32:58.419707+01	\N	USD	419000	\N	2343937	419000	\N	\N	Cancelled	\N	11759671			Voluntary	10565	Cash,Conventional,Other	15502343	BRIG01	Briggs Freeman Sotheby's Int'l	(214) 350-0400	Negotiable	-1				-1				-1				15520267	(214) 676-0399	mcampbell@briggsfreeman.com	Michael Campbell	0283989	-1					-1					-1					Exclusive Right to Sell/Lease				Active	DALLAS EAST (12)	EAST DALLAS (6)	North Texas Real Estate Information Systems		t	f	t	\N	2013-02-05 10:12:28+01		Centralized Showing Service		GREENLAND HILLS 1ST SECTION BL		For Sale				None	0	\N	\N		0	\N	\N	\N	\N	3%	0%	2012-04-24 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
57eb51ba-c171-11e5-a880-f23c91c841bd	57908b86-c171-11e5-a880-f23c91c841bd	\N	\N	\N	2016-01-23 02:33:45.516848+01	2016-01-23 02:33:45.516848+01	\N	USD	149900	\N	2351891	149900	\N	\N	Sold	\N	11771164			None	3513	Cash,Conventional,FHA,VA	15503553	COOK01	Virginia Cook, REALTORS	(214) 696-8877	Closing/Funding	-1				15506566	HMSI01	Home Marketing Services, Inc.	(972) 392-9595	-1				15550793	(214) 455-3873	write2oscar_a@yahoo.com	Oscar Almaraz	0519851	-1					15559775	(214) 212-5875	dustincarlock@gmail.com	Dustin Carlock	0552343	-1					Exclusive Right to Sell/Lease				Pending	DALLAS NORTH OAK CLIFF (14)	OAKCLIFF (13)	North Texas Real Estate Information Systems		t	t	t	\N	2013-02-05 10:14:13+01		Appointment (Appt Svc only)		KIMBALL ESTS BLK 8/6956 LT 15		For Sale				Blue iBox	****	2012-08-03 02:00:00+02	148000		0	\N	\N	\N	\N	3%	0%	2012-05-14 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
44d9dab6-c21f-11e5-8149-f23c91c841bd	44992778-c21f-11e5-8149-f23c91c841bd	\N	\N	\N	2016-01-23 23:18:45.956322+01	2016-01-23 23:18:45.956322+01	\N	USD	37500	\N	2356489	37500	\N	\N	Sold	256	11777680	Monthly	Back Yard Maintenance,Blanket Insurance,Exterior Maintenance,Front Yard Maintenance,Gas,Management Fees,Reserves,Sprinkler System,Trash,Water/Sewer	Mandatory	791	Cash,Owner Carry First	15511559	RMAD01	RE/MAX Associates of Dallas	(972) 907-0000	Closing/Funding	-1				15507836	KLLR01	Keller Williams Realty	(972) 350-5000	-1				15526437	(214) 789-9606	danwillems@remax.net	Dan Willems	0406057	-1					15569830	(972) 768-7383	Meg@MeganRealEstate.com	Megan Hoenniger	0594571	-1					Exclusive Right to Sell/Lease				Active Option Contract	DALLAS NORTHEAST (18)	NORTHEAST DALLAS (10)	North Texas Real Estate Information Systems		t	t	t	\N	2012-07-16 07:27:26+02		Centralized Showing Service		TEALWOOD-ON-THE-CREEK CONDO BL		For Sale/Lease				Blue iBox	000	2012-06-14 02:00:00+02	37500		0	\N	\N	\N	\N	3%	0%	2012-05-25 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
6d009fe2-bc12-11e5-9fef-f23c91c841bd	6cae03e0-bc12-11e5-9fef-f23c91c841bd	\N	\N	\N	2016-01-16 06:31:42.885374+01	2016-01-16 06:31:42.885374+01	\N	USD	359900	\N	2360683	359900	\N	\N	Sold	200	11783879	Quarterly	Full Use of Facilities,Management Fees	Mandatory	\N		38261686	RMDF08	RE/MAX DFW Associates	(214) 523-3300	Negotiable	-1				15504625	EBBY06	Ebby Halliday, REALTORS	(972) 987-3800	-1				15525153	(214) 818-4150	jenny@jennycapritta.com	Jenny Capritta	0384911	-1					15520251	(972) 596-0319	woconnor101@verizon.net	Wanda O'connor	0283445	-1					Exclusive Right to Sell/Lease				Pending	DALLAS EAST (12)	EAST DALLAS (12)	North Texas Real Estate Information Systems		t	t	t	\N	2014-03-31 19:30:52.99+02		Appointment Service		ENCLAVE AT WHITE ROCK PH 2 BLK		For Sale				Blue iBox	0	2012-08-20 02:00:00+02	350000		0	\N	\N	\N	\N	3%	0%	2012-06-06 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
94321c3e-c1e0-11e5-bc01-f23c91c841bd	9415efb4-c1e0-11e5-bc01-f23c91c841bd	\N	\N	\N	2016-01-23 15:50:00.781014+01	2016-01-23 15:50:00.781014+01	\N	USD	161000	\N	2388816	161000	\N	\N	Sold	254	11826172	Monthly	Exterior Maintenance,Management Fees	Mandatory	\N		15510819	PRUD05	Prudential Texas Properties	(972) 996-7496	Closing/Funding	-1				15511745	ROGE01	Rogers Healy and Associates	(214) 368-4663	-1				15529112	(214) 906-4485	stacie.hamiltondoyle@prutexas.com	Stacie Hamilton Doyle	0435191	-1					15554214	(214) 455-1630	bfarrell@mathews-nichols.com	Bill Farrell	0532042	-1					Exclusive Right to Sell/Lease				Pending	DALLAS OAK LAWN (17)	OAKLAWN (8)	North Texas Real Estate Information Systems		t	t	t	\N	2012-11-28 21:54:47+01		Centralized Showing Service		4103 AVONDALE TOWNHOMES UNIT 1		For Sale				Combo	000	2012-10-17 02:00:00+02	154799		0	\N	\N	\N	\N	3%	3%	2012-08-22 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
57b459b8-c175-11e5-8a87-f23c91c841bd	575f478e-c175-11e5-8a87-f23c91c841bd	\N	\N	\N	2016-01-23 03:02:23.143331+01	2016-01-23 03:02:23.143331+01	\N	USD	174000	\N	2412482	174000	\N	\N	Sold	\N	11862460			None	\N	Cash,Conventional	15504636	ebby19	Ebby Halliday, REALTORS	(972) 387-0300	Closing/Funding	-1				15504636	EBBY19	Ebby Halliday, REALTORS	(972) 387-0300	-1				15537483	(469) 831-2928	heidi@ebby.com	Heidi Loewinsohn	0474608	-1					15537483	(469) 831-2928	heidi@ebby.com	Heidi Loewinsohn	0474608	-1					Exclusive Right to Sell/Lease				Pending	DALLAS EAST (12)	EAST DALLAS (9)	North Texas Real Estate Information Systems		t	f	t	\N	2013-02-05 07:22:02+01		Centralized Showing Service				For Sale				Blue iBox	0	2013-01-25 01:00:00+01	170000		0	\N	\N	\N	\N	3%	0%	2012-11-09 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
89cd8692-bcbe-11e5-b338-f23c91c841bd	89877df0-bcbe-11e5-b338-f23c91c841bd	\N	\N	\N	2016-01-17 03:03:44.641932+01	2016-01-17 03:03:44.641932+01	\N	USD	1350000	\N	2435482	1475000	1375000	\N	Sold	\N	11897902			None	32222	Cash,Conventional,FHA,VA	15507704	KELR02	Keller Williams Realty	(972) 599-7000	Closing/Funding	-1				15504636	EBBY19	Ebby Halliday, REALTORS	(972) 387-0300	-1				15565119	(214) 288-0761	aprilmattison@yahoo.com	April Mattison	0574035	-1					15522550	(214) 533-9196	es@elissasabel.com	Elissa Sabel	0336600	-1					Exclusive Right to Sell/Lease				Pending	DALLAS NORTH (11)	NORTH DALLAS (2)	North Texas Real Estate Information Systems		t	f	t	2013-05-30 04:13:00+02	2013-07-30 21:07:26+02		Appointment (Appt Svc only),Centralized Showing Service	Survey Available	PRESTON DELL ESTATES BLK 3/699		For Sale		www.propertypanorama.com/mls.asp?id=212458		Blue iBox	000000000	2013-07-30 02:00:00+02	1284000		0	\N	\N	\N	\N	3%	0%	2013-02-06 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
9c7e1690-bcc7-11e5-914b-f23c91c841bd	9c1dd5a0-bcc7-11e5-914b-f23c91c841bd	\N	\N	\N	2016-01-17 04:08:41.468547+01	2016-01-17 04:08:41.468547+01	\N	USD	350000	\N	2442473	350000	\N	\N	Sold	850	11908056	Monthly	Other	Mandatory	\N		15511645	RMNO01	RE/MAX Premier	(972) 991-1616	Closing/Funding	-1				15504413	DPMA03	Dave Perry-Miller InTown	(214) 303-1133	-1				15526531	(469) 878-4427	mlalji@contactdallas.com	Mansur Lalji	0407185	-1					15554247	(214) 544-5698	emily@highrises.com	Emily Ray Porter	0532171	-1					Exclusive Right to Sell/Lease				Active Contingent	DALLAS OAK LAWN (17)	OAKLAWN (11)	North Texas Real Estate Information Systems		t	f	t	\N	2013-06-28 19:37:39+02		Appointment Service,Centralized Showing Service		Block C South Tower Residences		For Sale/Lease				Blue iBox	00	2013-06-20 02:00:00+02	310000		0	\N	\N	\N	\N	3%	0%	2013-02-26 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
6498764c-bce7-11e5-aa38-f23c91c841bd	647e3cf0-bce7-11e5-aa38-f23c91c841bd	\N	\N	\N	2016-01-17 07:56:11.583678+01	2016-01-17 07:56:11.583678+01	\N	USD	295000	\N	2445371	295000	\N	\N	Sold	1687	11912234	Monthly	Electric,Full Use of Facilities,Management Fees,Trash,Water/Sewer	Mandatory	\N	Cash,Conventional	15504785	ELLM01	David Ellis Real Estate	(972) 849-8880	Closing/Funding	-1				15503553	COOK01	Virginia Cook, REALTORS	(214) 696-8877	-1				15520330	(972) 849-8880	ellis@davidellisrealestate.com	David Ellis	0285809	-1					15552256	(469) 951-2646	nmartinez@virginiacook.com	Nancy Martinez	0525143	-1					Exclusive Right to Sell/Lease				Pending	DALLAS OAK LAWN (17)	OAKLAWN (9)	North Texas Real Estate Information Systems		t	t	t	\N	2013-03-21 05:57:19+01		Special		3525 Condominiums Blk 2/1043 A		For Sale				None	00000	2013-03-18 01:00:00+01	260000		0	\N	\N	\N	\N	3%	3%	2013-03-05 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
e3c0fa1c-bcc8-11e5-b3df-f23c91c841bd	e36a4528-bcc8-11e5-b3df-f23c91c841bd	\N	\N	\N	2016-01-17 04:17:50.521889+01	2016-01-17 04:17:50.521889+01	\N	USD	339000	\N	2450807	375000	359900	\N	Sold	\N	11919882	Annual	Full Use of Facilities,Management Fees	Mandatory	8636	Not Assumable	15504657	ebby35	Ebby Halliday, REALTORS	(214) 509-0808	Closing/Funding	-1				15511074	RCR00GB	Stepping Stone Realty	(817) 329-5069	-1				15537203	(214) 642-8997	dannasmith@ebby.com	Danna Smith	0473510	-1					15574738	(214) 683-9843	rjkey3@gmail.com	Rob Key	0616017	-1					Exclusive Right to Sell/Lease				Pending	ADDISON/FAR NORTH DALLAS AREA (10)	ADDISON (4)	North Texas Real Estate Information Systems		t	f	t	2013-04-15 18:07:00+02	2013-06-26 17:34:09+02		Appointment Service,Centralized Showing Service,Courtesy Call (Appt Svc Only)				For Sale				Combo	123456	2013-06-21 02:00:00+02	305000		0	\N	\N	\N	\N	3%	0%	2013-03-18 06:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
8d7203c4-bc99-11e5-936d-f23c91c841bd	8d1a8b12-bc99-11e5-936d-f23c91c841bd	\N	\N	\N	2016-01-16 22:38:59.374134+01	2016-01-16 22:38:59.374134+01	\N	USD	162500	\N	2497853	162500	\N	\N	Cancelled	150	11987002	Semi-Annual	Full Use of Facilities,Maintenance of Common Areas	Mandatory	3904	Cash,Conventional,FHA,Texas Vet,VA	15504040	DCLE01	Keller Williams Dallas County	(972) 283-8800	Closing/Funding	-1				-1				-1				15571397	(214) 404-0842	andreyoung@kw.com	Andre Young	0600904	-1					-1					-1					Exclusive Right to Sell/Lease				Temp Off Market	DUNCANVILLE AREA (28)	DUNCANVILLE (2)	North Texas Real Estate Information Systems		t	t	t	\N	2013-11-10 07:05:29+01		Centralized Showing Service		SUMMIT PARC 4 BLK P/8721 LT 11		For Sale				Blue iBox	951753	\N	\N		0	\N	\N	\N	\N	2.5%	2.5%	2013-07-09 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
2b384156-bcb6-11e5-84b0-f23c91c841bd	2aa5e9fa-bcb6-11e5-84b0-f23c91c841bd	\N	\N	\N	2016-01-17 02:03:49.983799+01	2016-01-17 02:03:49.983799+01	\N	USD	1325	\N	1090971	1325	\N	\N	Leased	\N	12004313			None	\N		15503934	DALR01	Jim Bricker	(972) 612-3209		-1				15503934	DALR01	Jim Bricker	(972) 612-3209	-1				15515730	(972) 612-3209	jimandbobbie@verizon.net	Jim Bricker	0113227	-1					15515730	(972) 612-3209	jimandbobbie@verizon.net	Jim Bricker	0113227	-1					Exclusive Right to Sell/Lease		Move-in	2013-08-06T00:00:00.000	Pending	ADDISON/FAR NORTH DALLAS AREA (10)	ADDISON (1)	North Texas Real Estate Information Systems	2013-08-22T00:00:00.000	t	t	t	\N	2013-08-24 17:02:28+02		Appointment (Appt Svc only),Combo Lock Box								Combo		2013-08-13 02:00:00+02	1325		1325	\N	\N	\N	\N	$500.00	0.00%	2013-08-06 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
0d9dfbf4-bc39-11e5-b04f-f23c91c841bd	0cb6d6ca-bc39-11e5-b04f-f23c91c841bd	\N	\N	\N	2016-01-16 11:08:13.227906+01	2016-01-16 11:08:13.227906+01	\N	USD	189000	\N	2529072	199000	199000	\N	Sold	\N	12034273			None	\N		15502347	BRIG03	Briggs Freeman Sotheby's Int'l	(214) 353-2500	Closing/Funding	-1				15511593	RMDF01	RE/MAX DFW Associates	(972) 462-8181	-1				15551227	(214) 762-9761	jennisto@yahoo.com	Jenni Stolarski	0521387	-1					15526883	(972) 393-9696	EdandKaty@rmdfw.com	Ed James	0411709	-1					Exclusive Right to Sell/Lease				Pending	DALLAS NORTH OAK CLIFF (14)	OAKCLIFF (2)	North Texas Real Estate Information Systems		t	f	t	2013-10-22 20:58:00+02	2014-02-07 05:35:53.33+01		Centralized Showing Service		OAK CLIFF ANNEX LOT 20 EDGEFIE		For Sale				Blue iBox	0	2014-01-31 01:00:00+01	189000		0	\N	\N	\N	\N	3%	0%	2013-10-02 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
4c1dd0be-bc95-11e5-92d4-f23c91c841bd	4b66cc84-bc95-11e5-92d4-f23c91c841bd	\N	\N	\N	2016-01-16 22:08:31.783521+01	2016-01-16 22:08:31.783521+01	\N	USD	2850	\N	1101151	2850	\N	\N	Leased	\N	12046897			None	\N		15514744	WYNN01	Joan Wynne Company	(214) 361-6125		-1				15507749	KEWS03	Keller Williams, Urban Dallas	(214) 234-8000	-1				15523178	(972) 915-7300	joan.wynne@golimo.com	Joan Wynne	0349369	-1					15577470	(214) 662-1984	sarahwalkerdallas@gmail.com	Sarah Walker	0626546	-1					Exclusive Right to Sell/Lease		Move-in 5	2013-11-30T00:00:00.000	Active	DALLAS NORTH (11)	NORTH DALLAS (11)	North Texas Real Estate Information Systems	2014-01-01T00:00:00.000	t	t	t	\N	2013-11-19 18:17:38+01		Agent Or Owner Present		THE MEADOWS 3 BLK H/5455 LOT 3		For Sale/Lease						2013-11-17 01:00:00+01	2850		2850	\N	\N	\N	\N	50%	50%	2013-10-28 06:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
dc07e002-bb28-11e5-b7d3-f23c91c841bd	db74d546-bb28-11e5-b7d3-f23c91c841bd	\N	\N	\N	2016-01-15 02:39:46.92516+01	2016-01-15 02:39:46.92516+01	\N	USD	397500	\N	37919010	425000	399000	\N	Expired	\N	12109468	Monthly	Blanket Insurance,Front Yard Maintenance,Gas,Management Fees,Other,Security,Sprinkler System,Trash,Water/Sewer	Mandatory	\N		15504638	ebby20	Ebby Halliday, REALTORS	(214) 692-0000	Closing/Funding	-1				-1				-1				15570388	(832) 326-8073	johnnymowad@ebby.com	Johnny Mowad	0596679	-1					-1					-1					Exclusive Right to Sell/Lease				Active	DALLAS OAK LAWN (17)	OAKLAWN (8)	North Texas Real Estate Information Systems		t	f	t	2014-08-21 17:53:04.393+02	2014-09-01 07:11:54.35+02		Centralized Showing Service				For Sale		apps2.shoot2sell.net/gallery/mls/3800-holland-ave-dallas-tx-11/		Blue iBox	0	\N	\N		0	\N	\N	\N	\N	3%	0%	2014-03-20 06:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
36169582-bbc1-11e5-9490-f23c91c841bd	357b8f4c-bbc1-11e5-9490-f23c91c841bd	\N	\N	\N	2016-01-15 20:50:21.519104+01	2016-01-15 20:50:21.519104+01	\N	USD	379000	\N	43529959	379000	\N	\N	Sold	\N	12137770			None	\N		15509565	NATHGRA01	Nathan Grace Real Estate, LLC.	(214) 765-0600	Closing/Funding	-1				15504034	DCCR01	Dallas City Center Realtors	(214) 515-9888	-1				15549113	(214) 662-9133	robin@cntrealestate.com	Robin Norcross	0513811	-1					15571343	(214) 207-0731	drew.burroughs@gmail.com	Drew Burroughs	0600699	-1					Exclusive Right to Sell/Lease				Pending	DALLAS NORTHEAST (18)	NORTHEAST DALLAS (14)	North Texas Real Estate Information Systems		t	t	t	\N	2014-06-24 18:15:18.7+02		Appointment (Appt Svc only),Centralized Showing Service		LAKE RIDGE ESTATES 1ST INST BL		For Sale		apps2.shoot2sell.net/gallery/mls/9033-guildhall-dr-dallas-tx/		Blue iBox	0000	2014-06-17 02:00:00+02	383000		0	\N	\N	\N	\N	3%	0%	2014-05-07 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
1eedff90-bb43-11e5-bcc2-f23c91c841bd	1e9020d2-bb43-11e5-bcc2-f23c91c841bd	\N	\N	\N	2016-01-15 05:47:46.077909+01	2016-01-15 05:47:46.077909+01	\N	USD	129900	\N	44370476	142000	142000	\N	Sold	\N	12158269			None	1636	Cash,Conventional,FHA,VA	15504034	DCCR01	Dallas City Center Realtors	(214) 515-9888	Closing/Funding	-1				15512741	STAN02AR	Stanfield REALTORS	(972) 641-0447	-1				15548744	(214) 395-0669	tony@dallascitycenter.com	Tony Nuncio	0512453	-1					15564541		pauladuncanson@yahoo.com	Paula Duncanson	0571654	-1					Exclusive Right to Sell/Lease				Pending	DALLAS NORTH OAK CLIFF (14)	OAKCLIFF (14)	North Texas Real Estate Information Systems		t	t	t	\N	2014-08-14 00:23:14.63+02		Appointment (Appt Svc only),Centralized Showing Service		DRUID HILLS 2 BLK 7/6036 LT 2		For Sale		apps2.shoot2sell.net/gallery/mls/2028-vatican-ln-dallas-tx/		Blue iBox	999999	2014-08-06 02:00:00+02	129900	2014-07-10T00:00:00.000	0	\N	\N	\N	\N	3%	0%	2014-06-09 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
6a4c1a98-0f23-11e5-9abf-0a95648eeb58	6a0b8c76-0f23-11e5-b3f9-0a95648eeb58	\N	\N	\N	2015-06-10 05:47:28.630804+02	2015-10-02 15:16:34.175732+02	https://d2j29n432zojb.cloudfront.net/6a226860-0f23-11e5-9925-4f9d43f10013.jpg	USD	5000	{https://d2j29n432zojb.cloudfront.net/6a226860-0f23-11e5-9925-4f9d43f10013.jpg}	47867079	5000	\N	\N	Active	\N	12184519			None	\N		15506724	HREA01	Hopkins Realty & Assoc. LLC	(972) 291-5475	Closing/Funding	-1				-1				-1				15522439	(214) 566-6113	Patdouglas88@gmail.com	Patricia D. Douglas, Gri	0334502	-1					-1					-1					Exclusive Right to Sell/Lease				Expired	DALLAS EAST (12)	EAST DALLAS (11)	North Texas Real Estate Information Systems		t	t	t	\N	2015-07-23 18:27:27.813+02		Go Show-No Appt. Necessary		W G BOWLINGS BLK 2438 LT 20 VO						None	00000	\N	\N		0	0	\N	\N	\N	$200	0%	2014-07-22 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
2b4fb172-bb2d-11e5-b859-f23c91c841bd	2adae04a-bb2d-11e5-b859-f23c91c841bd	\N	\N	\N	2016-01-15 03:10:37.922399+01	2016-01-15 03:10:37.922399+01	\N	USD	107100	\N	49605397	107100	\N	\N	Expired	\N	13006298			None	\N		15514583	WLLR01	Waller Group LLC	(214) 736-1500	Closing/Funding	-1				-1				-1				15551882		calljaetoday@gmail.com	Jeanie Nixon	0523717	-1					-1					-1					Exclusive Right to Sell/Lease				Active	DALLAS SOUTHEAST (13)	SOUTHEAST DALLAS (5)	North Texas Real Estate Information Systems		t	t	t	2014-08-21 22:34:35.197+02	2014-08-29 07:10:19.813+02		Combo Lock Box,Contact Agent		RUSTIC HILLS REV BLK H/6260 LOT 19B AT EZCEKEL INT		For Sale				Combo	0000000	\N	\N		0	\N	\N	\N	\N	2.5%	0%	2014-08-21 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
c87dc3aa-ba9f-11e5-bb20-f23c91c841bd	c8266a92-ba9f-11e5-bb20-f23c91c841bd	\N	\N	\N	2016-01-14 10:18:33.091459+01	2016-01-14 10:18:33.091459+01	\N	USD	95000	\N	49874310	149999	99500	\N	Expired	\N	13014354			Voluntary	\N	Cash,Conventional,Owner Carry First,Owner Carry Second	15506558	HMRE01	Harvard Companies, Inc	(214) 373-0007	Closing/Funding	-1				-1				-1				15575012	(214) 609-2555	jwilliams@harvardco.com	Babloo J. Williams	0617127	-1					-1					-1					Exclusive Right to Sell/Lease				Active	DALLAS EAST (12)	EAST DALLAS (12)	North Texas Real Estate Information Systems		t	t	t	2014-10-28 23:47:59.43+01	2014-12-01 07:11:54.877+01		Go Show-No Appt. Necessary		JUNIUS HEIGHTS BLK 17/1657 LT 15 INT20070275035 DD						None	0000	\N	\N		0	\N	\N	\N	\N	3%	3%	2014-09-05 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
fe815324-ba52-11e5-acec-f23c91c841bd	fe2ee120-ba52-11e5-acec-f23c91c841bd	\N	\N	\N	2016-01-14 01:08:52.463542+01	2016-01-14 01:08:52.463542+01	\N	USD	309900	\N	50547026	325000	319900	\N	Expired	314	13035093	Monthly	Blanket Insurance,Exterior Maintenance,Full Use of Facilities,Maintenance of Common Areas,Management Fees,Other,Reserves,Security,Sprinkler System,Trash,Water/Sewer	Mandatory	\N	Cash,Conventional	15502855	CBRB49	Coldwell Banker Residential	(214) 828-4300	Negotiable	-1				-1				-1				15522681	(214) 769-4322	philipwalkergroup@gmail.com	Philip W. Walker, Rebac	0339357	-1					-1					-1					Exclusive Right to Sell/Lease				Temp Off Market	DALLAS OAK LAWN (17)	OAKLAWN (11)	North Texas Real Estate Information Systems		t	f	t	2014-11-15 00:40:27.837+01	2015-02-01 07:11:46.92+01		Centralized Showing Service		BEAT AT THE SOUTH SIDE STATION BLK A/420 LT 1 ACS		For Sale				Blue iBox	0	\N	\N		0	\N	\N	\N	\N	3%	0%	2014-10-12 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
84dc7690-ba8c-11e5-a6ab-f23c91c841bd	84730ae8-ba8c-11e5-a6ab-f23c91c841bd	\N	\N	\N	2016-01-14 08:00:39.188878+01	2016-01-14 08:00:39.188878+01	\N	USD	1350	\N	50557280	1450	1450	\N	Expired	\N	13035402	Monthly		Mandatory	\N		15507965	KWPC01	Keller Williams - Park Cities	(214) 526-4663		-1				-1				-1				15574160	(214) 673-4049	chunilu@kw.com	Chuni Lu	0613647	-1					-1					-1					Exclusive Right to Sell/Lease		Move-in 5	2014-10-15T00:00:00.000	Active	DALLAS EAST (12)	EAST DALLAS (11)	North Texas Real Estate Information Systems		t	f	t	2014-12-03 16:47:49.643+01	2014-12-15 18:31:29.947+01		Centralized Showing Service,Go - Key Box,No Sign on Lot		ASCOT PLACE CONDOS BLK X/1861		For Lease	www.propertypanorama.com/mls.asp?id=217071			Blue iBox	12345	\N	\N		1350	\N	\N	\N	\N	50%	0%	2014-10-15 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
eb7c4f64-ba2e-11e5-af60-f23c91c841bd	eb3c8adc-ba2e-11e5-af60-f23c91c841bd	\N	\N	\N	2016-01-13 20:50:38.671595+01	2016-01-13 20:50:38.671595+01	\N	USD	9000	\N	50633269	9000	\N	\N	Expired	270	13037698	Quarterly		Voluntary	\N		15508309	LLLS01	Lucas Luxury Leasing & Sales	(972) 380-5100		-1				-1				-1				15519525	(214) 704-0803	lucasll@swbell.net	Mary Jill Crowder Lucas	0263154	-1					-1					-1					ER with Reservations		On execution	2015-03-20T00:00:00.000	Active	DALLAS NORTH (11)	NORTH DALLAS (12)	North Texas Real Estate Information Systems		t	t	t	\N	2015-03-16 06:10:59.68+01		Call-Key Box,Contact Agent,Special		LANSDOWNE ESTS BLK 8/5570 BLK 8/5570 LT 6 ROCKBROO		For Sale/Lease				None	0	\N	\N		9000	\N	\N	\N	\N	40%	40%	2014-10-17 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
f654b158-ba9a-11e5-87de-f23c91c841bd	f5ee1bdc-ba9a-11e5-87de-f23c91c841bd	\N	\N	\N	2016-01-14 09:44:02.513906+01	2016-01-14 09:44:02.513906+01	\N	USD	869999	\N	50791870	869999	\N	\N	Sold	\N	13043152			Voluntary	\N		38468685	BRIG06	Briggs Freeman Sotheby's	(214) 351-7100	Closing/Funding,Negotiable	-1				38468685	BRIG06	Briggs Freeman Sotheby's	(214) 351-7100	-1				15576376	(214) 563-5986	kelley@teamwhiteside.com	Kelley Mcmahon	0622347	-1					15572103	(469) 867-1734	lauren.valek@gmail.com	Lauren Farris	0604014	-1					Exclusive Right to Sell/Lease				Pending	DALLAS EAST (12)	EAST DALLAS (7)	North Texas Real Estate Information Systems		t	f	t	2014-10-27 17:16:44.083+01	2014-12-03 17:58:25.72+01		Centralized Showing Service		LAKEWOOD ESTATES BLK 9/2975 LOT 4 INT201400076542		For Sale				Gray AEII	0	2014-12-02 01:00:00+01	860000		0	\N	\N	\N	\N	3%	0%	2014-10-27 06:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
7c0307a4-ba9c-11e5-b276-f23c91c841bd	7bbb9658-ba9c-11e5-b276-f23c91c841bd	\N	\N	\N	2016-01-14 09:54:56.289943+01	2016-01-14 09:54:56.289943+01	\N	USD	460000	\N	50830245	460000	\N	\N	Sold	\N	13044345			Voluntary	\N	Cash,Conventional,FHA,VA	15500889	ABAR01	Allie Beth Allman & Assoc.	(214) 521-7355	Closing/Funding	-1				15510834	PRUD22	Berkshire HathawayHS PenFed TX	(214) 257-1111	-1				15516025	(214) 762-2108	marsue@williamsrealtor.com	Marsue Williams	0131461	-1					15532736	(214) 675-5350	cynthia@thenumber1agent.com	Cynthia Paine Drennan	0456378	-1					Exclusive Right to Sell/Lease				Pending	DALLAS EAST (12)	EAST DALLAS (11)	North Texas Real Estate Information Systems		t	f	t	\N	2014-12-02 21:14:22.76+01		Agent Or Owner Present,Centralized Showing Service		MUNGER PLACE BLK K/689 LT 8 INT200503541603 DD1003		For Sale				Blue iBox	0000	2014-12-08 01:00:00+01	436000		0	\N	\N	\N	\N	3%	0%	2014-10-20 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
61a1312e-ba74-11e5-8082-f23c91c841bd	61315caa-ba74-11e5-8082-f23c91c841bd	\N	\N	\N	2016-01-14 05:07:52.158962+01	2016-01-14 05:07:52.158962+01	\N	USD	339000	\N	51177813	339000	\N	\N	Expired	137	13056186	Monthly	Blanket Insurance,Exterior Maintenance,Maintenance of Common Areas,Management Fees,Reserves,Sprinkler System,Trash,Water/Sewer	Mandatory	\N	Cash,Conventional	15502855	CBRB49	Coldwell Banker Residential	(214) 828-4300	Closing/Funding	-1				-1				-1				15529917	(214) 674-8714	richardschalij@yahoo.com	Richard Schalij	0441123	-1					-1					-1					Exclusive Right to Sell/Lease				Active Option Contract	DALLAS EAST (12)	EAST DALLAS (11)	North Texas Real Estate Information Systems		t	f	t	2014-11-19 01:48:55.42+01	2015-01-02 20:07:09.673+01		Agent Or Owner Present,Special				For Sale				None	0000000	\N	\N		0	\N	\N	\N	\N	5%	0%	2014-11-19 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
ca9be44a-ba5f-11e5-a555-f23c91c841bd	ca2dd3f6-ba5f-11e5-a555-f23c91c841bd	\N	\N	\N	2016-01-14 02:40:28.853254+01	2016-01-14 02:40:28.853254+01	\N	USD	450000	\N	51490207	450000	\N	\N	Sold	\N	13065448			None	\N	Cash,Conventional,FHA	15504638	EBBY20	Ebby Halliday, REALTORS	(214) 692-0000	Closing/Funding	-1				38468685	BRIG06	Briggs Freeman Sotheby's	(214) 351-7100	-1				15579568	(713) 299-1546	jessicawantz@ebby.com	Jessica Wantz	0635021	-1					15576376	(214) 563-5986	kelley@teamwhiteside.com	Kelley Mcmahon	0622347	-1					Exclusive Right to Sell/Lease				Pending	DALLAS EAST (12)	EAST DALLAS (6)	North Texas Real Estate Information Systems		t	f	t	\N	2015-01-21 16:26:31.343+01		Centralized Showing Service				For Sale				Blue iBox	0000	2015-01-19 01:00:00+01	430000		0	\N	\N	\N	\N	3%	0%	2014-12-12 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
edb5195a-f7ec-11e4-bc76-0a95648eeb58	e88fac6a-f7ec-11e4-b318-0a95648eeb58	\N	\N	\N	2015-05-11 16:49:30.035252+02	2015-08-03 22:43:19.795186+02	https://d2j29n432zojb.cloudfront.net/5f2a92cb-a31e-4ce8-8218-3dd6f43cf7b0.jpg	USD	498000	{https://d2j29n432zojb.cloudfront.net/5f2a92cb-a31e-4ce8-8218-3dd6f43cf7b0.jpg,https://d2j29n432zojb.cloudfront.net/39749348-731b-4e95-a08f-00385040fa3d.jpg,https://d2j29n432zojb.cloudfront.net/6c1ebae6-3d70-4f0b-ae6a-84e348909073.jpg,https://d2j29n432zojb.cloudfront.net/715a1455-0043-45bb-852e-dd2cbeb12802.jpg,https://d2j29n432zojb.cloudfront.net/d5b1f999-a464-4e21-94eb-4c86aee01415.jpg,https://d2j29n432zojb.cloudfront.net/cafc5997-b43d-4c2d-b9d5-cf102fa74845.jpg,https://d2j29n432zojb.cloudfront.net/8d864141-3ed5-4d39-94a2-3c31a428be6d.jpg,https://d2j29n432zojb.cloudfront.net/54db3b2b-feb4-434c-8db3-288214d1203a.jpg,https://d2j29n432zojb.cloudfront.net/dcc2cdfe-88c9-4bbb-99f2-0fbf7082e96b.jpg,https://d2j29n432zojb.cloudfront.net/3f161f09-881e-4fc2-aff6-61f7da78ec30.jpg,https://d2j29n432zojb.cloudfront.net/41dafcb8-86db-4957-9fdc-cc764cc36f28.jpg,https://d2j29n432zojb.cloudfront.net/4860e023-b83f-47bf-8858-4979f94d589a.jpg,https://d2j29n432zojb.cloudfront.net/6a051a1a-9028-485c-ac52-a61d7c11482a.jpg,https://d2j29n432zojb.cloudfront.net/511bfcb2-c9b3-4735-b400-e4a06465ba8b.jpg,https://d2j29n432zojb.cloudfront.net/0d4434b4-1338-45aa-ae56-7162b4e000e1.jpg,https://d2j29n432zojb.cloudfront.net/ac24ff84-43b6-49ac-9f4e-ed1bc7fb6e38.jpg,https://d2j29n432zojb.cloudfront.net/212ed40c-64b2-42a7-9871-70439f7d6980.jpg,https://d2j29n432zojb.cloudfront.net/aa3247bf-b00d-4b03-b901-1f11dae668cf.jpg,https://d2j29n432zojb.cloudfront.net/bb621009-ee31-4ff1-849a-b5fa83c43dbb.jpg,https://d2j29n432zojb.cloudfront.net/81cd9c7d-e978-46c2-8993-6e6c402107a6.jpg,https://d2j29n432zojb.cloudfront.net/95007d0c-b156-453d-bc8b-263769e8e44a.jpg,https://d2j29n432zojb.cloudfront.net/8ebad726-8dc2-4695-b7e0-d0cbf43e011e.jpg,https://d2j29n432zojb.cloudfront.net/09a96880-842a-435c-8a07-31f65575e81b.jpg,https://d2j29n432zojb.cloudfront.net/884d2aa7-f7d5-41a3-a582-b266c5c572ff.jpg,https://d2j29n432zojb.cloudfront.net/86102fb3-2f29-4218-b381-60f4f5256602.jpg,https://d2j29n432zojb.cloudfront.net/fd04b10d-23e4-42a7-86e9-0a2f1822c526.jpg}	52656456	519000	519000	\N	Sold	\N	13103256			Voluntary	\N	Cash,Conventional	15514377	WBSHRT01	Skylark Realtors	(972) 965-6518	Closing/Funding	0				15510668	PRGRP01	Premier Group, REALTORS	(214) 944-4444	0				15555015	(972) 965-6518	anna@skylarkrealtors.com	Anna K. Short	0534782	15515828	(972) 212-9954		William B. Short Jr.	0120894	15525897	(214) 908-9008	ladshomes@aol.com	Leeann Derdeyn	0398378	0					Exclusive Right to Sell/Lease				Pending	DALLAS EAST (12)	EAST DALLAS (11)	North Texas Real Estate Information Systems		t	t	t	2015-03-26 11:46:33.87+01	2015-08-03 17:28:20.083+02		Appointment (Appt Svc only),Centralized Showing Service	Historical			For Sale				Blue iBox	51950330	2015-05-08 02:00:00+02	478000		0	25	\N	\N	\N	3%	0%	2015-03-01 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
05b2235a-325c-11e5-b020-0a995b070205	ff95786e-325b-11e5-b020-0a995b070205	\N	\N	\N	2015-07-25 01:30:51.860274+02	2015-08-31 21:48:26.939361+02	https://d2j29n432zojb.cloudfront.net/0325ff30-325c-11e5-baf6-9d18af1893e7.jpg	USD	327500	{https://d2j29n432zojb.cloudfront.net/0325ff30-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/0326e990-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/03267460-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/03275ec1-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/03267461-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/0326c280-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/032785d0-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/03269b72-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/03264d50-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/03262641-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/03269b71-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/03275ec0-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/032710a2-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/0326e991-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/03262642-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/032737b1-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/0326c281-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/0326e992-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/032710a0-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/03262640-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/03269b70-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/032737b2-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/032737b0-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/03267462-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/03264d51-325c-11e5-baf6-9d18af1893e7.jpg,https://d2j29n432zojb.cloudfront.net/032710a1-325c-11e5-baf6-9d18af1893e7.jpg}	55789812	327500	\N	\N	Sold	145	13201098	Monthly	Full Use of Facilities,Maintenance of Common Areas,Management Fees,Other	Mandatory	6664	Cash,Conventional,FHA	15502750	CBAP04	Coldwell Banker Apex	(972) 783-1919	Negotiable	0				15502750	CBAP04	Coldwell Banker Apex	(972) 783-1919	0				15554135	(214) 675-6161	tracy@tracymccord.com	Tracy A. Germansen Mccord Epro Abr	0531722	0					15554135	(214) 675-6161	tracy@tracymccord.com	Tracy A. Germansen Mccord Epro Abr	0531722	0					Exclusive Right to Sell/Lease				Pending	ADDISON/FAR NORTH DALLAS AREA (10)	ADDISON (4)	North Texas Real Estate Information Systems		t	t	t	\N	2015-08-31 16:45:07.93+02		Appointment Service		HIGHLAND CREEK MANOR (CDA), BLK 25/8734, LOT 20		For Sale			2015-07-31T00:00:00.000	Blue iBox	10	2015-08-31 02:00:00+02	323750		0	25	\N	\N	\N	3%	0%	2015-07-24 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
6be9e5ac-3317-11e5-92b3-0a995b070205	68f779d6-3317-11e5-92b3-0a995b070205	\N	\N	\N	2015-07-25 23:52:19.241918+02	2015-09-18 16:32:52.506936+02	https://d2j29n432zojb.cloudfront.net/69a69f60-3317-11e5-a475-e527e7c2b32a.jpg	USD	119900	{https://d2j29n432zojb.cloudfront.net/69a69f60-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a762b0-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a7d7e1-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a6ed81-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a7b0d0-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a71492-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a7d7e0-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a73ba1-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a71490-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a762b1-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a762b2-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a7b0d2-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a7fef0-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a73ba0-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a789c2-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a789c0-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a6ed80-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a6c670-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a789c1-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a71491-3317-11e5-a475-e527e7c2b32a.jpg,https://d2j29n432zojb.cloudfront.net/69a7b0d1-3317-11e5-a475-e527e7c2b32a.jpg}	55864068	119900	\N	\N	Sold	\N	13203165			Voluntary	2488	Cash,Conventional,FHA,VA	15510364	PEMR01	Legacy Premier Group	(972) 346-3202	Closing/Funding	0				15506790	HSPR01	Home Smart Premier	(817) 591-4322	0				15541238	(469) 446-4177	rebecca@1plusrealty.com	Rebecca Cucovatz	0487702	0					15546186	(214) 727-5894	helendhamilton@sbcglobal.net	Helen D. Hamilton	0504186	0					Exclusive Right to Sell/Lease				Pending	DALLAS EAST (12)	EAST DALLAS (10)	North Texas Real Estate Information Systems		t	f	t	2015-07-25 18:51:49.757+02	2015-09-18 11:30:51.27+02		Centralized Showing Service		BRAEBURN GLEN 3 REV BLK K/8571 LT 28A INT 20100019		For Sale			2015-08-11T00:00:00.000	Blue iBox	9999	2015-09-18 02:00:00+02	120000		0	20	\N	\N	\N	3%	0%	2015-07-25 07:00:00+02	\N	\N	\N	\N	\N	\N	\N	\N	\N
3a603d2a-9eb9-11e5-a82d-f23c91c841bd	34bec076-9eb9-11e5-a82d-f23c91c841bd	\N	\N	\N	2015-12-09 22:10:09.018251+01	2016-02-02 18:13:18.435699+01		USD	450000	{}	58544147	500000	500000	\N	Active	1004	13286681	Monthly	Blanket Insurance,Exterior Maintenance,Full Use of Facilities,Management Fees,Reserves,Security,Sprinkler System,Trash,Water/Sewer	Mandatory	\N	Cash,Conventional,FHA,Texas Vet,VA	15502343	BRIG01	Briggs Freeman Sotheby's Int'l	(214) 350-0400	Closing/Funding	-1				-1				-1				15550317	(214) 564-0234	mwood@briggsfreeman.com	Michelle Wood	0518219	-1					-1					-1					Exclusive Right to Sell/Lease				Active Option Contract	DALLAS OAK LAWN (17)	OAKLAWN (11)	North Texas Real Estate Information Systems		t	f	t	2016-02-02 18:09:51.487+01	2016-02-02 18:09:51.487+01		Appointment (Appt Svc only),Centralized Showing Service,Key in Office		BLOCK C SOUTH TOWER RESIDENCES BLK J/384 LT 11A AC		For Sale/Lease		http://www.propertypanorama.com/instaview/ntreis/13286681		None	0	\N	\N		0	12	\N	\N	\N	3%	0%	2015-12-09 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
8e6d1eea-9ecf-11e5-8199-f23c91c841bd	8d4008de-9ecf-11e5-8199-f23c91c841bd	\N	\N	\N	2015-12-10 00:49:58.959327+01	2016-01-04 15:53:42.617691+01		USD	265000	{}	58545058	265000	\N	\N	Active	522	13286709	Monthly	Back Yard Maintenance,Blanket Insurance,Full Use of Facilities,Gas,Maintenance of Common Areas,Management Fees,Reserves,Security,Sprinkler System,Trash,Water/Sewer	Mandatory	\N		15504414	DPMA04	Dave Perry Miller Real Estate	(214) 522-3838	Closing/Funding	-1				-1				-1				15521399	(469) 774-9749	steve@daveperrymiller.com	Stephen Collins	0312326	-1					-1					-1					Exclusive Right to Sell/Lease				Unknown	UNIVERSITY PARK/HIGHLAND PARK AREA (25)	UNIVERSITY PARK/HIGHLAND PARK (15)	North Texas Real Estate Information Systems		t	f	t	\N	2016-01-04 15:52:14.733+01		Appointment Service,Centralized Showing Service,Go (Appt Svc Only),Key in Office		CRESTPARK IN HIGHLAND PARK CONDO CRESTPARK WESTPK		For Sale		http://www.propertypanorama.com/instaview/ntreis/13286709		None	0000	\N	\N		0	25	\N	\N	\N	3%	0%	2015-12-09 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
58a718e4-9f54-11e5-a0f8-f23c91c841bd	578b93e0-9f54-11e5-a0f8-f23c91c841bd	\N	\N	\N	2015-12-10 16:40:31.807568+01	2015-12-13 22:56:34.634125+01		USD	999000	{}	58554075	999990	999990	\N	Active	1649	13286938	Monthly	Exterior Maintenance,Front Yard Maintenance,Full Use of Facilities,Maintenance of Common Areas,Management Fees,Other,Partial Use of Facilities,Reserves	Mandatory	16343	Cash,Conventional	15502343	BRIG01	Briggs Freeman Sotheby's Int'l	(214) 350-0400	Closing/Funding	-1				-1				-1				15525913	(214) 750-9300	martin.stevenson50@gmail.com	Martin Stevenson	0398556	15515799	(214) 750-9300	dmahoney@briggsfreeman.com	Daniel Mahoney	0118982	-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (11)	North Texas Real Estate Information Systems		t	f	t	2015-12-13 21:57:15.463+01	2015-12-13 22:53:36.693+01		Call-Key Box		BLOCK C CONDOMINIUMS BLK J/384 LT 11A ACS 1.648 UN		For Sale		http://www.propertypanorama.com/instaview/ntreis/13286938		None	0	\N	\N		0	13	\N	\N	\N	3%	0%	2015-12-10 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
d4e99ca0-a40f-11e5-a8b8-f23c91c841bd	cd907dc0-a40f-11e5-a8b8-f23c91c841bd	\N	\N	\N	2015-12-16 17:12:40.820393+01	2016-02-08 18:33:11.870143+01	https://d2j29n432zojb.cloudfront.net/d468f0a0-a40f-11e5-851c-d9febffe7e69.jpg	USD	725000	{https://d2j29n432zojb.cloudfront.net/d469db00-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d46a5030-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d46ac560-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d46b1380-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d46bafc0-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d46bfde0-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d46cc130-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d46d3660-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d46dab90-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d46e20c0-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d46e95f0-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d46f3230-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d46fa760-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d4701c90-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d4706ab0-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d470dfe0-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d4715510-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d4717c20-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d471ca40-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d471f150-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d4723f70-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d4726680-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d4728d90-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d472dbb0-a40f-11e5-851c-d9febffe7e69.jpg,https://d2j29n432zojb.cloudfront.net/d47329d0-a40f-11e5-851c-d9febffe7e69.jpg}	58615835	725000	\N	\N	Active	1444	13288625	Monthly	Back Yard Maintenance,Blanket Insurance,Exterior Maintenance,Front Yard Maintenance,Full Use of Facilities,Maintenance of Common Areas,Management Fees,Reserves,Sprinkler System,Trash	Mandatory	8594		15500889	ABAR01	Allie Beth Allman & Assoc.	(214) 521-7355	Negotiable	-1				-1				-1				15572121	(972) 896-5432	ani.nosnik@alliebeth.com	Ani Nosnik	0604095	-1					-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (8)	North Texas Real Estate Information Systems		t	f	t	\N	2016-02-08 18:31:27.14+01		Appointment (Appt Svc only)		DREXEL HIGHLANDER CONDOMINIUMS BLK 13/2028 LOT 12B		For Sale/Lease		http://www.propertypanorama.com/instaview/ntreis/13288625		None	none	\N	\N		0	25	\N	\N	\N	3%	3%	2015-12-14 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
5a96928a-a50b-11e5-89c6-f23c91c841bd	5927d1ca-a50b-11e5-89c6-f23c91c841bd	\N	\N	\N	2015-12-17 23:13:08.769907+01	2016-01-03 14:01:25.853641+01	https://d2j29n432zojb.cloudfront.net/59e96740-a50b-11e5-ba39-61a7f6fd08c1.jpg	USD	719000	{https://d2j29n432zojb.cloudfront.net/59ea0380-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59ea78b0-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59eac6d0-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59eb14f0-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59eb6310-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59ebb130-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59ebff50-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59ec4d70-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59ec9b90-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59ece9b0-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59ed37d0-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59ed85f0-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59edad00-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59edfb20-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59ee4940-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59ee9760-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59eee580-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59ef33a0-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59efa8d0-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59eff6f0-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59f04510-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59f09330-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59f0e150-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59f12f70-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59f17d90-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59f1cbb0-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59f219d0-a50b-11e5-ba39-61a7f6fd08c1.jpg,https://d2j29n432zojb.cloudfront.net/59f267f0-a50b-11e5-ba39-61a7f6fd08c1.jpg}	58665269	719000	\N	\N	Active	1650	13290014	Monthly	Blanket Insurance,Exterior Maintenance,Full Use of Facilities,Maintenance of Common Areas,Management Fees,Security,Sprinkler System,Trash,Water/Sewer	Mandatory	17481	Cash,Conventional	15510834	PRUD22	Berkshire HathawayHS PenFed TX	(214) 257-1111	Closing/Funding,Specific Date	-1				-1				-1				15559454	(214) 298-9547	pamyp@aol.com	Pamela Bruck	0551150	-1					-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (8)	North Texas Real Estate Information Systems		t	f	t	\N	2016-01-03 14:00:02.79+01		Centralized Showing Service		DREXEL HIGHLANDER CONDOMINIUMS BLK 13/2028 LT 12B		For Sale	www.vrguild.net/c/star.pl?Q=1512090914113594	www.vrguild.net/c/star.pl?Q=1512090914113594		None	0000	\N	\N		0	28	\N	\N	\N	3%	0%	2015-12-17 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
7e84d768-a814-11e5-8e1e-f23c91c841bd	7bf304c0-a814-11e5-8e1e-f23c91c841bd	\N	\N	\N	2015-12-21 19:56:08.010878+01	2016-01-22 17:02:53.467694+01	https://d2j29n432zojb.cloudfront.net/7e35b750-a814-11e5-bb6b-37fb6f9eff61.jpg	USD	399900	{https://d2j29n432zojb.cloudfront.net/7e362c80-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e36a1b0-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e36efd0-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e376500-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e37da30-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e382850-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e389d80-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e38eba0-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e3939c0-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e3987e0-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e39fd10-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e3a4b30-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e3ac060-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e3b3590-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e3bf8e0-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e3c4700-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e3ce340-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e3d7f80-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e3df4b0-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e3e42d0-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e3eb800-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e3f2d30-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e3f7b50-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e3fc970-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e403ea0-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e408cc0-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e40dae0-a814-11e5-bb6b-37fb6f9eff61.jpg,https://d2j29n432zojb.cloudfront.net/7e412900-a814-11e5-bb6b-37fb6f9eff61.jpg}	58705917	399900	\N	\N	Active	654	13291126	Monthly	Blanket Insurance,Exterior Maintenance,Full Use of Facilities,Gas,Maintenance of Common Areas,Management Fees,Reserves,Security,Trash,Water/Sewer	Mandatory	6786	Conventional	15511745	ROGE01	Rogers Healy and Associates	(214) 368-4663	Closing/Funding	-1				-1				-1				15547906	(469) 363-6992	intownsteve@gmail.com	Steven Rigely	0509679	-1					-1					-1					Exclusive Agency				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (11)	North Texas Real Estate Information Systems		t	f	t	\N	2016-01-22 03:32:34.763+01		Centralized Showing Service		BLOCK C CONDOMINIUMS BLK J/384 LT 11A ACS 1.648 UN		For Sale		http://www.propertypanorama.com/instaview/ntreis/13291126		None	N/A	\N	\N		0	28	\N	\N	\N	3%	0%	2015-12-21 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
033840ba-a9c0-11e5-8893-f23c91c841bd	02f86300-a9c0-11e5-8893-f23c91c841bd	\N	\N	\N	2015-12-23 22:56:25.749112+01	2016-02-08 18:38:39.212386+01	\N	USD	599990	\N	58731414	599990	\N	\N	Active	1367	13291847	Monthly	Back Yard Maintenance,Blanket Insurance,Exterior Maintenance,Front Yard Maintenance,Full Use of Facilities,Management Fees,Reserves,Trash	Mandatory	\N		15500889	ABAR01	Allie Beth Allman & Assoc.	(214) 521-7355	Closing/Funding	-1				-1				-1				15572121	(972) 896-5432	ani.nosnik@alliebeth.com	Ani Nosnik	0604095	-1					-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (8)	North Texas Real Estate Information Systems		t	f	t	\N	2016-02-08 18:33:51.33+01		Centralized Showing Service		DREXEL HIGHLANDER CONDOMINIUMS BLK 13/2028 LT 12B		For Sale/Lease		http://www.propertypanorama.com/instaview/ntreis/13291847		None	0	\N	\N		0	\N	\N	\N	\N	3%	0%	2015-12-23 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
52f2ba0a-af4b-11e5-a878-f23c91c841bd	4f83785a-af4b-11e5-a878-f23c91c841bd	\N	\N	\N	2015-12-31 00:16:15.370985+01	2016-02-10 06:05:22.878654+01	\N	USD	695000	\N	58804924	695000	\N	\N	Active	\N	13293473			None	12012		15504411	DPMA01	Dave Perry Miller Real Estate	(214) 369-6000	60-90 Days	-1				-1				-1				15526519	(214) 532-7331	lance@daveperrymiller.com	Lance Hancock	0407068	-1					-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (8)	North Texas Real Estate Information Systems		t	f	t	\N	2016-02-10 06:00:13.63+01		Call-Key Box		PERRY HOMES WYCLIFF BLK 7/2025 LT 6A INT2006001712		For Sale		http://www.propertypanorama.com/instaview/ntreis/13293473		Combo	00000	\N	\N		0	\N	\N	\N	\N	3%	0%	2015-12-30 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
7fd296ce-b326-11e5-9d3c-f23c91c841bd	7f8f0864-b326-11e5-9d3c-f23c91c841bd	\N	\N	\N	2016-01-04 22:02:43.929389+01	2016-02-15 19:43:43.419339+01	\N	USD	279900	\N	58870994	309500	309500	\N	Active	515	13294778	Monthly	Blanket Insurance,Exterior Maintenance,Full Use of Facilities,Management Fees,Trash	Mandatory	4738	Cash,Conventional	15506603	HOII01	H&O Investments, Inc	(972) 983-7500	Closing/Funding,Negotiable	-1				-1				-1				15541365	(972) 983-7500	jessica@ho-investments.com	Jessica Hernandez	0488148	-1					-1					-1					Exclusive Right to Sell/Lease				Active Option Contract	DALLAS OAK LAWN (17)	OAKLAWN (11)	North Texas Real Estate Information Systems		t	t	t	2016-01-30 20:14:33.47+01	2016-02-15 19:42:41.407+01		Appointment Service,Centralized Showing Service		BLKS F&H MASTER TERRACE CONDOS BLK F/389 LT 4A.2 A		For Sale		http://www.propertypanorama.com/instaview/ntreis/13294778		None	000000	\N	\N		0	\N	\N	\N	\N	2.5%	0%	2016-01-04 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
0c6138c8-b49b-11e5-a450-f23c91c841bd	0c0416d4-b49b-11e5-a450-f23c91c841bd	\N	\N	\N	2016-01-06 18:29:32.529036+01	2016-01-27 20:35:43.574446+01	\N	USD	85000	\N	58900413	85000	\N	\N	Sold	\N	13296395			None	\N	Cash,Conventional	15504633	EBBY16	Ebby Halliday, REALTORS	(972) 296-0110	Closing/Funding	-1				15509853	NMLS00NM	NON MLS	(999) 999-9999	-1				15576460	(214) 763-8735	kathygoen@ebby.com	Kathy Goen	0622712	-1					15583813			Non-Mls Member	99999999	-1					Exclusive Right to Sell/Lease				Pending	DALLAS NORTH OAK CLIFF (14)	OAKCLIFF (10)	North Texas Real Estate Information Systems		t	f	t	\N	2016-01-27 20:32:49.85+01		Agent Or Owner Present				For Sale			2016-01-09T00:00:00.000	None	000000	2016-01-26 01:00:00+01	76500		0	\N	\N	\N	\N	3%	0%	2015-12-04 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
73525c44-b48a-11e5-b2ad-f23c91c841bd	732ff23a-b48a-11e5-b2ad-f23c91c841bd	\N	\N	\N	2016-01-06 16:30:43.792258+01	2016-01-14 15:04:38.694036+01	\N	USD	255900	\N	58913859	255900	\N	\N	Active	276	13296809	Monthly	Blanket Insurance,Exterior Maintenance,Maintenance of Common Areas,Management Fees,Reserves,Sprinkler System,Trash,Water/Sewer	Mandatory	\N	Conventional	15501143	ALCK01	Al Coker & Associates, L.L.C.	(214) 443-9300	Closing/Funding	-1				-1				-1				15521053	(214) 443-9300	alcoker@alcoker.com	Al Coker	0303273	54551720		francisco@alcoker.com	Jose Rizo	0650688	-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (7)	North Texas Real Estate Information Systems		t	f	t	2016-01-06 16:30:31.793+01	2016-01-14 14:57:33.83+01		Go - Key Box				For Sale		http://www.propertypanorama.com/instaview/ntreis/13296809		Blue iBox	000000	\N	\N		0	\N	\N	\N	\N	3%	0%	2016-01-06 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
a24c374a-b88b-11e5-9643-f23c91c841bd	a1f16db0-b88b-11e5-9643-f23c91c841bd	\N	\N	\N	2016-01-11 18:49:16.752886+01	2016-01-22 17:04:28.156848+01	\N	USD	550000	\N	58982003	550000	\N	\N	Active	\N	13298916	Monthly	Exterior Maintenance,Maintenance of Common Areas,Management Fees,Sprinkler System	Mandatory	\N	Cash,Conventional	15502343	BRIG01	Briggs Freeman Sotheby's Int'l	(214) 350-0400	Other	-1				-1				-1				15550317	(214) 564-0234	mwood@briggsfreeman.com	Michelle Wood	0518219	-1					-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (8)	North Texas Real Estate Information Systems		t	f	t	\N	2016-01-21 00:14:21.333+01		Appointment (Appt Svc only),Call-Key Box,Centralized Showing Service		DONALD H GALE BLK 9/2045 LT 1A ACS 0.551 VOL200010		For Sale		http://www.propertypanorama.com/instaview/ntreis/13298916		None	0	\N	\N		0	\N	\N	\N	\N	3%	0%	2016-01-11 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
69fb7e54-b88c-11e5-a56f-f23c91c841bd	69d7a2b8-b88c-11e5-a56f-f23c91c841bd	\N	\N	\N	2016-01-11 18:54:51.768002+01	2016-01-22 17:04:28.228473+01	\N	USD	599000	\N	58982074	599000	\N	\N	Active	\N	13298919	Monthly	Exterior Maintenance,Maintenance of Common Areas,Management Fees,Sprinkler System	Mandatory	\N	Cash,Conventional	15502343	BRIG01	Briggs Freeman Sotheby's Int'l	(214) 350-0400	Closing/Funding	-1				-1				-1				15550317	(214) 564-0234	mwood@briggsfreeman.com	Michelle Wood	0518219	-1					-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (8)	North Texas Real Estate Information Systems		t	f	t	2016-01-11 18:53:35.423+01	2016-01-21 00:14:53.31+01		Appointment (Appt Svc only),Call-Key Box,Centralized Showing Service		DONALD H GALE BLK 9/2045 LT 1A ACS 0.551 VOL200010		For Sale		http://www.propertypanorama.com/instaview/ntreis/13298919		None	0	\N	\N		0	\N	\N	\N	\N	3%	0%	2016-01-11 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
33f97c1a-b88d-11e5-9634-f23c91c841bd	335d4106-b88d-11e5-9634-f23c91c841bd	\N	\N	\N	2016-01-11 19:00:30.655114+01	2016-01-22 17:04:28.350358+01	\N	USD	525000	\N	58982325	525000	\N	\N	Active	\N	13298934	Monthly	Exterior Maintenance,Maintenance of Common Areas,Management Fees,Sprinkler System	Mandatory	\N	Cash,Conventional	15502343	BRIG01	Briggs Freeman Sotheby's Int'l	(214) 350-0400	Closing/Funding	-1				-1				-1				15550317	(214) 564-0234	mwood@briggsfreeman.com	Michelle Wood	0518219	-1					-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (8)	North Texas Real Estate Information Systems		t	f	t	\N	2016-01-21 00:15:22.423+01		Appointment (Appt Svc only),Call-Key Box,Centralized Showing Service		DONALD H GALE BLK 9/2045 LT 1A ACS 0.551 VOL200010		For Sale		http://www.propertypanorama.com/instaview/ntreis/13298934		None	0	\N	\N		0	\N	\N	\N	\N	3%	0%	2016-01-11 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
839acca8-ba34-11e5-849e-f23c91c841bd	83676f52-ba34-11e5-849e-f23c91c841bd	\N	\N	\N	2016-01-13 21:30:41.36896+01	2016-02-18 13:14:13.308897+01	\N	USD	479000	\N	59052080	479000	\N	\N	Active	900	13301054	Annual	Maintenance of Common Areas,Management Fees	Mandatory	\N	Cash,Conventional	15502343	BRIG01	Briggs Freeman Sotheby's Int'l	(214) 350-0400	Closing/Funding	-1				-1				-1				15560450	(214) 725-1451	dduvall@briggsfreeman.com	Diane Duvall-Rogers	0555105	-1					-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (8)	North Texas Real Estate Information Systems		t	f	t	\N	2016-02-17 22:51:00.69+01		Centralized Showing Service,Courtesy Call (Appt Svc Only)	Survey Available,Verify Tax Exemptions	HOLLAND AVENUE SEC 2 BLK 7/1579 LT 2C INT201100031		For Sale		http://www.propertypanorama.com/instaview/ntreis/13301054		Blue iBox	0	\N	\N		0	\N	\N	\N	\N	3%	0%	2016-01-13 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
06d1cdc2-be10-11e5-a85f-f23c91c841bd	06b3c6c4-be10-11e5-a85f-f23c91c841bd	\N	\N	\N	2016-01-18 19:19:34.782902+01	2016-01-19 08:04:08.642369+01	\N	USD	575000	\N	59095666	575000	\N	\N	Active	\N	13302285			None	\N		15504414	DPMA04	Dave Perry Miller Real Estate	(214) 522-3838	Closing/Funding,Negotiable,Subject to Lease	-1				-1				-1				15576795	(214) 983-6465	lesli@daveperrymiller.com	Lesli Levine	0624050	15575816	(940) 636-9086	lindsey@daveperrymiller.com	Lindsey Bradley	0620202	-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (8)	North Texas Real Estate Information Systems		t	f	t	\N	2016-01-19 08:00:12.823+01		Centralized Showing Service		NORTH OAK LAWN BLK 5/2043 LT 9 INT201300324704 DD0		For Sale		http://www.propertypanorama.com/instaview/ntreis/13302285		Blue iBox	00000000000000	\N	\N		0	\N	\N	\N	\N	3%	0%	2016-01-18 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
8e3c7b1c-be11-11e5-aac7-f23c91c841bd	8e0ae0a2-be11-11e5-aac7-f23c91c841bd	\N	\N	\N	2016-01-18 19:30:31.47058+01	2016-01-19 08:04:08.643563+01	\N	USD	575000	\N	59096317	575000	\N	\N	Active	\N	13302308			None	\N		15504414	DPMA04	Dave Perry Miller Real Estate	(214) 522-3838	Closing/Funding,Negotiable,Subject to Lease	-1				-1				-1				15576795	(214) 983-6465	lesli@daveperrymiller.com	Lesli Levine	0624050	15575816	(940) 636-9086	lindsey@daveperrymiller.com	Lindsey Bradley	0620202	-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (8)	North Texas Real Estate Information Systems		t	f	t	\N	2016-01-19 08:00:13.293+01		Centralized Showing Service		NORTH OAK LAWN BLK 5/2043 LT 9 INT201300324704 DD0		For Sale		http://www.propertypanorama.com/instaview/ntreis/13302308		Blue iBox	000000000	\N	\N		0	\N	\N	\N	\N	3%	0%	2016-01-18 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
fd2f7bea-be12-11e5-a1cd-f23c91c841bd	fd018b04-be12-11e5-a1cd-f23c91c841bd	\N	\N	\N	2016-01-18 19:40:47.108176+01	2016-01-19 08:04:08.644771+01	\N	USD	500000	\N	59097482	500000	\N	\N	Active	\N	13302339			None	\N		15504414	DPMA04	Dave Perry Miller Real Estate	(214) 522-3838	Closing/Funding,Negotiable,Subject to Lease	-1				-1				-1				15576795	(214) 983-6465	lesli@daveperrymiller.com	Lesli Levine	0624050	15575816	(940) 636-9086	lindsey@daveperrymiller.com	Lindsey Bradley	0620202	-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (8)	North Texas Real Estate Information Systems		t	f	t	\N	2016-01-19 08:00:16.807+01		Centralized Showing Service		NORTH OAK LAWN BLK 5/2043 LT 9 INT201300324704 DD0		For Sale		http://www.propertypanorama.com/instaview/ntreis/13302339		Blue iBox	0000000000000	\N	\N		0	\N	\N	\N	\N	3%	0%	2016-01-18 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
cdaef89c-cb9a-11e5-b4c2-f23c91c841bd	cd920d68-cb9a-11e5-b4c2-f23c91c841bd	\N	\N	\N	2016-02-05 00:55:44.086023+01	2016-02-05 09:02:54.391846+01	\N	USD	7995000	\N	59505817	7995000	\N	\N	Active	8598	13314620	Monthly	Blanket Insurance,Exterior Maintenance,Full Use of Facilities,Management Fees,Trash,Water/Sewer	Mandatory	\N		15500889	ABAR01	Allie Beth Allman & Assoc.	(214) 521-7355	Negotiable	-1				-1				-1				15518461	(972) 380-7750	alliebeth@alliebeth.com	Allie Beth Allman	0229822	-1					-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (11)	North Texas Real Estate Information Systems		t	f	t	\N	2016-02-05 09:00:04.963+01		Agent Or Owner Present,Centralized Showing Service		BLOCK C CONDOMINIUMS BLK J/384		For Sale		http://www.propertypanorama.com/instaview/ntreis/13314620		None	0000	\N	\N		0	\N	\N	\N	\N	2.5%	0%	2016-02-04 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
7ff2fad0-cc63-11e5-913f-f23c91c841bd	7fded1f4-cc63-11e5-913f-f23c91c841bd	\N	\N	\N	2016-02-06 00:52:22.51221+01	2016-02-08 16:09:24.1054+01	\N	USD	1350000	\N	59529693	1350000	\N	\N	Active	1600	13315265	Monthly	Blanket Insurance,Exterior Maintenance,Full Use of Facilities,Maintenance of Common Areas,Management Fees,Security,Trash,Water/Sewer	Mandatory	17874	Cash,Conventional	51886430	CBRB35	Minnette Murray Properties	(214) 521-0044	Closing/Funding	-1				-1				-1				15533485	(214) 850-3172	minnette@minnettemurray.com	Minnette Murray	0459742	-1					-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (11)	North Texas Real Estate Information Systems		t	t	t	\N	2016-02-08 16:04:53.84+01		Agent Or Owner Present,Appointment Service		BLOCK C CONDOMINIUMS BLK J/384 LT 11A ACS 1.648 UN		For Sale		http://www.propertypanorama.com/instaview/ntreis/13315265		None	0000	\N	\N		0	\N	\N	\N	\N	3%	3%	2016-02-05 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
33836686-d0db-11e5-b351-f23c91c841bd	3369d720-d0db-11e5-b351-f23c91c841bd	\N	\N	\N	2016-02-11 17:19:18.532708+01	2016-02-15 06:51:57.884268+01	\N	USD	770000	\N	59616961	770000	\N	\N	Active	1207	13317847	Monthly	Blanket Insurance,Exterior Maintenance,Full Use of Facilities,Maintenance of Common Areas,Management Fees,Reserves,Security,Sprinkler System,Trash,Water/Sewer	Mandatory	11927	Cash,Conventional	15515154	KELL01	Keller Williams Realty DPR	(972) 732-6000	Closing/Funding,Negotiable	-1				-1				-1				15552513	(214) 632-0400	dmlally@yahoo.com	Dawn Lally	0526008	-1					-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (11)	North Texas Real Estate Information Systems		t	t	t	\N	2016-02-15 06:50:26.323+01		Appointment (Appt Svc only),Appointment Service,Centralized Showing Service,Contact Agent		BLOCK C CONDOMINIUMS BLK J/384 LT 11A ACS 1.648 UN		For Sale		http://www.propertypanorama.com/instaview/ntreis/13317847		None	9999999	\N	\N		0	\N	\N	\N	\N	3%	0%	2016-02-11 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
ff96cf30-d36d-11e5-89e7-f23c91c841bd	ff8dd628-d36d-11e5-89e7-f23c91c841bd	\N	\N	\N	2016-02-14 23:55:09.762476+01	2016-02-16 07:05:27.332506+01	\N	USD	649000	\N	59698128	649000	\N	\N	Active	880	13320030	Quarterly	Blanket Insurance,Exterior Maintenance,Front Yard Maintenance,Sprinkler System	Mandatory	\N	Cash,Conventional	15500889	ABAR01	Allie Beth Allman & Assoc.	(214) 521-7355	Specific Date	-1				-1				-1				15517783	(214) 793-1935	kris@krisgravesrealty.com	Kristine Graves	0203647	-1					-1					-1					Exclusive Right to Sell/Lease				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (8)	North Texas Real Estate Information Systems		t	t	t	2016-02-14 23:53:10.917+01	2016-02-16 07:00:07.57+01		Centralized Showing Service				For Sale		http://www.propertypanorama.com/instaview/ntreis/13320030		Blue iBox	0000	\N	\N		0	\N	\N	\N	\N	3.00%	0%	2016-02-13 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
d6d79d92-d41a-11e5-bf12-f23c91c841bd	d6bc050a-d41a-11e5-bf12-f23c91c841bd	\N	\N	\N	2016-02-15 20:32:24.335595+01	2016-02-18 13:17:53.517651+01	\N	USD	739000	\N	59709556	739000	\N	\N	Active	1458	13320337	Monthly	Blanket Insurance,Full Use of Facilities,Maintenance of Common Areas,Management Fees,Reserves,Trash,Water/Sewer	Mandatory	12611		15511745	ROGE01	Rogers Healy and Associates	(214) 368-4663	Closing/Funding	-1				-1				-1				15547906	(469) 363-6992	intownsteve@gmail.com	Steven Rigely	0509679	-1					-1					-1					Exclusive Agency				Unknown	DALLAS OAK LAWN (17)	OAKLAWN (11)	North Texas Real Estate Information Systems		t	f	t	\N	2016-02-17 17:09:26.24+01		Centralized Showing Service		BLOCK C SOUTH TOWER RESIDENCES BLK J/384 LT 11A AC		For Sale		http://www.propertypanorama.com/instaview/ntreis/13320337		None	N/A	\N	\N		0	\N	\N	\N	\N	3%	0%	2016-02-15 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
d0675a2a-c1f4-11e5-9606-f23c91c841bd	cfcf6210-c1f4-11e5-9606-f23c91c841bd	\N	\N	\N	2016-01-23 18:14:51.727859+01	2016-01-23 18:14:51.727859+01	\N	USD	169900	\N	1441103	174900	\N	\N	Sold	\N	9563795		None	None	\N	Cash,Conventional	15504414	DPMA04	Dave Perry-Miller & Associates	(214) 522-3838	Closing/Funding	-1				15507704	KELR02	Keller Williams Realty	(972) 599-7000	-1				15544117	(214) 460-2006	billgilmore@ellenterry.com	Bill Gilmore	0497197	-1					15541378	(214) 538-3386	lscox@kw.com	Lisa Cox	0488185	-1					Exclusive Right to Sell/Lease				Pending	DALLAS EAST (12)	EAST DALLAS (7)	North Texas Real Estate Information Systems		t	t	t	2003-06-16 07:00:00+02	2012-10-05 15:25:25+02		Courtesy Call (Appt Svc Only)				For Sale					0	2003-07-30 02:00:00+02	163500		0	\N	\N	\N	\N	3%	0%	2002-11-01 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
db627ebe-c1f4-11e5-9606-f23c91c841bd	dae2b0d0-c1f4-11e5-9606-f23c91c841bd	\N	\N	\N	2016-01-23 18:15:10.150567+01	2016-01-23 18:15:10.150567+01	\N	USD	299900	\N	1462373	317500	\N	\N	Sold	\N	9614748		None	None	\N	Conventional	15502855	CBRB49	Coldwell Banker Residential	(214) 828-4300	Negotiable	-1				15504636	EBBY19	Ebby Halliday, REALTORS	(972) 387-0300	-1				15521122	(214) 725-5018	john.whiteside62@gmail.com	John Whiteside	0305112	-1					15527473	(214) 728-2533	suzyhotchkiss@ebby.com	Suzanne Hotchkiss	0419047	-1					Exclusive Right to Sell/Lease				Pending	DALLAS EAST (12)	EAST DALLAS (7)	North Texas Real Estate Information Systems		t	t	t	2003-04-07 07:00:00+02	2012-10-05 15:25:35+02		Appointment (Appt Svc only)									0	2003-07-31 02:00:00+02	282000		0	\N	\N	\N	\N	3%	0%	2003-02-22 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
dc2fb5be-c1f4-11e5-9606-f23c91c841bd	dbb1fe44-c1f4-11e5-9606-f23c91c841bd	\N	\N	\N	2016-01-23 18:15:11.495579+01	2016-01-23 18:15:11.495579+01	\N	USD	179900	\N	1463691	182900	\N	\N	Sold	\N	9617831			None	3544		15502862	CBRB55	Coldwell Banker Residential	(214) 521-0044	Negotiable	-1				15515154	KELL01	Keller Williams Realty	(972) 732-6000	-1				15535011	(214) 728-0543	brianramm@sbcglobal.net	Brian Ramm	0465669	-1					15526831	(972) 489-3518	jjrsp@aol.com	Jean Pennant	0411049	-1					Exclusive Right to Sell/Lease				Active Option Contract	DALLAS NORTHWEST (16)	NORTHWEST DALLAS (12)	North Texas Real Estate Information Systems		t	t	t	2003-04-23 07:00:00+02	2012-10-05 15:25:03+02		Courtesy Call (Appt Svc Only)									0	2003-07-02 02:00:00+02	170000		0	\N	\N	\N	\N	3%	3%	2003-03-03 07:00:00+01	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY messages (id, comment, image_url, document_url, video_url, recommendation, author, created_at, updated_at, room, message_type, image_thumbnail_url, deleted_at, notification, reference, mentions) FROM stdin;
\.


--
-- Data for Name: messages_acks; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY messages_acks (id, message, room, "user", created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY migrations (created_at, state) FROM stdin;
2017-04-21 23:23:17.033416+02	["1450892284-migrate-to-migratus.js", "1450892285-add-transaction_type.js", "1450992285-add-transaction-table.js", "1445901432374-index_lot_square_meters.js", "1445993755874-add-deleted_at-to-contacts-table.js", "1446050100836-add-phone_number-to-invitations-table.js", "1446075397352-add-url-to-invitations-table.js", "1446127759888-add-invitee-name-to-invitations-table.js", "1446130519521-making-URL-required.js", "1446131342117-making-room-required-on-invitation_records.js", "1446136879566-drop-unique_room_email-on-invitations_records.js", "1446137023457-drop-unique_room_invited_user-on-invitations_records.js", "1446843945790-add-unique_user_email-to-contacts.js", "1446843954367-add-unique_user_phone-to-contacts.js", "1446896833342-drop-email-not-null-constraint-on-invitation_records.js", "1447206136336-add-Unknown-to-client_type.js", "1447236927402-move-states-to-database.js", "1447293794873-adding-wipe_everything-to-migrations.js", "1447445990411-changing-default-value-for-created_at-on-messages-table.js", "1447446153142-changing-default-value-for-updated_at-on-messages-table.js", "1447626023490-adding-cover_image_url-to-contacts.js", "1447626030028-adding-profile_image_url-to-contacts.js", "1447626041233-adding-invitation_url-to-contacts.js", "1447626049214-adding-company-to-contacts.js", "1447626055840-adding-address-to-contacts.js", "1447626283891-adding-birthday-to-contacts.js", "1447675600966-add-verifications-table.js", "1447675926814-add-phone_verified-to-user-table.js", "1447763766161-add-function-toggle_phone_confirmed.js", "1447763772460-add-trigger-toggle_phone_confirmed-to-users-table.js", "1447784747543-adding-unique-index-on-user-to-verifications.js", "1447838094741-index-address-locations.js", "1447885561989-adding-created_at-to-verifications-table.js", "1447885787290-adding-phone_number-to-verifications-table.js", "1447886025910-rename-verifications-table-to-phone_verifications.js", "1447886153527-rename-index-verifications_user_idx-to-phone_verifications_user_idx.js", "1447886633175-rename-constraint-verification_user_fkey-to-phone_verification_user_fkey.js", "1447887451164-remove-user-field-from-phone_verifications-as-it's-no-longer-needed.js", "1447888200217-adding-unique-constraint-to-phone_number-on-phone_verifications.js", "1447892303349-dropping-function-toggle_phone_confirmed.js", "1447892411201-adding-function-falsify_phone_confirmed.js", "1447892499175-updating-trigger-falsify_phone_confirmed.js", "1447898625713-adding-email_verifications-table.js", "1447898793209-adding-unique-index-to-email-on-email_verifications.js", "1447899281193-adding-falsify_email_confirmed-function.js", "1447899423837-adding-trigger-falsify_phone_confirmed.js", "1448137229842-remove-contact_user-unique-constraint-from-contacts.js", "1448137497161-remove-email-unique-constraint-from-contacts.js", "1448137561605-remove-phone_number-unique-constraint-from-contacts.js", "1448196305455-cleanup.js", "1448315035824-renewing-wipe_everything-function.js", "1448320523474-renewing-wipe_everything-function-again.js", "1448496141452-removing-not-null-constraint-from-room-on-invitation_records.js", "1448498029074-removing-not-null-constraint-from-invitee_name-on-invitation_records.js", "1448498131207-rename-column-invitee_name-to-invitee_first_name-on-invitation_records.js", "1448498229267-add-column-invitee_last_name-to-invitation_records.js", "1448709084687-ntreis_jobs.js", "1449145639146-raw_listings.js", "1449247501363-add-invitation-value-to-notification_object_class.js", "1449579468904-add-pk-constraint-on-contacts-table.js", "1449579485775-add-tags-table.js", "1449579486869-add-pk-constraint-on-tags-table.js", "1449579487914-add-sample-tags-to-tag-table.js", "1449579488946-add-contacts_tags-table.js", "1449579489970-add-pk-constraint-on-contacts_tags-table.js", "1449579491101-add-fk-constraint-on-contacts_tags-to-contacts.js", "1449579492179-add-fk-constraint-on-contacts_tags-to-tags.js", "1449579851003-add-unique-index-to-contacts-and-tag-on-contacts_tags.js", "1449791716714-new_rets_structure.js", "1449793430966-photos.js", "1450080646801-agents.js", "1450099024600-add-constraint-unique-to-agents-matrix-unique-id.js", "1450108866312-add-created_at-to-agents-table.js", "1450109300975-add-updated_at-to-agents-table.js", "1450109380729-add-deleted_at-to-agents-table.js", "1450380054752-remove-unique-index-to-contacts-and-tag-from-contacts_tags.js", "1450380056052-remove-fk-constraint-from-contacts_tags-to-tags.js", "1450380057285-remove-fk-constraint-from-contacts_tags-to-contacts.js", "1450380058413-remove-pk-constraint-from-contacts_tags-table.js", "1450380059548-drop-contacts_tags-table.js", "1450380060677-remove-pk-constraint-from-tags-table.js", "1450380061860-remove-tags-table.js", "1450380064018-add-tag_types_type.js", "1450380065053-add-tags-table.js", "1450380066041-add-pk-constraint-on-tags-table.js", "1450380067058-add-unique-index-to-entity-and-tag-and-type-on-tags.js", "1450820536634-index-photos-by-mui.js", "1451116734869-add-transaction_contacts.js", "1451118009117-add-unique-transaction_contact-constraint-to-transaction_contacts.js", "1451130220537-add-attachments-table.js", "1451142669770-remove-not-null-from-attachments-on-user-column.js", "1451232249000-dummy.js", "1451232250000-open-houses-table.js", "1451328594069-dummy.js", "1451328594070-add-column-exif-to-photos.js", "1451423625562-unique-mui-for-mls-data.js", "1451450529697-add-task-status.js", "1451451117596-add-tasks-table.js", "1451451912846-add-task_contacts-table.js", "1451737199011-add-offices-table.js", "1451737200944-add-pk-constraint-on-offices-table.js", "1451737276604-add-important_dates-table.js", "1451737295370-add-unique-index-to-matrix_unique_id-on-offices-table.js", "1451752078718-add-transaction_contact_roles-table.js", "1451752080431-add-pk-constraint-on-transaction_contact_roles-table.js", "1451752081723-add-unique-index-to-transaction_contact-and-role-on-transaction_contact_roles-table.js", "1451752711861-add-fk-constraint-from-transaction_contact_roles-to-transaction_contacts-on-transaction_contact_roles.js", "1452263321920-created_at-for-agents.js", "1452321651569-add-statuses-to-alerts.js", "1452421814866-open_house-for-alerts.js", "1452428469472-add-pk-constraint-to-id-on-agents-table.js", "1452428471098-add-agent-column-to-users-table.js", "1452428472489-add-fk-constraint-from-agents-to-users-on-agent-column.js", "1452431996310-create-office_status-type.js", "1452431997760-change-type-of-status-column-from-listing_status-to-office_status-in-offices.js", "1452520766982-added-attachments_eav-table.js", "1452541023744-making-room-optional-on-notifications.js", "1452553926488-updated_at-for-offices.js", "1452604575100-add-units-table.js", "1452604576466-add-pk-constraint-on-units-table.js", "1452604577816-add-fk-constraint-from-units-to-listings-on-listing-column.js", "1452604579130-add-unique-index-to-matrix_unique_id-on-units-table.js", "1452635560585-making-open_house-not-null-on-alerts.js", "1452636359744-making-room-optional-on-notifications.js", "1452636359745-job-name-for-mls-jobs.js", "1452638928908-sanitizing-agent-data.js", "1452678323141-add-property_rooms-table.js", "1452678326202-add-pk-constraint-on-property_rooms-table.js", "1452678338888-add-fk-constraint-from-property_rooms-to-listings-on-listing-column.js", "1452678437616-add-unique-index-to-matrix_unique_id-on-property_rooms-table.js", "1452684856815-index-addresses.mui.js", "1452723737987-adding-minimum_sold_date-to-alerts.js", "1452983122161-adding-info-field-to-attachments.js", "1453245064140_agency-commisions.js", "1453486463024_limit-and-offset-on-mls-jobs.js", "1453810212699_create-adding-notification-values.js", "1453812923369_clean-rooms-and-units.js", "1453938849097_add_private_property.js", "1453989910718_add_attachment_type_actions.js", "1453995448769_fix_negative_values.js", "1454089493650_adding-missing-constraints.js", "1454163327853_add_mentions_to_messages.js", "1454163327953_add-note_type-type.js", "1454421779900_add-notes-table.js", "1454421795349_add-pk-constraint-on-notes-table.js", "1454421811349_add-fk-constraint-from-users-to-notes-on-user-column.js", "1454437890431_add_expense_to_tasks.js", "1454949868083_rename_office_licence_number_to_license_number.js", "1455120409894_renewing_wipe_everything.js", "1455186121898_adding-a-few-missing-mls-columns.js", "1455211865664_new-user-type.js", "1455799169732_fix-close-date-and-index-several-columns.js", "1455873497765_regexp-index-on-agent-mlsid.js", "11453847023987_fixing_tag_stuff.js", "1456234080178_upper-case-index-for-mls-agent-search.js", "1456417146535_agent_exp-function.js", "1457359440555_adding_cma_table.js", "1457361834148_adding_cma_to_notification_object_class.js", "1457458789080_updated_cma_fields.js", "1457543933245_adding_main_listing_to_cma.js", "1457985874149_task_private_constraints.js", "1458273844097_remove_median_from_cma.js", "1458611456365_materialized-view-for-alert-matching.js", "1458662487321_address-added-to-listings_filters.js", "1458750962848_device_uuid-to-device_id.js", "1458899554843_email-verifications-are-no-more-unique-per-email.js", "1459517340167_open-house-notification-enums.js", "1459589073148_postal-code-added-for-string-search.js", "1459867451238_pgtrgm-indexes.js", "1460220867260_agent-phones.js", "1460222320414_agent-emails.js", "1460317064424_aditional-listing-fields.js", "1460369470712_add_secondary_password_for_shadow.js", "1460573473055_add-user-to-tags.js", "1460888878152_notifications_users.js", "1460901371212_notification-deliveries.js", "1461058512679_order-listings.js", "1461138820063_better-listing-orders.js", "1462640302492_index-agent-phones-and-emails.js", "1463138787356_faster-agent-emails-and-phones.js", "1464011658875_add_personal_rooms_to_users.js", "1464275548191_rebuild-agent-emails-with-indexed-lowercase-email.js", "1464912180668_device-id-added-to-notification_tokens.js", "1465227673602_update-wipe-everything.js", "1466097946907_updated_at-for-tags.js", "1465839877887_new-listings-filters-with-office-and-agent.js", "1466532404345_brands.js", "1463938357763_add-google_id-to-tasks-table.js", "1463938363691_add-google_tokens-table.js", "1463938907111_add-pk-constraint-on-google_tokens-table.js", "1463938910381_add-fk-constraint-from-users-to-google_tokens-on-user-column.js", "1463938912967_add-unique-index-to-user-on-google_tokens-table.js", "1466548008324_add_contact_source_brand_to_contacts.js", "1466704436235_renew-listings_filters-with-to_tsvector-index.js", "1467145251651_brand_user_updates.js", "1467116178006_agent-images.js", "1467297560689_renew-listings_filters-with-index-on-status.js", "1467395461237_search_url-to-map_url.js", "1467398619327_logo_url_wide.js", "1467638532691_words-materialized-view.js", "1467646727415_proper-order-of-address-parts.js", "1467772179851_mls-areas-for-listings_filters.js", "1468839668931_making-photo-script-fast.js", "1468955141410_bring-back-id-and-location-indexes.js", "1469380481495_office.brand.js", "1469387560841_adding_close_price_to_listings_filters.js", "1469466309707_adding_default_avatar_to_branding_object.js", "1469584327339_unique-agent-mls-id.js", "1469587617378_created_at_for_listings_filters.js", "1469789872140_property_type-to-property_types.js", "1470060683121_materialized-view-for-schools-and-areas.js", "1470074368874_new-mls_areas-mv.js", "1470139315409_materialized-view-for-counties-and-subdivisions.js", "1470224124835_new-filters.js", "1470276730843_architectural-style-to-array.js", "1470352500655_removing-location,-horizontal-distance-and-vertical-distance.js", "1470544041736_selling-side-added-to-alerts.js", "1469461912555_add_fake_email_to_user.js", "1470677412463_use-parking-spaces-covered-total.js", "1470833192706_new-mls-areas-format.js", "1470913270611_use-json-arrays.js", "1471019474816_middle_school.js", "1471289574670_appearances-for-schools-and-subdivisions.js", "1471626825217_high-schools-offices-and-agents-on-alerts.js", "1471691683929_deleteting-photos.js", "1471908189584_listings_url-for-brands.js", "1472327986154_dom-and-cdom-are-integers-again.js", "1472051263392_new-attributes-for-brands.js", "1472760609982_user-facebook-access-token.js", "1473436754157_add_excluded_listing_ids_to_alert_model.js", "1473332310808_update-to-brands.js", "1473963155097_no-partial-match-on-mls-number.js", "1474380512142_user-proper-default-timezone.js", "1475092746255_parent-brands.js", "1474837265712_zip-code-search.js", "1474981666469_remove-google-tokens.js", "1476018096689_removing-user-codes-which-are-obsolete.js", "1476703534500_add_available_seamless_phone_number_pool.js", "1477915302643_photo-revisions.js", "1477949676256_websites.js", "1478699995528_website-brand.js", "1479214923974_website-brand-is-optional.js", "1479327141953_website-revisions.js", "1479480128591_unique-hostnames.js", "1479838144332_add_archived_property_to_rooms_users.js", "1479838420959_remove_unused_room_properties.js", "1479323818205_stripe-tokens.js", "1479831464289_godaddy-shoppers.js", "1480339301174_sripe-charges.js", "1481314822841_godaddy-domains.js", "1481322441861_stripe-customer-dates.js", "1481331479695_additions-to-godaddy-tables.js", "1481832023931_forms.js", "1481841336729_admin-user-type.js", "1482196560269_deals.js", "1482361812430_envelopes.js", "1482384329259_contact_model_updates.js", "1482674083862_envelope-documents.js", "1482844304771_deal-address.js", "1482845149391_envelope-webhook-token.js", "1483099832033_revision-status.js", "1484310127481_docusign_users.js", "1484577476972_more-roles.js", "1484929783791_user-features.js", "1485258076925_files.js", "1485793020569_docusign-oauth.js", "1485872998442_filename-instead-of-url.js", "1484742147976_migrating_tags_to_new_contact_model_as_attributes.js", "1485353044417_add_activity_tables.js", "1486498345593_removing_tasks_and_transactions.js", "1486681126998_change_nows_to_timestamps.js", "1487092119678_adding_device_ids_for_ios_android.js", "1487186000774_get_brand_users-function.js", "1487206088020_brand-agents.js", "1487300126893_deal-brand.js", "1488325640280_deal-context.js", "1488888680007_schemaless-deal-context.js", "1488979861161_recommendation_updates.js", "1489676011468_adding_user_opened_ios_activity.js", "1489704286688_adding_called_contact_activity.js", "1489741871773_open-house-can-be-null.js", "1489773731652_adding_user_created_contact_activity.js", "1490134027145_review-requests.js", "1490034226311_adding_user_signed_up_activity.js", "1490571693869_room-references.js", "1490606012625_room-reference.js", "1490637530776_proper-envelope-documents.js", "1490662067538_adding_coming_soon_to_listing_statuses.js", "1490664697229_fix_coming_soon_sort_order.js", "1490897380810_brand-rooms.js", "1491243902924_room-references.js", "1491527713198_submission-pdfs.js", "1491681771080_to-be-processed-at-for-photos.js", "1491683290875_index-to-be-processed-at.js", "1491926707260_co-agents-added-to-listing-filters.js", "1492223663747_update-test-user.js", "1492384449939_update-test-user.js", "1490270979635_adding_seen_at_notifications.js", "1492663103456_removing_old_notifications.js"]
\.


--
-- Data for Name: mls_data; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY mls_data (id, created_at, value, class, resource, matrix_unique_id) FROM stdin;
\.


--
-- Data for Name: mls_jobs; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY mls_jobs (id, created_at, last_modified_date, last_id, results, query, is_initial_completed, name, "limit", "offset") FROM stdin;
ae415598-c368-11e5-91bf-f23c91c841bd	2016-01-25 14:36:47.219891+01	2008-11-30 03:23:42	1986233	4	(MatrixModifiedDT=2008-12-04T03:23:42.000-),(MatrixModifiedDT=2008-11-30T03:23:42.000+)	t	old_listings	20000	0
23dac0ec-d704-11e5-b0f8-f23c91c841bd	2016-02-19 13:27:28.604573+01	2016-02-19 06:00:33.54	59775624	45	(MatrixModifiedDT=2016-02-19T04:00:33.060+)	t	agents	10000	\N
24eb6cca-d704-11e5-b910-f23c91c841bd	2016-02-19 13:27:30.389946+01	2016-02-19 03:11:05.537	59561213	1	(MatrixModifiedDT=2016-02-19T03:11:05.537+)	t	open_houses	10000	\N
260f8546-d704-11e5-91a3-f23c91c841bd	2016-02-19 13:27:32.302974+01	2016-02-19 06:00:11.52	59754731	2	(MatrixModifiedDT=2016-02-19T04:00:10.970+)	t	offices	10000	\N
64c1194c-d706-11e5-924b-f23c91c841bd	2016-02-19 13:43:36.481565+01	2016-02-19 06:43:28.63	59800966	5	(MatrixModifiedDT=2016-02-19T06:35:38.670+)	t	listings	10000	\N
b3d5c916-d705-11e5-b3d6-f23c91c841bd	2016-02-19 13:38:39.66047+01	2014-08-11 16:00:25.367	11465112	10000	(matrix_unique_id=11455113+)	f	rooms	10000	\N
f752b7f2-d706-11e5-ac30-f23c91c841bd	2016-02-19 13:47:42.383523+01	2016-02-19 06:47:04.723	59801096	39	(ModifiedDate=2016-02-19T06:38:25.027+)	t	photos	10000	\N
b4f6ba80-d705-11e5-bdf0-f23c91c841bd	2016-02-19 13:38:41.552082+01	2016-02-18 18:46:56.58	59794167	2	(MatrixModifiedDT=2016-02-18T18:46:56.580+)	t	units	10000	\N
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY notifications (id, object, message, created_at, updated_at, room, action, object_class, subject, auxiliary_object_class, auxiliary_object, recommendation, auxiliary_subject, subject_class, auxiliary_subject_class, extra_subject_class, extra_object_class, deleted_at, exclude, specific) FROM stdin;
\.


--
-- Data for Name: notifications_deliveries; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY notifications_deliveries (id, "user", notification, device_token, type, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: notifications_tokens; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY notifications_tokens (id, "user", device_token, created_at, updated_at, device_id) FROM stdin;
\.


--
-- Data for Name: notifications_users; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY notifications_users (id, "user", notification, acked_at, created_at, updated_at, deleted_at, seen_at) FROM stdin;
\.


--
-- Data for Name: offices; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY offices (id, board, email, fax, office_mui, office_mls_id, license_number, address, care_of, city, postal_code, postal_code_plus4, state, matrix_unique_id, matrix_modified_dt, mls, mls_id, mls_provider, nar_number, contact_mui, contact_mls_id, long_name, name, status, phone, other_phone, st_address, st_city, st_country, st_postal_code, st_postal_code_plus4, st_state, url, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: open_houses; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY open_houses (id, start_time, end_time, description, listing_mui, refreshments, type, matrix_unique_id, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: password_recovery_records; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY password_recovery_records (id, email, "user", token, created_at, updated_at, expires_at) FROM stdin;
\.


--
-- Data for Name: phone_verifications; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY phone_verifications (id, code, created_at, phone_number) FROM stdin;
\.


--
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY photos (id, created_at, processed_at, error, matrix_unique_id, listing_mui, description, url, "order", exif, deleted_at, revision, to_be_processed_at) FROM stdin;
c59f583c-a277-11e5-b8fe-f23c91c841bd	2015-12-14 16:31:40.502877+01	2016-01-25 14:22:09.326794+01	\N	15621043	1528396		http://cdn.rechat.co/15621043.jpg	0	{}	\N	0	2017-04-08 22:06:06.159087+02
b306a502-a279-11e5-a917-f23c91c841bd	2015-12-14 16:45:28.296495+01	2016-01-25 14:11:57.156101+01	\N	15666457	1569942		http://cdn.rechat.co/15666457.jpg	0	{}	\N	0	2017-04-08 22:06:06.118671+02
f717be34-a279-11e5-8fd2-f23c91c841bd	2015-12-14 16:47:22.493645+01	2016-01-25 14:10:07.964576+01	\N	15675813	1119877		http://cdn.rechat.co/15675813.jpg	0	{}	\N	0	2017-04-08 22:06:06.116296+02
58e68bae-a27a-11e5-9f00-f23c91c841bd	2015-12-14 16:50:06.587929+01	2016-01-25 14:06:15.272672+01	\N	15692651	1600249		http://cdn.rechat.co/15692651.jpg	0	{}	\N	0	2017-04-08 22:05:48.758021+02
4943f0a0-a27b-11e5-9e8a-f23c91c841bd	2015-12-14 16:56:49.85327+01	2016-01-25 13:46:36.535515+01	\N	15725230	1640052		http://cdn.rechat.co/15725230.jpg	0	{}	\N	0	2017-04-08 22:05:48.771579+02
f1fea7b2-a27b-11e5-ba92-f23c91c841bd	2015-12-14 17:01:32.934045+01	2016-01-25 13:41:15.752268+01	\N	15748919	1657963		http://cdn.rechat.co/15748919.jpg	0	{}	\N	0	2017-04-08 22:06:05.581903+02
81771f14-a27c-11e5-ba5c-f23c91c841bd	2015-12-14 17:05:33.637658+01	2016-01-25 13:32:28.174241+01	\N	15768544	1396847		http://cdn.rechat.co/15768544.jpg	0	{}	\N	0	2017-04-08 22:06:05.55149+02
993fb8ee-a27d-11e5-97bb-f23c91c841bd	2015-12-14 17:13:23.036655+01	2016-01-25 13:22:40.981163+01	\N	15807439	1137861		http://cdn.rechat.co/15807439.jpg	0	{}	\N	0	2017-04-08 22:06:05.505374+02
5ffb37ec-a27e-11e5-8cb2-f23c91c841bd	2015-12-14 17:18:56.454489+01	2016-01-25 13:17:54.207642+01	\N	15831093	1753662		http://cdn.rechat.co/15831093.jpg	0	{}	\N	0	2017-04-08 22:05:48.842035+02
e8b5977a-a27f-11e5-8ccc-f23c91c841bd	2015-12-14 17:29:55.342462+01	2016-01-25 13:04:41.359419+01	\N	15885108	1311841		http://cdn.rechat.co/15885108.jpg	0	{}	\N	0	2017-04-08 22:05:48.865812+02
5e45831e-a281-11e5-a3e3-f23c91c841bd	2015-12-14 17:40:22.07613+01	2016-01-25 12:52:26.813491+01	\N	15935523	1863063		http://cdn.rechat.co/15935523.jpg	0	{}	\N	0	2017-04-08 22:05:48.888334+02
ca6929a4-a283-11e5-87de-f23c91c841bd	2015-12-14 17:57:42.497161+01	2016-01-25 12:27:42.765678+01	\N	16023117	1157723		http://cdn.rechat.co/16023117.jpg	0	{}	\N	0	2017-04-08 22:05:48.926096+02
4d7f8e46-a33d-11e5-b06d-f23c91c841bd	2015-12-15 16:05:39.320346+01	2016-01-25 03:54:40.666164+01	\N	22413617	1933053	9840 Crocker Exterior	http://cdn.rechat.co/22413617.jpg	0	{}	\N	0	2017-04-08 22:06:09.805936+02
9a4ee26c-a284-11e5-9c48-f23c91c841bd	2015-12-14 18:03:31.290956+01	2016-01-25 14:40:05.799463+01	\N	16068957	1988905		http://cdn.rechat.co/16068957.jpg	0	{}	\N	0	2017-04-08 22:06:06.224486+02
99540b80-a284-11e5-9c48-f23c91c841bd	2015-12-14 18:03:29.64698+01	2016-01-25 14:32:46.524912+01	\N	16068353	1991939	FRONT OF HOUSE	http://cdn.rechat.co/16068353.jpg	0	{}	\N	0	2017-04-08 22:05:48.943063+02
81cb4df4-a29b-11e5-b6f4-f23c91c841bd	2015-12-14 20:47:28.58808+01	2016-01-24 23:25:16.870358+01	\N	16998201	1354359		http://cdn.rechat.co/16998201.jpg	0	{}	\N	0	2017-04-08 22:06:08.466152+02
2f1b2a90-a2e4-11e5-b5b8-f23c91c841bd	2015-12-15 05:27:43.12192+01	2016-01-24 08:07:46.44157+01	\N	18173897	2015306		http://cdn.rechat.co/18173897.jpg	0	{}	\N	0	2017-04-08 22:06:04.071431+02
bc65f340-a2b6-11e5-b637-f23c91c841bd	2015-12-15 00:02:23.321205+01	2016-01-24 17:09:42.829171+01	\N	17427706	2025784		http://cdn.rechat.co/17427706.jpg	0	{}	\N	0	2017-04-08 22:05:49.404137+02
2be85db6-a2e4-11e5-b5b8-f23c91c841bd	2015-12-15 05:27:37.755803+01	2016-01-24 08:09:25.26596+01	\N	18172013	2034018		http://cdn.rechat.co/18172013.jpg	0	{}	\N	0	2017-04-08 22:06:04.089129+02
761581e4-a33d-11e5-b9ba-f23c91c841bd	2015-12-15 16:06:47.411928+01	2016-01-23 17:05:32.716313+01	\N	22430418	2047261		http://cdn.rechat.co/22430418.jpg	0	{}	\N	0	2017-04-08 22:05:52.471517+02
25ce89e6-a2e4-11e5-b5b8-f23c91c841bd	2015-12-15 05:27:27.520218+01	2016-01-24 08:12:45.43068+01	\N	18168014	2062249		http://cdn.rechat.co/18168014.jpg	0	{}	\N	0	2017-04-08 22:05:49.623469+02
80f9edae-a2e6-11e5-a411-f23c91c841bd	2015-12-15 05:44:19.470681+01	2016-01-24 07:30:38.415603+01	\N	18220970	2065316		http://cdn.rechat.co/18220970.jpg	0	{}	\N	0	2017-04-08 22:05:49.639958+02
7c2282b8-a2d8-11e5-b0b4-f23c91c841bd	2015-12-15 04:03:58.393738+01	2016-01-24 12:52:35.440131+01	\N	17837979	1379463		http://cdn.rechat.co/17837979.jpg	0	{}	\N	0	2017-04-08 22:05:49.507249+02
fbb90b20-a2e0-11e5-8ee0-f23c91c841bd	2015-12-15 05:04:48.424821+01	2016-01-24 11:59:38.520845+01	\N	17941653	1380895		http://cdn.rechat.co/17941653.jpg	0	{}	\N	0	2017-04-08 22:06:06.664159+02
f6e44cd6-a2e5-11e5-9ccf-f23c91c841bd	2015-12-15 05:40:27.803362+01	2016-01-24 07:37:41.627403+01	\N	18212227	2083889	Front view with side courtyard and patio.	http://cdn.rechat.co/18212227.jpg	0	{}	\N	0	2017-04-08 22:05:49.448765+02
abbb2334-a2e4-11e5-8c70-f23c91c841bd	2015-12-15 05:31:12.207663+01	2016-01-24 07:49:17.166256+01	\N	18196266	1383273	Front	http://cdn.rechat.co/18196266.jpg	0	{}	\N	0	2017-04-08 22:05:49.632403+02
954fe61a-a286-11e5-a641-f23c91c841bd	2015-12-14 18:17:41.902475+01	2016-01-25 10:59:11.761104+01	\N	16231557	2119751	Kitchen	http://cdn.rechat.co/16231557.jpg	4	{}	\N	0	2017-04-08 22:05:48.978951+02
954fbf00-a286-11e5-a641-f23c91c841bd	2015-12-14 18:17:41.901434+01	2016-01-25 10:59:11.303435+01	\N	16231556	2119751	Dining Room	http://cdn.rechat.co/16231556.jpg	3	{}	\N	0	2017-04-08 22:05:48.978954+02
955013d8-a286-11e5-a641-f23c91c841bd	2015-12-14 18:17:41.903554+01	2016-01-25 10:59:11.265384+01	\N	16231558	2119751	Master Bedroom	http://cdn.rechat.co/16231558.jpg	5	{}	\N	0	2017-04-08 22:05:48.978958+02
954f97be-a286-11e5-a641-f23c91c841bd	2015-12-14 18:17:41.900432+01	2016-01-25 10:59:11.315833+01	\N	16231555	2119751	Living Room (2)	http://cdn.rechat.co/16231555.jpg	2	{}	\N	0	2017-04-08 22:05:48.978959+02
954f2b4e-a286-11e5-a641-f23c91c841bd	2015-12-14 18:17:41.897682+01	2016-01-25 10:59:11.958657+01	\N	16231552	2119751	Master Bath	http://cdn.rechat.co/16231552.jpg	6	{}	\N	0	2017-04-08 22:05:48.978962+02
954f71e4-a286-11e5-a641-f23c91c841bd	2015-12-14 18:17:41.899486+01	2016-01-25 10:59:11.389678+01	\N	16231554	2119751	Living Room	http://cdn.rechat.co/16231554.jpg	1	{}	\N	0	2017-04-08 22:06:05.148799+02
954f4d90-a286-11e5-a641-f23c91c841bd	2015-12-14 18:17:41.898572+01	2016-01-25 10:59:11.524003+01	\N	16231553	2119751	Front	http://cdn.rechat.co/16231553.jpg	0	{}	\N	0	2017-04-08 22:06:05.1488+02
62d5ea70-a28d-11e5-8e94-f23c91c841bd	2015-12-14 19:06:23.694105+01	2016-01-25 04:26:13.018642+01	\N	16667038	1289260		http://cdn.rechat.co/16667038.jpg	6	{}	\N	0	2017-04-08 22:05:49.24094+02
62d5ae8e-a28d-11e5-8e94-f23c91c841bd	2015-12-14 19:06:23.69256+01	2016-01-25 04:26:13.03733+01	\N	16667037	1289260		http://cdn.rechat.co/16667037.jpg	5	{}	\N	0	2017-04-08 22:05:49.240951+02
62c78ae8-a28d-11e5-8e94-f23c91c841bd	2015-12-14 19:06:23.599878+01	2016-01-25 04:26:13.295449+01	\N	16667031	1289260		http://cdn.rechat.co/16667031.jpg	7	{}	\N	0	2017-04-08 22:05:49.240954+02
62d571ee-a28d-11e5-8e94-f23c91c841bd	2015-12-14 19:06:23.690945+01	2016-01-25 04:26:13.081948+01	\N	16667036	1289260		http://cdn.rechat.co/16667036.jpg	4	{}	\N	0	2017-04-08 22:05:49.240958+02
62d4d82e-a28d-11e5-8e94-f23c91c841bd	2015-12-14 19:06:23.687019+01	2016-01-25 04:26:13.594375+01	\N	16667034	1289260		http://cdn.rechat.co/16667034.jpg	2	{}	\N	0	2017-04-08 22:05:49.240965+02
62d52eaa-a28d-11e5-8e94-f23c91c841bd	2015-12-14 19:06:23.689237+01	2016-01-25 04:26:13.101357+01	\N	16667035	1289260		http://cdn.rechat.co/16667035.jpg	3	{}	\N	0	2017-04-08 22:06:09.630977+02
62c7f0a0-a28d-11e5-8e94-f23c91c841bd	2015-12-14 19:06:23.60254+01	2016-01-25 04:26:13.242807+01	\N	16667033	1289260		http://cdn.rechat.co/16667033.jpg	1	{}	\N	0	2017-04-08 22:06:09.630979+02
62c7bb80-a28d-11e5-8e94-f23c91c841bd	2015-12-14 19:06:23.601147+01	2016-01-25 04:26:13.290556+01	\N	16667032	1289260		http://cdn.rechat.co/16667032.jpg	0	{}	\N	0	2017-04-08 22:06:09.630981+02
e8c6494a-a2f6-11e5-af19-f23c91c841bd	2015-12-15 07:41:45.563002+01	2016-01-22 23:22:46.002886+01	\N	19541977	2175635		http://cdn.rechat.co/19541977.jpg	0	{}	\N	0	2017-04-08 22:05:51.06011+02
436331c0-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.089544+01	2016-01-23 07:01:05.859215+01	\N	19479788	2203370	Jetted Tub	http://cdn.rechat.co/19479788.jpg	10	{}	\N	0	2017-04-08 22:05:35.334515+02
4363920a-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.092012+01	2016-01-23 07:01:05.393715+01	\N	19479790	2203370	First Living Aera	http://cdn.rechat.co/19479790.jpg	12	{}	\N	0	2017-04-08 22:05:51.040543+02
4363644c-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.090841+01	2016-01-23 07:01:05.567124+01	\N	19479789	2203370	Spa-Pool	http://cdn.rechat.co/19479789.jpg	11	{}	\N	0	2017-04-08 22:05:51.040545+02
43617fa6-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.078346+01	2016-01-23 07:01:06.19288+01	\N	19479780	2203370	Tiled Floor Entry	http://cdn.rechat.co/19479780.jpg	2	{}	\N	0	2017-04-08 22:05:51.040545+02
436258a4-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.083899+01	2016-01-23 07:01:05.88165+01	\N	19479784	2203370	Built In Desk kitchen	http://cdn.rechat.co/19479784.jpg	6	{}	\N	0	2017-04-08 22:05:51.040546+02
43610db4-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.075429+01	2016-01-23 07:01:06.517716+01	\N	19479778	2203370	View Of Living Room	http://cdn.rechat.co/19479778.jpg	15	{}	\N	0	2017-04-08 22:05:51.040546+02
4361b35e-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.079669+01	2016-01-23 07:01:06.781402+01	\N	19479781	2203370	Stairs To Second Floor	http://cdn.rechat.co/19479781.jpg	3	{}	\N	0	2017-04-08 22:05:51.040546+02
4362cb0e-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.08683+01	2016-01-23 07:01:05.704357+01	\N	19479786	2203370	Dining View Looking Out To Pool	http://cdn.rechat.co/19479786.jpg	8	{}	\N	0	2017-04-08 22:05:51.040547+02
43621fba-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.082444+01	2016-01-23 07:01:06.010311+01	\N	19479783	2203370	Full Bath Upstairs	http://cdn.rechat.co/19479783.jpg	5	{}	\N	0	2017-04-08 22:05:51.040547+02
4360d588-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.073978+01	2016-01-23 07:01:07.70305+01	\N	19479777	2203370	5 Bedroom Family Home	http://cdn.rechat.co/19479777.jpg	0	{}	\N	0	2017-04-08 22:05:51.040548+02
436145ea-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.076868+01	2016-01-23 07:01:06.508583+01	\N	19479779	2203370	Very Nice Walk Up	http://cdn.rechat.co/19479779.jpg	1	{}	\N	0	2017-04-08 22:05:51.040548+02
4363fbe6-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.09473+01	2016-01-23 07:01:05.241231+01	\N	19479792	2203370	View Of Kitchen	http://cdn.rechat.co/19479792.jpg	14	{}	\N	0	2017-04-08 22:06:05.118646+02
4363cc16-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.093502+01	2016-01-23 07:01:05.48856+01	\N	19479791	2203370	Large Living Aera	http://cdn.rechat.co/19479791.jpg	13	{}	\N	0	2017-04-08 22:06:05.118647+02
43630100-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.088261+01	2016-01-23 07:01:05.601999+01	\N	19479787	2203370	Large Master Bedroom	http://cdn.rechat.co/19479787.jpg	9	{}	\N	0	2017-04-08 22:06:05.118647+02
4362931e-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.085398+01	2016-01-23 07:01:05.810546+01	\N	19479785	2203370	Breakfast-Kitchen Aera	http://cdn.rechat.co/19479785.jpg	7	{}	\N	0	2017-04-08 22:06:05.118648+02
4361e7c0-a2f6-11e5-bd82-f23c91c841bd	2015-12-15 07:37:08.080996+01	2016-01-23 07:01:06.020428+01	\N	19479782	2203370	Formal Dining Room	http://cdn.rechat.co/19479782.jpg	4	{}	\N	0	2017-04-08 22:06:05.118655+02
d286d1b6-a2c6-11e5-9a92-f23c91c841bd	2015-12-15 01:57:32.394077+01	2016-01-24 15:35:32.136764+01	\N	17609280	2228463		http://cdn.rechat.co/17609280.jpg	0	{}	\N	0	2017-04-08 22:05:49.463516+02
295785cc-a2c6-11e5-a686-f23c91c841bd	2015-12-15 01:52:48.54927+01	2016-01-24 15:43:02.41504+01	\N	17597887	2245733		http://cdn.rechat.co/17597887.jpg	0	{}	\N	0	2017-04-08 22:05:49.459803+02
ffad2b0e-a2cb-11e5-ad1a-f23c91c841bd	2015-12-15 02:34:35.626538+01	2016-01-24 15:01:46.276241+01	\N	17669687	1164904		http://cdn.rechat.co/17669687.jpg	0	{}	\N	0	2017-04-08 22:06:06.740438+02
1908e032-a2a6-11e5-a190-f23c91c841bd	2015-12-14 22:03:17.294882+01	2016-01-24 21:04:58.974052+01	\N	17176589	2248275	yard	http://cdn.rechat.co/17176589.jpg	1	{}	\N	0	2017-04-08 22:05:49.286688+02
19097df8-a2a6-11e5-a190-f23c91c841bd	2015-12-14 22:03:17.298917+01	2016-01-24 21:04:57.560341+01	\N	17176591	2248275	living area	http://cdn.rechat.co/17176591.jpg	3	{}	\N	0	2017-04-08 22:05:49.286689+02
1909f4cc-a2a6-11e5-a190-f23c91c841bd	2015-12-14 22:03:17.301962+01	2016-01-24 21:04:57.5057+01	\N	17176593	2248275	bedroom 1	http://cdn.rechat.co/17176593.jpg	5	{}	\N	0	2017-04-08 22:05:49.28669+02
190943a6-a2a6-11e5-a190-f23c91c841bd	2015-12-14 22:03:17.297406+01	2016-01-24 21:04:57.644888+01	\N	17176590	2248275	back	http://cdn.rechat.co/17176590.jpg	2	{}	\N	0	2017-04-08 22:05:49.286692+02
1909ba48-a2a6-11e5-a190-f23c91c841bd	2015-12-14 22:03:17.30044+01	2016-01-24 21:04:57.655441+01	\N	17176592	2248275	garage	http://cdn.rechat.co/17176592.jpg	4	{}	\N	0	2017-04-08 22:05:49.286696+02
1908a39c-a2a6-11e5-a190-f23c91c841bd	2015-12-14 22:03:17.293334+01	2016-01-24 21:04:57.745474+01	\N	17176588	2248275	Front	http://cdn.rechat.co/17176588.jpg	0	{}	\N	0	2017-04-08 22:05:49.286697+02
190a64a2-a2a6-11e5-a190-f23c91c841bd	2015-12-14 22:03:17.304788+01	2016-01-24 21:04:57.90928+01	\N	17176594	2248275	bedroom 2	http://cdn.rechat.co/17176594.jpg	6	{}	\N	0	2017-04-08 22:05:49.286697+02
19086bde-a2a6-11e5-a190-f23c91c841bd	2015-12-14 22:03:17.291969+01	2016-01-24 21:04:58.316813+01	\N	17176587	2248275	kitchen	http://cdn.rechat.co/17176587.jpg	7	{}	\N	0	2017-04-08 22:06:08.316479+02
bcf41b00-a2f4-11e5-bdd3-f23c91c841bd	2015-12-15 07:26:13.050074+01	2016-01-23 10:29:58.237369+01	\N	19335068	2272071	Luxury loft living, with private balconies facing the central business district skyline	http://cdn.rechat.co/19335068.jpg	0	{}	\N	0	2017-04-08 22:06:05.330627+02
b0a136f2-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.936308+01	2016-01-24 11:34:34.871516+01	\N	17965582	2317178		http://cdn.rechat.co/17965582.jpg	20	{}	\N	0	2017-04-08 22:05:38.339874+02
b0a0721c-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.931231+01	2016-01-24 11:34:34.982144+01	\N	17965578	2317178		http://cdn.rechat.co/17965578.jpg	16	{}	\N	0	2017-04-08 22:05:38.339875+02
b0a09fd0-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.93245+01	2016-01-24 11:34:34.992719+01	\N	17965579	2317178		http://cdn.rechat.co/17965579.jpg	17	{}	\N	0	2017-04-08 22:05:38.339943+02
b09f8bcc-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.925367+01	2016-01-24 11:34:35.176118+01	\N	17965573	2317178		http://cdn.rechat.co/17965573.jpg	11	{}	\N	0	2017-04-08 22:05:38.339982+02
b09ef162-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.921429+01	2016-01-24 11:34:35.284931+01	\N	17965570	2317178		http://cdn.rechat.co/17965570.jpg	8	{}	\N	0	2017-04-08 22:05:38.339998+02
b0a0d4c8-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.933805+01	2016-01-24 11:34:35.427529+01	\N	17965580	2317178		http://cdn.rechat.co/17965580.jpg	18	{}	\N	0	2017-04-08 22:05:38.339999+02
b09d5d02-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.911078+01	2016-01-24 11:34:35.545229+01	\N	17965563	2317178		http://cdn.rechat.co/17965563.jpg	1	{}	\N	0	2017-04-08 22:05:38.34008+02
b09d931c-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.912464+01	2016-01-24 11:34:35.582755+01	\N	17965564	2317178		http://cdn.rechat.co/17965564.jpg	2	{}	\N	0	2017-04-08 22:05:38.340117+02
b09e86a0-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.918698+01	2016-01-24 11:34:37.418052+01	\N	17965568	2317178		http://cdn.rechat.co/17965568.jpg	6	{}	\N	0	2017-04-08 22:05:38.34045+02
b09e519e-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.917326+01	2016-01-24 11:34:35.500079+01	\N	17965567	2317178		http://cdn.rechat.co/17965567.jpg	5	{}	\N	0	2017-04-08 22:05:48.491388+02
b0a03e6e-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.929955+01	2016-01-24 11:34:35.020692+01	\N	17965577	2317178		http://cdn.rechat.co/17965577.jpg	15	{}	\N	0	2017-04-08 22:05:49.548761+02
b09f5ada-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.924129+01	2016-01-24 11:34:35.164446+01	\N	17965572	2317178		http://cdn.rechat.co/17965572.jpg	10	{}	\N	0	2017-04-08 22:05:49.548773+02
b09fb8b8-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.926528+01	2016-01-24 11:34:35.076581+01	\N	17965574	2317178		http://cdn.rechat.co/17965574.jpg	12	{}	\N	0	2017-04-08 22:05:49.548778+02
b09ebab2-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.920029+01	2016-01-24 11:34:35.269784+01	\N	17965569	2317178		http://cdn.rechat.co/17965569.jpg	7	{}	\N	0	2017-04-08 22:05:49.548782+02
b0a10894-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.935132+01	2016-01-24 11:34:34.980086+01	\N	17965581	2317178		http://cdn.rechat.co/17965581.jpg	19	{}	\N	0	2017-04-08 22:05:49.548783+02
b0a01272-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.928807+01	2016-01-24 11:34:35.088706+01	\N	17965576	2317178		http://cdn.rechat.co/17965576.jpg	14	{}	\N	0	2017-04-08 22:05:49.548783+02
b09f268c-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.922789+01	2016-01-24 11:34:35.259521+01	\N	17965571	2317178		http://cdn.rechat.co/17965571.jpg	9	{}	\N	0	2017-04-08 22:05:49.548783+02
b09e1a8a-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.915927+01	2016-01-24 11:34:35.455025+01	\N	17965566	2317178		http://cdn.rechat.co/17965566.jpg	4	{}	\N	0	2017-04-08 22:05:49.548785+02
b09d28d2-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.909739+01	2016-01-24 11:34:35.565379+01	\N	17965562	2317178		http://cdn.rechat.co/17965562.jpg	21	{}	\N	0	2017-04-08 22:05:49.548786+02
b09dcdaa-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.913961+01	2016-01-24 11:34:36.100429+01	\N	17965565	2317178		http://cdn.rechat.co/17965565.jpg	3	{}	\N	0	2017-04-08 22:05:49.548786+02
b09cf3a8-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.90837+01	2016-01-24 11:34:35.879295+01	\N	17965561	2317178		http://cdn.rechat.co/17965561.jpg	0	{}	\N	0	2017-04-08 22:05:49.548789+02
b09fe5d6-a2e1-11e5-8ef7-f23c91c841bd	2015-12-15 05:09:51.92769+01	2016-01-24 11:34:38.785377+01	\N	17965575	2317178		http://cdn.rechat.co/17965575.jpg	13	{}	\N	0	2017-04-08 22:05:49.548789+02
4835971c-a2ef-11e5-95e8-f23c91c841bd	2015-12-15 06:47:09.70216+01	2016-01-23 21:23:15.746564+01	\N	18827471	2339947		http://cdn.rechat.co/18827471.jpg	0	{}	\N	0	2017-04-08 22:05:50.677176+02
088ecbce-a2ef-11e5-ad38-f23c91c841bd	2015-12-15 06:45:22.912576+01	2016-01-23 21:58:39.657469+01	\N	18799278	2343937		http://cdn.rechat.co/18799278.jpg	0	{}	\N	0	2017-04-08 22:05:50.623157+02
87d0f0ca-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.919945+01	2016-01-23 22:56:42.213871+01	\N	18749875	2351891		http://cdn.rechat.co/18749875.jpg	10	{}	\N	0	2017-04-08 22:05:48.512149+02
87d1b83e-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.925101+01	2016-01-23 22:56:42.060475+01	\N	18749879	2351891		http://cdn.rechat.co/18749879.jpg	14	{}	\N	0	2017-04-08 22:05:49.840827+02
87d0156a-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.914298+01	2016-01-23 22:56:42.377332+01	\N	18749871	2351891		http://cdn.rechat.co/18749871.jpg	6	{}	\N	0	2017-04-08 22:05:49.840827+02
87bf6472-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.804775+01	2016-01-23 22:56:42.765005+01	\N	18749866	2351891		http://cdn.rechat.co/18749866.jpg	1	{}	\N	0	2017-04-08 22:05:49.840828+02
87d189f4-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.923903+01	2016-01-23 22:56:42.157902+01	\N	18749878	2351891		http://cdn.rechat.co/18749878.jpg	13	{}	\N	0	2017-04-08 22:05:49.840828+02
87d234c6-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.928281+01	2016-01-23 22:56:41.973156+01	\N	18749881	2351891		http://cdn.rechat.co/18749881.jpg	16	{}	\N	0	2017-04-08 22:05:49.840829+02
87bed02a-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.801109+01	2016-01-23 22:56:42.815378+01	\N	18749864	2351891		http://cdn.rechat.co/18749864.jpg	24	{}	\N	0	2017-04-08 22:05:49.840829+02
87d1245a-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.92131+01	2016-01-23 22:56:42.211269+01	\N	18749876	2351891		http://cdn.rechat.co/18749876.jpg	11	{}	\N	0	2017-04-08 22:05:49.840829+02
87bfd510-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.807764+01	2016-01-23 22:56:42.52145+01	\N	18749868	2351891		http://cdn.rechat.co/18749868.jpg	3	{}	\N	0	2017-04-08 22:05:49.84083+02
87d0872a-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.917226+01	2016-01-23 22:56:42.327712+01	\N	18749873	2351891		http://cdn.rechat.co/18749873.jpg	8	{}	\N	0	2017-04-08 22:05:49.84083+02
87c03e74-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.81042+01	2016-01-23 22:56:42.477795+01	\N	18749870	2351891		http://cdn.rechat.co/18749870.jpg	5	{}	\N	0	2017-04-08 22:05:49.840831+02
87d35e82-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.935819+01	2016-01-23 22:56:41.806856+01	\N	18749886	2351891		http://cdn.rechat.co/18749886.jpg	21	{}	\N	0	2017-04-08 22:05:49.84089+02
87d3be04-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.938335+01	2016-01-23 22:56:43.714491+01	\N	18749888	2351891		http://cdn.rechat.co/18749888.jpg	23	{}	\N	0	2017-04-08 22:05:49.840892+02
87d38876-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.936873+01	2016-01-23 22:56:41.696498+01	\N	18749887	2351891		http://cdn.rechat.co/18749887.jpg	22	{}	\N	0	2017-04-08 22:05:49.840892+02
87bfab44-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.8068+01	2016-01-23 22:56:42.760148+01	\N	18749867	2351891		http://cdn.rechat.co/18749867.jpg	2	{}	\N	0	2017-04-08 22:06:06.315269+02
87d308f6-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.933708+01	2016-01-23 22:56:41.871567+01	\N	18749885	2351891		http://cdn.rechat.co/18749885.jpg	20	{}	\N	0	2017-04-08 22:06:06.316877+02
87d2d732-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.93243+01	2016-01-23 22:56:41.911607+01	\N	18749884	2351891		http://cdn.rechat.co/18749884.jpg	19	{}	\N	0	2017-04-08 22:06:06.316879+02
87d2744a-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.929897+01	2016-01-23 22:56:41.929612+01	\N	18749882	2351891		http://cdn.rechat.co/18749882.jpg	17	{}	\N	0	2017-04-08 22:06:06.316879+02
87d2a794-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.931225+01	2016-01-23 22:56:41.951037+01	\N	18749883	2351891		http://cdn.rechat.co/18749883.jpg	18	{}	\N	0	2017-04-08 22:06:06.316879+02
87d1fa2e-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.92676+01	2016-01-23 22:56:42.029935+01	\N	18749880	2351891		http://cdn.rechat.co/18749880.jpg	15	{}	\N	0	2017-04-08 22:06:06.31688+02
87d155ba-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.922579+01	2016-01-23 22:56:42.15039+01	\N	18749877	2351891		http://cdn.rechat.co/18749877.jpg	12	{}	\N	0	2017-04-08 22:06:06.31688+02
87d0bbf0-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.918639+01	2016-01-23 22:56:42.283781+01	\N	18749874	2351891		http://cdn.rechat.co/18749874.jpg	9	{}	\N	0	2017-04-08 22:06:06.316881+02
87d04d78-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.915808+01	2016-01-23 22:56:42.357698+01	\N	18749872	2351891		http://cdn.rechat.co/18749872.jpg	7	{}	\N	0	2017-04-08 22:06:06.316881+02
87c00256-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.808955+01	2016-01-23 22:56:42.479957+01	\N	18749869	2351891		http://cdn.rechat.co/18749869.jpg	4	{}	\N	0	2017-04-08 22:06:06.316882+02
87bf0662-a2ee-11e5-b8a6-f23c91c841bd	2015-12-15 06:41:46.802575+01	2016-01-23 22:56:42.945657+01	\N	18749865	2351891		http://cdn.rechat.co/18749865.jpg	0	{}	\N	0	2017-04-08 22:06:06.316882+02
8a347088-a34a-11e5-bca0-f23c91c841bd	2015-12-15 17:40:24.626639+01	2016-01-23 23:19:26.920542+01	\N	22787738	2356489		http://cdn.rechat.co/22787738.jpg	1	{}	\N	0	2017-04-08 22:05:52.592847+02
8a3445b8-a34a-11e5-bca0-f23c91c841bd	2015-12-15 17:40:24.625539+01	2016-01-23 23:19:26.96298+01	\N	22787737	2356489		http://cdn.rechat.co/22787737.jpg	0	{}	\N	0	2017-04-08 22:05:52.592847+02
8a34cb8c-a34a-11e5-bca0-f23c91c841bd	2015-12-15 17:40:24.628958+01	2016-01-23 23:19:26.90287+01	\N	22787740	2356489		http://cdn.rechat.co/22787740.jpg	3	{}	\N	0	2017-04-08 22:05:52.592848+02
8a349efa-a34a-11e5-bca0-f23c91c841bd	2015-12-15 17:40:24.627824+01	2016-01-23 23:19:26.916886+01	\N	22787739	2356489		http://cdn.rechat.co/22787739.jpg	2	{}	\N	0	2017-04-08 22:06:06.332024+02
8a3418fe-a34a-11e5-bca0-f23c91c841bd	2015-12-15 17:40:24.624398+01	2016-01-23 23:19:27.082492+01	\N	22787736	2356489		http://cdn.rechat.co/22787736.jpg	4	{}	\N	0	2017-04-08 22:06:06.332046+02
1124820c-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.818781+01	2016-01-18 02:34:58.415096+01	\N	18703038	2360683		http://cdn.rechat.co/18703038.jpg	1	{}	\N	0	2017-04-08 22:05:36.17162+02
1124e8a0-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.821356+01	2016-01-18 02:34:58.750931+01	\N	18703040	2360683		http://cdn.rechat.co/18703040.jpg	3	{}	\N	0	2017-04-08 22:05:36.171621+02
112615ea-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.829044+01	2016-01-18 02:34:57.533561+01	\N	18703044	2360683		http://cdn.rechat.co/18703044.jpg	7	{}	\N	0	2017-04-08 22:05:49.824218+02
1135c742-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.931962+01	2016-01-18 02:34:56.976061+01	\N	18703056	2360683		http://cdn.rechat.co/18703056.jpg	19	{}	\N	0	2017-04-08 22:05:49.824218+02
1127b54e-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.839693+01	2016-01-18 02:34:57.812551+01	\N	18703050	2360683		http://cdn.rechat.co/18703050.jpg	13	{}	\N	0	2017-04-08 22:05:49.824219+02
1126bd10-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.833335+01	2016-01-18 02:34:57.528414+01	\N	18703046	2360683		http://cdn.rechat.co/18703046.jpg	9	{}	\N	0	2017-04-08 22:05:49.824219+02
1135f71c-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.9332+01	2016-01-18 02:34:56.931952+01	\N	18703057	2360683		http://cdn.rechat.co/18703057.jpg	20	{}	\N	0	2017-04-08 22:05:49.82422+02
1135607c-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.929345+01	2016-01-18 02:34:57.105361+01	\N	18703054	2360683		http://cdn.rechat.co/18703054.jpg	17	{}	\N	0	2017-04-08 22:05:49.82422+02
113530d4-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.928096+01	2016-01-18 02:34:57.189586+01	\N	18703053	2360683		http://cdn.rechat.co/18703053.jpg	16	{}	\N	0	2017-04-08 22:05:49.824221+02
1125a43e-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.826148+01	2016-01-18 02:34:57.636855+01	\N	18703043	2360683		http://cdn.rechat.co/18703043.jpg	6	{}	\N	0	2017-04-08 22:05:49.824221+02
112529fa-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.823026+01	2016-01-18 02:34:57.736786+01	\N	18703041	2360683		http://cdn.rechat.co/18703041.jpg	4	{}	\N	0	2017-04-08 22:05:49.824221+02
1125678a-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.824584+01	2016-01-18 02:34:58.74833+01	\N	18703042	2360683		http://cdn.rechat.co/18703042.jpg	5	{}	\N	0	2017-04-08 22:05:49.824222+02
11273c86-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.836588+01	2016-01-18 02:34:57.457857+01	\N	18703048	2360683		http://cdn.rechat.co/18703048.jpg	11	{}	\N	0	2017-04-08 22:05:49.824222+02
11362930-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.934457+01	2016-01-18 02:34:56.921585+01	\N	18703058	2360683		http://cdn.rechat.co/18703058.jpg	21	{}	\N	0	2017-04-08 22:06:03.945315+02
113659fa-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.935696+01	2016-01-18 02:34:56.92946+01	\N	18703059	2360683		http://cdn.rechat.co/18703059.jpg	22	{}	\N	0	2017-04-08 22:06:03.945316+02
11359808-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.93076+01	2016-01-18 02:34:57.108165+01	\N	18703055	2360683		http://cdn.rechat.co/18703055.jpg	18	{}	\N	0	2017-04-08 22:06:03.945316+02
11277c0a-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.838223+01	2016-01-18 02:34:57.384987+01	\N	18703049	2360683		http://cdn.rechat.co/18703049.jpg	12	{}	\N	0	2017-04-08 22:06:03.945317+02
1127de3e-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.840795+01	2016-01-18 02:34:57.320351+01	\N	18703051	2360683		http://cdn.rechat.co/18703051.jpg	14	{}	\N	0	2017-04-08 22:06:03.945336+02
1126fe2e-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.835007+01	2016-01-18 02:34:57.495192+01	\N	18703047	2360683		http://cdn.rechat.co/18703047.jpg	10	{}	\N	0	2017-04-08 22:06:03.945336+02
112653ca-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.830642+01	2016-01-18 02:34:57.595476+01	\N	18703045	2360683		http://cdn.rechat.co/18703045.jpg	8	{}	\N	0	2017-04-08 22:06:03.945337+02
1134f5b0-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.926511+01	2016-01-18 02:34:57.778979+01	\N	18703052	2360683		http://cdn.rechat.co/18703052.jpg	15	{}	\N	0	2017-04-08 22:06:03.945338+02
1124b10a-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.819952+01	2016-01-18 02:34:57.850584+01	\N	18703039	2360683		http://cdn.rechat.co/18703039.jpg	2	{}	\N	0	2017-04-08 22:06:03.945338+02
112425a0-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.81643+01	2016-01-18 02:34:58.062307+01	\N	18703036	2360683		http://cdn.rechat.co/18703036.jpg	23	{}	\N	0	2017-04-08 22:06:03.945339+02
1124528c-a2ee-11e5-945d-f23c91c841bd	2015-12-15 06:38:27.81758+01	2016-01-18 02:34:58.926444+01	\N	18703037	2360683		http://cdn.rechat.co/18703037.jpg	0	{}	\N	0	2017-04-08 22:06:03.945345+02
edd0f3d2-a2e6-11e5-aee9-f23c91c841bd	2015-12-15 05:47:22.073839+01	2016-01-24 07:23:10.958286+01	\N	18228306	2388816		http://cdn.rechat.co/18228306.jpg	6	{}	\N	0	2017-04-08 22:05:49.642067+02
edcf9a14-a2e6-11e5-aee9-f23c91c841bd	2015-12-15 05:47:22.064986+01	2016-01-24 07:23:11.188107+01	\N	18228300	2388816		http://cdn.rechat.co/18228300.jpg	0	{}	\N	0	2017-04-08 22:05:49.642265+02
edd0ba52-a2e6-11e5-aee9-f23c91c841bd	2015-12-15 05:47:22.072363+01	2016-01-24 07:23:10.961771+01	\N	18228305	2388816		http://cdn.rechat.co/18228305.jpg	5	{}	\N	0	2017-04-08 22:05:49.642298+02
edd043c4-a2e6-11e5-aee9-f23c91c841bd	2015-12-15 05:47:22.069333+01	2016-01-24 07:23:11.109829+01	\N	18228303	2388816		http://cdn.rechat.co/18228303.jpg	3	{}	\N	0	2017-04-08 22:05:49.642299+02
edd16aba-a2e6-11e5-aee9-f23c91c841bd	2015-12-15 05:47:22.076799+01	2016-01-24 07:23:10.88153+01	\N	18228308	2388816		http://cdn.rechat.co/18228308.jpg	8	{}	\N	0	2017-04-08 22:05:49.6423+02
edd129d8-a2e6-11e5-aee9-f23c91c841bd	2015-12-15 05:47:22.075223+01	2016-01-24 07:23:10.945196+01	\N	18228307	2388816		http://cdn.rechat.co/18228307.jpg	7	{}	\N	0	2017-04-08 22:05:49.642301+02
edd07e70-a2e6-11e5-aee9-f23c91c841bd	2015-12-15 05:47:22.070827+01	2016-01-24 07:23:11.023065+01	\N	18228304	2388816		http://cdn.rechat.co/18228304.jpg	4	{}	\N	0	2017-04-08 22:05:49.642301+02
edd00cba-a2e6-11e5-aee9-f23c91c841bd	2015-12-15 05:47:22.067925+01	2016-01-24 07:23:11.133165+01	\N	18228302	2388816	HOME VACANT NO APPLAINCES	http://cdn.rechat.co/18228302.jpg	2	{}	\N	0	2017-04-08 22:05:49.642302+02
edcf5fe0-a2e6-11e5-aee9-f23c91c841bd	2015-12-15 05:47:22.063481+01	2016-01-24 07:23:11.246755+01	\N	18228299	2388816		http://cdn.rechat.co/18228299.jpg	9	{}	\N	0	2017-04-08 22:05:49.642309+02
edcfd4d4-a2e6-11e5-aee9-f23c91c841bd	2015-12-15 05:47:22.066482+01	2016-01-24 07:23:11.178121+01	\N	18228301	2388816		http://cdn.rechat.co/18228301.jpg	1	{}	\N	0	2017-04-08 22:06:04.146823+02
f7789d1e-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.932011+01	2016-01-23 03:09:46.91221+01	\N	22877409	2412482		http://cdn.rechat.co/22877409.jpg	10	{}	\N	0	2017-04-08 22:05:48.612495+02
f7777fc4-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.924701+01	2016-01-23 03:09:47.310678+01	\N	22877401	2412482		http://cdn.rechat.co/22877401.jpg	2	{}	\N	0	2017-04-08 22:05:52.627283+02
f7774158-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.923114+01	2016-01-23 03:09:47.481222+01	\N	22877399	2412482		http://cdn.rechat.co/22877399.jpg	0	{}	\N	0	2017-04-08 22:05:52.627285+02
f7772006-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.922257+01	2016-01-23 03:09:47.544054+01	\N	22877398	2412482		http://cdn.rechat.co/22877398.jpg	23	{}	\N	0	2017-04-08 22:05:52.627286+02
f7798c9c-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.938128+01	2016-01-23 03:09:46.5479+01	\N	22877416	2412482		http://cdn.rechat.co/22877416.jpg	17	{}	\N	0	2017-04-08 22:05:52.627287+02
f779e656-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.940333+01	2016-01-23 03:09:46.568435+01	\N	22877418	2412482		http://cdn.rechat.co/22877418.jpg	19	{}	\N	0	2017-04-08 22:05:52.627288+02
f779af7e-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.939039+01	2016-01-23 03:09:46.487516+01	\N	22877417	2412482		http://cdn.rechat.co/22877417.jpg	18	{}	\N	0	2017-04-08 22:05:52.627289+02
f7783b44-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.929454+01	2016-01-23 03:09:47.076327+01	\N	22877406	2412482		http://cdn.rechat.co/22877406.jpg	7	{}	\N	0	2017-04-08 22:05:52.62729+02
f7792540-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.93547+01	2016-01-23 03:09:46.690683+01	\N	22877413	2412482		http://cdn.rechat.co/22877413.jpg	14	{}	\N	0	2017-04-08 22:05:52.62729+02
f778ea12-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.933951+01	2016-01-23 03:09:46.797028+01	\N	22877411	2412482		http://cdn.rechat.co/22877411.jpg	12	{}	\N	0	2017-04-08 22:05:52.62729+02
f778bc40-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.932815+01	2016-01-23 03:09:46.851268+01	\N	22877410	2412482		http://cdn.rechat.co/22877410.jpg	11	{}	\N	0	2017-04-08 22:05:52.627291+02
f7787f3c-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.931219+01	2016-01-23 03:09:46.990633+01	\N	22877408	2412482		http://cdn.rechat.co/22877408.jpg	9	{}	\N	0	2017-04-08 22:05:52.627291+02
f778179a-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.928522+01	2016-01-23 03:09:47.074486+01	\N	22877405	2412482		http://cdn.rechat.co/22877405.jpg	6	{}	\N	0	2017-04-08 22:05:52.627292+02
f777c42a-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.926459+01	2016-01-23 03:09:47.213821+01	\N	22877403	2412482		http://cdn.rechat.co/22877403.jpg	4	{}	\N	0	2017-04-08 22:05:52.627293+02
f77a3570-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.942383+01	2016-01-23 03:09:46.540888+01	\N	22877420	2412482		http://cdn.rechat.co/22877420.jpg	21	{}	\N	0	2017-04-08 22:06:04.7753+02
f77a611c-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.943487+01	2016-01-23 03:09:46.573223+01	\N	22877421	2412482		http://cdn.rechat.co/22877421.jpg	22	{}	\N	0	2017-04-08 22:06:04.7753+02
f7795dbc-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.93695+01	2016-01-23 03:09:46.650578+01	\N	22877415	2412482		http://cdn.rechat.co/22877415.jpg	16	{}	\N	0	2017-04-08 22:06:04.775301+02
f77940ca-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.936205+01	2016-01-23 03:09:46.714832+01	\N	22877414	2412482		http://cdn.rechat.co/22877414.jpg	15	{}	\N	0	2017-04-08 22:06:04.775301+02
f77909de-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.93477+01	2016-01-23 03:09:46.920002+01	\N	22877412	2412482		http://cdn.rechat.co/22877412.jpg	13	{}	\N	0	2017-04-08 22:06:04.775302+02
f7785c46-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.930293+01	2016-01-23 03:09:46.999719+01	\N	22877407	2412482		http://cdn.rechat.co/22877407.jpg	8	{}	\N	0	2017-04-08 22:06:04.775302+02
f777eae0-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.92745+01	2016-01-23 03:09:47.127618+01	\N	22877404	2412482		http://cdn.rechat.co/22877404.jpg	5	{}	\N	0	2017-04-08 22:06:04.775302+02
f777a0f8-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.925539+01	2016-01-23 03:09:47.265573+01	\N	22877402	2412482		http://cdn.rechat.co/22877402.jpg	3	{}	\N	0	2017-04-08 22:06:04.775303+02
f7775f76-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.923885+01	2016-01-23 03:09:47.427987+01	\N	22877400	2412482		http://cdn.rechat.co/22877400.jpg	1	{}	\N	0	2017-04-08 22:06:04.775303+02
f77a1130-a34e-11e5-8e37-f23c91c841bd	2015-12-15 18:12:05.941445+01	2016-01-23 03:09:47.554538+01	\N	22877419	2412482		http://cdn.rechat.co/22877419.jpg	20	{}	\N	0	2017-04-08 22:06:04.775304+02
5df0cecc-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.977865+01	2016-01-17 12:36:26.007544+01	\N	20710957	2435482	Large manicured backyard	http://cdn.rechat.co/20710957.jpg	23	{}	\N	0	2017-04-08 22:05:48.560055+02
5deabc8a-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.938251+01	2016-01-17 12:36:27.825066+01	\N	20710936	2435482	Sweeping staircase. Handscraped wood floors	http://cdn.rechat.co/20710936.jpg	2	{}	\N	0	2017-04-08 22:05:48.560056+02
5ded515c-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.955196+01	2016-01-17 12:36:26.018132+01	\N	20710953	2435482	Upstairs bedroom with bonus room & bath	http://cdn.rechat.co/20710953.jpg	19	{}	\N	0	2017-04-08 22:05:51.509035+02
5dea6122-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.935942+01	2016-01-17 12:36:26.945986+01	\N	20710934	2435482	5716 Charlestown Dr	http://cdn.rechat.co/20710934.jpg	0	{}	\N	0	2017-04-08 22:05:51.509035+02
5dec3dda-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.948166+01	2016-01-17 12:36:26.323369+01	\N	20710946	2435482	View of Master toward bath	http://cdn.rechat.co/20710946.jpg	12	{}	\N	0	2017-04-08 22:05:51.509036+02
5dec1d96-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.947345+01	2016-01-17 12:36:26.384662+01	\N	20710945	2435482	Master suite, large windows, handscraped wood floor	http://cdn.rechat.co/20710945.jpg	11	{}	\N	0	2017-04-08 22:05:51.509037+02
5ded75f6-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.956147+01	2016-01-17 12:36:25.933198+01	\N	20710954	2435482	Sitting area	http://cdn.rechat.co/20710954.jpg	20	{}	\N	0	2017-04-08 22:05:51.509037+02
5ded3000-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.95438+01	2016-01-17 12:36:26.035558+01	\N	20710952	2435482	Upstairs bedroom with bath	http://cdn.rechat.co/20710952.jpg	18	{}	\N	0	2017-04-08 22:05:51.509038+02
5deb12f2-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.940503+01	2016-01-17 12:36:26.653535+01	\N	20710938	2435482	Formal Living with stone fireplace	http://cdn.rechat.co/20710938.jpg	4	{}	\N	0	2017-04-08 22:05:51.509039+02
5ded0f76-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.953523+01	2016-01-17 12:36:26.145825+01	\N	20710951	2435482	Upstairs bedroom with bath	http://cdn.rechat.co/20710951.jpg	17	{}	\N	0	2017-04-08 22:05:51.509039+02
5decbf3a-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.951524+01	2016-01-17 12:36:26.240206+01	\N	20710949	2435482	Upstairs gameroom	http://cdn.rechat.co/20710949.jpg	15	{}	\N	0	2017-04-08 22:05:51.50904+02
5decdde4-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.952296+01	2016-01-17 12:36:26.875025+01	\N	20710950	2435482	Upstairs Media room, wet bar, refrigerator, equipment cabinet	http://cdn.rechat.co/20710950.jpg	16	{}	\N	0	2017-04-08 22:05:51.50904+02
5debd732-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.945488+01	2016-01-17 12:36:26.420231+01	\N	20710943	2435482	Wolf gas stoves & 6 burner cooktop & grill	http://cdn.rechat.co/20710943.jpg	9	{}	\N	0	2017-04-08 22:05:51.509047+02
5debb158-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.944487+01	2016-01-17 12:36:26.463308+01	\N	20710942	2435482	Huge island kitchen, Subzero, dual dishwashers	http://cdn.rechat.co/20710942.jpg	8	{}	\N	0	2017-04-08 22:05:51.509048+02
5deb4344-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.941693+01	2016-01-17 12:36:26.543143+01	\N	20710939	2435482	Family room with views of the outdoor kitchen & yard	http://cdn.rechat.co/20710939.jpg	5	{}	\N	0	2017-04-08 22:05:51.509049+02
5dea94e4-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.937212+01	2016-01-17 12:36:26.80842+01	\N	20710935	2435482	Stunning entry, opens to formals	http://cdn.rechat.co/20710935.jpg	1	{}	\N	0	2017-04-08 22:05:51.509051+02
5deb689c-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.94265+01	2016-01-17 12:36:28.601001+01	\N	20710940	2435482	Gorgeous family room opens to the kitchen	http://cdn.rechat.co/20710940.jpg	6	{}	\N	0	2017-04-08 22:05:51.509053+02
5dedbb6a-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.957974+01	2016-01-17 12:36:25.945225+01	\N	20710956	2435482	Outdoor kitchen, fireplace, grill, large covered patio	http://cdn.rechat.co/20710956.jpg	22	{}	\N	0	2017-04-08 22:06:03.391125+02
5ded9e1e-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.957202+01	2016-01-17 12:36:25.992594+01	\N	20710955	2435482	Craft room with 3 walls of built-in shelves	http://cdn.rechat.co/20710955.jpg	21	{}	\N	0	2017-04-08 22:06:03.391138+02
5deca022-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.950712+01	2016-01-17 12:36:26.321436+01	\N	20710948	2435482	Custom Master closet with built-in dresser	http://cdn.rechat.co/20710948.jpg	14	{}	\N	0	2017-04-08 22:06:03.391139+02
5debfd52-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.94651+01	2016-01-17 12:36:26.367281+01	\N	20710944	2435482	Guest room with French doors leading to the patio. Private bath	http://cdn.rechat.co/20710944.jpg	10	{}	\N	0	2017-04-08 22:06:03.39114+02
5dec7fe8-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.94988+01	2016-01-17 12:36:26.376577+01	\N	20710947	2435482	Master bath, dual vanities, makeup counter, jetted tub, shower w/multiple body sprays	http://cdn.rechat.co/20710947.jpg	13	{}	\N	0	2017-04-08 22:06:03.391141+02
5deae41c-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.939316+01	2016-01-17 12:36:26.649763+01	\N	20710937	2435482	Handsome private study with French doors	http://cdn.rechat.co/20710937.jpg	3	{}	\N	0	2017-04-08 22:06:03.391142+02
5dea32ba-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.934752+01	2016-01-17 12:36:26.846554+01	\N	20710933	2435482	Extended driveway with electric gate. 4 car garage	http://cdn.rechat.co/20710933.jpg	24	{}	\N	0	2017-04-08 22:06:03.391142+02
5deb8c14-a327-11e5-884c-f23c91c841bd	2015-12-15 13:28:37.943556+01	2016-01-17 12:36:26.923411+01	\N	20710941	2435482	Walk-in wet bar, wine racks, & wine refrigerator	http://cdn.rechat.co/20710941.jpg	7	{}	\N	0	2017-04-08 22:06:03.391143+02
32a38aa0-a324-11e5-bf62-f23c91c841bd	2015-12-15 13:05:56.839537+01	2016-01-17 15:30:23.769082+01	\N	20505473	2442473		http://cdn.rechat.co/20505473.jpg	6	{}	\N	0	2017-04-08 22:05:51.435894+02
32a0cf40-a324-11e5-bf62-f23c91c841bd	2015-12-15 13:05:56.821586+01	2016-01-17 15:30:23.886773+01	\N	20505466	2442473	Kitchen has state of the art appliances and cabinets	http://cdn.rechat.co/20505466.jpg	8	{}	\N	0	2017-04-08 22:05:51.435896+02
32a361ce-a324-11e5-bf62-f23c91c841bd	2015-12-15 13:05:56.838256+01	2016-01-17 15:30:24.281459+01	\N	20505472	2442473		http://cdn.rechat.co/20505472.jpg	5	{}	\N	0	2017-04-08 22:05:51.435897+02
32a18cf0-a324-11e5-bf62-f23c91c841bd	2015-12-15 13:05:56.826309+01	2016-01-17 15:30:24.059646+01	\N	20505467	2442473	Furnished one bedroom in the South Tower Victory Plaza	http://cdn.rechat.co/20505467.jpg	0	{}	\N	0	2017-04-08 22:06:03.494279+02
32a2905a-a324-11e5-bf62-f23c91c841bd	2015-12-15 13:05:56.833053+01	2016-01-17 15:30:24.294894+01	\N	20505470	2442473	elegant furniture, spacious rooms, awesome finish and amenities	http://cdn.rechat.co/20505470.jpg	3	{}	\N	0	2017-04-08 22:06:03.49428+02
32a2e9f6-a324-11e5-bf62-f23c91c841bd	2015-12-15 13:05:56.835203+01	2016-01-17 15:30:23.76563+01	\N	20505471	2442473	Relax and enjoy your evening	http://cdn.rechat.co/20505471.jpg	4	{}	\N	0	2017-04-08 22:06:03.494967+02
32a3d24e-a324-11e5-bf62-f23c91c841bd	2015-12-15 13:05:56.841286+01	2016-01-17 15:30:23.770102+01	\N	20505474	2442473	huge breakfast bar	http://cdn.rechat.co/20505474.jpg	7	{}	\N	0	2017-04-08 22:06:03.494968+02
32a25b6c-a324-11e5-bf62-f23c91c841bd	2015-12-15 13:05:56.831673+01	2016-01-17 15:30:23.773234+01	\N	20505469	2442473		http://cdn.rechat.co/20505469.jpg	2	{}	\N	0	2017-04-08 22:06:03.494969+02
32a20dd8-a324-11e5-bf62-f23c91c841bd	2015-12-15 13:05:56.829614+01	2016-01-17 15:30:23.883843+01	\N	20505468	2442473	Amazing views of downtown Calatrava bridge	http://cdn.rechat.co/20505468.jpg	1	{}	\N	0	2017-04-08 22:06:03.49497+02
cbbf5d96-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.216546+01	2016-01-17 15:49:11.993105+01	\N	20483378	2450807		http://cdn.rechat.co/20483378.jpg	7	{}	\N	0	2017-04-08 22:05:48.554227+02
cbc3be04-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.245232+01	2016-01-17 15:49:11.736684+01	\N	20483382	2450807		http://cdn.rechat.co/20483382.jpg	11	{}	\N	0	2017-04-08 22:05:51.428354+02
cbc00840-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.220794+01	2016-01-17 15:49:11.745802+01	\N	20483380	2450807		http://cdn.rechat.co/20483380.jpg	9	{}	\N	0	2017-04-08 22:05:51.428355+02
cbc38218-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.243494+01	2016-01-17 15:49:11.80364+01	\N	20483381	2450807		http://cdn.rechat.co/20483381.jpg	10	{}	\N	0	2017-04-08 22:05:51.428356+02
cbbfa36e-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.218271+01	2016-01-17 15:49:11.845726+01	\N	20483379	2450807		http://cdn.rechat.co/20483379.jpg	8	{}	\N	0	2017-04-08 22:05:51.428358+02
cbbeb580-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.212243+01	2016-01-17 15:49:12.119138+01	\N	20483375	2450807		http://cdn.rechat.co/20483375.jpg	4	{}	\N	0	2017-04-08 22:05:51.428359+02
cbc44f9a-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.248865+01	2016-01-17 15:49:11.646903+01	\N	20483385	2450807		http://cdn.rechat.co/20483385.jpg	14	{}	\N	0	2017-04-08 22:05:51.42836+02
cbc41ac0-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.247602+01	2016-01-17 15:49:11.668333+01	\N	20483384	2450807		http://cdn.rechat.co/20483384.jpg	13	{}	\N	0	2017-04-08 22:05:51.428361+02
cbc3ecb2-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.246408+01	2016-01-17 15:49:11.673853+01	\N	20483383	2450807		http://cdn.rechat.co/20483383.jpg	12	{}	\N	0	2017-04-08 22:05:51.428368+02
cbbeed48-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.213665+01	2016-01-17 15:49:11.987874+01	\N	20483376	2450807		http://cdn.rechat.co/20483376.jpg	5	{}	\N	0	2017-04-08 22:05:51.428369+02
cbbe293a-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.208614+01	2016-01-17 15:49:12.429211+01	\N	20483372	2450807		http://cdn.rechat.co/20483372.jpg	1	{}	\N	0	2017-04-08 22:05:51.428369+02
cbc4c8b2-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.252028+01	2016-01-17 15:49:12.115268+01	\N	20483388	2450807		http://cdn.rechat.co/20483388.jpg	17	{}	\N	0	2017-04-08 22:05:51.42837+02
cbbe5842-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.209859+01	2016-01-17 15:49:12.651394+01	\N	20483373	2450807		http://cdn.rechat.co/20483373.jpg	2	{}	\N	0	2017-04-08 22:05:51.428371+02
cbbdf992-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.2074+01	2016-01-17 15:49:12.343089+01	\N	20483371	2450807		http://cdn.rechat.co/20483371.jpg	24	{}	\N	0	2017-04-08 22:05:51.428371+02
cbbdc0bc-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.205974+01	2016-01-17 15:49:12.406844+01	\N	20483370	2450807		http://cdn.rechat.co/20483370.jpg	0	{}	\N	0	2017-04-08 22:05:51.428371+02
cbc590ee-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.257172+01	2016-01-17 15:49:14.074225+01	\N	20483393	2450807		http://cdn.rechat.co/20483393.jpg	22	{}	\N	0	2017-04-08 22:05:51.428375+02
cbbe8704-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.211057+01	2016-01-17 15:49:13.250407+01	\N	20483374	2450807		http://cdn.rechat.co/20483374.jpg	3	{}	\N	0	2017-04-08 22:05:51.428376+02
cbc5bb6e-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.258262+01	2016-01-17 15:49:11.389857+01	\N	20483394	2450807		http://cdn.rechat.co/20483394.jpg	23	{}	\N	0	2017-04-08 22:06:03.638639+02
cbc4f918-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.253229+01	2016-01-17 15:49:11.549117+01	\N	20483389	2450807		http://cdn.rechat.co/20483389.jpg	18	{}	\N	0	2017-04-08 22:06:03.63864+02
cbc499e6-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.250861+01	2016-01-17 15:49:11.578143+01	\N	20483387	2450807		http://cdn.rechat.co/20483387.jpg	16	{}	\N	0	2017-04-08 22:06:03.638641+02
cbc47696-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.2499+01	2016-01-17 15:49:11.594763+01	\N	20483386	2450807		http://cdn.rechat.co/20483386.jpg	15	{}	\N	0	2017-04-08 22:06:03.63871+02
cbbf2470-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.215065+01	2016-01-17 15:49:13.002006+01	\N	20483377	2450807		http://cdn.rechat.co/20483377.jpg	6	{}	\N	0	2017-04-08 22:06:03.638744+02
cbc53928-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.254942+01	2016-01-17 15:49:11.42624+01	\N	20483391	2450807		http://cdn.rechat.co/20483391.jpg	20	{}	\N	0	2017-04-08 22:06:03.638978+02
cbc56344-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.256021+01	2016-01-17 15:49:11.46958+01	\N	20483392	2450807		http://cdn.rechat.co/20483392.jpg	21	{}	\N	0	2017-04-08 22:06:03.638979+02
cbc51b14-a323-11e5-b1e7-f23c91c841bd	2015-12-15 13:03:04.254127+01	2016-01-17 15:49:11.474391+01	\N	20483390	2450807		http://cdn.rechat.co/20483390.jpg	19	{}	\N	0	2017-04-08 22:06:03.638979+02
832ecf88-a32f-11e5-8337-f23c91c841bd	2015-12-15 14:26:56.433997+01	2016-01-17 01:06:48.101622+01	\N	21322496	2497853	Front Elevation from Street	http://cdn.rechat.co/21322496.jpg	0	{}	\N	0	2017-04-08 22:05:48.574077+02
181b4df4-a355-11e5-b7c4-f23c91c841bd	2015-12-15 18:55:57.665603+01	2016-01-17 02:05:09.007345+01	\N	23123097	1090971	KITCHEN SHOWING PLANT SHELF	http://cdn.rechat.co/23123097.jpg	8	{}	\N	0	2017-04-08 22:05:48.374936+02
181b0ad8-a355-11e5-b7c4-f23c91c841bd	2015-12-15 18:55:57.663955+01	2016-01-17 02:05:09.010253+01	\N	23123096	1090971	LOOKING TOWARDS ENTRY	http://cdn.rechat.co/23123096.jpg	7	{}	\N	0	2017-04-08 22:05:48.37495+02
1818e3de-a355-11e5-b7c4-f23c91c841bd	2015-12-15 18:55:57.649842+01	2016-01-17 02:08:18.247674+01	\N	23123088	1090971	ANOTHER VIEW OF COURTYARD	http://cdn.rechat.co/23123088.jpg	12	{}	\N	0	2017-04-08 22:05:48.618073+02
181ac71c-a355-11e5-b7c4-f23c91c841bd	2015-12-15 18:55:57.662218+01	2016-01-17 02:05:09.060245+01	\N	23123095	1090971	LIVING AND DINING	http://cdn.rechat.co/23123095.jpg	6	{}	\N	0	2017-04-08 22:05:53.717978+02
181a8de2-a355-11e5-b7c4-f23c91c841bd	2015-12-15 18:55:57.660699+01	2016-01-17 02:05:09.094485+01	\N	23123094	1090971	LIGHT AND BRIGHT KITCHEN	http://cdn.rechat.co/23123094.jpg	5	{}	\N	0	2017-04-08 22:05:53.717987+02
181a45e4-a355-11e5-b7c4-f23c91c841bd	2015-12-15 18:55:57.658913+01	2016-01-17 02:05:09.134653+01	\N	23123093	1090971	UPSTAIRS BATH	http://cdn.rechat.co/23123093.jpg	4	{}	\N	0	2017-04-08 22:05:53.71799+02
1819b87c-a355-11e5-b7c4-f23c91c841bd	2015-12-15 18:55:57.655165+01	2016-01-17 02:05:09.365337+01	\N	23123091	1090971	DOWNSTAIRS BATH	http://cdn.rechat.co/23123091.jpg	2	{}	\N	0	2017-04-08 22:05:53.718006+02
18192772-a355-11e5-b7c4-f23c91c841bd	2015-12-15 18:55:57.651575+01	2016-01-17 02:05:09.46802+01	\N	23123089	1090971		http://cdn.rechat.co/23123089.jpg	0	{}	\N	0	2017-04-08 22:05:53.718007+02
181a03ae-a355-11e5-b7c4-f23c91c841bd	2015-12-15 18:55:57.657187+01	2016-01-17 02:05:09.668004+01	\N	23123092	1090971	HALF BATH	http://cdn.rechat.co/23123092.jpg	3	{}	\N	0	2017-04-08 22:05:53.71801+02
18196a98-a355-11e5-b7c4-f23c91c841bd	2015-12-15 18:55:57.653299+01	2016-01-17 02:05:09.855462+01	\N	23123090	1090971	TWO LARGE MASTER BEDROOMS	http://cdn.rechat.co/23123090.jpg	1	{}	\N	0	2017-04-08 22:05:53.718013+02
181bdc9c-a355-11e5-b7c4-f23c91c841bd	2015-12-15 18:55:57.669288+01	2016-01-17 02:05:12.56933+01	\N	23123099	1090971	OTHER MASTER BED UPSTAIRS	http://cdn.rechat.co/23123099.jpg	10	{}	\N	0	2017-04-08 22:05:53.718016+02
181c2774-a355-11e5-b7c4-f23c91c841bd	2015-12-15 18:55:57.67121+01	2016-01-17 02:05:14.292697+01	\N	23123100	1090971	BACK COURTYARD	http://cdn.rechat.co/23123100.jpg	11	{}	\N	0	2017-04-08 22:05:53.718017+02
181b91d8-a355-11e5-b7c4-f23c91c841bd	2015-12-15 18:55:57.667367+01	2016-01-17 02:08:00.626487+01	\N	23123098	1090971	UPSTAIRS OTHER LIVING AREA	http://cdn.rechat.co/23123098.jpg	9	{}	\N	0	2017-04-08 22:05:53.718018+02
d6e49812-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.850052+01	2016-01-16 16:13:07.413801+01	\N	21913850	2529072		http://cdn.rechat.co/21913850.jpg	17	{}	\N	0	2017-04-08 22:05:47.279657+02
d6e4d566-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.851561+01	2016-01-16 16:13:07.382766+01	\N	21913851	2529072		http://cdn.rechat.co/21913851.jpg	18	{}	\N	0	2017-04-08 22:05:47.279722+02
d6e438a4-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.847624+01	2016-01-16 16:13:07.496642+01	\N	21913848	2529072		http://cdn.rechat.co/21913848.jpg	15	{}	\N	0	2017-04-08 22:05:47.279727+02
d6e4083e-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.846384+01	2016-01-16 16:13:07.529756+01	\N	21913847	2529072		http://cdn.rechat.co/21913847.jpg	14	{}	\N	0	2017-04-08 22:05:47.279727+02
d6e3ac9a-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.844036+01	2016-01-16 16:13:07.649943+01	\N	21913845	2529072		http://cdn.rechat.co/21913845.jpg	12	{}	\N	0	2017-04-08 22:05:47.279727+02
d6e3360c-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.841002+01	2016-01-16 16:13:07.740317+01	\N	21913843	2529072		http://cdn.rechat.co/21913843.jpg	10	{}	\N	0	2017-04-08 22:05:47.279729+02
d6e469a0-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.848848+01	2016-01-16 16:13:07.763123+01	\N	21913849	2529072		http://cdn.rechat.co/21913849.jpg	16	{}	\N	0	2017-04-08 22:05:47.279729+02
d6e306f0-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.839796+01	2016-01-16 16:13:07.81888+01	\N	21913842	2529072		http://cdn.rechat.co/21913842.jpg	9	{}	\N	0	2017-04-08 22:05:47.27973+02
d6e2dc5c-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.838698+01	2016-01-16 16:13:07.939354+01	\N	21913841	2529072		http://cdn.rechat.co/21913841.jpg	8	{}	\N	0	2017-04-08 22:05:47.279731+02
d6e2a336-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.837189+01	2016-01-16 16:13:07.969592+01	\N	21913840	2529072		http://cdn.rechat.co/21913840.jpg	7	{}	\N	0	2017-04-08 22:05:47.279731+02
d6e276d6-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.835892+01	2016-01-16 16:13:08.032073+01	\N	21913839	2529072		http://cdn.rechat.co/21913839.jpg	6	{}	\N	0	2017-04-08 22:05:47.279732+02
d6e3dc1a-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.845249+01	2016-01-16 16:13:08.101776+01	\N	21913846	2529072		http://cdn.rechat.co/21913846.jpg	13	{}	\N	0	2017-04-08 22:05:47.279732+02
d6e13c12-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.82803+01	2016-01-16 16:13:08.159925+01	\N	21913836	2529072		http://cdn.rechat.co/21913836.jpg	3	{}	\N	0	2017-04-08 22:05:47.279733+02
d6e0d2f4-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.825357+01	2016-01-16 16:13:08.365772+01	\N	21913834	2529072		http://cdn.rechat.co/21913834.jpg	1	{}	\N	0	2017-04-08 22:05:47.279734+02
d6e0a90a-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.82428+01	2016-01-16 16:13:08.403131+01	\N	21913833	2529072		http://cdn.rechat.co/21913833.jpg	0	{}	\N	0	2017-04-08 22:05:47.279734+02
d6e07e12-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.82314+01	2016-01-16 16:13:08.498066+01	\N	21913832	2529072		http://cdn.rechat.co/21913832.jpg	19	{}	\N	0	2017-04-08 22:05:47.279735+02
d6e16c64-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.829278+01	2016-01-16 16:13:09.462577+01	\N	21913837	2529072		http://cdn.rechat.co/21913837.jpg	4	{}	\N	0	2017-04-08 22:05:47.279757+02
d6e1a6f2-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.830783+01	2016-01-16 16:13:09.59504+01	\N	21913838	2529072		http://cdn.rechat.co/21913838.jpg	5	{}	\N	0	2017-04-08 22:05:47.279759+02
d6e380c6-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.842892+01	2016-01-16 16:13:09.753466+01	\N	21913844	2529072		http://cdn.rechat.co/21913844.jpg	11	{}	\N	0	2017-04-08 22:05:47.27976+02
d6e10238-a337-11e5-9a6c-f23c91c841bd	2015-12-15 15:26:32.826554+01	2016-01-16 16:13:35.529451+01	\N	21913835	2529072		http://cdn.rechat.co/21913835.jpg	2	{}	\N	0	2017-04-08 22:05:47.280119+02
61886ca8-a330-11e5-82e8-f23c91c841bd	2015-12-15 14:33:09.475437+01	2016-01-16 23:55:55.966532+01	\N	21389591	1101151	Front From Meadow Road	http://cdn.rechat.co/21389591.jpg	0	{}	\N	0	2017-04-08 22:05:47.663971+02
6188a6c8-a330-11e5-82e8-f23c91c841bd	2015-12-15 14:33:09.476904+01	2016-01-16 23:55:58.481621+01	\N	21389592	1101151	Backyard From Ally	http://cdn.rechat.co/21389592.jpg	1	{}	\N	0	2017-04-08 22:05:52.177576+02
6ec0f054-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:20.015605+01	2016-01-15 02:44:08.171012+01	\N	37919824	37919010		http://cdn.rechat.co/37919824.jpg	22	{}	\N	0	2017-04-08 22:06:06.219284+02
6ec12cd6-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:20.017+01	2016-01-15 02:44:08.19875+01	\N	37919825	37919010		http://cdn.rechat.co/37919825.jpg	23	{}	\N	0	2017-04-08 22:06:06.219284+02
6ec09a32-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:20.013291+01	2016-01-15 02:44:08.221798+01	\N	37919822	37919010		http://cdn.rechat.co/37919822.jpg	20	{}	\N	0	2017-04-08 22:06:06.219284+02
6ec0681e-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:20.012069+01	2016-01-15 02:44:08.255956+01	\N	37919821	37919010		http://cdn.rechat.co/37919821.jpg	19	{}	\N	0	2017-04-08 22:06:06.219285+02
6ec03ea2-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:20.011005+01	2016-01-15 02:44:08.291716+01	\N	37919820	37919010		http://cdn.rechat.co/37919820.jpg	18	{}	\N	0	2017-04-08 22:06:06.219292+02
6ec014e0-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:20.009919+01	2016-01-15 02:44:08.295962+01	\N	37919819	37919010		http://cdn.rechat.co/37919819.jpg	17	{}	\N	0	2017-04-08 22:06:06.219293+02
6ebfa208-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:20.006958+01	2016-01-15 02:44:08.366124+01	\N	37919817	37919010		http://cdn.rechat.co/37919817.jpg	15	{}	\N	0	2017-04-08 22:06:06.219293+02
6ebfcf76-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:20.008156+01	2016-01-15 02:44:08.36753+01	\N	37919818	37919010		http://cdn.rechat.co/37919818.jpg	16	{}	\N	0	2017-04-08 22:06:06.219294+02
6ebf425e-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:20.004509+01	2016-01-15 02:44:08.385261+01	\N	37919816	37919010		http://cdn.rechat.co/37919816.jpg	14	{}	\N	0	2017-04-08 22:06:06.219294+02
6ec0c016-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:20.014319+01	2016-01-15 02:44:08.407078+01	\N	37919823	37919010		http://cdn.rechat.co/37919823.jpg	21	{}	\N	0	2017-04-08 22:06:06.219294+02
6ebf073a-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:20.003107+01	2016-01-15 02:44:08.574833+01	\N	37919815	37919010		http://cdn.rechat.co/37919815.jpg	13	{}	\N	0	2017-04-08 22:06:06.219295+02
6ebeb2a8-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:20.000832+01	2016-01-15 02:44:08.596259+01	\N	37919813	37919010		http://cdn.rechat.co/37919813.jpg	11	{}	\N	0	2017-04-08 22:06:06.219295+02
6eaf5808-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:19.900286+01	2016-01-15 02:44:08.639266+01	\N	37919812	37919010		http://cdn.rechat.co/37919812.jpg	10	{}	\N	0	2017-04-08 22:06:06.219296+02
6ebed9fe-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:20.001933+01	2016-01-15 02:44:08.65461+01	\N	37919814	37919010		http://cdn.rechat.co/37919814.jpg	12	{}	\N	0	2017-04-08 22:06:06.219296+02
6eaf26bc-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:19.899041+01	2016-01-15 02:44:08.715228+01	\N	37919811	37919010		http://cdn.rechat.co/37919811.jpg	9	{}	\N	0	2017-04-08 22:06:06.219296+02
6eaebfec-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:19.896411+01	2016-01-15 02:44:08.752773+01	\N	37919809	37919010		http://cdn.rechat.co/37919809.jpg	7	{}	\N	0	2017-04-08 22:06:06.219297+02
6eaef46c-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:19.897735+01	2016-01-15 02:44:08.754847+01	\N	37919810	37919010		http://cdn.rechat.co/37919810.jpg	8	{}	\N	0	2017-04-08 22:06:06.219297+02
6eae929c-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:19.895237+01	2016-01-15 02:44:08.778411+01	\N	37919808	37919010		http://cdn.rechat.co/37919808.jpg	6	{}	\N	0	2017-04-08 22:06:06.219298+02
6eae442c-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:19.893003+01	2016-01-15 02:44:08.859739+01	\N	37919807	37919010		http://cdn.rechat.co/37919807.jpg	5	{}	\N	0	2017-04-08 22:06:06.219298+02
6ea6b342-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:19.843641+01	2016-01-15 02:44:08.883248+01	\N	37919805	37919010		http://cdn.rechat.co/37919805.jpg	3	{}	\N	0	2017-04-08 22:06:06.219299+02
6ea6ea7e-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:19.845057+01	2016-01-15 02:44:08.911599+01	\N	37919806	37919010		http://cdn.rechat.co/37919806.jpg	4	{}	\N	0	2017-04-08 22:06:06.219299+02
6ea67ae4-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:19.842148+01	2016-01-15 02:44:09.001254+01	\N	37919804	37919010		http://cdn.rechat.co/37919804.jpg	2	{}	\N	0	2017-04-08 22:06:06.219306+02
6ea6140a-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:19.839521+01	2016-01-15 02:44:09.012139+01	\N	37919803	37919010		http://cdn.rechat.co/37919803.jpg	1	{}	\N	0	2017-04-08 22:06:06.219307+02
6ea5d7a6-a35b-11e5-9a6e-f23c91c841bd	2015-12-15 19:41:19.837871+01	2016-01-15 02:44:09.213694+01	\N	37919802	37919010		http://cdn.rechat.co/37919802.jpg	0	{}	\N	0	2017-04-08 22:06:06.219307+02
3587f844-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.489235+01	2016-01-15 22:06:07.772627+01	\N	43535749	43529959		http://cdn.rechat.co/43535749.jpg	11	{}	\N	0	2017-04-08 22:05:36.586301+02
358aa666-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.50661+01	2016-01-15 22:06:07.429748+01	\N	43535762	43529959		http://cdn.rechat.co/43535762.jpg	24	{}	\N	0	2017-04-08 22:05:36.586378+02
358992f8-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.499711+01	2016-01-15 22:06:07.53315+01	\N	43535757	43529959		http://cdn.rechat.co/43535757.jpg	19	{}	\N	0	2017-04-08 22:05:36.586378+02
35895f54-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.498424+01	2016-01-15 22:06:07.611954+01	\N	43535756	43529959		http://cdn.rechat.co/43535756.jpg	18	{}	\N	0	2017-04-08 22:05:36.586379+02
35886040-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.491841+01	2016-01-15 22:06:07.714011+01	\N	43535751	43529959		http://cdn.rechat.co/43535751.jpg	13	{}	\N	0	2017-04-08 22:05:36.586416+02
35873d64-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.484448+01	2016-01-15 22:06:07.912676+01	\N	43535746	43529959		http://cdn.rechat.co/43535746.jpg	8	{}	\N	0	2017-04-08 22:05:36.586474+02
35870aba-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.483147+01	2016-01-15 22:06:07.952569+01	\N	43535745	43529959		http://cdn.rechat.co/43535745.jpg	7	{}	\N	0	2017-04-08 22:05:36.586475+02
3589bda0-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.500819+01	2016-01-15 22:06:07.554846+01	\N	43535758	43529959		http://cdn.rechat.co/43535758.jpg	20	{}	\N	0	2017-04-08 22:05:48.64428+02
3589253e-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.496935+01	2016-01-15 22:06:07.582046+01	\N	43535755	43529959		http://cdn.rechat.co/43535755.jpg	17	{}	\N	0	2017-04-08 22:05:54.020139+02
3587750e-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.485863+01	2016-01-15 22:06:07.917169+01	\N	43535747	43529959		http://cdn.rechat.co/43535747.jpg	9	{}	\N	0	2017-04-08 22:05:54.020141+02
35882648-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.490418+01	2016-01-15 22:06:07.86856+01	\N	43535750	43529959		http://cdn.rechat.co/43535750.jpg	12	{}	\N	0	2017-04-08 22:05:54.020146+02
3588c440-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.494452+01	2016-01-15 22:06:07.671935+01	\N	43535753	43529959		http://cdn.rechat.co/43535753.jpg	15	{}	\N	0	2017-04-08 22:05:54.020146+02
358a54fe-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.504679+01	2016-01-15 22:06:07.382968+01	\N	43535761	43529959		http://cdn.rechat.co/43535761.jpg	23	{}	\N	0	2017-04-08 22:05:54.020147+02
358a22a4-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.503421+01	2016-01-15 22:06:07.406885+01	\N	43535760	43529959		http://cdn.rechat.co/43535760.jpg	22	{}	\N	0	2017-04-08 22:05:54.020147+02
3585c4c0-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.47481+01	2016-01-15 22:06:08.173523+01	\N	43535740	43529959		http://cdn.rechat.co/43535740.jpg	2	{}	\N	0	2017-04-08 22:05:54.020153+02
3589ee38-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.502082+01	2016-01-15 22:06:07.524941+01	\N	43535759	43529959		http://cdn.rechat.co/43535759.jpg	21	{}	\N	0	2017-04-08 22:05:54.020154+02
3588f776-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.495743+01	2016-01-15 22:06:07.667349+01	\N	43535754	43529959		http://cdn.rechat.co/43535754.jpg	16	{}	\N	0	2017-04-08 22:05:54.020154+02
35889222-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.493175+01	2016-01-15 22:06:07.745556+01	\N	43535752	43529959		http://cdn.rechat.co/43535752.jpg	14	{}	\N	0	2017-04-08 22:05:54.020155+02
3585f814-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.476123+01	2016-01-15 22:06:08.149453+01	\N	43535741	43529959		http://cdn.rechat.co/43535741.jpg	3	{}	\N	0	2017-04-08 22:05:54.020155+02
3587bfa0-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.487639+01	2016-01-15 22:06:07.866841+01	\N	43535748	43529959		http://cdn.rechat.co/43535748.jpg	10	{}	\N	0	2017-04-08 22:05:54.020155+02
3586c12c-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.481261+01	2016-01-15 22:06:07.996976+01	\N	43535744	43529959		http://cdn.rechat.co/43535744.jpg	6	{}	\N	0	2017-04-08 22:05:54.020156+02
3586831a-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.479635+01	2016-01-15 22:06:08.050873+01	\N	43535743	43529959		http://cdn.rechat.co/43535743.jpg	5	{}	\N	0	2017-04-08 22:05:54.020156+02
35864350-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.478035+01	2016-01-15 22:06:08.131183+01	\N	43535742	43529959		http://cdn.rechat.co/43535742.jpg	4	{}	\N	0	2017-04-08 22:05:54.020156+02
358591c6-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.473493+01	2016-01-15 22:06:08.230544+01	\N	43535739	43529959		http://cdn.rechat.co/43535739.jpg	1	{}	\N	0	2017-04-08 22:05:54.020157+02
35855940-a362-11e5-8ac6-f23c91c841bd	2015-12-15 20:29:50.471962+01	2016-01-15 22:06:08.375706+01	\N	43535738	43529959		http://cdn.rechat.co/43535738.jpg	0	{}	\N	0	2017-04-08 22:05:54.020158+02
33d5db5a-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.624495+01	2016-01-15 05:53:36.569779+01	\N	44370561	44370476		http://cdn.rechat.co/44370561.jpg	23	{}	\N	0	2017-04-08 22:06:06.494143+02
33d61980-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.626104+01	2016-01-15 05:53:36.582776+01	\N	44370562	44370476		http://cdn.rechat.co/44370562.jpg	24	{}	\N	0	2017-04-08 22:06:06.494145+02
33d58b0a-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.622393+01	2016-01-15 05:53:36.67725+01	\N	44370560	44370476		http://cdn.rechat.co/44370560.jpg	22	{}	\N	0	2017-04-08 22:06:06.494148+02
33d4d5b6-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.617903+01	2016-01-15 05:53:36.711299+01	\N	44370559	44370476		http://cdn.rechat.co/44370559.jpg	21	{}	\N	0	2017-04-08 22:06:06.494149+02
33d4a474-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.616557+01	2016-01-15 05:53:36.719736+01	\N	44370558	44370476		http://cdn.rechat.co/44370558.jpg	20	{}	\N	0	2017-04-08 22:06:06.49416+02
33d3eb60-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.611915+01	2016-01-15 05:53:36.780222+01	\N	44370557	44370476		http://cdn.rechat.co/44370557.jpg	19	{}	\N	0	2017-04-08 22:06:06.49416+02
33d39340-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.60966+01	2016-01-15 05:53:36.792199+01	\N	44370555	44370476		http://cdn.rechat.co/44370555.jpg	17	{}	\N	0	2017-04-08 22:06:06.494161+02
33d3bf50-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.610788+01	2016-01-15 05:53:36.796903+01	\N	44370556	44370476		http://cdn.rechat.co/44370556.jpg	18	{}	\N	0	2017-04-08 22:06:06.494162+02
33d3365c-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.607232+01	2016-01-15 05:53:36.889971+01	\N	44370553	44370476		http://cdn.rechat.co/44370553.jpg	15	{}	\N	0	2017-04-08 22:06:06.494164+02
33d2ff0c-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.605865+01	2016-01-15 05:53:36.90418+01	\N	44370552	44370476		http://cdn.rechat.co/44370552.jpg	14	{}	\N	0	2017-04-08 22:06:06.494164+02
33d2d27a-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.6047+01	2016-01-15 05:53:37.023268+01	\N	44370551	44370476		http://cdn.rechat.co/44370551.jpg	13	{}	\N	0	2017-04-08 22:06:06.494165+02
33d2a4da-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.603555+01	2016-01-15 05:53:37.024712+01	\N	44370550	44370476		http://cdn.rechat.co/44370550.jpg	12	{}	\N	0	2017-04-08 22:06:06.494178+02
33d27898-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.602419+01	2016-01-15 05:53:37.126041+01	\N	44370549	44370476		http://cdn.rechat.co/44370549.jpg	11	{}	\N	0	2017-04-08 22:06:06.494179+02
33d247ce-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.601145+01	2016-01-15 05:53:37.142289+01	\N	44370548	44370476		http://cdn.rechat.co/44370548.jpg	10	{}	\N	0	2017-04-08 22:06:06.49418+02
33d21678-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.599908+01	2016-01-15 05:53:37.177485+01	\N	44370547	44370476		http://cdn.rechat.co/44370547.jpg	9	{}	\N	0	2017-04-08 22:06:06.494181+02
33d1e78e-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.598702+01	2016-01-15 05:53:37.206592+01	\N	44370546	44370476		http://cdn.rechat.co/44370546.jpg	8	{}	\N	0	2017-04-08 22:06:06.494181+02
33d17b82-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.595696+01	2016-01-15 05:53:37.273555+01	\N	44370544	44370476		http://cdn.rechat.co/44370544.jpg	6	{}	\N	0	2017-04-08 22:06:06.494182+02
33d1b4e4-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.597405+01	2016-01-15 05:53:37.318385+01	\N	44370545	44370476		http://cdn.rechat.co/44370545.jpg	7	{}	\N	0	2017-04-08 22:06:06.494183+02
33d0f22a-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.592428+01	2016-01-15 05:53:37.343816+01	\N	44370542	44370476		http://cdn.rechat.co/44370542.jpg	4	{}	\N	0	2017-04-08 22:06:06.494184+02
33d0bf3a-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.59104+01	2016-01-15 05:53:37.394756+01	\N	44370541	44370476		http://cdn.rechat.co/44370541.jpg	3	{}	\N	0	2017-04-08 22:06:06.49419+02
33d043de-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.587933+01	2016-01-15 05:53:37.602602+01	\N	44370539	44370476		http://cdn.rechat.co/44370539.jpg	1	{}	\N	0	2017-04-08 22:06:06.494192+02
33d00e3c-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.586562+01	2016-01-15 05:53:37.755427+01	\N	44370538	44370476		http://cdn.rechat.co/44370538.jpg	0	{}	\N	0	2017-04-08 22:06:06.494192+02
33d12876-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.593809+01	2016-01-15 05:53:37.79995+01	\N	44370543	44370476		http://cdn.rechat.co/44370543.jpg	5	{}	\N	0	2017-04-08 22:06:06.494195+02
33d36410-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.608449+01	2016-01-15 05:53:37.873189+01	\N	44370554	44370476		http://cdn.rechat.co/44370554.jpg	16	{}	\N	0	2017-04-08 22:06:06.494197+02
33d07c00-a368-11e5-8627-f23c91c841bd	2015-12-15 21:12:44.589371+01	2016-01-15 05:53:37.983968+01	\N	44370540	44370476		http://cdn.rechat.co/44370540.jpg	2	{}	\N	0	2017-04-08 22:06:06.494199+02
59b16c4a-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.590136+01	2016-01-15 03:11:22.153965+01	\N	49605622	49605397		http://cdn.rechat.co/49605622.jpg	16	{}	\N	0	2017-04-08 22:06:06.279544+02
59af3ace-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.57578+01	2016-01-15 03:11:23.604967+01	\N	49605611	49605397		http://cdn.rechat.co/49605611.jpg	7	{}	\N	0	2017-04-08 22:06:06.279662+02
59aeccce-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.572946+01	2016-01-15 03:11:23.683062+01	\N	49605610	49605397		http://cdn.rechat.co/49605610.jpg	6	{}	\N	0	2017-04-08 22:06:06.279663+02
59b1319e-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.588675+01	2016-01-15 03:11:22.224697+01	\N	49605621	49605397		http://cdn.rechat.co/49605621.jpg	15	{}	\N	0	2017-04-08 22:06:06.279858+02
59b104bc-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.587558+01	2016-01-15 03:11:22.30111+01	\N	49605620	49605397		http://cdn.rechat.co/49605620.jpg	0	{}	\N	0	2017-04-08 22:06:06.279858+02
59b0d69a-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.586375+01	2016-01-15 03:11:22.305218+01	\N	49605619	49605397		http://cdn.rechat.co/49605619.jpg	1	{}	\N	0	2017-04-08 22:06:06.279859+02
59b0a8be-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.585191+01	2016-01-15 03:11:22.325422+01	\N	49605618	49605397		http://cdn.rechat.co/49605618.jpg	14	{}	\N	0	2017-04-08 22:06:06.279859+02
59b077d6-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.583936+01	2016-01-15 03:11:22.349827+01	\N	49605617	49605397		http://cdn.rechat.co/49605617.jpg	13	{}	\N	0	2017-04-08 22:06:06.27986+02
59b04a18-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.582749+01	2016-01-15 03:11:22.403124+01	\N	49605616	49605397		http://cdn.rechat.co/49605616.jpg	12	{}	\N	0	2017-04-08 22:06:06.27986+02
59afe884-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.580279+01	2016-01-15 03:11:22.444654+01	\N	49605614	49605397		http://cdn.rechat.co/49605614.jpg	10	{}	\N	0	2017-04-08 22:06:06.279861+02
59b0185e-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.581503+01	2016-01-15 03:11:22.561366+01	\N	49605615	49605397		http://cdn.rechat.co/49605615.jpg	11	{}	\N	0	2017-04-08 22:06:06.279868+02
59af86c8-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.577754+01	2016-01-15 03:11:22.576667+01	\N	49605612	49605397		http://cdn.rechat.co/49605612.jpg	8	{}	\N	0	2017-04-08 22:06:06.279869+02
59afb85a-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.579045+01	2016-01-15 03:11:22.594016+01	\N	49605613	49605397		http://cdn.rechat.co/49605613.jpg	9	{}	\N	0	2017-04-08 22:06:06.279869+02
59ad79fa-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.564346+01	2016-01-15 03:11:22.704674+01	\N	49605608	49605397		http://cdn.rechat.co/49605608.jpg	4	{}	\N	0	2017-04-08 22:06:06.27987+02
59adabaa-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.565596+01	2016-01-15 03:11:22.746011+01	\N	49605609	49605397		http://cdn.rechat.co/49605609.jpg	5	{}	\N	0	2017-04-08 22:06:06.27987+02
59ad4d4a-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.563202+01	2016-01-15 03:11:22.832509+01	\N	49605607	49605397		http://cdn.rechat.co/49605607.jpg	3	{}	\N	0	2017-04-08 22:06:06.279871+02
59ad20f4-a377-11e5-9e65-f23c91c841bd	2015-12-15 23:01:10.562066+01	2016-01-15 03:11:23.142461+01	\N	49605605	49605397		http://cdn.rechat.co/49605605.jpg	2	{}	\N	0	2017-04-08 22:06:06.279872+02
14991f5e-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.60255+01	2016-01-14 10:19:45.411991+01	\N	50822141	49874310	Current Craftsman floor plan approved by Landmark provides high ceilings in the living room ! Ask agent for details of this free floor plan.	http://cdn.rechat.co/50822141.jpg	8	{"XPTitle": [66, 0, 114, 0, 105, 0, 103, 0, 104, 0, 116, 0, 32, 0, 67, 0, 114, 0, 97, 0, 102, 0, 116, 0, 115, 0, 109, 0, 97, 0, 110, 0, 45, 0, 83, 0, 116, 0, 121, 0, 108, 0, 101, 0, 32, 0, 72, 0, 111, 0, 109, 0, 101, 0, 115, 0, 32, 0, 68, 0, 101, 0, 99, 0, 111, 0, 114, 0, 32, 0, 73, 0, 100, 0, 101, 0, 97, 0, 115, 0, 32, 0, 68, 0, 105, 0, 110, 0, 105, 0, 110, 0, 103, 0, 32, 0, 82, 0, 111, 0, 111, 0, 109, 0, 32, 0, 87, 0, 111, 0, 111, 0, 100, 0, 101, 0, 110, 0, 32, 0, 70, 0, 108, 0, 111, 0, 111, 0, 114, 0, 0, 0], "Software": "Picasa", "ModifyDate": "2013:06:21 17:53:10", "XResolution": 72, "YResolution": 72, "ImageUniqueID": "fe3b749e659c1c88041035f2fd6f961f", "ExifImageWidth": 600, "ResolutionUnit": 2, "ExifImageHeight": 450, "DateTimeOriginal": 1371837180, "ImageDescription": "Bright Craftsman-Style Homes Decor Ideas Dining Room Wooden Floor", "RelatedImageWidth": 600, "RelatedImageHeight": 450}	\N	0	2017-04-08 22:05:38.91484+02
14c13750-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.865462+01	2016-01-14 10:19:44.988838+01	\N	50822383	49874310	Prairie Home in Junius Heights with wrap around garage.	http://cdn.rechat.co/50822383.jpg	7	{}	\N	0	2017-04-08 22:05:39.294266+02
97537e60-a383-11e5-b60c-f23c91c841bd	2015-12-16 00:28:47.954124+01	2016-01-14 10:20:27.76573+01	\N	50401441	49874310	SURVEY 50 X 150 FT lot in Junius Heights - Lakewood Country Club 	http://cdn.rechat.co/50401441.jpg	1	{"Artist": "Harvard Office", "XPAuthor": [72, 0, 97, 0, 114, 0, 118, 0, 97, 0, 114, 0, 100, 0, 32, 0, 79, 0, 102, 0, 102, 0, 105, 0, 99, 0, 101, 0, 0, 0], "CreateDate": 1411489977, "DateTimeOriginal": 1411489977, "SubSecTimeOriginal": "43", "SubSecTimeDigitized": "43"}	\N	0	2017-04-08 22:05:39.342444+02
14c2568a-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.872865+01	2016-01-14 10:19:44.567183+01	\N	50822392	49874310	All are welcome ! Junius Heights 8th Annual Historic Home Tour 	http://cdn.rechat.co/50822392.jpg	21	{}	\N	0	2017-04-08 22:06:04.610456+02
14c2194a-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.871309+01	2016-01-14 10:19:44.603072+01	\N	50822390	49874310	This home is only a few homes over from the subject lot, on the same street.	http://cdn.rechat.co/50822390.jpg	15	{}	\N	0	2017-04-08 22:06:04.610456+02
14ddbef2-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:25.052459+01	2016-01-14 10:19:44.364018+01	\N	50822508	49874310	LOCATED Close to White Rock Lake, Lakewood Country Club & Shopping Centers, SMU, Baylor Medical Hospital, Uptown & Downtown	http://cdn.rechat.co/50822508.jpg	22	{}	\N	0	2017-04-08 22:06:04.610473+02
14c1de30-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.869795+01	2016-01-14 10:19:44.727637+01	\N	50822388	49874310	Junius Home	http://cdn.rechat.co/50822388.jpg	13	{}	\N	0	2017-04-08 22:06:04.610478+02
14c1bd10-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.868908+01	2016-01-14 10:19:44.756985+01	\N	50822387	49874310	Tudor with class.	http://cdn.rechat.co/50822387.jpg	12	{"Make": "Canon", "Flash": 24, "Model": "Canon PowerShot A70", "FNumber": 2.8, "Software": "Adobe Photoshop CS Macintosh", "CreateDate": 1092817981, "ModifyDate": "2004:08:26 00:51:45", "FocalLength": 5.40625, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.0025, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 300, "ResolutionUnit": 2, "ExifImageHeight": 236, "DateTimeOriginal": 1092817981, "DigitalZoomRatio": 1, "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 1, "RelatedImageWidth": 1600, "ShutterSpeedValue": 8.65625, "RelatedImageHeight": 1200, "ExposureCompensation": 0, "FocalPlaneXResolution": 7692.307692307692, "FocalPlaneYResolution": 7692.307692307692, "CompressedBitsPerPixel": 5, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.610482+02
14c19862-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.868007+01	2016-01-14 10:19:44.819782+01	\N	50822386	49874310	Cute cottage style Craftsman bungalow!	http://cdn.rechat.co/50822386.jpg	11	{}	\N	0	2017-04-08 22:06:04.610482+02
14c1fb86-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.870532+01	2016-01-14 10:19:44.821767+01	\N	50822389	49874310	Example by the awesome Greenbriar Home builder Drew Colon & team also in Junius Heights	http://cdn.rechat.co/50822389.jpg	14	{}	\N	0	2017-04-08 22:06:04.610483+02
14c178e6-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.867196+01	2016-01-14 10:19:44.909289+01	\N	50822385	49874310	Large Prairie Home example will not fit on lot, but is a home in Junius Heights.	http://cdn.rechat.co/50822385.jpg	10	{}	\N	0	2017-04-08 22:06:04.610484+02
14c0eb9c-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.863547+01	2016-01-14 10:19:45.151996+01	\N	50822381	49874310	another Craftsman on Junius Ave (Junius Heights)	http://cdn.rechat.co/50822381.jpg	4	{}	\N	0	2017-04-08 22:06:04.610485+02
14c0c914-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.862651+01	2016-01-14 10:19:45.164739+01	\N	50822380	49874310	Check out our neighbors ! Awesome Craftsman on Victor Ave (Junius Heights)	http://cdn.rechat.co/50822380.jpg	3	{}	\N	0	2017-04-08 22:06:04.610485+02
14c2370e-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.872078+01	2016-01-14 10:19:45.184261+01	\N	50822391	49874310	Detached Garages are popular and acceptable to the Historic Land Mark Commission	http://cdn.rechat.co/50822391.jpg	20	{}	\N	0	2017-04-08 22:06:04.610486+02
14c082ce-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.860836+01	2016-01-14 10:19:45.351794+01	\N	50822378	49874310	Approved Certificate of Appropriateness from Junius Heights Historic Commmitee  & Land Mark Commission - Transferable to buyer.	http://cdn.rechat.co/50822378.jpg	0	{"Software": "Adobe Photoshop CS4 Windows", "ModifyDate": "2009:09:09 16:35:53", "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExifImageWidth": 960, "ResolutionUnit": 2, "ExifImageHeight": 282}	\N	0	2017-04-08 22:06:04.610487+02
740feb06-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:26.777864+01	2016-01-13 20:52:30.926298+01	\N	50637133	50633269		http://cdn.rechat.co/50637133.jpg	2	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.15871+02
14988cce-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.598727+01	2016-01-14 10:19:45.516962+01	\N	50822137	49874310		http://cdn.rechat.co/50822137.jpg	19	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "ExifImageWidth": 246, "ResolutionUnit": 2, "ExifImageHeight": 395}	\N	0	2017-04-08 22:06:04.610487+02
14c156d6-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.866327+01	2016-01-14 10:19:45.521858+01	\N	50822384	49874310	Example of a wooden deck for the front patio.	http://cdn.rechat.co/50822384.jpg	9	{}	\N	0	2017-04-08 22:06:04.610488+02
1497ef26-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.594922+01	2016-01-14 10:19:45.669381+01	\N	50822135	49874310	Custom Craftsman design, can be modified.	http://cdn.rechat.co/50822135.jpg	6	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.610495+02
1498363e-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.596774+01	2016-01-14 10:19:45.634415+01	\N	50822136	49874310		http://cdn.rechat.co/50822136.jpg	18	{"XPTitle": [83, 0, 116, 0, 117, 0, 110, 0, 110, 0, 105, 0, 110, 0, 103, 0, 32, 0, 68, 0, 101, 0, 116, 0, 97, 0, 105, 0, 108, 0, 115, 0, 32, 0, 73, 0, 110, 0, 116, 0, 101, 0, 114, 0, 105, 0, 111, 0, 114, 0, 32, 0, 67, 0, 114, 0, 97, 0, 102, 0, 116, 0, 115, 0, 109, 0, 97, 0, 110, 0, 32, 0, 72, 0, 111, 0, 109, 0, 101, 0, 32, 0, 83, 0, 116, 0, 97, 0, 105, 0, 114, 0, 115, 0, 32, 0, 86, 0, 105, 0, 101, 0, 119, 0, 32, 0, 84, 0, 105, 0, 108, 0, 101, 0, 32, 0, 70, 0, 108, 0, 111, 0, 111, 0, 114, 0, 0, 0], "ImageDescription": "Stunning Details Interior Craftsman Home Stairs View Tile Floor"}	\N	0	2017-04-08 22:06:04.610503+02
1497b934-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.593498+01	2016-01-14 10:19:45.765003+01	\N	50822134	49874310	Full Construction Plans available for this home.	http://cdn.rechat.co/50822134.jpg	16	{}	\N	0	2017-04-08 22:06:04.610503+02
14c0a812-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.861813+01	2016-01-14 10:19:47.019045+01	\N	50822379	49874310	Junius Heights Historic Overlay. 	http://cdn.rechat.co/50822379.jpg	2	{}	\N	0	2017-04-08 22:06:04.610507+02
1498d2d8-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.600777+01	2016-01-14 10:19:47.027115+01	\N	50822140	49874310	Dining room view of a Craftsman bungalow.	http://cdn.rechat.co/50822140.jpg	17	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "ExifImageWidth": 262, "ResolutionUnit": 2, "ExifImageHeight": 348}	\N	0	2017-04-08 22:06:04.610507+02
14c10dca-a38b-11e5-8e84-f23c91c841bd	2015-12-16 01:22:24.864409+01	2016-01-14 10:19:47.319564+01	\N	50822382	49874310	Prairie Home on Junius Ave	http://cdn.rechat.co/50822382.jpg	5	{}	\N	0	2017-04-08 22:06:04.610515+02
e5388c52-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.626712+01	2016-01-14 01:11:43.285235+01	\N	50669908	50547026		http://cdn.rechat.co/50669908.jpg	5	{}	\N	0	2017-04-08 22:05:48.113871+02
e53861e6-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.625626+01	2016-01-14 01:11:43.366287+01	\N	50669907	50547026		http://cdn.rechat.co/50669907.jpg	4	{}	\N	0	2017-04-08 22:05:48.113884+02
e53a3c78-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.637657+01	2016-01-14 01:11:43.444614+01	\N	50669916	50547026		http://cdn.rechat.co/50669916.jpg	13	{}	\N	0	2017-04-08 22:05:48.113903+02
e53c150c-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.649724+01	2016-01-14 01:11:42.435686+01	\N	50669922	50547026		http://cdn.rechat.co/50669922.jpg	19	{}	\N	0	2017-04-08 22:05:48.120686+02
e53ca184-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.653238+01	2016-01-14 01:11:42.451401+01	\N	50669924	50547026		http://cdn.rechat.co/50669924.jpg	21	{}	\N	0	2017-04-08 22:05:48.12072+02
e53d0b4c-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.655039+01	2016-01-14 01:11:42.45566+01	\N	50669925	50547026		http://cdn.rechat.co/50669925.jpg	22	{}	\N	0	2017-04-08 22:05:48.120721+02
e53c5d00-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.651504+01	2016-01-14 01:11:42.636755+01	\N	50669923	50547026		http://cdn.rechat.co/50669923.jpg	20	{}	\N	0	2017-04-08 22:05:48.120726+02
e53b996a-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.646607+01	2016-01-14 01:11:42.638037+01	\N	50669921	50547026		http://cdn.rechat.co/50669921.jpg	18	{}	\N	0	2017-04-08 22:05:48.120726+02
e53b62f6-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.645194+01	2016-01-14 01:11:42.705503+01	\N	50669920	50547026		http://cdn.rechat.co/50669920.jpg	17	{}	\N	0	2017-04-08 22:05:48.120727+02
e53adfa2-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.641857+01	2016-01-14 01:11:42.809442+01	\N	50669918	50547026		http://cdn.rechat.co/50669918.jpg	15	{}	\N	0	2017-04-08 22:05:48.120728+02
e53a0488-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.636208+01	2016-01-14 01:11:42.995349+01	\N	50669915	50547026		http://cdn.rechat.co/50669915.jpg	12	{}	\N	0	2017-04-08 22:05:48.120729+02
e539d008-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.634885+01	2016-01-14 01:11:43.021846+01	\N	50669914	50547026		http://cdn.rechat.co/50669914.jpg	11	{}	\N	0	2017-04-08 22:05:48.120729+02
e5399cc8-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.633551+01	2016-01-14 01:11:43.023285+01	\N	50669913	50547026		http://cdn.rechat.co/50669913.jpg	10	{}	\N	0	2017-04-08 22:05:48.120755+02
e53aa672-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.640388+01	2016-01-14 01:11:43.089889+01	\N	50669917	50547026		http://cdn.rechat.co/50669917.jpg	14	{}	\N	0	2017-04-08 22:05:48.120755+02
e53964ba-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.632114+01	2016-01-14 01:11:43.123667+01	\N	50669912	50547026		http://cdn.rechat.co/50669912.jpg	9	{}	\N	0	2017-04-08 22:05:48.120756+02
e5392d2e-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.630714+01	2016-01-14 01:11:43.171761+01	\N	50669911	50547026		http://cdn.rechat.co/50669911.jpg	8	{}	\N	0	2017-04-08 22:05:48.120804+02
e538f566-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.62927+01	2016-01-14 01:11:43.22786+01	\N	50669910	50547026		http://cdn.rechat.co/50669910.jpg	7	{}	\N	0	2017-04-08 22:05:48.120805+02
e538bda8-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.627853+01	2016-01-14 01:11:43.231695+01	\N	50669909	50547026		http://cdn.rechat.co/50669909.jpg	6	{}	\N	0	2017-04-08 22:05:48.120805+02
e5383a9a-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.624585+01	2016-01-14 01:11:43.452612+01	\N	50669906	50547026		http://cdn.rechat.co/50669906.jpg	3	{}	\N	0	2017-04-08 22:05:48.120842+02
e537e7e8-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.622495+01	2016-01-14 01:11:43.501431+01	\N	50669904	50547026		http://cdn.rechat.co/50669904.jpg	1	{}	\N	0	2017-04-08 22:05:48.120842+02
e537c0e2-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.621472+01	2016-01-14 01:11:43.638032+01	\N	50669903	50547026		http://cdn.rechat.co/50669903.jpg	0	{}	\N	0	2017-04-08 22:05:48.120843+02
e538118c-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.623563+01	2016-01-14 01:11:45.520397+01	\N	50669905	50547026		http://cdn.rechat.co/50669905.jpg	2	{}	\N	0	2017-04-08 22:05:48.120957+02
e53b2dcc-a387-11e5-849b-f23c91c841bd	2015-12-16 00:59:36.643852+01	2016-01-14 01:11:46.461352+01	\N	50669919	50547026		http://cdn.rechat.co/50669919.jpg	16	{}	\N	0	2017-04-08 22:05:48.121039+02
155caab4-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:38.400595+01	2016-01-14 08:05:40.506223+01	\N	50561210	50557280		http://cdn.rechat.co/50561210.jpg	12	{"ISO": 200, "Make": "Canon", "Flash": 16, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363184101, "ImageWidth": 3000, "ModifyDate": "2014:10:13 15:18:01", "FocalLength": 5, "ImageHeight": 4000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.03333333333333333, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 768, "ResolutionUnit": 2, "ExifImageHeight": 1024, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 1.47, "DateTimeOriginal": 1363184101, "DigitalZoomRatio": 1, "ImageDescription": "                               ", "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 4.90625, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.47966+02
7490802c-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.620521+01	2016-01-13 20:52:30.984377+01	\N	50637774	50633269		http://cdn.rechat.co/50637774.jpg	1	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158711+02
15f884fc-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:39.421918+01	2016-01-14 08:05:40.601452+01	\N	50562107	50557280		http://cdn.rechat.co/50562107.jpg	4	{"ISO": 400, "Make": "Canon", "Flash": 16, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363285023, "ImageWidth": 4000, "ModifyDate": "2014:10:13 15:46:34", "FocalLength": 5, "ImageHeight": 3000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.03333333333333333, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 64.4, "DateTimeOriginal": 1363285023, "DigitalZoomRatio": 1, "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 4.90625, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479662+02
151a80c6-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:37.966999+01	2016-01-14 08:05:40.694607+01	\N	50560974	50557280		http://cdn.rechat.co/50560974.jpg	18	{"ISO": 800, "Make": "Canon", "Flash": 16, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363183556, "ImageWidth": 3000, "ModifyDate": "2014:10:13 15:08:59", "FocalLength": 5, "ImageHeight": 4000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.03333333333333333, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 768, "ResolutionUnit": 2, "ExifImageHeight": 1024, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 3.82, "DateTimeOriginal": 1363183556, "DigitalZoomRatio": 1, "ImageDescription": "                               ", "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 4.90625, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479675+02
151a536c-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:37.965852+01	2016-01-14 08:05:40.696613+01	\N	50560973	50557280		http://cdn.rechat.co/50560973.jpg	17	{"ISO": 800, "Make": "Canon", "Flash": 16, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363183493, "ImageWidth": 3000, "ModifyDate": "2014:10:13 15:04:57", "FocalLength": 5, "ImageHeight": 4000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.04, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 768, "ResolutionUnit": 2, "ExifImageHeight": 1024, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 64.4, "DateTimeOriginal": 1363183493, "DigitalZoomRatio": 1, "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 4.65625, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479676+02
151a25fe-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:37.964655+01	2016-01-14 08:05:40.768786+01	\N	50560972	50557280		http://cdn.rechat.co/50560972.jpg	16	{"ISO": 500, "Make": "Canon", "Flash": 16, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363183956, "ImageWidth": 3000, "ModifyDate": "2014:10:13 15:07:10", "FocalLength": 5, "ImageHeight": 4000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.03333333333333333, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 768, "ResolutionUnit": 2, "ExifImageHeight": 1024, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 64.4, "DateTimeOriginal": 1363183956, "DigitalZoomRatio": 1, "ImageDescription": "                               ", "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 4.90625, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479686+02
15197ca8-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:37.960347+01	2016-01-14 08:05:40.899464+01	\N	50560969	50557280		http://cdn.rechat.co/50560969.jpg	13	{"ISO": 400, "Make": "Canon", "Flash": 24, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363183400, "ImageWidth": 3000, "ModifyDate": "2014:10:13 14:57:15", "FocalLength": 5, "ImageHeight": 4000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 768, "ResolutionUnit": 2, "ExifImageHeight": 1024, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 64.4, "DateTimeOriginal": 1363183400, "DigitalZoomRatio": 1, "ImageDescription": "                               ", "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 5.90625, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479691+02
95195924-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:50.69474+01	2016-01-14 09:46:05.725131+01	\N	50795688	50791870		http://cdn.rechat.co/50795688.jpg	24	{"Copyright": "Copyright 2010 Stephen Reed", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.558747+02
fc70663c-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:35.011654+01	2016-01-14 02:42:05.439394+01	\N	51494734	51490207		http://cdn.rechat.co/51494734.jpg	15	{}	\N	0	2017-04-08 22:06:03.390639+02
1519ad9a-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:37.961601+01	2016-01-14 08:05:41.000223+01	\N	50560970	50557280		http://cdn.rechat.co/50560970.jpg	14	{"ISO": 160, "Make": "Canon", "Flash": 16, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363183835, "ImageWidth": 4000, "ModifyDate": "2014:10:13 14:59:26", "FocalLength": 5, "ImageHeight": 3000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.03333333333333333, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 0.91, "DateTimeOriginal": 1363183835, "DigitalZoomRatio": 1, "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 4.90625, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479702+02
15194986-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:37.959005+01	2016-01-14 08:05:41.004128+01	\N	50560968	50557280		http://cdn.rechat.co/50560968.jpg	11	{"ISO": 800, "Make": "Canon", "Flash": 24, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363183352, "ImageWidth": 3000, "ModifyDate": "2014:10:13 14:53:47", "FocalLength": 5, "ImageHeight": 4000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.02, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 768, "ResolutionUnit": 2, "ExifImageHeight": 1024, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 64.4, "DateTimeOriginal": 1363183352, "DigitalZoomRatio": 1, "ImageDescription": "                               ", "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 5.65625, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479706+02
1519dfae-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:37.962866+01	2016-01-14 08:05:41.036021+01	\N	50560971	50557280		http://cdn.rechat.co/50560971.jpg	15	{"ISO": 125, "Make": "Canon", "Flash": 16, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363183679, "ImageWidth": 4000, "ModifyDate": "2014:10:13 15:04:01", "FocalLength": 5, "ImageHeight": 3000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.03333333333333333, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 2.73, "DateTimeOriginal": 1363183679, "DigitalZoomRatio": 1, "ImageDescription": "                               ", "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 4.90625, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479707+02
1518af12-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:37.955013+01	2016-01-14 08:05:41.114106+01	\N	50560960	50557280		http://cdn.rechat.co/50560960.jpg	8	{"ISO": 320, "Make": "Canon", "Flash": 24, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363183236, "ImageWidth": 3000, "ModifyDate": "2014:10:13 14:43:51", "FocalLength": 5, "ImageHeight": 4000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 768, "ResolutionUnit": 2, "ExifImageHeight": 1024, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 1, "DateTimeOriginal": 1363183236, "DigitalZoomRatio": 1, "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 5.90625, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479714+02
15191632-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:37.957676+01	2016-01-14 08:05:41.150631+01	\N	50560963	50557280		http://cdn.rechat.co/50560963.jpg	10	{"ISO": 640, "Make": "Canon", "Flash": 16, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363183586, "ImageWidth": 4000, "ModifyDate": "2014:10:13 14:52:32", "FocalLength": 5, "ImageHeight": 3000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.03333333333333333, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 64.4, "DateTimeOriginal": 1363183586, "DigitalZoomRatio": 1, "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 4.90625, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479715+02
9218446a-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.654437+01	2016-01-14 09:46:13.994858+01	\N	50791930	50791870		http://cdn.rechat.co/50791930.jpg	22	{"Copyright": "Shoot2Sell Photography", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.559374+02
921768ec-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.64886+01	2016-01-14 09:46:07.327838+01	\N	50791925	50791870		http://cdn.rechat.co/50791925.jpg	17	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573415+02
1518e234-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:37.956346+01	2016-01-14 08:05:41.229757+01	\N	50560961	50557280		http://cdn.rechat.co/50560961.jpg	9	{"ISO": 400, "Make": "Canon", "Flash": 24, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363183201, "ImageWidth": 4000, "ModifyDate": "2014:10:13 14:50:46", "FocalLength": 5, "ImageHeight": 3000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 6.41, "DateTimeOriginal": 1363183201, "DigitalZoomRatio": 1, "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 5.90625, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479715+02
151875f6-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:37.953542+01	2016-01-14 08:05:41.284798+01	\N	50560959	50557280		http://cdn.rechat.co/50560959.jpg	7	{"ISO": 500, "Make": "Canon", "Flash": 24, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363183293, "ImageWidth": 4000, "ModifyDate": "2014:10:13 14:38:52", "FocalLength": 5, "ImageHeight": 3000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 64.4, "DateTimeOriginal": 1363183293, "DigitalZoomRatio": 1, "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 5.90625, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479718+02
1430de1c-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:36.43581+01	2016-01-14 08:05:41.692269+01	\N	50559684	50557280		http://cdn.rechat.co/50559684.jpg	5	{"ISO": 320, "Make": "Canon", "Flash": 16, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363183012, "ImageWidth": 3000, "ModifyDate": "2014:10:13 14:35:49", "FocalLength": 5, "ImageHeight": 4000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.025, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 768, "ResolutionUnit": 2, "ExifImageHeight": 1024, "SamplesPerPixel": 3, "SensitivityType": 4, "DateTimeOriginal": 1363183012, "DigitalZoomRatio": 1, "ImageDescription": "                               ", "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 5.3125, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479737+02
151ab802-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:37.968428+01	2016-01-14 08:05:41.707272+01	\N	50560975	50557280		http://cdn.rechat.co/50560975.jpg	6	{"ISO": 250, "Make": "Canon", "Flash": 16, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363182991, "ImageWidth": 4000, "ModifyDate": "2014:10:13 15:11:13", "FocalLength": 5, "ImageHeight": 3000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.03333333333333333, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 64.4, "DateTimeOriginal": 1363182991, "DigitalZoomRatio": 1, "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 4.90625, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479745+02
1430910a-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:36.433832+01	2016-01-14 08:05:42.157477+01	\N	50559681	50557280		http://cdn.rechat.co/50559681.jpg	3	{"ISO": 200, "Make": "Canon", "Flash": 16, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 2.8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363185423, "ImageWidth": 3000, "ModifyDate": "2014:10:13 14:04:02", "FocalLength": 5, "ImageHeight": 4000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.00125, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 2.96875, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 768, "ResolutionUnit": 2, "ExifImageHeight": 1024, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 64.4, "DateTimeOriginal": 1363185423, "DigitalZoomRatio": 1, "ImageDescription": "                               ", "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 9.65625, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479753+02
92171234-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.6466+01	2016-01-14 09:46:07.371513+01	\N	50791923	50791870		http://cdn.rechat.co/50791923.jpg	15	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.57344+02
92173e94-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.647703+01	2016-01-14 09:46:07.430422+01	\N	50791924	50791870		http://cdn.rechat.co/50791924.jpg	16	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573452+02
1430bc52-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:36.434916+01	2016-01-14 08:05:42.180772+01	\N	50559683	50557280		http://cdn.rechat.co/50559683.jpg	1	{"ISO": 200, "Make": "Canon", "Flash": 16, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1363185498, "ImageWidth": 4000, "ModifyDate": "2014:10:13 14:01:22", "FocalLength": 5, "ImageHeight": 3000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.004, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 6, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 64.4, "DateTimeOriginal": 1363185498, "DigitalZoomRatio": 1, "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 7.96875, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479762+02
140932ea-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:36.175864+01	2016-01-14 08:05:42.515708+01	\N	50559388	50557280		http://cdn.rechat.co/50559388.jpg	0	{"ISO": 125, "Make": "Canon", "Flash": 16, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1361636995, "ImageWidth": 4000, "ModifyDate": "2014:10:13 13:59:28", "FocalLength": 5, "ImageHeight": 3000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.004, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 6, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 64.4, "DateTimeOriginal": 1361636995, "DigitalZoomRatio": 1, "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 7.96875, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479768+02
143069f0-a386-11e5-b129-f23c91c841bd	2015-12-16 00:46:36.432874+01	2016-01-14 08:05:42.583086+01	\N	50559680	50557280		http://cdn.rechat.co/50559680.jpg	2	{"ISO": 125, "Make": "Canon", "Flash": 16, "Model": "Canon PowerShot ELPH 100 HS", "FNumber": 8, "Software": "Adobe Photoshop CS5 Windows", "CreateDate": 1361637037, "ImageWidth": 4000, "ModifyDate": "2014:10:13 14:02:38", "FocalLength": 5, "ImageHeight": 3000, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.003125, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 6, "BitsPerSample": [8, 8, 8], "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768, "SamplesPerPixel": 3, "SensitivityType": 4, "SubjectDistance": 64.4, "DateTimeOriginal": 1361637037, "DigitalZoomRatio": 1, "ImageDescription": "                               ", "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 4000, "ShutterSpeedValue": 8.3125, "RelatedImageHeight": 3000, "ExposureCompensation": 0, "FocalPlaneXResolution": 16393.44262295082, "FocalPlaneYResolution": 16393.44262295082, "CompressedBitsPerPixel": 3, "FocalPlaneResolutionUnit": 2, "PhotometricInterpretation": 2}	\N	0	2017-04-08 22:06:04.479772+02
7491a4de-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.627228+01	2016-01-13 20:52:31.152681+01	\N	50637778	50633269		http://cdn.rechat.co/50637778.jpg	6	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.134369+02
74961456-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.657051+01	2016-01-13 20:52:29.701974+01	\N	50637796	50633269		http://cdn.rechat.co/50637796.jpg	24	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158587+02
7495d360-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.655399+01	2016-01-13 20:52:29.850923+01	\N	50637795	50633269		http://cdn.rechat.co/50637795.jpg	23	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158596+02
74958ffe-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.653718+01	2016-01-13 20:52:29.874279+01	\N	50637794	50633269		http://cdn.rechat.co/50637794.jpg	22	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158606+02
7494dd2a-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.649114+01	2016-01-13 20:52:30.006599+01	\N	50637791	50633269		http://cdn.rechat.co/50637791.jpg	19	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158616+02
74955476-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.652177+01	2016-01-13 20:52:30.020486+01	\N	50637793	50633269		http://cdn.rechat.co/50637793.jpg	21	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158616+02
749516a0-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.650611+01	2016-01-13 20:52:30.031222+01	\N	50637792	50633269		http://cdn.rechat.co/50637792.jpg	20	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158617+02
7494a738-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.64781+01	2016-01-13 20:52:30.062204+01	\N	50637790	50633269		http://cdn.rechat.co/50637790.jpg	18	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158625+02
74947600-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.646533+01	2016-01-13 20:52:30.120815+01	\N	50637789	50633269		http://cdn.rechat.co/50637789.jpg	17	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158626+02
7493f6da-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.643206+01	2016-01-13 20:52:30.208665+01	\N	50637787	50633269		http://cdn.rechat.co/50637787.jpg	15	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158634+02
749436a4-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.64481+01	2016-01-13 20:52:30.217973+01	\N	50637788	50633269		http://cdn.rechat.co/50637788.jpg	16	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158635+02
749377aa-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.639981+01	2016-01-13 20:52:30.285374+01	\N	50637786	50633269		http://cdn.rechat.co/50637786.jpg	14	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158656+02
74935496-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.639116+01	2016-01-13 20:52:30.297161+01	\N	50637785	50633269		http://cdn.rechat.co/50637785.jpg	13	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158656+02
74931af8-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.6376+01	2016-01-13 20:52:30.364791+01	\N	50637784	50633269		http://cdn.rechat.co/50637784.jpg	12	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158657+02
7492e042-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.636141+01	2016-01-13 20:52:30.405047+01	\N	50637783	50633269		http://cdn.rechat.co/50637783.jpg	11	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158657+02
7491de4a-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.629539+01	2016-01-13 20:52:30.596991+01	\N	50637779	50633269		http://cdn.rechat.co/50637779.jpg	7	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158658+02
74921e32-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.631164+01	2016-01-13 20:52:30.603502+01	\N	50637780	50633269		http://cdn.rechat.co/50637780.jpg	8	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158658+02
7492ab4a-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.634771+01	2016-01-13 20:52:30.504991+01	\N	50637782	50633269		http://cdn.rechat.co/50637782.jpg	10	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158707+02
74927292-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.632551+01	2016-01-13 20:52:30.515286+01	\N	50637781	50633269		http://cdn.rechat.co/50637781.jpg	9	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158708+02
74914e62-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.625705+01	2016-01-13 20:52:30.687373+01	\N	50637777	50633269		http://cdn.rechat.co/50637777.jpg	5	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158708+02
74910060-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.623612+01	2016-01-13 20:52:30.720487+01	\N	50637776	50633269		http://cdn.rechat.co/50637776.jpg	4	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158708+02
7490ca14-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.622373+01	2016-01-13 20:52:30.776897+01	\N	50637775	50633269		http://cdn.rechat.co/50637775.jpg	3	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158709+02
74901ede-a387-11e5-981e-f23c91c841bd	2015-12-16 00:56:27.618063+01	2016-01-13 20:52:30.848683+01	\N	50637773	50633269		http://cdn.rechat.co/50637773.jpg	0	{"ImageDescription": ""}	\N	0	2017-04-08 22:06:04.158709+02
9216b352-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.644217+01	2016-01-14 09:46:07.487668+01	\N	50791921	50791870		http://cdn.rechat.co/50791921.jpg	13	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573453+02
921686d4-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.643018+01	2016-01-14 09:46:07.546406+01	\N	50791920	50791870		http://cdn.rechat.co/50791920.jpg	12	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.57352+02
9216e4bc-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.645453+01	2016-01-14 09:46:07.557265+01	\N	50791922	50791870		http://cdn.rechat.co/50791922.jpg	14	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.57369+02
921521d6-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.633944+01	2016-01-14 09:46:07.877272+01	\N	50791915	50791870		http://cdn.rechat.co/50791915.jpg	7	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573756+02
95193a3e-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:50.693931+01	2016-01-14 09:46:05.899324+01	\N	50795687	50791870		http://cdn.rechat.co/50795687.jpg	23	{"Copyright": "Copyright 2011 Stephen Reed", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573792+02
9214f6c0-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.632841+01	2016-01-14 09:46:07.897167+01	\N	50791914	50791870		http://cdn.rechat.co/50791914.jpg	6	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573804+02
9214cad8-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.631534+01	2016-01-14 09:46:07.960857+01	\N	50791913	50791870		http://cdn.rechat.co/50791913.jpg	5	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573805+02
92147574-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.629512+01	2016-01-14 09:46:07.988021+01	\N	50791912	50791870		http://cdn.rechat.co/50791912.jpg	4	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573842+02
9214481a-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.628343+01	2016-01-14 09:46:08.07536+01	\N	50791911	50791870		http://cdn.rechat.co/50791911.jpg	3	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573844+02
92141c64-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.627231+01	2016-01-14 09:46:08.116419+01	\N	50791910	50791870		http://cdn.rechat.co/50791910.jpg	2	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573879+02
92165920-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.641846+01	2016-01-14 09:46:08.192988+01	\N	50791919	50791870		http://cdn.rechat.co/50791919.jpg	11	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573881+02
9213c0fc-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.624795+01	2016-01-14 09:46:08.391349+01	\N	50791908	50791870		http://cdn.rechat.co/50791908.jpg	0	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573903+02
92181102-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.653181+01	2016-01-14 09:46:07.153057+01	\N	50791929	50791870		http://cdn.rechat.co/50791929.jpg	21	{"Copyright": "Shoot2Sell Photography", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573965+02
9217e830-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.652118+01	2016-01-14 09:46:07.219162+01	\N	50791928	50791870		http://cdn.rechat.co/50791928.jpg	20	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573965+02
9217bc70-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.651012+01	2016-01-14 09:46:07.222235+01	\N	50791927	50791870		http://cdn.rechat.co/50791927.jpg	19	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573966+02
9217915a-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.64991+01	2016-01-14 09:46:07.291266+01	\N	50791926	50791870		http://cdn.rechat.co/50791926.jpg	18	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573967+02
92162d9c-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.640507+01	2016-01-14 09:46:07.699771+01	\N	50791918	50791870		http://cdn.rechat.co/50791918.jpg	10	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573984+02
9215ba88-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.637805+01	2016-01-14 09:46:07.799878+01	\N	50791917	50791870		http://cdn.rechat.co/50791917.jpg	9	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573988+02
92154cd8-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.635049+01	2016-01-14 09:46:07.80226+01	\N	50791916	50791870		http://cdn.rechat.co/50791916.jpg	8	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.573988+02
9213eece-a38a-11e5-b826-f23c91c841bd	2015-12-16 01:18:45.626051+01	2016-01-14 09:46:09.523692+01	\N	50791909	50791870		http://cdn.rechat.co/50791909.jpg	1	{"XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.574103+02
140804aa-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.148474+01	2016-01-14 09:56:34.35404+01	\N	50858456	50830245		http://cdn.rechat.co/50858456.jpg	15	{}	\N	0	2017-04-08 22:05:37.35882+02
1407d02a-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.147139+01	2016-01-14 09:56:34.371226+01	\N	50858455	50830245		http://cdn.rechat.co/50858455.jpg	14	{}	\N	0	2017-04-08 22:05:37.358821+02
14071efa-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.142536+01	2016-01-14 09:56:34.579873+01	\N	50858452	50830245		http://cdn.rechat.co/50858452.jpg	11	{}	\N	0	2017-04-08 22:05:37.358834+02
1409f94a-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.16128+01	2016-01-14 09:56:33.757324+01	\N	50858465	50830245		http://cdn.rechat.co/50858465.jpg	24	{}	\N	0	2017-04-08 22:05:37.358902+02
140987c6-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.158367+01	2016-01-14 09:56:33.976685+01	\N	50858463	50830245		http://cdn.rechat.co/50858463.jpg	22	{}	\N	0	2017-04-08 22:05:37.358959+02
1409be80-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.159778+01	2016-01-14 09:56:33.987013+01	\N	50858464	50830245		http://cdn.rechat.co/50858464.jpg	23	{}	\N	0	2017-04-08 22:05:37.35896+02
140916c4-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.155502+01	2016-01-14 09:56:33.991061+01	\N	50858461	50830245		http://cdn.rechat.co/50858461.jpg	20	{}	\N	0	2017-04-08 22:05:37.35896+02
14095012-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.156946+01	2016-01-14 09:56:34.063835+01	\N	50858462	50830245		http://cdn.rechat.co/50858462.jpg	21	{}	\N	0	2017-04-08 22:05:37.358961+02
1408e00a-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.154103+01	2016-01-14 09:56:34.127944+01	\N	50858460	50830245		http://cdn.rechat.co/50858460.jpg	19	{}	\N	0	2017-04-08 22:05:37.358972+02
14087548-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.151346+01	2016-01-14 09:56:34.260413+01	\N	50858458	50830245		http://cdn.rechat.co/50858458.jpg	17	{}	\N	0	2017-04-08 22:05:37.358973+02
14083dbc-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.149931+01	2016-01-14 09:56:34.286333+01	\N	50858457	50830245		http://cdn.rechat.co/50858457.jpg	16	{}	\N	0	2017-04-08 22:05:37.358991+02
1408aa18-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.152708+01	2016-01-14 09:56:34.325698+01	\N	50858459	50830245		http://cdn.rechat.co/50858459.jpg	18	{}	\N	0	2017-04-08 22:05:37.358991+02
140670ea-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.138118+01	2016-01-14 09:56:34.741604+01	\N	50858449	50830245		http://cdn.rechat.co/50858449.jpg	8	{}	\N	0	2017-04-08 22:05:37.359026+02
1406db2a-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.140787+01	2016-01-14 09:56:34.758821+01	\N	50858451	50830245		http://cdn.rechat.co/50858451.jpg	10	{}	\N	0	2017-04-08 22:05:37.359026+02
1406a362-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.139446+01	2016-01-14 09:56:34.78512+01	\N	50858450	50830245		http://cdn.rechat.co/50858450.jpg	9	{}	\N	0	2017-04-08 22:05:37.359027+02
14063990-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.136696+01	2016-01-14 09:56:34.830093+01	\N	50858448	50830245		http://cdn.rechat.co/50858448.jpg	7	{}	\N	0	2017-04-08 22:05:37.35904+02
1405cc12-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.133889+01	2016-01-14 09:56:34.884133+01	\N	50858446	50830245		http://cdn.rechat.co/50858446.jpg	5	{}	\N	0	2017-04-08 22:05:37.359058+02
1406051a-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.135355+01	2016-01-14 09:56:34.953179+01	\N	50858447	50830245		http://cdn.rechat.co/50858447.jpg	6	{}	\N	0	2017-04-08 22:05:37.359066+02
140556e2-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.130963+01	2016-01-14 09:56:35.088756+01	\N	50858444	50830245		http://cdn.rechat.co/50858444.jpg	3	{}	\N	0	2017-04-08 22:05:37.359066+02
14058bb2-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.132318+01	2016-01-14 09:56:35.12753+01	\N	50858445	50830245		http://cdn.rechat.co/50858445.jpg	4	{}	\N	0	2017-04-08 22:05:37.359072+02
140521b8-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.129592+01	2016-01-14 09:56:35.317515+01	\N	50858443	50830245		http://cdn.rechat.co/50858443.jpg	2	{}	\N	0	2017-04-08 22:05:37.35908+02
1404eb76-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.128215+01	2016-01-14 09:56:35.397128+01	\N	50858442	50830245		http://cdn.rechat.co/50858442.jpg	1	{}	\N	0	2017-04-08 22:05:37.359087+02
1404b296-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.126696+01	2016-01-14 09:56:35.545366+01	\N	50858441	50830245		http://cdn.rechat.co/50858441.jpg	0	{}	\N	0	2017-04-08 22:05:37.359255+02
1407547e-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.14401+01	2016-01-14 09:56:36.52952+01	\N	50858453	50830245		http://cdn.rechat.co/50858453.jpg	12	{}	\N	0	2017-04-08 22:05:37.362654+02
140791d2-a38c-11e5-872c-f23c91c841bd	2015-12-16 01:29:33.145507+01	2016-01-14 09:56:51.91399+01	\N	50858454	50830245		http://cdn.rechat.co/50858454.jpg	13	{}	\N	0	2017-04-08 22:06:04.584919+02
fc7113fc-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:35.0161+01	2016-01-14 02:42:05.22186+01	\N	51494737	51490207		http://cdn.rechat.co/51494737.jpg	18	{}	\N	0	2017-04-08 22:06:03.390639+02
fc70dd1a-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:35.014698+01	2016-01-14 02:42:05.299873+01	\N	51494736	51490207		http://cdn.rechat.co/51494736.jpg	17	{}	\N	0	2017-04-08 22:06:03.390639+02
fc70a8f4-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:35.01336+01	2016-01-14 02:42:05.472978+01	\N	51494735	51490207		http://cdn.rechat.co/51494735.jpg	16	{}	\N	0	2017-04-08 22:06:03.39064+02
fc714d36-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:35.017562+01	2016-01-14 02:42:05.542028+01	\N	51494738	51490207		http://cdn.rechat.co/51494738.jpg	19	{}	\N	0	2017-04-08 22:06:03.39064+02
fc70250a-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:35.00999+01	2016-01-14 02:42:06.005032+01	\N	51494733	51490207		http://cdn.rechat.co/51494733.jpg	14	{}	\N	0	2017-04-08 22:06:03.390641+02
fc6fbb4c-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:35.007302+01	2016-01-14 02:42:06.125314+01	\N	51494731	51490207		http://cdn.rechat.co/51494731.jpg	12	{}	\N	0	2017-04-08 22:06:03.390641+02
fc6ff09e-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:35.008615+01	2016-01-14 02:42:06.186748+01	\N	51494732	51490207		http://cdn.rechat.co/51494732.jpg	13	{}	\N	0	2017-04-08 22:06:03.390642+02
fc6f7fd8-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:35.005751+01	2016-01-14 02:42:06.243521+01	\N	51494730	51490207		http://cdn.rechat.co/51494730.jpg	11	{}	\N	0	2017-04-08 22:06:03.390642+02
fc6f3fe6-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:35.004113+01	2016-01-14 02:42:06.362089+01	\N	51494729	51490207		http://cdn.rechat.co/51494729.jpg	10	{}	\N	0	2017-04-08 22:06:03.390643+02
fc6ede34-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:35.001633+01	2016-01-14 02:42:06.5051+01	\N	51494727	51490207		http://cdn.rechat.co/51494727.jpg	8	{}	\N	0	2017-04-08 22:06:03.390643+02
fc6f1084-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:35.002902+01	2016-01-14 02:42:06.517429+01	\N	51494728	51490207		http://cdn.rechat.co/51494728.jpg	9	{}	\N	0	2017-04-08 22:06:03.390644+02
fc6e7f70-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:34.999215+01	2016-01-14 02:42:06.621663+01	\N	51494726	51490207		http://cdn.rechat.co/51494726.jpg	7	{}	\N	0	2017-04-08 22:06:03.390644+02
fc6e4fc8-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:34.998+01	2016-01-14 02:42:06.667034+01	\N	51494725	51490207		http://cdn.rechat.co/51494725.jpg	6	{}	\N	0	2017-04-08 22:06:03.390644+02
fc6e199a-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:34.996585+01	2016-01-14 02:42:06.950584+01	\N	51494724	51490207		http://cdn.rechat.co/51494724.jpg	5	{}	\N	0	2017-04-08 22:06:03.390645+02
fc6dccb0-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:34.99445+01	2016-01-14 02:42:07.012995+01	\N	51494723	51490207		http://cdn.rechat.co/51494723.jpg	4	{}	\N	0	2017-04-08 22:06:03.390646+02
fc6cb6c2-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:34.987527+01	2016-01-14 02:42:07.841653+01	\N	51494719	51490207		http://cdn.rechat.co/51494719.jpg	0	{}	\N	0	2017-04-08 22:06:03.390666+02
fc6d8386-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:34.992767+01	2016-01-14 02:42:08.914124+01	\N	51494722	51490207		http://cdn.rechat.co/51494722.jpg	3	{}	\N	0	2017-04-08 22:06:03.390706+02
fc6cfbd2-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:34.98929+01	2016-01-14 02:42:09.727153+01	\N	51494720	51490207		http://cdn.rechat.co/51494720.jpg	1	{}	\N	0	2017-04-08 22:06:03.390725+02
fc6d50f0-a39c-11e5-8b8d-f23c91c841bd	2015-12-16 03:30:34.991135+01	2016-01-14 02:42:42.007449+01	\N	51494721	51490207		http://cdn.rechat.co/51494721.jpg	2	{}	\N	0	2017-04-08 22:06:03.392685+02
60f3c220-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.997475+01	2015-12-20 01:20:49.38882+01	\N	52656510	52656456		http://cdn.rechat.co/52656510.jpg	15	{}	\N	0	2017-04-08 22:05:35.487876+02
60f05edc-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.975348+01	2015-12-20 01:20:49.982102+01	\N	52656496	52656456		http://cdn.rechat.co/52656496.jpg	1	{}	\N	0	2017-04-08 22:05:35.487894+02
60f46838-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:31.001694+01	2015-12-20 01:20:48.928208+01	\N	52656513	52656456		http://cdn.rechat.co/52656513.jpg	18	{}	\N	0	2017-04-08 22:05:35.487912+02
60f1ebee-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.985464+01	2015-12-20 01:20:49.600834+01	\N	52656503	52656456		http://cdn.rechat.co/52656503.jpg	8	{}	\N	0	2017-04-08 22:05:35.487917+02
60f5d77c-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:31.011109+01	2015-12-20 01:20:48.531009+01	\N	52656519	52656456		http://cdn.rechat.co/52656519.jpg	24	{}	\N	0	2017-04-08 22:05:35.487936+02
60f4e22c-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:31.004851+01	2015-12-20 01:20:48.653044+01	\N	52656515	52656456		http://cdn.rechat.co/52656515.jpg	20	{}	\N	0	2017-04-08 22:05:35.487937+02
60f38364-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.995884+01	2015-12-20 01:20:49.214945+01	\N	52656509	52656456		http://cdn.rechat.co/52656509.jpg	14	{}	\N	0	2017-04-08 22:05:35.487937+02
60f2d4be-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.991453+01	2015-12-20 01:20:49.480519+01	\N	52656506	52656456		http://cdn.rechat.co/52656506.jpg	11	{}	\N	0	2017-04-08 22:05:35.487938+02
60f128da-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.980521+01	2015-12-20 01:20:49.87844+01	\N	52656500	52656456		http://cdn.rechat.co/52656500.jpg	5	{}	\N	0	2017-04-08 22:05:35.487938+02
60f3eab6-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.998526+01	2015-12-20 01:20:48.954767+01	\N	52656511	52656456		http://cdn.rechat.co/52656511.jpg	16	{}	\N	0	2017-04-08 22:05:35.48892+02
60f09078-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.976537+01	2015-12-20 01:20:50.088243+01	\N	52656497	52656456		http://cdn.rechat.co/52656497.jpg	2	{}	\N	0	2017-04-08 22:05:35.48892+02
60f4a3c0-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:31.003262+01	2015-12-20 01:20:48.738766+01	\N	52656514	52656456		http://cdn.rechat.co/52656514.jpg	19	{}	\N	0	2017-04-08 22:05:35.488926+02
60f21d12-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.986764+01	2015-12-20 01:20:49.543942+01	\N	52656504	52656456		http://cdn.rechat.co/52656504.jpg	9	{}	\N	0	2017-04-08 22:05:35.488926+02
60f1aab2-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.983827+01	2015-12-20 01:20:49.66665+01	\N	52656502	52656456		http://cdn.rechat.co/52656502.jpg	7	{}	\N	0	2017-04-08 22:05:35.488926+02
60f598de-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:31.009523+01	2015-12-20 01:20:48.764529+01	\N	52656518	52656456		http://cdn.rechat.co/52656518.jpg	23	{}	\N	0	2017-04-08 22:05:35.488938+02
60f0c854-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.978038+01	2015-12-20 01:20:49.847167+01	\N	52656498	52656456		http://cdn.rechat.co/52656498.jpg	3	{}	\N	0	2017-04-08 22:05:35.488939+02
60f0f89c-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.979268+01	2015-12-20 01:20:49.819372+01	\N	52656499	52656456		http://cdn.rechat.co/52656499.jpg	4	{}	\N	0	2017-04-08 22:05:35.488949+02
60f15d78-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.981835+01	2015-12-20 01:20:49.787473+01	\N	52656501	52656456		http://cdn.rechat.co/52656501.jpg	6	{}	\N	0	2017-04-08 22:05:35.488949+02
60f51f26-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:31.006405+01	2015-12-20 01:20:48.714234+01	\N	52656516	52656456		http://cdn.rechat.co/52656516.jpg	21	{}	\N	0	2017-04-08 22:05:35.488958+02
60f4254e-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:31.000013+01	2015-12-20 01:20:48.905628+01	\N	52656512	52656456		http://cdn.rechat.co/52656512.jpg	17	{}	\N	0	2017-04-08 22:05:35.488958+02
60f346b0-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.994299+01	2015-12-20 01:20:52.437354+01	\N	52656508	52656456		http://cdn.rechat.co/52656508.jpg	13	{}	\N	0	2017-04-08 22:05:35.488958+02
60f308b2-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.992784+01	2015-12-20 01:20:49.371575+01	\N	52656507	52656456		http://cdn.rechat.co/52656507.jpg	12	{}	\N	0	2017-04-08 22:05:35.48898+02
60f55a4a-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:31.007927+01	2015-12-20 01:20:48.711901+01	\N	52656517	52656456		http://cdn.rechat.co/52656517.jpg	22	{}	\N	0	2017-04-08 22:05:35.488991+02
60f2a476-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.990187+01	2015-12-20 01:20:51.627242+01	\N	52656505	52656456		http://cdn.rechat.co/52656505.jpg	10	{}	\N	0	2017-04-08 22:05:36.648671+02
60f02fca-a3ca-11e5-ac89-f23c91c841bd	2015-12-16 08:55:30.974143+01	2015-12-20 01:20:50.115377+01	\N	52656495	52656456		http://cdn.rechat.co/52656495.jpg	0	{}	\N	0	2017-04-08 22:05:47.693219+02
3b1c0d3e-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.246129+01	2015-12-17 12:47:16.464058+01	\N	55818491	55789812		http://cdn.rechat.co/55818491.jpg	3	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:45", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.224301+02
3b1e8488-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.262377+01	2015-12-17 12:47:16.520457+01	\N	55818507	55789812		http://cdn.rechat.co/55818507.jpg	19	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:52", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.224528+02
3b1b6f64-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.242099+01	2015-12-17 12:47:17.447039+01	\N	55818488	55789812		http://cdn.rechat.co/55818488.jpg	0	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:43", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.224569+02
3b1e3a6e-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.260479+01	2015-12-17 12:47:15.649302+01	\N	55818505	55789812		http://cdn.rechat.co/55818505.jpg	17	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:52", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.224573+02
3b1c5bae-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.248191+01	2015-12-17 12:47:16.254216+01	\N	55818493	55789812		http://cdn.rechat.co/55818493.jpg	5	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:46", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.224574+02
3b1cabc2-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.250261+01	2015-12-17 12:47:16.277445+01	\N	55818495	55789812		http://cdn.rechat.co/55818495.jpg	7	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:47", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.224577+02
3b1dce8a-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.25771+01	2015-12-17 12:47:15.846273+01	\N	55818502	55789812		http://cdn.rechat.co/55818502.jpg	14	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:50", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.224578+02
3b1f17f4-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.266133+01	2015-12-17 12:47:15.618646+01	\N	55818511	55789812		http://cdn.rechat.co/55818511.jpg	23	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:54", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.224582+02
3b1df3ba-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.258663+01	2015-12-17 12:47:15.754811+01	\N	55818503	55789812		http://cdn.rechat.co/55818503.jpg	15	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:51", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.224583+02
3b1f39e6-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.267017+01	2015-12-17 12:47:15.981372+01	\N	55818512	55789812		http://cdn.rechat.co/55818512.jpg	24	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:43", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.224583+02
3b1e5ec2-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.26141+01	2015-12-17 12:47:15.626033+01	\N	55818506	55789812		http://cdn.rechat.co/55818506.jpg	18	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:52", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.226437+02
3b1e16ec-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.25956+01	2015-12-17 12:47:15.701199+01	\N	55818504	55789812		http://cdn.rechat.co/55818504.jpg	16	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:51", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.226441+02
3b1d2c64-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.25355+01	2015-12-17 12:47:16.098014+01	\N	55818498	55789812		http://cdn.rechat.co/55818498.jpg	10	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:49", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.226441+02
3b1d7e30-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.255644+01	2015-12-17 12:47:15.95622+01	\N	55818500	55789812		http://cdn.rechat.co/55818500.jpg	12	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:50", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.226443+02
3b1eab52-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.263362+01	2015-12-17 12:47:15.569497+01	\N	55818508	55789812		http://cdn.rechat.co/55818508.jpg	20	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:53", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.226445+02
3b1d5608-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.254615+01	2015-12-17 12:47:17.085947+01	\N	55818499	55789812		http://cdn.rechat.co/55818499.jpg	11	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:49", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.226449+02
3b1c35ca-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.247134+01	2015-12-17 12:47:17.957591+01	\N	55818492	55789812		http://cdn.rechat.co/55818492.jpg	4	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:45", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.226457+02
3b1da888-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.256742+01	2015-12-17 12:47:16.406881+01	\N	55818501	55789812		http://cdn.rechat.co/55818501.jpg	13	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:50", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.226459+02
3b1ba876-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.243572+01	2015-12-17 12:47:16.572132+01	\N	55818489	55789812		http://cdn.rechat.co/55818489.jpg	1	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:44", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.226459+02
3b1bd3d2-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.244687+01	2015-12-17 12:47:16.496677+01	\N	55818490	55789812		http://cdn.rechat.co/55818490.jpg	2	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:44", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.226467+02
3b1c82d2-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.249216+01	2015-12-17 12:47:58.338221+01	\N	55818494	55789812		http://cdn.rechat.co/55818494.jpg	6	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:47", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.226632+02
3b1ed01e-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.264307+01	2015-12-17 12:47:15.437998+01	\N	55818509	55789812		http://cdn.rechat.co/55818509.jpg	21	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:53", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:39.656983+02
3b1cff50-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.252408+01	2015-12-17 12:47:16.125798+01	\N	55818497	55789812		http://cdn.rechat.co/55818497.jpg	9	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:48", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:49.352276+02
3b1cd69c-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.251362+01	2015-12-17 12:47:16.311192+01	\N	55818496	55789812		http://cdn.rechat.co/55818496.jpg	8	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:48", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:49.357215+02
3b1ef45e-a4b3-11e5-8076-f23c91c841bd	2015-12-17 12:42:20.265233+01	2015-12-17 12:47:15.563446+01	\N	55818510	55789812		http://cdn.rechat.co/55818510.jpg	22	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:07:22 15:45:54", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:49.358127+02
5c1463e4-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.050971+01	2015-12-17 13:06:25.222976+01	\N	55866227	55864068		http://cdn.rechat.co/55866227.jpg	16	{"Software": "Picasa"}	\N	0	2017-04-08 22:05:36.127236+02
5c142ca8-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.049339+01	2015-12-17 13:06:25.38251+01	\N	55866226	55864068		http://cdn.rechat.co/55866226.jpg	15	{"Software": "Picasa"}	\N	0	2017-04-08 22:05:36.127245+02
5c1387a8-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.045169+01	2015-12-17 13:06:26.534386+01	\N	55866225	55864068		http://cdn.rechat.co/55866225.jpg	14	{"Software": "Picasa"}	\N	0	2017-04-08 22:05:36.127257+02
5c1492b0-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.052177+01	2015-12-17 13:06:25.303884+01	\N	55866228	55864068		http://cdn.rechat.co/55866228.jpg	17	{"Software": "Picasa"}	\N	0	2017-04-08 22:05:36.127665+02
5c11ec0e-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.034755+01	2015-12-17 13:06:25.614184+01	\N	55866219	55864068		http://cdn.rechat.co/55866219.jpg	8	{"ISO": 320, "Make": "Panasonic", "Flash": 25, "Model": "DMC-ZS8", "Artist": "Picasa", "FNumber": 3.8, "Contrast": 0, "Software": "Ver.1.1  ", "Sharpness": 0, "ColorSpace": 1, "CreateDate": 1437822907, "ModifyDate": "2015:07:25 16:16:03", "Saturation": 0, "FocalLength": 6.8, "GainControl": 2, "LightSource": 4, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ImageUniqueID": "63b0f2da46ceaed57452bcde04ce3410", "SensingMethod": 2, "CustomRendered": 1, "ExifImageWidth": 800, "ResolutionUnit": 2, "ExifImageHeight": 600, "ExposureProgram": 2, "SensitivityType": 1, "DateTimeOriginal": 1437822907, "DigitalZoomRatio": 0, "MaxApertureValue": 3.8515625, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 2560, "RelatedImageHeight": 1920, "ExposureCompensation": 0, "CompressedBitsPerPixel": 4, "FocalLengthIn35mmFormat": 38}	\N	0	2017-04-08 22:05:48.694649+02
25b90c5e-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.181701+01	2015-12-18 13:44:02.669351+01	\N	58545136	58545058		http://cdn.rechat.co/58545136.jpg	5	{}	\N	0	2017-04-08 22:05:37.735346+02
25b938aa-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.182839+01	2015-12-18 13:44:02.615335+01	\N	58545137	58545058		http://cdn.rechat.co/58545137.jpg	6	{}	\N	0	2017-04-08 22:05:37.735346+02
25b86060-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.177269+01	2015-12-18 13:44:06.551778+01	\N	58545132	58545058		http://cdn.rechat.co/58545132.jpg	1	{}	\N	0	2017-04-08 22:05:37.735347+02
25bc7844-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.204093+01	2015-12-18 13:44:02.011719+01	\N	58545151	58545058		http://cdn.rechat.co/58545151.jpg	20	{}	\N	0	2017-04-08 22:05:37.735363+02
25bd8bd0-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.21114+01	2015-12-18 13:44:01.706803+01	\N	58545155	58545058		http://cdn.rechat.co/58545155.jpg	24	{}	\N	0	2017-04-08 22:05:37.735383+02
5c104570-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.023853+01	2015-12-17 13:06:30.579371+01	\N	55866212	55864068		http://cdn.rechat.co/55866212.jpg	1	{"ISO": 640, "Make": "Panasonic", "Flash": 25, "Model": "DMC-ZS8", "Artist": "Picasa", "FNumber": 3.3, "Contrast": 0, "Software": "Ver.1.1  ", "Sharpness": 0, "ColorSpace": 1, "CreateDate": 1437822819, "ModifyDate": "2015:07:25 16:16:01", "Saturation": 0, "FocalLength": 4.3, "GainControl": 2, "LightSource": 4, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ImageUniqueID": "cf7b7c474fc3e6f73a327bbb019806c4", "SensingMethod": 2, "CustomRendered": 1, "ExifImageWidth": 800, "ResolutionUnit": 2, "ExifImageHeight": 600, "ExposureProgram": 2, "SensitivityType": 1, "DateTimeOriginal": 1437822819, "DigitalZoomRatio": 0, "MaxApertureValue": 3.4453125, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 2560, "RelatedImageHeight": 1920, "ExposureCompensation": 0, "CompressedBitsPerPixel": 4, "FocalLengthIn35mmFormat": 24}	\N	0	2017-04-08 22:05:48.694963+02
5c11baea-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.033497+01	2015-12-17 13:06:25.609931+01	\N	55866218	55864068		http://cdn.rechat.co/55866218.jpg	7	{"ISO": 400, "Make": "Panasonic", "Flash": 25, "Model": "DMC-ZS8", "Artist": "Picasa", "FNumber": 3.5, "Contrast": 0, "Software": "Ver.1.1  ", "Sharpness": 0, "ColorSpace": 1, "CreateDate": 1437822973, "ModifyDate": "2015:07:25 16:16:05", "Saturation": 0, "FocalLength": 5.4, "GainControl": 2, "LightSource": 4, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ImageUniqueID": "fe9c1427901f63ccd45b02d23eed3114", "SensingMethod": 2, "CustomRendered": 1, "ExifImageWidth": 800, "ResolutionUnit": 2, "ExifImageHeight": 600, "ExposureProgram": 2, "SensitivityType": 1, "DateTimeOriginal": 1437822973, "DigitalZoomRatio": 0, "MaxApertureValue": 3.6171875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 2560, "RelatedImageHeight": 1920, "ExposureCompensation": 0, "CompressedBitsPerPixel": 4, "FocalLengthIn35mmFormat": 30}	\N	0	2017-04-08 22:05:48.695159+02
5c108526-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.025529+01	2015-12-17 13:06:25.879872+01	\N	55866213	55864068		http://cdn.rechat.co/55866213.jpg	2	{"ISO": 500, "Make": "Panasonic", "Flash": 25, "Model": "DMC-ZS8", "Artist": "Picasa", "FNumber": 3.3, "Contrast": 0, "Software": "Ver.1.1  ", "Sharpness": 0, "ColorSpace": 1, "CreateDate": 1437822803, "ModifyDate": "2015:07:25 16:16:01", "Saturation": 0, "FocalLength": 4.3, "GainControl": 2, "LightSource": 4, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ImageUniqueID": "c601ca40add8f84011265299afe0a230", "SensingMethod": 2, "CustomRendered": 1, "ExifImageWidth": 800, "ResolutionUnit": 2, "ExifImageHeight": 600, "ExposureProgram": 2, "SensitivityType": 1, "DateTimeOriginal": 1437822803, "DigitalZoomRatio": 0, "MaxApertureValue": 3.4453125, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 2560, "RelatedImageHeight": 1920, "ExposureCompensation": 0, "CompressedBitsPerPixel": 4, "FocalLengthIn35mmFormat": 24}	\N	0	2017-04-08 22:05:48.695284+02
5c100358-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.0222+01	2015-12-17 13:06:26.019556+01	\N	55866211	55864068		http://cdn.rechat.co/55866211.jpg	0	{"ISO": 100, "Make": "Panasonic", "Flash": 24, "Model": "DMC-ZS8", "Artist": "Picasa", "FNumber": 4.5, "Contrast": 0, "Software": "Ver.1.1  ", "Sharpness": 0, "ColorSpace": 1, "CreateDate": 1437821509, "ModifyDate": "2015:07:25 16:16:00", "Saturation": 0, "FocalLength": 4.3, "GainControl": 0, "LightSource": 0, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.002, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ImageUniqueID": "7a170ea1269a88253b137e125642417d", "SensingMethod": 2, "CustomRendered": 1, "ExifImageWidth": 800, "ResolutionUnit": 2, "ExifImageHeight": 600, "ExposureProgram": 2, "SensitivityType": 1, "DateTimeOriginal": 1437821509, "DigitalZoomRatio": 0, "MaxApertureValue": 3.4453125, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 2560, "RelatedImageHeight": 1920, "ExposureCompensation": 0, "CompressedBitsPerPixel": 4, "FocalLengthIn35mmFormat": 24}	\N	0	2017-04-08 22:05:48.695341+02
5c110578-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.02878+01	2015-12-17 13:06:26.310119+01	\N	55866215	55864068		http://cdn.rechat.co/55866215.jpg	4	{"ISO": 250, "Make": "Panasonic", "Flash": 25, "Model": "DMC-ZS8", "Artist": "Picasa", "FNumber": 3.5, "Contrast": 0, "Software": "Ver.1.1  ", "Sharpness": 0, "ColorSpace": 1, "CreateDate": 1437822938, "ModifyDate": "2015:07:25 16:16:04", "Saturation": 0, "FocalLength": 5.4, "GainControl": 2, "LightSource": 4, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ImageUniqueID": "bada1c5d233a2c277a9a229b8de4aa0d", "SensingMethod": 2, "CustomRendered": 1, "ExifImageWidth": 800, "ResolutionUnit": 2, "ExifImageHeight": 600, "ExposureProgram": 2, "SensitivityType": 1, "DateTimeOriginal": 1437822938, "DigitalZoomRatio": 0, "MaxApertureValue": 3.6171875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 2560, "RelatedImageHeight": 1920, "ExposureCompensation": 0, "CompressedBitsPerPixel": 4, "FocalLengthIn35mmFormat": 30}	\N	0	2017-04-08 22:05:48.695374+02
25ba07f8-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.187854+01	2015-12-18 13:44:02.445131+01	\N	58545141	58545058		http://cdn.rechat.co/58545141.jpg	10	{}	\N	0	2017-04-08 22:05:37.735383+02
25b9c52c-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.186416+01	2015-12-18 13:44:02.462966+01	\N	58545140	58545058		http://cdn.rechat.co/58545140.jpg	9	{}	\N	0	2017-04-08 22:05:37.735384+02
25bb587e-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.19254+01	2015-12-18 13:44:02.207125+01	\N	58545146	58545058		http://cdn.rechat.co/58545146.jpg	15	{}	\N	0	2017-04-08 22:05:37.735384+02
25bc09cc-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.201236+01	2015-12-18 13:44:02.042786+01	\N	58545149	58545058		http://cdn.rechat.co/58545149.jpg	18	{}	\N	0	2017-04-08 22:05:37.735385+02
25b99980-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.185283+01	2015-12-18 13:44:02.47947+01	\N	58545139	58545058		http://cdn.rechat.co/58545139.jpg	8	{}	\N	0	2017-04-08 22:05:37.735454+02
25b966d6-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.183995+01	2015-12-18 13:44:02.636336+01	\N	58545138	58545058		http://cdn.rechat.co/58545138.jpg	7	{}	\N	0	2017-04-08 22:05:37.735455+02
25bcabe8-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.205435+01	2015-12-18 13:44:02.400173+01	\N	58545152	58545058		http://cdn.rechat.co/58545152.jpg	21	{}	\N	0	2017-04-08 22:05:37.735456+02
25bcdd34-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.206696+01	2015-12-18 13:44:01.780323+01	\N	58545153	58545058		http://cdn.rechat.co/58545153.jpg	22	{}	\N	0	2017-04-08 22:05:37.735456+02
25b8e1fc-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.180574+01	2015-12-18 13:44:02.712171+01	\N	58545135	58545058		http://cdn.rechat.co/58545135.jpg	4	{}	\N	0	2017-04-08 22:05:37.735457+02
5c12216a-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.036114+01	2015-12-17 13:06:25.580195+01	\N	55866220	55864068		http://cdn.rechat.co/55866220.jpg	9	{"ISO": 400, "Make": "Panasonic", "Flash": 25, "Model": "DMC-ZS8", "Artist": "Picasa", "FNumber": 3.5, "Contrast": 0, "Software": "Ver.1.1  ", "Sharpness": 0, "ColorSpace": 1, "CreateDate": 1437822988, "ModifyDate": "2015:07:25 16:16:06", "Saturation": 0, "FocalLength": 5.4, "GainControl": 2, "LightSource": 4, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ImageUniqueID": "973238c2d7a6b4a819f00336cd23d4cc", "SensingMethod": 2, "CustomRendered": 1, "ExifImageWidth": 800, "ResolutionUnit": 2, "ExifImageHeight": 600, "ExposureProgram": 2, "SensitivityType": 1, "DateTimeOriginal": 1437822988, "DigitalZoomRatio": 0, "MaxApertureValue": 3.6171875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 2560, "RelatedImageHeight": 1920, "ExposureCompensation": 0, "CompressedBitsPerPixel": 4, "FocalLengthIn35mmFormat": 30}	\N	0	2017-04-08 22:05:48.695682+02
5c126fc6-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.037968+01	2015-12-17 13:06:25.521449+01	\N	55866221	55864068		http://cdn.rechat.co/55866221.jpg	10	{"ISO": 400, "Make": "Panasonic", "Flash": 25, "Model": "DMC-ZS8", "Artist": "Picasa", "FNumber": 3.3, "Contrast": 0, "Software": "Ver.1.1  ", "Sharpness": 0, "ColorSpace": 1, "CreateDate": 1437822849, "ModifyDate": "2015:07:25 16:16:02", "Saturation": 0, "FocalLength": 4.3, "GainControl": 2, "LightSource": 4, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ImageUniqueID": "143b6e5d3f5aaa6c004ef6f4d70b1f12", "SensingMethod": 2, "CustomRendered": 1, "ExifImageWidth": 600, "ResolutionUnit": 2, "ExifImageHeight": 800, "ExposureProgram": 2, "SensitivityType": 1, "DateTimeOriginal": 1437822849, "DigitalZoomRatio": 0, "MaxApertureValue": 3.4453125, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 2560, "RelatedImageHeight": 1920, "ExposureCompensation": 0, "CompressedBitsPerPixel": 4, "FocalLengthIn35mmFormat": 24}	\N	0	2017-04-08 22:05:48.696961+02
5c14c1ae-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.053381+01	2015-12-17 13:06:25.906774+01	\N	55866229	55864068		http://cdn.rechat.co/55866229.jpg	18	{"ISO": 100, "Make": "Panasonic", "Flash": 24, "Model": "DMC-ZS8", "Artist": "Picasa", "FNumber": 4, "Contrast": 0, "Software": "Ver.1.1  ", "Sharpness": 0, "ColorSpace": 1, "CreateDate": 1437822236, "ModifyDate": "2015:07:25 16:16:00", "Saturation": 0, "FocalLength": 4.3, "GainControl": 0, "LightSource": 0, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.0025, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ImageUniqueID": "bd7783455debe11770c79b12751fb2f7", "SensingMethod": 2, "CustomRendered": 1, "ExifImageWidth": 800, "ResolutionUnit": 2, "ExifImageHeight": 600, "ExposureProgram": 2, "SensitivityType": 1, "DateTimeOriginal": 1437822236, "DigitalZoomRatio": 0, "MaxApertureValue": 3.4453125, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 2560, "RelatedImageHeight": 1920, "ExposureCompensation": 0, "CompressedBitsPerPixel": 4, "FocalLengthIn35mmFormat": 24}	\N	0	2017-04-08 22:05:48.697281+02
5c14f0f2-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.054571+01	2015-12-17 13:06:24.7252+01	\N	55866230	55864068		http://cdn.rechat.co/55866230.jpg	19	{"Software": "Picasa"}	\N	0	2017-04-08 22:05:48.69729+02
5c1182dc-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.032108+01	2015-12-17 13:06:26.247689+01	\N	55866217	55864068		http://cdn.rechat.co/55866217.jpg	6	{"ISO": 400, "Make": "Panasonic", "Flash": 25, "Model": "DMC-ZS8", "Artist": "Picasa", "FNumber": 3.8, "Contrast": 0, "Software": "Ver.1.1  ", "Sharpness": 0, "ColorSpace": 1, "CreateDate": 1437822895, "ModifyDate": "2015:07:25 16:16:03", "Saturation": 0, "FocalLength": 6.8, "GainControl": 2, "LightSource": 4, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ImageUniqueID": "a839cd1d26dcf6ec880b957e915a753e", "SensingMethod": 2, "CustomRendered": 1, "ExifImageWidth": 800, "ResolutionUnit": 2, "ExifImageHeight": 600, "ExposureProgram": 2, "SensitivityType": 1, "DateTimeOriginal": 1437822895, "DigitalZoomRatio": 0, "MaxApertureValue": 3.8515625, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 2560, "RelatedImageHeight": 1920, "ExposureCompensation": 0, "CompressedBitsPerPixel": 4, "FocalLengthIn35mmFormat": 38}	\N	0	2017-04-08 22:05:48.69729+02
5c10c176-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.027075+01	2015-12-17 13:06:25.87465+01	\N	55866214	55864068		http://cdn.rechat.co/55866214.jpg	3	{"ISO": 400, "Make": "Panasonic", "Flash": 25, "Model": "DMC-ZS8", "Artist": "Picasa", "FNumber": 3.5, "Contrast": 0, "Software": "Ver.1.1  ", "Sharpness": 0, "ColorSpace": 1, "CreateDate": 1437822950, "ModifyDate": "2015:07:25 16:16:05", "Saturation": 0, "FocalLength": 5.4, "GainControl": 2, "LightSource": 4, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ImageUniqueID": "f97e2048d3c0eae8f257db79f6869590", "SensingMethod": 2, "CustomRendered": 1, "ExifImageWidth": 800, "ResolutionUnit": 2, "ExifImageHeight": 600, "ExposureProgram": 2, "SensitivityType": 1, "DateTimeOriginal": 1437822950, "DigitalZoomRatio": 0, "MaxApertureValue": 3.6171875, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 2560, "RelatedImageHeight": 1920, "ExposureCompensation": 0, "CompressedBitsPerPixel": 4, "FocalLengthIn35mmFormat": 30}	\N	0	2017-04-08 22:05:48.697293+02
25ba52ee-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.19+01	2015-12-18 13:44:02.911567+01	\N	58545143	58545058		http://cdn.rechat.co/58545143.jpg	12	{}	\N	0	2017-04-08 22:05:37.735458+02
25bd13e4-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.208016+01	2015-12-18 13:44:01.766537+01	\N	58545154	58545058		http://cdn.rechat.co/58545154.jpg	23	{}	\N	0	2017-04-08 22:05:37.874579+02
25b832d4-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.176106+01	2015-12-18 13:44:02.952879+01	\N	58545131	58545058		http://cdn.rechat.co/58545131.jpg	0	{}	\N	0	2017-04-08 22:05:55.760773+02
25b88ab8-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.178378+01	2015-12-18 13:44:06.430511+01	\N	58545133	58545058		http://cdn.rechat.co/58545133.jpg	2	{}	\N	0	2017-04-08 22:05:55.773295+02
8a338a98-a588-11e5-858f-f23c91c841bd	2015-12-18 14:09:15.743497+01	2015-12-18 14:14:54.232766+01	\N	58602039	58554075	Living Room looking over balcony to west Downtown	http://cdn.rechat.co/58602039.jpg	1	{}	\N	0	2017-04-08 22:05:36.702451+02
8a3481a0-a588-11e5-858f-f23c91c841bd	2015-12-18 14:09:15.749839+01	2015-12-18 14:14:53.884249+01	\N	58602044	58554075	Living Room looking towards Kitchen	http://cdn.rechat.co/58602044.jpg	6	{}	\N	0	2017-04-08 22:05:36.702452+02
8a33bfea-a588-11e5-858f-f23c91c841bd	2015-12-18 14:09:15.74491+01	2015-12-18 14:15:07.62397+01	\N	58602040	58554075	Good  view of Kitchen - Great view of Downtown from	http://cdn.rechat.co/58602040.jpg	2	{}	\N	0	2017-04-08 22:05:36.702478+02
5c114f60-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.030625+01	2015-12-17 13:06:25.793409+01	\N	55866216	55864068		http://cdn.rechat.co/55866216.jpg	5	{"ISO": 250, "Make": "Panasonic", "Flash": 25, "Model": "DMC-ZS8", "Artist": "Picasa", "FNumber": 3.8, "Contrast": 0, "Software": "Ver.1.1  ", "Sharpness": 0, "ColorSpace": 1, "CreateDate": 1437822924, "ModifyDate": "2015:07:25 16:16:04", "Saturation": 0, "FocalLength": 6.8, "GainControl": 2, "LightSource": 4, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ImageUniqueID": "4ccc5efa7ade584eb5ebc7c38f6031b0", "SensingMethod": 2, "CustomRendered": 1, "ExifImageWidth": 800, "ResolutionUnit": 2, "ExifImageHeight": 600, "ExposureProgram": 2, "SensitivityType": 1, "DateTimeOriginal": 1437822924, "DigitalZoomRatio": 0, "MaxApertureValue": 3.8515625, "SceneCaptureType": 0, "YCbCrPositioning": 2, "RelatedImageWidth": 2560, "RelatedImageHeight": 1920, "ExposureCompensation": 0, "CompressedBitsPerPixel": 4, "FocalLengthIn35mmFormat": 38}	\N	0	2017-04-08 22:05:48.697293+02
5c133794-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.043195+01	2015-12-17 13:06:25.483232+01	\N	55866224	55864068		http://cdn.rechat.co/55866224.jpg	13	{"Software": "Picasa"}	\N	0	2017-04-08 22:05:48.6977+02
5c12ab44-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.039646+01	2015-12-17 13:06:25.517819+01	\N	55866222	55864068		http://cdn.rechat.co/55866222.jpg	11	{"Software": "Picasa"}	\N	0	2017-04-08 22:05:48.698201+02
5c12f5cc-a4b6-11e5-a100-f23c91c841bd	2015-12-17 13:04:44.041491+01	2015-12-17 13:06:27.443298+01	\N	55866223	55864068		http://cdn.rechat.co/55866223.jpg	12	{"ISO": 64, "Make": "NIKON", "Flash": 24, "Model": "COOLPIX P50  ", "FNumber": 2.8, "Contrast": 0, "Software": "COOLPIX P50V1.0                ", "Sharpness": 0, "ColorSpace": 1, "CreateDate": -62169984000, "ModifyDate": "0000:00:00 00:00:00", "Saturation": 0, "FocalLength": 4.7, "GainControl": 1, "LightSource": 0, "Orientation": 1, "XResolution": 300, "YResolution": 300, "ExposureMode": 0, "ExposureTime": 0.002430133657351154, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "CustomRendered": 0, "ExifImageWidth": 3264, "ResolutionUnit": 2, "ExifImageHeight": 2448, "ExposureProgram": 2, "DateTimeOriginal": -62169984000, "DigitalZoomRatio": 0, "ImageDescription": "                               ", "MaxApertureValue": 3, "SceneCaptureType": 0, "YCbCrPositioning": 2, "ExposureCompensation": 0, "SubjectDistanceRange": 0, "CompressedBitsPerPixel": 2, "FocalLengthIn35mmFormat": 28}	\N	0	2017-04-08 22:05:48.698466+02
251019aa-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:48.074499+01	2015-12-18 13:44:34.90612+01	\N	58544192	58544147		http://cdn.rechat.co/58544192.jpg	8	{"Software": "Adobe Photoshop Lightroom 6.1 (Macintosh)", "ModifyDate": "2015:12:09 14:37:02", "Orientation": 1, "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.69197+02
251059b0-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:48.076143+01	2015-12-18 13:44:37.444704+01	\N	58544194	58544147		http://cdn.rechat.co/58544194.jpg	10	{"Software": "Adobe Photoshop Lightroom 6.1 (Macintosh)", "ModifyDate": "2015:12:09 14:37:03", "Orientation": 1, "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.691975+02
250f04b6-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:48.067383+01	2015-12-18 13:44:35.537+01	\N	58544184	58544147		http://cdn.rechat.co/58544184.jpg	0	{"Software": "Adobe Photoshop Lightroom 6.1 (Macintosh)", "ModifyDate": "2015:12:09 14:36:58", "Orientation": 1, "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.691976+02
250f6d7a-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:48.070056+01	2015-12-18 13:44:35.307337+01	\N	58544187	58544147		http://cdn.rechat.co/58544187.jpg	3	{"Software": "Adobe Photoshop Lightroom 6.1 (Macintosh)", "ModifyDate": "2015:12:09 14:37:00", "Orientation": 1, "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.69407+02
250f2342-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:48.068188+01	2015-12-18 13:44:35.664924+01	\N	58544185	58544147		http://cdn.rechat.co/58544185.jpg	1	{"Software": "Adobe Photoshop Lightroom 6.1 (Macintosh)", "ModifyDate": "2015:12:09 14:36:58", "Orientation": 1, "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.694071+02
25107bb6-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:48.076964+01	2015-12-18 13:44:34.923514+01	\N	58544195	58544147		http://cdn.rechat.co/58544195.jpg	11	{"Software": "Adobe Photoshop Lightroom 6.1 (Macintosh)", "ModifyDate": "2015:12:09 14:37:03", "Orientation": 1, "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:36.694072+02
250f42d2-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:48.068992+01	2015-12-18 13:44:37.173675+01	\N	58544186	58544147		http://cdn.rechat.co/58544186.jpg	2	{"Software": "Adobe Photoshop Lightroom 6.1 (Macintosh)", "ModifyDate": "2015:12:09 14:36:58", "Orientation": 1, "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:37.330362+02
250f944e-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:48.071052+01	2015-12-18 13:44:35.477911+01	\N	58544188	58544147		http://cdn.rechat.co/58544188.jpg	4	{"Software": "Adobe Photoshop Lightroom 6.1 (Macintosh)", "ModifyDate": "2015:12:09 14:37:01", "Orientation": 1, "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:37.330363+02
250ffb96-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:48.073726+01	2015-12-18 13:44:35.50142+01	\N	58544191	58544147		http://cdn.rechat.co/58544191.jpg	7	{"Software": "Adobe Photoshop Lightroom 6.1 (Macintosh)", "ModifyDate": "2015:12:09 14:37:02", "Orientation": 1, "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:37.728354+02
250fda3a-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:48.072856+01	2015-12-18 13:44:35.060567+01	\N	58544190	58544147		http://cdn.rechat.co/58544190.jpg	6	{"Software": "Adobe Photoshop Lightroom 6.1 (Macintosh)", "ModifyDate": "2015:12:09 14:37:02", "Orientation": 1, "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:37.876669+02
250fb35c-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:48.07187+01	2015-12-18 13:44:35.354797+01	\N	58544189	58544147		http://cdn.rechat.co/58544189.jpg	5	{"Software": "Adobe Photoshop Lightroom 6.1 (Macintosh)", "ModifyDate": "2015:12:09 14:37:01", "Orientation": 1, "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:37.876671+02
251036ce-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:48.075249+01	2015-12-18 13:44:35.649008+01	\N	58544193	58544147		http://cdn.rechat.co/58544193.jpg	9	{"Software": "Adobe Photoshop Lightroom 6.1 (Macintosh)", "ModifyDate": "2015:12:09 14:37:03", "Orientation": 1, "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:55.77188+02
25b8b51a-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.179467+01	2015-12-18 13:44:02.754749+01	\N	58545134	58545058		http://cdn.rechat.co/58545134.jpg	3	{}	\N	0	2017-04-08 22:05:36.694003+02
25ba93da-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.191711+01	2015-12-18 13:44:02.172447+01	\N	58545145	58545058		http://cdn.rechat.co/58545145.jpg	14	{}	\N	0	2017-04-08 22:05:36.694004+02
25bbcde0-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.19972+01	2015-12-18 13:44:02.024926+01	\N	58545148	58545058		http://cdn.rechat.co/58545148.jpg	17	{}	\N	0	2017-04-08 22:05:36.694004+02
25bb9bae-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.198335+01	2015-12-18 13:44:02.092185+01	\N	58545147	58545058		http://cdn.rechat.co/58545147.jpg	16	{}	\N	0	2017-04-08 22:05:37.328256+02
25ba2e68-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.189099+01	2015-12-18 13:44:02.917951+01	\N	58545142	58545058		http://cdn.rechat.co/58545142.jpg	11	{}	\N	0	2017-04-08 22:05:37.328275+02
25bc4252-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.202724+01	2015-12-18 13:44:02.078724+01	\N	58545150	58545058		http://cdn.rechat.co/58545150.jpg	19	{}	\N	0	2017-04-08 22:05:37.703866+02
25ba7184-a584-11e5-9d3f-f23c91c841bd	2015-12-18 13:37:49.190832+01	2015-12-18 13:44:02.338745+01	\N	58545144	58545058		http://cdn.rechat.co/58545144.jpg	13	{}	\N	0	2017-04-08 22:05:37.703876+02
8a3450b8-a588-11e5-858f-f23c91c841bd	2015-12-18 14:09:15.748551+01	2015-12-18 14:14:53.944122+01	\N	58602043	58554075	Wide Entry	http://cdn.rechat.co/58602043.jpg	5	{}	\N	0	2017-04-08 22:05:36.704094+02
8a33f03c-a588-11e5-858f-f23c91c841bd	2015-12-18 14:09:15.746125+01	2015-12-18 14:14:54.036801+01	\N	58602041	58554075	View of Kitchen from east end	http://cdn.rechat.co/58602041.jpg	3	{}	\N	0	2017-04-08 22:05:36.704095+02
8a267010-a588-11e5-858f-f23c91c841bd	2015-12-18 14:09:15.657565+01	2015-12-18 14:14:54.280887+01	\N	58602038	58554075	Downtown Dallas centered from balcony	http://cdn.rechat.co/58602038.jpg	0	{}	\N	0	2017-04-08 22:05:37.718032+02
8a353de8-a588-11e5-858f-f23c91c841bd	2015-12-18 14:09:15.754673+01	2015-12-18 14:14:53.658841+01	\N	58602048	58554075		http://cdn.rechat.co/58602048.jpg	10	{}	\N	0	2017-04-08 22:05:48.425018+02
8a34de66-a588-11e5-858f-f23c91c841bd	2015-12-18 14:09:15.752172+01	2015-12-18 14:14:53.727745+01	\N	58602046	58554075	Bath with double lavatories, open shower behind tub,  lots of room	http://cdn.rechat.co/58602046.jpg	8	{}	\N	0	2017-04-08 22:05:48.425117+02
8a356872-a588-11e5-858f-f23c91c841bd	2015-12-18 14:09:15.755775+01	2015-12-18 14:14:53.591221+01	\N	58602049	58554075	Condo Pool	http://cdn.rechat.co/58602049.jpg	11	{}	\N	0	2017-04-08 22:05:48.425118+02
8a3421c4-a588-11e5-858f-f23c91c841bd	2015-12-18 14:09:15.747395+01	2015-12-18 14:14:53.955466+01	\N	58602042	58554075	Raised bar in front of Kitchen	http://cdn.rechat.co/58602042.jpg	4	{}	\N	0	2017-04-08 22:05:48.425118+02
8a34ae5a-a588-11e5-858f-f23c91c841bd	2015-12-18 14:09:15.751005+01	2015-12-18 14:14:53.928192+01	\N	58602045	58554075	Master Bedroom	http://cdn.rechat.co/58602045.jpg	7	{}	\N	0	2017-04-08 22:05:48.425119+02
8a359874-a588-11e5-858f-f23c91c841bd	2015-12-18 14:09:15.756997+01	2015-12-18 14:14:53.614611+01	\N	58602050	58554075	Master Bedroom looking to east side of Downtown over Balcony	http://cdn.rechat.co/58602050.jpg	12	{}	\N	0	2017-04-08 22:05:48.425119+02
8a350e22-a588-11e5-858f-f23c91c841bd	2015-12-18 14:09:15.753439+01	2015-12-18 14:14:53.731342+01	\N	58602047	58554075	Half Bath with interesting wash bowl	http://cdn.rechat.co/58602047.jpg	9	{}	\N	0	2017-04-08 22:05:48.427637+02
27e57070-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.808355+01	2015-12-18 14:26:45.364917+01	\N	58625132	58615835		http://cdn.rechat.co/58625132.jpg	16	{}	\N	0	2017-04-08 22:05:36.59726+02
27e52340-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.806412+01	2015-12-18 14:26:45.316354+01	\N	58625130	58615835		http://cdn.rechat.co/58625130.jpg	14	{}	\N	0	2017-04-08 22:05:36.59726+02
27e4071c-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.799123+01	2015-12-18 14:26:45.900268+01	\N	58625122	58615835		http://cdn.rechat.co/58625122.jpg	6	{}	\N	0	2017-04-08 22:05:36.597261+02
27e3dd8c-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.798055+01	2015-12-18 14:26:46.105003+01	\N	58625121	58615835		http://cdn.rechat.co/58625121.jpg	5	{}	\N	0	2017-04-08 22:05:36.597261+02
27e4db38-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.804561+01	2015-12-18 14:26:45.544587+01	\N	58625128	58615835		http://cdn.rechat.co/58625128.jpg	12	{}	\N	0	2017-04-08 22:05:36.597262+02
27e33d0a-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.79394+01	2015-12-18 14:26:46.800117+01	\N	58625117	58615835		http://cdn.rechat.co/58625117.jpg	2	{}	\N	0	2017-04-08 22:05:36.597262+02
27e2bde4-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.790684+01	2015-12-18 14:26:46.325251+01	\N	58625114	58615835		http://cdn.rechat.co/58625114.jpg	23	{}	\N	0	2017-04-08 22:05:36.597263+02
27e479ae-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.802091+01	2015-12-18 14:26:45.669281+01	\N	58625125	58615835		http://cdn.rechat.co/58625125.jpg	9	{}	\N	0	2017-04-08 22:05:36.597266+02
27e4b87e-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.803675+01	2015-12-18 14:26:45.623711+01	\N	58625127	58615835		http://cdn.rechat.co/58625127.jpg	11	{}	\N	0	2017-04-08 22:05:36.597266+02
27e292c4-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.789491+01	2015-12-18 14:26:46.487043+01	\N	58625113	58615835		http://cdn.rechat.co/58625113.jpg	22	{}	\N	0	2017-04-08 22:05:36.705482+02
27e36672-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.794982+01	2015-12-18 14:26:50.180408+01	\N	58625118	58615835		http://cdn.rechat.co/58625118.jpg	3	{}	\N	0	2017-04-08 22:05:36.705513+02
27e4ffa0-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.80552+01	2015-12-18 14:26:45.540867+01	\N	58625129	58615835		http://cdn.rechat.co/58625129.jpg	13	{}	\N	0	2017-04-08 22:05:37.713839+02
27e59e06-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.809576+01	2015-12-18 14:26:47.910753+01	\N	58625133	58615835		http://cdn.rechat.co/58625133.jpg	17	{}	\N	0	2017-04-08 22:05:41.457391+02
27e38d64-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.796011+01	2015-12-18 14:26:46.008626+01	\N	58625119	58615835		http://cdn.rechat.co/58625119.jpg	0	{}	\N	0	2017-04-08 22:05:48.419103+02
27e3b3e8-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.796977+01	2015-12-18 14:26:45.935276+01	\N	58625120	58615835		http://cdn.rechat.co/58625120.jpg	4	{}	\N	0	2017-04-08 22:05:48.419104+02
27e316a4-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.792937+01	2015-12-18 14:26:46.208037+01	\N	58625116	58615835		http://cdn.rechat.co/58625116.jpg	1	{}	\N	0	2017-04-08 22:05:48.419104+02
27e54456-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.807312+01	2015-12-18 14:26:45.569861+01	\N	58625131	58615835		http://cdn.rechat.co/58625131.jpg	15	{}	\N	0	2017-04-08 22:05:48.419105+02
27e49772-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.80288+01	2015-12-18 14:26:45.631642+01	\N	58625126	58615835		http://cdn.rechat.co/58625126.jpg	10	{}	\N	0	2017-04-08 22:05:48.419228+02
27e42e0e-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.800119+01	2015-12-18 14:26:45.75388+01	\N	58625123	58615835		http://cdn.rechat.co/58625123.jpg	7	{}	\N	0	2017-04-08 22:05:48.419794+02
27e2eb0c-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.791829+01	2015-12-18 14:26:46.86381+01	\N	58625115	58615835		http://cdn.rechat.co/58625115.jpg	24	{}	\N	0	2017-04-08 22:05:48.42946+02
27e64a9a-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.813947+01	2015-12-18 14:26:45.140808+01	\N	58625137	58615835		http://cdn.rechat.co/58625137.jpg	21	{}	\N	0	2017-04-08 22:05:48.42952+02
27e5c502-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.810604+01	2015-12-18 14:26:45.733325+01	\N	58625134	58615835		http://cdn.rechat.co/58625134.jpg	18	{}	\N	0	2017-04-08 22:05:48.429521+02
27e5ea00-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.811506+01	2015-12-18 14:26:45.285731+01	\N	58625135	58615835		http://cdn.rechat.co/58625135.jpg	19	{}	\N	0	2017-04-08 22:05:48.431558+02
27e61980-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.812664+01	2015-12-18 14:26:45.184214+01	\N	58625136	58615835		http://cdn.rechat.co/58625136.jpg	20	{}	\N	0	2017-04-08 22:05:48.431559+02
27e4553c-a58a-11e5-8c69-f23c91c841bd	2015-12-18 14:20:49.801121+01	2015-12-18 14:26:58.785043+01	\N	58625124	58615835		http://cdn.rechat.co/58625124.jpg	8	{}	\N	0	2017-04-08 22:05:48.431585+02
7c1378d8-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.528914+01	2015-12-20 22:52:14.898927+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665906	58665269		\N	14	\N	\N	0	2017-04-08 22:05:48.401374+02
7c140640-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.532536+01	2015-12-20 22:52:14.868765+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665910	58665269		\N	17	\N	\N	0	2017-04-08 22:05:48.402924+02
7c152c28-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.54004+01	2015-12-20 22:52:14.811825+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665915	58665269		\N	22	\N	\N	0	2017-04-08 22:05:48.402963+02
7c125d9a-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.521605+01	2015-12-20 22:52:15.004922+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665899	58665269		\N	7	\N	\N	0	2017-04-08 22:05:48.403033+02
7c120ea8-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.519025+01	2015-12-20 22:52:15.021317+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665897	58665269		\N	5	\N	\N	0	2017-04-08 22:05:48.403049+02
7c1623f8-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.546407+01	2015-12-20 22:52:14.761185+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665919	58665269		\N	26	\N	\N	0	2017-04-08 22:05:48.40309+02
7c12d9a0-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.524814+01	2015-12-20 22:52:14.959783+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665902	58665269		\N	10	\N	\N	0	2017-04-08 22:05:48.404704+02
7c13d7e2-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.531331+01	2015-12-20 22:52:14.880177+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665909	58665269		\N	16	\N	\N	0	2017-04-08 22:05:48.426668+02
7c12b1dc-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.523793+01	2015-12-20 22:52:14.9777+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665901	58665269		\N	9	\N	\N	0	2017-04-08 22:05:48.434554+02
7c128518-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.522634+01	2015-12-20 22:52:14.995406+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665900	58665269		\N	8	\N	\N	0	2017-04-08 22:05:48.434554+02
7c11ac6a-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.517099+01	2015-12-20 22:52:15.037288+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665895	58665269		\N	3	\N	\N	0	2017-04-08 22:05:48.434784+02
7c115ef4-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.515117+01	2015-12-20 22:52:15.058311+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665893	58665269		\N	1	\N	\N	0	2017-04-08 22:05:48.434785+02
7c15f6e4-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.545254+01	2015-12-20 22:52:14.772346+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665918	58665269		\N	25	\N	\N	0	2017-04-08 22:05:48.43481+02
7c156512-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.541402+01	2015-12-20 22:52:14.800105+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665916	58665269		\N	23	\N	\N	0	2017-04-08 22:05:48.43482+02
7c14f410-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.538583+01	2015-12-20 22:52:14.823135+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665914	58665269		\N	21	\N	\N	0	2017-04-08 22:05:48.434828+02
7c14c030-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.53727+01	2015-12-20 22:52:14.833976+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665913	58665269		\N	20	\N	\N	0	2017-04-08 22:05:48.434828+02
7c1659b8-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.547761+01	2015-12-20 22:52:14.748341+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665920	58665269		\N	27	\N	\N	0	2017-04-08 22:05:48.708787+02
7c15c796-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.544033+01	2015-12-20 22:52:14.785934+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665917	58665269		\N	24	\N	\N	0	2017-04-08 22:05:48.708787+02
7c1491b4-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.536069+01	2015-12-20 22:52:14.84601+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665912	58665269		\N	19	\N	\N	0	2017-04-08 22:05:48.708788+02
7c1461bc-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.534874+01	2015-12-20 22:52:14.857144+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665911	58665269		\N	18	\N	\N	0	2017-04-08 22:05:48.708788+02
7c1350c4-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.527837+01	2015-12-20 22:52:14.912801+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665905	58665269		\N	13	\N	\N	0	2017-04-08 22:05:48.708788+02
7c13015a-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.525833+01	2015-12-20 22:52:14.942673+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665903	58665269		\N	11	\N	\N	0	2017-04-08 22:05:48.708789+02
7c123432-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.520535+01	2015-12-20 22:52:15.012848+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665898	58665269		\N	6	\N	\N	0	2017-04-08 22:05:48.70879+02
7c1185be-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.51611+01	2015-12-20 22:52:15.048177+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665894	58665269		\N	2	\N	\N	0	2017-04-08 22:05:48.70879+02
7c113898-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.514124+01	2015-12-20 22:52:15.092663+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665892	58665269		\N	0	\N	\N	0	2017-04-08 22:05:48.708791+02
7c1327ac-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.526809+01	2015-12-20 22:52:15.436598+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665904	58665269		\N	12	\N	\N	0	2017-04-08 22:05:48.708807+02
7c11d2f8-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.518085+01	2015-12-20 22:52:15.527695+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665896	58665269		\N	4	\N	\N	0	2017-04-08 22:05:48.708808+02
7c13a88a-a58d-11e5-b8f0-f23c91c841bd	2015-12-18 14:44:39.530086+01	2015-12-20 22:52:15.926284+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20412" ReplyText="Too many outstanding requests">\n</RETS>\n	58665908	58665269		\N	15	\N	\N	0	2017-04-08 22:05:48.708812+02
fda75ed0-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.824584+01	2015-12-21 19:56:20.961686+01	\N	58706124	58705917		http://cdn.rechat.co/58706124.jpg	3	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436274, "ModifyDate": "2015:12:18 16:05:58", "Saturation": 0, "FocalLength": 9, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.011111111111111112, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 6.25, "ExifImageHeight": 972, "ExposureProgram": 3, "DateTimeOriginal": 1450436274, "MaxApertureValue": 4.41, "SceneCaptureType": 0, "ShutterSpeedValue": 6.491853, "ExposureCompensation": 0, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 14, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:36.81669+02
fdab5efe-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.850862+01	2015-12-21 19:56:28.466074+01	\N	58706138	58705917		http://cdn.rechat.co/58706138.jpg	17	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450437003, "ModifyDate": "2015:12:19 13:28:36", "Saturation": 0, "FocalLength": 9.5, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.003125, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 8.41, "ExifImageHeight": 960, "ExposureProgram": 3, "DateTimeOriginal": 1450437003, "MaxApertureValue": 4.5, "SceneCaptureType": 0, "ShutterSpeedValue": 8.321928, "ExposureCompensation": 0.33, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 14, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.112044+02
fdac2f28-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.856234+01	2015-12-21 19:56:28.728969+01	\N	58706142	58705917		http://cdn.rechat.co/58706142.jpg	21	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450435880, "ModifyDate": "2015:12:18 14:26:50", "Saturation": 0, "FocalLength": 8, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.0025, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 8.75, "ExifImageHeight": 963, "ExposureProgram": 3, "DateTimeOriginal": 1450435880, "MaxApertureValue": 4.33, "SceneCaptureType": 0, "ShutterSpeedValue": 8.643856, "ExposureCompensation": 0.33, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 12, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.112089+02
fdac5480-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.857199+01	2015-12-21 19:56:29.76717+01	\N	58706143	58705917		http://cdn.rechat.co/58706143.jpg	22	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450435816, "ModifyDate": "2015:12:18 14:22:53", "Saturation": 0, "FocalLength": 13, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.0008, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 3043, "ResolutionUnit": 2, "BrightnessValue": 10.08, "ExifImageHeight": 2036, "ExposureProgram": 3, "DateTimeOriginal": 1450435816, "MaxApertureValue": 4.66, "SceneCaptureType": 0, "ShutterSpeedValue": 10.287712, "ExposureCompensation": 0, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 20, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.112325+02
fdabe39c-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.854217+01	2015-12-21 19:56:31.245292+01	\N	58706140	58705917		http://cdn.rechat.co/58706140.jpg	19	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450435989, "ModifyDate": "2015:12:18 15:46:45", "Saturation": 0, "FocalLength": 8, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.004347826086956522, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 7.91, "ExifImageHeight": 963, "ExposureProgram": 3, "DateTimeOriginal": 1450435989, "MaxApertureValue": 4.33, "SceneCaptureType": 0, "ShutterSpeedValue": 7.84549, "ExposureCompensation": 0.33, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 12, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.113958+02
fdac0a16-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.855268+01	2015-12-21 19:56:24.061846+01	\N	58706141	58705917		http://cdn.rechat.co/58706141.jpg	20	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450435960, "ModifyDate": "2015:12:18 15:43:54", "Saturation": 0, "FocalLength": 8, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.004, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 8, "ExifImageHeight": 963, "ExposureProgram": 3, "DateTimeOriginal": 1450435960, "MaxApertureValue": 4.33, "SceneCaptureType": 0, "ShutterSpeedValue": 7.965784, "ExposureCompensation": 0.33, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 12, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.117167+02
fda9b9aa-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.840078+01	2015-12-21 19:56:26.145227+01	\N	58706131	58705917		http://cdn.rechat.co/58706131.jpg	10	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436802, "ModifyDate": "2015:12:19 11:52:51", "Saturation": 0, "FocalLength": 9, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.07692307692307693, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 3.91, "ExifImageHeight": 963, "ExposureProgram": 3, "DateTimeOriginal": 1450436802, "MaxApertureValue": 4.41, "SceneCaptureType": 0, "ShutterSpeedValue": 3.70044, "ExposureCompensation": 0.33, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 14, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.177937+02
fdaba47c-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.852639+01	2015-12-21 19:56:32.055526+01	\N	58706139	58705917		http://cdn.rechat.co/58706139.jpg	18	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450437052, "ModifyDate": "2015:12:19 13:30:31", "Saturation": 0, "FocalLength": 8.5, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.002857142857142857, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 8.5, "ExifImageHeight": 963, "ExposureProgram": 3, "DateTimeOriginal": 1450437052, "MaxApertureValue": 4.41, "SceneCaptureType": 0, "ShutterSpeedValue": 8.451211, "ExposureCompensation": 0.33, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 13, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.178161+02
fda8a47a-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.832673+01	2015-12-21 19:56:20.757606+01	\N	58706127	58705917		http://cdn.rechat.co/58706127.jpg	6	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436382, "ModifyDate": "2015:12:18 17:02:15", "Saturation": 0, "FocalLength": 8.5, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.011111111111111112, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 7.16, "ExifImageHeight": 963, "ExposureProgram": 3, "DateTimeOriginal": 1450436382, "MaxApertureValue": 4.41, "SceneCaptureType": 0, "ShutterSpeedValue": 6.491853, "ExposureCompensation": 1, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 13, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.180987+02
10bf6f5e-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.561214+01	2016-01-11 18:49:36.294916+01	\N	59002895	58982003		http://cdn.rechat.co/59002895.jpg	19	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:46", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563455+02
10bf9ca4-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.562374+01	2016-01-11 18:49:36.380676+01	\N	59002896	58982003		http://cdn.rechat.co/59002896.jpg	20	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:46", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563455+02
10bf44e8-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.560189+01	2016-01-11 18:49:36.460132+01	\N	59002894	58982003		http://cdn.rechat.co/59002894.jpg	18	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:45", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563456+02
fda7309a-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.823444+01	2015-12-21 19:56:21.096056+01	\N	58706123	58705917		http://cdn.rechat.co/58706123.jpg	2	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436191, "ModifyDate": "2015:12:18 16:01:52", "Saturation": 0, "FocalLength": 9.5, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.014285714285714285, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 5.83, "ExifImageHeight": 966, "ExposureProgram": 3, "DateTimeOriginal": 1450436191, "MaxApertureValue": 4.5, "SceneCaptureType": 0, "ShutterSpeedValue": 6.129283, "ExposureCompensation": 0, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 14, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.181487+02
fda70318-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.822279+01	2015-12-21 19:56:23.886571+01	\N	58706122	58705917		http://cdn.rechat.co/58706122.jpg	1	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436142, "ModifyDate": "2015:12:18 15:55:32", "Saturation": 0, "FocalLength": 12, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.0125, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 7.08, "ExifImageHeight": 963, "ExposureProgram": 3, "DateTimeOriginal": 1450436142, "MaxApertureValue": 4.66, "SceneCaptureType": 0, "ShutterSpeedValue": 6.321928, "ExposureCompensation": 1, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 18, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.181712+02
9feddfe8-a810-11e5-b28d-f23c91c841bd	2015-12-21 19:28:26.07736+01	2015-12-21 19:56:25.108678+01	\N	58706291	58705917		http://cdn.rechat.co/58706291.jpg	24	{"ISO": 200, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D", "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 3.5 (Windows)", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1324103243, "ModifyDate": "2012:07:03 08:47:27", "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "MeteringMode": 5, "SerialNumber": "2421200103", "WhiteBalance": 0, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "DateTimeOriginal": 1324103243, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": 1, "FocalPlaneXResolution": 3086.9257950530036, "FocalPlaneYResolution": 3091.295116772824, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:05:37.184832+02
9fed8656-a810-11e5-b28d-f23c91c841bd	2015-12-21 19:28:26.075085+01	2015-12-21 19:56:30.234643+01	\N	58706290	58705917		http://cdn.rechat.co/58706290.jpg	23	{"ISO": 200, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D", "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 3.5 (Windows)", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1324103122, "ModifyDate": "2012:07:03 08:47:27", "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "MeteringMode": 5, "SerialNumber": "2421200103", "WhiteBalance": 0, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "DateTimeOriginal": 1324103122, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": 1, "FocalPlaneXResolution": 3086.9257950530036, "FocalPlaneYResolution": 3091.295116772824, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:05:37.200526+02
9fee1634-a810-11e5-b28d-f23c91c841bd	2015-12-21 19:28:26.078926+01	2015-12-21 19:56:24.544321+01	\N	58706292	58705917		http://cdn.rechat.co/58706292.jpg	25	{"ISO": 200, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D", "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 3.5 (Windows)", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1324103510, "ModifyDate": "2012:07:03 08:47:26", "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "MeteringMode": 5, "SerialNumber": "2421200103", "WhiteBalance": 0, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "DateTimeOriginal": 1324103510, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -0.3333333333333333, "FocalPlaneXResolution": 3086.9257950530036, "FocalPlaneYResolution": 3091.295116772824, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:05:37.225747+02
9fee4dca-a810-11e5-b28d-f23c91c841bd	2015-12-21 19:28:26.080431+01	2015-12-21 19:56:20.634013+01	\N	58706293	58705917		http://cdn.rechat.co/58706293.jpg	26	{"ISO": 200, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark II", "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 4.4 (Windows)", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1390778972, "ModifyDate": "2014:01:28 12:48:53", "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "MeteringMode": 5, "SerialNumber": "1020705890", "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "DateTimeOriginal": 1390778972, "MaxApertureValue": 4, "SceneCaptureType": 0, "SubSecTimeOriginal": "40", "SubSecTimeDigitized": "40", "ExposureCompensation": -2.6666666666666665, "FocalPlaneXResolution": 2646.3331048663467, "FocalPlaneYResolution": 2686.847619047619, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:05:37.228921+02
28538f2e-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.63261+01	2016-01-09 00:44:10.551235+01	\N	58872988	58870994		http://cdn.rechat.co/58872988.jpg	0	{"ISO": 200, "Make": "Canon", "Flash": 0, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 8, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451306447, "ModifyDate": "2015:12:28 12:40:47", "SubSecTime": "03", "FocalLength": 11, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.00625, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451306447, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 7.375, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.222525+02
fda94ac4-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.837281+01	2015-12-21 19:56:21.995902+01	\N	58706130	58705917		http://cdn.rechat.co/58706130.jpg	9	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436745, "ModifyDate": "2015:12:19 11:49:58", "Saturation": 0, "FocalLength": 9, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.03333333333333333, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 4.91, "ExifImageHeight": 963, "ExposureProgram": 3, "DateTimeOriginal": 1450436745, "MaxApertureValue": 4.41, "SceneCaptureType": 0, "ShutterSpeedValue": 4.906891, "ExposureCompensation": 0.33, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 14, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.647164+02
fdaa87c2-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.845386+01	2015-12-21 19:56:29.166371+01	\N	58706133	58705917		http://cdn.rechat.co/58706133.jpg	12	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436469, "ModifyDate": "2015:12:19 11:32:47", "Saturation": 0, "FocalLength": 9, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.25, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 2.58, "ExifImageHeight": 964, "ExposureProgram": 3, "DateTimeOriginal": 1450436469, "MaxApertureValue": 4.41, "SceneCaptureType": 0, "ShutterSpeedValue": 2, "ExposureCompensation": 1, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 14, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.71163+02
fda79558-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.826052+01	2015-12-21 19:56:20.899637+01	\N	58706125	58705917		http://cdn.rechat.co/58706125.jpg	4	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436274, "ModifyDate": "2015:12:18 16:11:27", "Saturation": 0, "FocalLength": 9, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.011111111111111112, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 6.25, "ExifImageHeight": 964, "ExposureProgram": 3, "DateTimeOriginal": 1450436274, "MaxApertureValue": 4.41, "SceneCaptureType": 0, "ShutterSpeedValue": 6.491853, "ExposureCompensation": 0, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 14, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.716786+02
fdab37c6-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.84985+01	2015-12-21 19:56:28.247959+01	\N	58706137	58705917		http://cdn.rechat.co/58706137.jpg	16	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436598, "ModifyDate": "2015:12:19 11:40:15", "Saturation": 0, "FocalLength": 9, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.2, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 1.83, "ExifImageHeight": 963, "ExposureProgram": 3, "DateTimeOriginal": 1450436598, "MaxApertureValue": 4.41, "SceneCaptureType": 0, "ShutterSpeedValue": 2.321928, "ExposureCompensation": 0, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 14, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.718524+02
fdab0eea-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.848766+01	2015-12-21 19:56:23.477465+01	\N	58706136	58705917		http://cdn.rechat.co/58706136.jpg	15	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436549, "ModifyDate": "2015:12:19 11:37:15", "Saturation": 0, "FocalLength": 8, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.25, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 2.25, "ExifImageHeight": 963, "ExposureProgram": 3, "DateTimeOriginal": 1450436549, "MaxApertureValue": 4.33, "SceneCaptureType": 0, "ShutterSpeedValue": 2, "ExposureCompensation": 0.67, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 12, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.721551+02
10bf1c3e-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.559142+01	2016-01-11 18:49:36.670248+01	\N	59002893	58982003		http://cdn.rechat.co/59002893.jpg	17	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:45", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563456+02
10bef222-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.558063+01	2016-01-11 18:49:36.779884+01	\N	59002892	58982003		http://cdn.rechat.co/59002892.jpg	16	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:44", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563457+02
10bfee8e-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.564532+01	2016-01-11 18:49:35.847855+01	\N	59002898	58982003		http://cdn.rechat.co/59002898.jpg	22	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:47", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563457+02
fda8dada-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.834365+01	2015-12-21 19:56:20.587631+01	\N	58706128	58705917		http://cdn.rechat.co/58706128.jpg	7	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436653, "ModifyDate": "2015:12:19 11:42:22", "Saturation": 0, "FocalLength": 8, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.2, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 2.91, "ExifImageHeight": 963, "ExposureProgram": 3, "DateTimeOriginal": 1450436653, "MaxApertureValue": 4.33, "SceneCaptureType": 0, "ShutterSpeedValue": 2.321928, "ExposureCompensation": 1, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 12, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.732075+02
fdaad844-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.847413+01	2015-12-21 19:56:25.558358+01	\N	58706135	58705917		http://cdn.rechat.co/58706135.jpg	14	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436505, "ModifyDate": "2015:12:19 11:35:00", "Saturation": 0, "FocalLength": 8, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.25, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 2.16, "ExifImageHeight": 963, "ExposureProgram": 3, "DateTimeOriginal": 1450436505, "MaxApertureValue": 4.33, "SceneCaptureType": 0, "ShutterSpeedValue": 2, "ExposureCompensation": 0.67, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 12, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.733977+02
fda6d88e-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.821166+01	2015-12-21 19:56:21.064076+01	\N	58706121	58705917		http://cdn.rechat.co/58706121.jpg	0	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436045, "ModifyDate": "2015:12:18 15:51:32", "Saturation": 0, "FocalLength": 8, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.008695652173913044, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 6.91, "ExifImageHeight": 960, "ExposureProgram": 3, "DateTimeOriginal": 1450436045, "MaxApertureValue": 4.33, "SceneCaptureType": 0, "ShutterSpeedValue": 6.84549, "ExposureCompensation": 0.33, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 12, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.735603+02
fdaab2ce-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.846447+01	2015-12-21 19:56:26.611458+01	\N	58706134	58705917		http://cdn.rechat.co/58706134.jpg	13	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436911, "ModifyDate": "2015:12:19 13:24:08", "Saturation": 0, "FocalLength": 8, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.25, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 2.5, "ExifImageHeight": 969, "ExposureProgram": 3, "DateTimeOriginal": 1450436911, "MaxApertureValue": 4.33, "SceneCaptureType": 0, "ShutterSpeedValue": 2, "ExposureCompensation": 1, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 12, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.738083+02
fdaa5cf2-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.844235+01	2015-12-21 19:56:21.077688+01	\N	58706132	58705917		http://cdn.rechat.co/58706132.jpg	11	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436837, "ModifyDate": "2015:12:19 11:56:24", "Saturation": 0, "FocalLength": 11.5, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.1, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 4.58, "ExifImageHeight": 963, "ExposureProgram": 3, "DateTimeOriginal": 1450436837, "MaxApertureValue": 4.58, "SceneCaptureType": 0, "ShutterSpeedValue": 3.321928, "ExposureCompensation": 1.33, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 17, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.750975+02
10bfc788-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.563521+01	2016-01-11 18:49:36.196549+01	\N	59002897	58982003		http://cdn.rechat.co/59002897.jpg	21	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:47", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563458+02
10bec446-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.556864+01	2016-01-11 18:49:37.295653+01	\N	59002891	58982003		http://cdn.rechat.co/59002891.jpg	15	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:43", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563458+02
10bc9c66-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.542767+01	2016-01-11 18:49:38.968919+01	\N	59002880	58982003		http://cdn.rechat.co/59002880.jpg	4	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:37", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.544886+02
fda92350-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.836255+01	2015-12-21 19:56:27.12729+01	\N	58706129	58705917		http://cdn.rechat.co/58706129.jpg	8	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436713, "ModifyDate": "2015:12:19 11:46:39", "Saturation": 0, "FocalLength": 8, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.04, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 4.75, "ExifImageHeight": 963, "ExposureProgram": 3, "DateTimeOriginal": 1450436713, "MaxApertureValue": 4.33, "SceneCaptureType": 0, "ShutterSpeedValue": 4.643856, "ExposureCompensation": 0.33, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 12, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.752484+02
fda806a0-a80f-11e5-b2a5-f23c91c841bd	2015-12-21 19:23:53.828703+01	2015-12-21 19:56:22.618015+01	\N	58706126	58705917		http://cdn.rechat.co/58706126.jpg	5	{"ISO": 200, "Make": "FUJIFILM", "Flash": 16, "Model": "FinePix S5Pro", "FNumber": 7.1, "Contrast": 0, "LensInfo": [8, 16, 4.5, 5.6], "Software": "Adobe Photoshop CS6 (Macintosh)", "LensModel": "8.0-16.0 mm f/4.5-5.6", "Sharpness": 0, "CreateDate": 1450436339, "ModifyDate": "2015:12:18 16:14:49", "Saturation": 0, "FocalLength": 8.5, "LightSource": 0, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.005, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.655638, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 1440, "ResolutionUnit": 2, "BrightnessValue": 7.41, "ExifImageHeight": 963, "ExposureProgram": 3, "DateTimeOriginal": 1450436339, "MaxApertureValue": 4.41, "SceneCaptureType": 0, "ShutterSpeedValue": 7.643856, "ExposureCompensation": 0, "SubjectDistanceRange": 0, "FocalPlaneXResolution": 630, "FocalPlaneYResolution": 630, "FocalLengthIn35mmFormat": 13, "FocalPlaneResolutionUnit": 3}	\N	0	2017-04-08 22:05:37.753545+02
9fef0c06-a810-11e5-b28d-f23c91c841bd	2015-12-21 19:28:26.084996+01	2015-12-21 19:56:30.861624+01	\N	58706294	58705917		http://cdn.rechat.co/58706294.jpg	27	{"ISO": 200, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D", "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 4.3 (Windows)", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1375813523, "ModifyDate": "2013:08:07 12:41:49", "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "MeteringMode": 5, "SerialNumber": "620304410", "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "DateTimeOriginal": 1375813523, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -0.3333333333333333, "FocalPlaneXResolution": 3086.9257950530036, "FocalPlaneYResolution": 3091.295116772824, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:05:37.849026+02
c88458e2-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.41352+01	2015-12-23 22:58:08.956215+01	\N	58731482	58731414		http://cdn.rechat.co/58731482.jpg	11	{}	\N	0	2017-04-08 22:05:37.035037+02
c8832990-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.405765+01	2015-12-23 22:58:09.25257+01	\N	58731475	58731414		http://cdn.rechat.co/58731475.jpg	4	{}	\N	0	2017-04-08 22:05:37.035037+02
c8837c92-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.407835+01	2015-12-23 22:58:09.077888+01	\N	58731477	58731414		http://cdn.rechat.co/58731477.jpg	6	{}	\N	0	2017-04-08 22:05:37.035044+02
c883d174-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.409966+01	2015-12-23 22:58:09.104921+01	\N	58731479	58731414		http://cdn.rechat.co/58731479.jpg	8	{}	\N	0	2017-04-08 22:05:37.035044+02
c88531ea-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.419063+01	2015-12-23 22:58:08.777634+01	\N	58731486	58731414		http://cdn.rechat.co/58731486.jpg	15	{}	\N	0	2017-04-08 22:05:37.035045+02
c882ae34-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.402615+01	2015-12-23 22:58:09.32944+01	\N	58731472	58731414		http://cdn.rechat.co/58731472.jpg	1	{}	\N	0	2017-04-08 22:05:37.648019+02
c882db84-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.403755+01	2015-12-23 22:58:09.25858+01	\N	58731473	58731414		http://cdn.rechat.co/58731473.jpg	2	{}	\N	0	2017-04-08 22:05:37.64802+02
c8841fc6-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.412071+01	2015-12-23 22:58:09.488619+01	\N	58731481	58731414		http://cdn.rechat.co/58731481.jpg	10	{}	\N	0	2017-04-08 22:05:37.64802+02
c8858cc6-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.421315+01	2015-12-23 22:58:08.7653+01	\N	58731487	58731414		http://cdn.rechat.co/58731487.jpg	16	{}	\N	0	2017-04-08 22:05:37.648022+02
c883033e-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.404771+01	2015-12-23 22:58:09.163501+01	\N	58731474	58731414		http://cdn.rechat.co/58731474.jpg	3	{}	\N	0	2017-04-08 22:05:37.648049+02
c88707d6-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.430801+01	2015-12-23 22:58:08.620116+01	\N	58731491	58731414		http://cdn.rechat.co/58731491.jpg	20	{}	\N	0	2017-04-08 22:05:37.64805+02
c884a1a8-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.415398+01	2015-12-23 22:58:08.870485+01	\N	58731484	58731414		http://cdn.rechat.co/58731484.jpg	13	{}	\N	0	2017-04-08 22:05:37.64805+02
c883521c-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.40679+01	2015-12-23 22:58:09.173784+01	\N	58731476	58731414		http://cdn.rechat.co/58731476.jpg	5	{}	\N	0	2017-04-08 22:05:37.648069+02
c88285c6-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.401542+01	2015-12-23 22:58:09.286293+01	\N	58731471	58731414		http://cdn.rechat.co/58731471.jpg	0	{}	\N	0	2017-04-08 22:05:37.64807+02
c884d56a-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.416477+01	2015-12-23 22:58:08.798325+01	\N	58731485	58731414		http://cdn.rechat.co/58731485.jpg	14	{}	\N	0	2017-04-08 22:05:37.740986+02
c883a7ee-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.408933+01	2015-12-23 22:58:09.063966+01	\N	58731478	58731414		http://cdn.rechat.co/58731478.jpg	7	{}	\N	0	2017-04-08 22:05:37.741191+02
c883fc58-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.411135+01	2015-12-23 22:58:08.96396+01	\N	58731480	58731414		http://cdn.rechat.co/58731480.jpg	9	{}	\N	0	2017-04-08 22:05:37.741263+02
c885dc8a-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.423433+01	2015-12-23 22:58:08.676813+01	\N	58731489	58731414		http://cdn.rechat.co/58731489.jpg	18	{}	\N	0	2017-04-08 22:05:50.004611+02
c887a196-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.434982+01	2015-12-23 22:58:08.547333+01	\N	58731493	58731414		http://cdn.rechat.co/58731493.jpg	22	{}	\N	0	2017-04-08 22:05:50.004613+02
c8876bae-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.433506+01	2015-12-23 22:58:08.52488+01	\N	58731492	58731414		http://cdn.rechat.co/58731492.jpg	21	{}	\N	0	2017-04-08 22:05:55.646903+02
c8860264-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.424422+01	2015-12-23 22:58:08.606435+01	\N	58731490	58731414		http://cdn.rechat.co/58731490.jpg	19	{}	\N	0	2017-04-08 22:05:55.646918+02
c8847e1c-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.414464+01	2015-12-23 22:58:09.068855+01	\N	58731483	58731414		http://cdn.rechat.co/58731483.jpg	12	{}	\N	0	2017-04-08 22:05:55.646918+02
c885b39a-a991-11e5-8a9f-f23c91c841bd	2015-12-23 17:25:30.422408+01	2015-12-23 22:58:08.722821+01	\N	58731488	58731414		http://cdn.rechat.co/58731488.jpg	17	{}	\N	0	2017-04-08 22:05:55.646919+02
284b8180-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.579988+01	2016-01-04 22:07:35.473555+01	\N	58872953	58870994		http://cdn.rechat.co/58872953.jpg	0	{"ISO": 200, "Make": "Canon", "Flash": 0, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 8, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451306447, "ModifyDate": "2015:12:28 12:40:47", "SubSecTime": "03", "FocalLength": 11, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.00625, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451306447, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 7.375, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.222582+02
761639d8-cf73-11e5-859d-f23c91c841bd	2016-02-09 22:24:11.402266+01	2016-02-09 22:24:52.894405+01	\N	59594042	58804924		http://cdn.rechat.co/59594042.jpg	8	{"ISO": 320, "Make": "Canon", "Flash": 0, "Model": "Canon EOS REBEL T3i", "Artist": "", "FNumber": 3.5, "LensInfo": [18, 55, null, null], "Copyright": "", "ColorSpace": 1, "CreateDate": 1454986844, "ModifyDate": "2016:02:09 03:00:44", "SubSecTime": "62", "FocalLength": 18, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.025, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "SerialNumber": "352077205792", "WhiteBalance": 0, "ApertureValue": 3.625, "CustomRendered": 0, "ExifImageWidth": 5184, "ResolutionUnit": 2, "ExifImageHeight": 3456, "ExposureProgram": 2, "SensitivityType": 2, "DateTimeOriginal": 1454986844, "SceneCaptureType": 0, "YCbCrPositioning": 2, "ShutterSpeedValue": 5.375, "SubSecTimeOriginal": "62", "SubSecTimeDigitized": "62", "ExposureCompensation": 0, "FocalPlaneXResolution": 5728.176795580111, "FocalPlaneYResolution": 5808.403361344538, "FocalPlaneResolutionUnit": 2, "RecommendedExposureIndex": 320}	\N	0	2017-04-08 22:06:11.303637+02
7616bb4c-cf73-11e5-859d-f23c91c841bd	2016-02-09 22:24:11.405625+01	2016-02-09 22:24:52.735211+01	\N	59594044	58804924		http://cdn.rechat.co/59594044.jpg	10	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS REBEL T3i", "Artist": "", "FNumber": 7.1, "LensInfo": [18, 55, null, null], "Copyright": "", "ColorSpace": 1, "CreateDate": 1454986734, "ModifyDate": "2016:02:09 02:58:54", "SubSecTime": "30", "FocalLength": 18, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.005, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "SerialNumber": "352077205792", "WhiteBalance": 0, "ApertureValue": 5.625, "CustomRendered": 0, "ExifImageWidth": 5184, "ResolutionUnit": 2, "ExifImageHeight": 3456, "ExposureProgram": 2, "SensitivityType": 2, "DateTimeOriginal": 1454986734, "SceneCaptureType": 0, "YCbCrPositioning": 2, "ShutterSpeedValue": 7.625, "SubSecTimeOriginal": "30", "SubSecTimeDigitized": "30", "ExposureCompensation": 0, "FocalPlaneXResolution": 5728.176795580111, "FocalPlaneYResolution": 5808.403361344538, "FocalPlaneResolutionUnit": 2, "RecommendedExposureIndex": 400}	\N	0	2017-04-08 22:06:11.303637+02
76169540-cf73-11e5-859d-f23c91c841bd	2016-02-09 22:24:11.404557+01	2016-02-09 22:24:52.658153+01	\N	59594043	58804924		http://cdn.rechat.co/59594043.jpg	9	{"ISO": 160, "Make": "Canon", "Flash": 0, "Model": "Canon EOS REBEL T3i", "Artist": "", "FNumber": 3.5, "LensInfo": [18, 55, null, null], "Copyright": "", "ColorSpace": 1, "CreateDate": 1454986977, "ModifyDate": "2016:02:09 03:02:57", "SubSecTime": "00", "FocalLength": 18, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.025, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "SerialNumber": "352077205792", "WhiteBalance": 0, "ApertureValue": 3.625, "CustomRendered": 0, "ExifImageWidth": 5184, "ResolutionUnit": 2, "ExifImageHeight": 3456, "ExposureProgram": 2, "SensitivityType": 2, "DateTimeOriginal": 1454986977, "SceneCaptureType": 0, "YCbCrPositioning": 2, "ShutterSpeedValue": 5.375, "SubSecTimeOriginal": "00", "SubSecTimeDigitized": "00", "ExposureCompensation": 0, "FocalPlaneXResolution": 5728.176795580111, "FocalPlaneYResolution": 5808.403361344538, "FocalPlaneResolutionUnit": 2, "RecommendedExposureIndex": 160}	\N	0	2017-04-08 22:06:11.305491+02
76003552-cf73-11e5-859d-f23c91c841bd	2016-02-09 22:24:11.257767+01	2016-02-09 22:24:52.940927+01	\N	59594039	58804924		http://cdn.rechat.co/59594039.jpg	5	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS REBEL T3i", "Artist": "", "FNumber": 4, "LensInfo": [18, 55, null, null], "Copyright": "", "ColorSpace": 1, "CreateDate": 1454986618, "ModifyDate": "2016:02:09 02:56:58", "SubSecTime": "69", "FocalLength": 18, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "SerialNumber": "352077205792", "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 5184, "ResolutionUnit": 2, "ExifImageHeight": 3456, "ExposureProgram": 2, "SensitivityType": 2, "DateTimeOriginal": 1454986618, "SceneCaptureType": 0, "YCbCrPositioning": 2, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "69", "SubSecTimeDigitized": "69", "ExposureCompensation": 0, "FocalPlaneXResolution": 5728.176795580111, "FocalPlaneYResolution": 5808.403361344538, "FocalPlaneResolutionUnit": 2, "RecommendedExposureIndex": 400}	\N	0	2017-04-08 22:06:11.305497+02
75ffee8a-cf73-11e5-859d-f23c91c841bd	2016-02-09 22:24:11.256205+01	2016-02-09 22:24:53.046896+01	\N	59594038	58804924		http://cdn.rechat.co/59594038.jpg	4	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS REBEL T3i", "Artist": "", "FNumber": 5.6, "LensInfo": [18, 55, null, null], "Copyright": "", "ColorSpace": 1, "CreateDate": 1454987008, "ModifyDate": "2016:02:09 03:03:28", "SubSecTime": "00", "FocalLength": 18, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.0125, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "SerialNumber": "352077205792", "WhiteBalance": 0, "ApertureValue": 5, "CustomRendered": 0, "ExifImageWidth": 5184, "ResolutionUnit": 2, "ExifImageHeight": 3456, "ExposureProgram": 2, "SensitivityType": 2, "DateTimeOriginal": 1454987008, "SceneCaptureType": 0, "YCbCrPositioning": 2, "ShutterSpeedValue": 6.375, "SubSecTimeOriginal": "00", "SubSecTimeDigitized": "00", "ExposureCompensation": 0, "FocalPlaneXResolution": 5728.176795580111, "FocalPlaneYResolution": 5808.403361344538, "FocalPlaneResolutionUnit": 2, "RecommendedExposureIndex": 400}	\N	0	2017-04-08 22:06:11.305498+02
284fd3f2-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.60824+01	2016-01-04 22:10:46.211721+01	\N	58872973	58870994		http://cdn.rechat.co/58872973.jpg	15	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908112, "ModifyDate": "2016:01:04 11:48:32", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908112, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223064+02
76006766-cf73-11e5-859d-f23c91c841bd	2016-02-09 22:24:11.259233+01	2016-02-09 22:24:53.110667+01	\N	59594040	58804924		http://cdn.rechat.co/59594040.jpg	6	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS REBEL T3i", "Artist": "", "FNumber": 4, "LensInfo": [18, 55, null, null], "Copyright": "", "ColorSpace": 1, "CreateDate": 1454986608, "ModifyDate": "2016:02:09 02:56:48", "SubSecTime": "00", "FocalLength": 18, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "SerialNumber": "352077205792", "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 5184, "ResolutionUnit": 2, "ExifImageHeight": 3456, "ExposureProgram": 2, "SensitivityType": 2, "DateTimeOriginal": 1454986608, "SceneCaptureType": 0, "YCbCrPositioning": 2, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "00", "SubSecTimeDigitized": "00", "ExposureCompensation": 0, "FocalPlaneXResolution": 5728.176795580111, "FocalPlaneYResolution": 5808.403361344538, "FocalPlaneResolutionUnit": 2, "RecommendedExposureIndex": 400}	\N	0	2017-04-08 22:06:11.305513+02
75ffc72a-cf73-11e5-859d-f23c91c841bd	2016-02-09 22:24:11.255211+01	2016-02-09 22:24:53.246057+01	\N	59594037	58804924		http://cdn.rechat.co/59594037.jpg	3	{"ISO": 160, "Make": "Canon", "Flash": 0, "Model": "Canon EOS REBEL T3i", "Artist": "", "FNumber": 3.5, "LensInfo": [18, 55, null, null], "Copyright": "", "ColorSpace": 1, "CreateDate": 1454986538, "ModifyDate": "2016:02:09 02:55:38", "SubSecTime": "29", "FocalLength": 18, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.025, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "SerialNumber": "352077205792", "WhiteBalance": 0, "ApertureValue": 3.625, "CustomRendered": 0, "ExifImageWidth": 5184, "ResolutionUnit": 2, "ExifImageHeight": 3456, "ExposureProgram": 2, "SensitivityType": 2, "DateTimeOriginal": 1454986538, "SceneCaptureType": 0, "YCbCrPositioning": 2, "ShutterSpeedValue": 5.375, "SubSecTimeOriginal": "29", "SubSecTimeDigitized": "29", "ExposureCompensation": 0, "FocalPlaneXResolution": 5728.176795580111, "FocalPlaneYResolution": 5808.403361344538, "FocalPlaneResolutionUnit": 2, "RecommendedExposureIndex": 160}	\N	0	2017-04-08 22:06:11.305513+02
75ffa510-cf73-11e5-859d-f23c91c841bd	2016-02-09 22:24:11.254337+01	2016-02-09 22:24:53.119661+01	\N	59594036	58804924		http://cdn.rechat.co/59594036.jpg	2	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS REBEL T3i", "Artist": "", "FNumber": 4, "LensInfo": [18, 55, null, null], "Copyright": "", "ColorSpace": 1, "CreateDate": 1454986592, "ModifyDate": "2016:02:09 02:56:32", "SubSecTime": "00", "FocalLength": 18, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "SerialNumber": "352077205792", "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 5184, "ResolutionUnit": 2, "ExifImageHeight": 3456, "ExposureProgram": 2, "SensitivityType": 2, "DateTimeOriginal": 1454986592, "SceneCaptureType": 0, "YCbCrPositioning": 2, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "00", "SubSecTimeDigitized": "00", "ExposureCompensation": 0, "FocalPlaneXResolution": 5728.176795580111, "FocalPlaneYResolution": 5808.403361344538, "FocalPlaneResolutionUnit": 2, "RecommendedExposureIndex": 400}	\N	0	2017-04-08 22:06:11.305517+02
75ff4a34-cf73-11e5-859d-f23c91c841bd	2016-02-09 22:24:11.251939+01	2016-02-09 22:24:53.25399+01	\N	59594034	58804924	4123 Wycliff Townhomes	http://cdn.rechat.co/59594034.jpg	0	{"ISO": 100, "Make": "Canon", "Flash": 0, "Model": "Canon EOS REBEL T3i", "Artist": "", "FNumber": 10, "LensInfo": [18, 55, null, null], "Copyright": "", "ColorSpace": 1, "CreateDate": 1454987201, "ModifyDate": "2016:02:09 03:06:41", "SubSecTime": "00", "FocalLength": 23, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.004, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "SerialNumber": "352077205792", "WhiteBalance": 0, "ApertureValue": 6.625, "CustomRendered": 0, "ExifImageWidth": 5184, "ResolutionUnit": 2, "ExifImageHeight": 3456, "ExposureProgram": 2, "SensitivityType": 2, "DateTimeOriginal": 1454987201, "SceneCaptureType": 0, "YCbCrPositioning": 2, "ShutterSpeedValue": 8, "SubSecTimeOriginal": "00", "SubSecTimeDigitized": "00", "ExposureCompensation": 0, "FocalPlaneXResolution": 5728.176795580111, "FocalPlaneYResolution": 5808.403361344538, "FocalPlaneResolutionUnit": 2, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.305518+02
75ff8382-cf73-11e5-859d-f23c91c841bd	2016-02-09 22:24:11.253462+01	2016-02-09 22:24:53.186192+01	\N	59594035	58804924		http://cdn.rechat.co/59594035.jpg	1	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS REBEL T3i", "Artist": "", "FNumber": 8, "LensInfo": [18, 55, null, null], "Copyright": "", "ColorSpace": 1, "CreateDate": 1454987157, "ModifyDate": "2016:02:09 03:05:57", "SubSecTime": "93", "FocalLength": 29, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.005, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "SerialNumber": "352077205792", "WhiteBalance": 0, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 5184, "ResolutionUnit": 2, "ExifImageHeight": 3456, "ExposureProgram": 2, "SensitivityType": 2, "DateTimeOriginal": 1454987157, "SceneCaptureType": 0, "YCbCrPositioning": 2, "ShutterSpeedValue": 7.625, "SubSecTimeOriginal": "93", "SubSecTimeDigitized": "93", "ExposureCompensation": 0, "FocalPlaneXResolution": 5728.176795580111, "FocalPlaneYResolution": 5808.403361344538, "FocalPlaneResolutionUnit": 2, "RecommendedExposureIndex": 400}	\N	0	2017-04-08 22:06:11.305526+02
284f3cb2-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.604432+01	2016-01-04 22:10:46.398537+01	\N	58872970	58870994		http://cdn.rechat.co/58872970.jpg	14	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 5, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908096, "ModifyDate": "2016:01:04 11:48:16", "SubSecTime": "04", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4.625, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908096, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "04", "SubSecTimeDigitized": "04", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223066+02
76008f70-cf73-11e5-859d-f23c91c841bd	2016-02-09 22:24:11.260287+01	2016-02-09 22:24:55.025524+01	\N	59594041	58804924		http://cdn.rechat.co/59594041.jpg	7	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS REBEL T3i", "Artist": "", "FNumber": 4, "LensInfo": [18, 55, null, null], "Copyright": "", "ColorSpace": 1, "CreateDate": 1454986778, "ModifyDate": "2016:02:09 02:59:38", "SubSecTime": "75", "FocalLength": 18, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "SerialNumber": "352077205792", "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 5184, "ResolutionUnit": 2, "ExifImageHeight": 3456, "ExposureProgram": 2, "SensitivityType": 2, "DateTimeOriginal": 1454986778, "SceneCaptureType": 0, "YCbCrPositioning": 2, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "75", "SubSecTimeDigitized": "75", "ExposureCompensation": 0, "FocalPlaneXResolution": 5728.176795580111, "FocalPlaneYResolution": 5808.403361344538, "FocalPlaneResolutionUnit": 2, "RecommendedExposureIndex": 400}	\N	0	2017-04-08 22:06:11.305542+02
284c16e0-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.58383+01	2016-01-04 22:07:34.805646+01	\N	58872957	58870994		http://cdn.rechat.co/58872957.jpg	4	{"ISO": 200, "Make": "Canon", "Flash": 0, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 5.6, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451306289, "ModifyDate": "2015:12:28 12:38:09", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.01, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451306289, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6.625, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.216611+02
284ee5e6-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.602223+01	2016-01-04 22:10:49.148166+01	\N	58872968	58870994		http://cdn.rechat.co/58872968.jpg	11	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908055, "ModifyDate": "2016:01:04 11:47:35", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908055, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.222511+02
284e4d16-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.598317+01	2016-01-04 22:10:47.080466+01	\N	58872965	58870994		http://cdn.rechat.co/58872965.jpg	16	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451907934, "ModifyDate": "2016:01:04 11:45:34", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451907934, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.222515+02
284e8754-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.599772+01	2016-01-04 22:10:46.849262+01	\N	58872966	58870994		http://cdn.rechat.co/58872966.jpg	19	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451907950, "ModifyDate": "2016:01:04 11:45:50", "SubSecTime": "04", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451907950, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "04", "SubSecTimeDigitized": "04", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.222519+02
284eb472-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.60094+01	2016-01-04 22:10:46.659366+01	\N	58872967	58870994		http://cdn.rechat.co/58872967.jpg	22	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451907981, "ModifyDate": "2016:01:04 11:46:21", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451907981, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.222523+02
85e02940-b660-11e5-bdb5-f23c91c841bd	2016-01-09 00:35:38.384244+01	2016-01-09 00:37:14.451932+01	\N	58974996	58870994		http://cdn.rechat.co/58974996.jpg	22	{"ISO": 1603, "Make": "LG Electronics", "Flash": 1, "Model": "VS840 4G", "FNumber": 2.4, "ColorSpace": 1, "CreateDate": 1388328319, "FocalLength": 4.31, "XResolution": 72, "YResolution": 72, "ExposureTime": 0.07692307692307693, "InteropIndex": "R98", "ExifImageWidth": 2560, "ResolutionUnit": 2, "ExifImageHeight": 1920, "DateTimeOriginal": 1388328319, "YCbCrPositioning": 1, "ExposureCompensation": 0}	\N	0	2017-04-08 22:06:03.465828+02
284f0fee-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.603308+01	2016-01-04 22:10:46.595728+01	\N	58872969	58870994		http://cdn.rechat.co/58872969.jpg	13	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 5, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908072, "ModifyDate": "2016:01:04 11:47:52", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4.625, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908072, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223068+02
2850d78e-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.614894+01	2016-01-04 22:10:46.199463+01	\N	58872976	58870994		http://cdn.rechat.co/58872976.jpg	10	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908185, "ModifyDate": "2016:01:04 11:49:45", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908185, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.22307+02
284fa062-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.606923+01	2016-01-04 22:07:43.416387+01	\N	58872972	58870994		http://cdn.rechat.co/58872972.jpg	19	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4.5, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908097, "ModifyDate": "2016:01:04 11:48:17", "SubSecTime": "77", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4.375, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908097, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "77", "SubSecTimeDigitized": "77", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223122+02
284f6a98-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.605553+01	2016-01-04 22:07:43.948003+01	\N	58872971	58870994		http://cdn.rechat.co/58872971.jpg	18	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 5, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908096, "ModifyDate": "2016:01:04 11:48:16", "SubSecTime": "04", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4.625, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908096, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "04", "SubSecTimeDigitized": "04", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223124+02
28509c92-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.613307+01	2016-01-04 22:07:44.514874+01	\N	58872975	58870994		http://cdn.rechat.co/58872975.jpg	22	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908158, "ModifyDate": "2016:01:04 11:49:18", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908158, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223126+02
2850214a-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.610215+01	2016-01-04 22:09:17.185466+01	\N	58872974	58870994		http://cdn.rechat.co/58872974.jpg	18	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 5, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908096, "ModifyDate": "2016:01:04 11:48:16", "SubSecTime": "04", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4.625, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908096, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "04", "SubSecTimeDigitized": "04", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223134+02
85df7ba8-b660-11e5-bdb5-f23c91c841bd	2016-01-09 00:35:38.378379+01	2016-01-09 00:35:49.289484+01	\N	58974993	58870994		http://cdn.rechat.co/58974993.jpg	19	{"ISO": 1678, "Make": "LG Electronics", "Flash": 1, "Model": "VS840 4G", "FNumber": 2.4, "ColorSpace": 1, "CreateDate": 1388328154, "FocalLength": 4.31, "XResolution": 72, "YResolution": 72, "ExposureTime": 0.058823529411764705, "InteropIndex": "R98", "ExifImageWidth": 2560, "ResolutionUnit": 2, "ExifImageHeight": 1920, "DateTimeOriginal": 1388328154, "YCbCrPositioning": 1, "ExposureCompensation": 0}	\N	0	2017-04-08 22:06:03.465852+02
10bc6c0a-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.541516+01	2016-01-11 18:49:39.322332+01	\N	59002879	58982003		http://cdn.rechat.co/59002879.jpg	3	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:36", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.544886+02
28511e74-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.616502+01	2016-01-04 22:07:45.488359+01	\N	58872977	58870994		http://cdn.rechat.co/58872977.jpg	24	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908190, "ModifyDate": "2016:01:04 11:49:50", "SubSecTime": "86", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908190, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "86", "SubSecTimeDigitized": "86", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223166+02
28530d4c-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.629431+01	2016-01-09 00:44:06.510299+01	\N	58872985	58870994		http://cdn.rechat.co/58872985.jpg	1	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908613, "ModifyDate": "2016:01:04 11:56:53", "SubSecTime": "22", "FocalLength": 11, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908613, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "22", "SubSecTimeDigitized": "22", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223168+02
28528296-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.6259+01	2016-01-04 22:10:45.849001+01	\N	58872982	58870994		http://cdn.rechat.co/58872982.jpg	21	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908326, "ModifyDate": "2016:01:04 11:52:06", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908326, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223172+02
284dd1b0-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.595155+01	2016-01-04 22:10:47.545192+01	\N	58872962	58870994		http://cdn.rechat.co/58872962.jpg	12	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451907682, "ModifyDate": "2016:01:04 11:41:22", "SubSecTime": "22", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451907682, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "22", "SubSecTimeDigitized": "22", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223309+02
284e2480-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.597256+01	2016-01-04 22:10:47.367811+01	\N	58872964	58870994		http://cdn.rechat.co/58872964.jpg	17	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451907919, "ModifyDate": "2016:01:04 11:45:19", "SubSecTime": "78", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451907919, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "78", "SubSecTimeDigitized": "78", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223311+02
284df8ca-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.596165+01	2016-01-04 22:10:47.566873+01	\N	58872963	58870994		http://cdn.rechat.co/58872963.jpg	9	{"ISO": 200, "Make": "Canon", "Flash": 0, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 9, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451907695, "ModifyDate": "2016:01:04 11:41:35", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.005, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 6.375, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451907695, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 7.625, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223313+02
284c4656-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.585015+01	2016-02-15 17:47:07.176987+01	\N	58872958	58870994		http://cdn.rechat.co/58872958.jpg	16	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1086, "ResolutionUnit": 2, "ExifImageHeight": 724}	\N	0	2017-04-08 22:06:11.476924+02
284d1bd0-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.590301+01	2016-02-15 17:47:07.217433+01	\N	58872959	58870994		http://cdn.rechat.co/58872959.jpg	15	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1086, "ResolutionUnit": 2, "ExifImageHeight": 724}	\N	0	2017-04-08 22:06:11.476925+02
10bb8e0c-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.53584+01	2016-01-11 18:49:39.663926+01	\N	59002877	58982003		http://cdn.rechat.co/59002877.jpg	1	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:35", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.544887+02
284baafc-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.581067+01	2016-01-09 00:44:03.057259+01	\N	58872954	58870994		http://cdn.rechat.co/58872954.jpg	2	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 5, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908581, "ModifyDate": "2016:01:04 11:56:21", "SubSecTime": "03", "FocalLength": 11, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4.625, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908581, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223317+02
28532fb6-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.630343+01	2016-02-15 17:47:06.873008+01	\N	58872986	58870994		http://cdn.rechat.co/58872986.jpg	21	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908561, "ModifyDate": "2016:01:04 11:56:01", "SubSecTime": "05", "FocalLength": 11, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908561, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "05", "SubSecTimeDigitized": "05", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.22337+02
2851994e-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.619923+01	2016-01-04 22:10:45.97309+01	\N	58872979	58870994		http://cdn.rechat.co/58872979.jpg	20	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908221, "ModifyDate": "2016:01:04 11:50:21", "SubSecTime": "87", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908221, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "87", "SubSecTimeDigitized": "87", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223543+02
28516d8e-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.618727+01	2016-01-04 22:10:46.086682+01	\N	58872978	58870994		http://cdn.rechat.co/58872978.jpg	18	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908206, "ModifyDate": "2016:01:04 11:50:06", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908206, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.223548+02
284bef9e-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.582809+01	2016-02-15 17:47:07.618555+01	\N	58872956	58870994		http://cdn.rechat.co/58872956.jpg	27	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768}	\N	0	2017-04-08 22:06:03.223599+02
85dfd300-b660-11e5-bdb5-f23c91c841bd	2016-01-09 00:35:38.3818+01	2016-01-09 00:35:55.041772+01	\N	58974994	58870994		http://cdn.rechat.co/58974994.jpg	20	{"ISO": 1595, "Make": "LG Electronics", "Flash": 1, "Model": "VS840 4G", "FNumber": 2.4, "ColorSpace": 1, "CreateDate": 1388328345, "FocalLength": 4.31, "XResolution": 72, "YResolution": 72, "ExposureTime": 0.05, "InteropIndex": "R98", "ExifImageWidth": 2560, "ResolutionUnit": 2, "ExifImageHeight": 1920, "DateTimeOriginal": 1388328345, "YCbCrPositioning": 1, "ExposureCompensation": 0}	\N	0	2017-04-08 22:06:03.448724+02
85df070e-b660-11e5-bdb5-f23c91c841bd	2016-01-09 00:35:38.374996+01	2016-01-09 00:35:55.580857+01	\N	58974992	58870994		http://cdn.rechat.co/58974992.jpg	18	{"ISO": 1659, "Make": "LG Electronics", "Flash": 1, "Model": "VS840 4G", "FNumber": 2.4, "ColorSpace": 1, "CreateDate": 1388327806, "FocalLength": 4.31, "XResolution": 72, "YResolution": 72, "ExposureTime": 0.1, "InteropIndex": "R98", "ExifImageWidth": 2560, "ResolutionUnit": 2, "ExifImageHeight": 1920, "DateTimeOriginal": 1388327806, "YCbCrPositioning": 1, "ExposureCompensation": 0}	\N	0	2017-04-08 22:06:03.460886+02
85e000d2-b660-11e5-bdb5-f23c91c841bd	2016-01-09 00:35:38.383193+01	2016-01-09 00:35:55.96643+01	\N	58974995	58870994		http://cdn.rechat.co/58974995.jpg	21	{"ISO": 1115, "Make": "LG Electronics", "Flash": 1, "Model": "VS840 4G", "FNumber": 2.4, "ColorSpace": 1, "CreateDate": 1388328338, "FocalLength": 4.31, "XResolution": 72, "YResolution": 72, "ExposureTime": 0.03333333333333333, "InteropIndex": "R98", "ExifImageWidth": 2560, "ResolutionUnit": 2, "ExifImageHeight": 1920, "DateTimeOriginal": 1388328338, "YCbCrPositioning": 1, "ExposureCompensation": 0}	\N	0	2017-04-08 22:06:03.461163+02
aef9a03a-b661-11e5-a8b9-f23c91c841bd	2016-01-09 00:43:56.834395+01	2016-02-15 17:47:06.692088+01	\N	58975085	58870994		http://cdn.rechat.co/58975085.jpg	7	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768}	\N	0	2017-04-08 22:06:03.461663+02
10bd00c0-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.545337+01	2016-01-11 18:49:38.740813+01	\N	59002882	58982003		http://cdn.rechat.co/59002882.jpg	6	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:38", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563453+02
10bcd9c4-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.544335+01	2016-01-11 18:49:38.918342+01	\N	59002881	58982003		http://cdn.rechat.co/59002881.jpg	5	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:38", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563453+02
aef92722-b661-11e5-a8b9-f23c91c841bd	2016-01-09 00:43:56.831257+01	2016-01-09 00:44:08.437881+01	\N	58975083	58870994		http://cdn.rechat.co/58975083.jpg	4	{"ISO": 200, "Make": "Canon", "Flash": 0, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 7.1, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451306407, "ModifyDate": "2015:12:28 12:40:07", "SubSecTime": "36", "FocalLength": 11, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.01, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5.625, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451306407, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6.625, "SubSecTimeOriginal": "36", "SubSecTimeDigitized": "36", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.465159+02
aefa0f52-b661-11e5-a8b9-f23c91c841bd	2016-01-09 00:43:56.83712+01	2016-01-09 00:44:10.119481+01	\N	58975086	58870994		http://cdn.rechat.co/58975086.jpg	7	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 8, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451306332, "ModifyDate": "2015:12:28 12:38:52", "SubSecTime": "03", "FocalLength": 11, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.005, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451306332, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 7.625, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.46516+02
aefab844-b661-11e5-a8b9-f23c91c841bd	2016-01-09 00:43:56.841445+01	2016-01-09 00:44:10.991903+01	\N	58975087	58870994		http://cdn.rechat.co/58975087.jpg	8	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 9, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451306336, "ModifyDate": "2015:12:28 12:38:56", "SubSecTime": "43", "FocalLength": 11, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.005, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 6.375, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451306336, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 7.625, "SubSecTimeOriginal": "43", "SubSecTimeDigitized": "43", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.46516+02
aefb8a94-b661-11e5-a8b9-f23c91c841bd	2016-01-09 00:43:56.846903+01	2016-01-09 00:44:11.556512+01	\N	58975089	58870994		http://cdn.rechat.co/58975089.jpg	10	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 11, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908231, "ModifyDate": "2016:01:04 11:50:31", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.005, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 7, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908231, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 7.625, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.465171+02
aefc3908-b661-11e5-a8b9-f23c91c841bd	2016-01-09 00:43:56.851447+01	2016-02-15 17:47:06.649355+01	\N	58975091	58870994		http://cdn.rechat.co/58975091.jpg	24	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4.5, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908609, "ModifyDate": "2016:01:04 11:56:49", "SubSecTime": "12", "FocalLength": 11, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4.375, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908609, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "12", "SubSecTimeDigitized": "12", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.465238+02
aefcb086-b661-11e5-a8b9-f23c91c841bd	2016-01-09 00:43:56.854495+01	2016-02-15 17:47:06.468532+01	\N	58975093	58870994		http://cdn.rechat.co/58975093.jpg	26	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768}	\N	0	2017-04-08 22:06:03.465246+02
aefc6ff4-b661-11e5-a8b9-f23c91c841bd	2016-01-09 00:43:56.852871+01	2016-02-15 17:47:06.76269+01	\N	58975092	58870994		http://cdn.rechat.co/58975092.jpg	25	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768}	\N	0	2017-04-08 22:06:03.465247+02
284bcdca-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.581966+01	2016-01-09 00:44:03.095918+01	\N	58872955	58870994		http://cdn.rechat.co/58872955.jpg	3	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451305812, "ModifyDate": "2015:12:28 12:30:12", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451305812, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.465247+02
aef9594a-b661-11e5-a8b9-f23c91c841bd	2016-01-09 00:43:56.832574+01	2016-02-15 17:47:06.659773+01	\N	58975084	58870994		http://cdn.rechat.co/58975084.jpg	6	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1086, "ResolutionUnit": 2, "ExifImageHeight": 724}	\N	0	2017-04-08 22:06:03.465286+02
aefb5c72-b661-11e5-a8b9-f23c91c841bd	2016-01-09 00:43:56.845654+01	2016-01-09 00:44:04.800049+01	\N	58975088	58870994		http://cdn.rechat.co/58975088.jpg	9	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451306239, "ModifyDate": "2015:12:28 12:37:19", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451306239, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.465867+02
85de7212-b660-11e5-bdb5-f23c91c841bd	2016-01-09 00:35:38.371334+01	2016-01-09 00:35:53.096714+01	\N	58974991	58870994		http://cdn.rechat.co/58974991.jpg	17	{"ISO": 1659, "Make": "LG Electronics", "Flash": 1, "Model": "VS840 4G", "FNumber": 2.4, "ColorSpace": 1, "CreateDate": 1388327777, "FocalLength": 4.31, "XResolution": 72, "YResolution": 72, "ExposureTime": 0.1, "InteropIndex": "R98", "ExifImageWidth": 2560, "ResolutionUnit": 2, "ExifImageHeight": 1920, "DateTimeOriginal": 1388327777, "YCbCrPositioning": 1, "ExposureCompensation": 0}	\N	0	2017-04-08 22:06:03.465872+02
85ddc542-b660-11e5-bdb5-f23c91c841bd	2016-01-09 00:35:38.366557+01	2016-01-09 00:35:53.883246+01	\N	58974990	58870994		http://cdn.rechat.co/58974990.jpg	16	{"ISO": 654, "Make": "LG Electronics", "Flash": 1, "Model": "VS840 4G", "FNumber": 2.4, "ColorSpace": 1, "CreateDate": 1388327732, "FocalLength": 4.31, "XResolution": 72, "YResolution": 72, "ExposureTime": 0.03333333333333333, "InteropIndex": "R98", "ExifImageWidth": 2560, "ResolutionUnit": 2, "ExifImageHeight": 1920, "DateTimeOriginal": 1388327732, "YCbCrPositioning": 1, "ExposureCompensation": 0}	\N	0	2017-04-08 22:06:03.465879+02
e328b44a-d402-11e5-a454-f23c91c841bd	2016-02-15 17:40:57.078521+01	2016-02-15 17:42:06.863556+01	\N	59704842	58870994		http://cdn.rechat.co/59704842.jpg	5	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1086, "ResolutionUnit": 2, "ExifImageHeight": 724}	\N	0	2017-04-08 22:06:11.471584+02
e32a6bf0-d402-11e5-a454-f23c91c841bd	2016-02-15 17:40:57.089781+01	2016-02-15 17:47:03.828248+01	\N	59704854	58870994		http://cdn.rechat.co/59704854.jpg	9	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1086, "ResolutionUnit": 2, "ExifImageHeight": 724}	\N	0	2017-04-08 22:06:11.472197+02
e329e932-d402-11e5-a454-f23c91c841bd	2016-02-15 17:40:57.086427+01	2016-02-15 17:47:04.22658+01	\N	59704850	58870994		http://cdn.rechat.co/59704850.jpg	8	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768}	\N	0	2017-04-08 22:06:11.472197+02
e328e078-d402-11e5-a454-f23c91c841bd	2016-02-15 17:40:57.079655+01	2016-02-15 17:42:11.318769+01	\N	59704843	58870994		http://cdn.rechat.co/59704843.jpg	4	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1086, "ResolutionUnit": 2, "ExifImageHeight": 724}	\N	0	2017-04-08 22:06:11.47221+02
e3294374-d402-11e5-a454-f23c91c841bd	2016-02-15 17:40:57.08217+01	2016-02-15 17:47:04.36162+01	\N	59704846	58870994		http://cdn.rechat.co/59704846.jpg	28	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1024, "ResolutionUnit": 2, "ExifImageHeight": 768}	\N	0	2017-04-08 22:06:11.47265+02
e3292236-d402-11e5-a454-f23c91c841bd	2016-02-15 17:40:57.08133+01	2016-02-15 17:42:12.391495+01	\N	59704845	58870994		http://cdn.rechat.co/59704845.jpg	32	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1086, "ResolutionUnit": 2, "ExifImageHeight": 724}	\N	0	2017-04-08 22:06:11.472664+02
e32a0ae8-d402-11e5-a454-f23c91c841bd	2016-02-15 17:40:57.087281+01	2016-02-15 17:42:13.468362+01	\N	59704851	58870994		http://cdn.rechat.co/59704851.jpg	10	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1086, "ResolutionUnit": 2, "ExifImageHeight": 724}	\N	0	2017-04-08 22:06:11.472695+02
e329a7b0-d402-11e5-a454-f23c91c841bd	2016-02-15 17:40:57.084739+01	2016-02-15 17:42:14.42012+01	\N	59704849	58870994		http://cdn.rechat.co/59704849.jpg	6	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1086, "ResolutionUnit": 2, "ExifImageHeight": 724}	\N	0	2017-04-08 22:06:11.472718+02
e328ffcc-d402-11e5-a454-f23c91c841bd	2016-02-15 17:40:57.080466+01	2016-02-15 17:47:04.321421+01	\N	59704844	58870994		http://cdn.rechat.co/59704844.jpg	10	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1086, "ResolutionUnit": 2, "ExifImageHeight": 724}	\N	0	2017-04-08 22:06:11.472719+02
e32aab7e-d402-11e5-a454-f23c91c841bd	2016-02-15 17:40:57.091417+01	2016-02-15 17:47:03.659381+01	\N	59704856	58870994		http://cdn.rechat.co/59704856.jpg	13	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1086, "ResolutionUnit": 2, "ExifImageHeight": 724}	\N	0	2017-04-08 22:06:11.472738+02
e32a4c6a-d402-11e5-a454-f23c91c841bd	2016-02-15 17:40:57.088966+01	2016-02-15 17:47:03.815961+01	\N	59704853	58870994		http://cdn.rechat.co/59704853.jpg	14	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1086, "ResolutionUnit": 2, "ExifImageHeight": 724}	\N	0	2017-04-08 22:06:11.475468+02
e32a8aae-d402-11e5-a454-f23c91c841bd	2016-02-15 17:40:57.090574+01	2016-02-15 17:47:03.781063+01	\N	59704855	58870994		http://cdn.rechat.co/59704855.jpg	11	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1086, "ResolutionUnit": 2, "ExifImageHeight": 724}	\N	0	2017-04-08 22:06:11.476228+02
e32a2a8c-d402-11e5-a454-f23c91c841bd	2016-02-15 17:40:57.088087+01	2016-02-15 17:47:04.123765+01	\N	59704852	58870994		http://cdn.rechat.co/59704852.jpg	12	{"Orientation": 1, "XResolution": 72, "YResolution": 72, "OffsetSchema": 0, "ExifImageWidth": 1086, "ResolutionUnit": 2, "ExifImageHeight": 724}	\N	0	2017-04-08 22:06:11.476257+02
284da15e-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.593853+01	2016-02-15 17:47:06.905195+01	\N	58872961	58870994		http://cdn.rechat.co/58872961.jpg	18	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 8, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451306302, "ModifyDate": "2015:12:28 12:38:22", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.005, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451306302, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 7.625, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.476867+02
284d6108-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.5922+01	2016-02-15 17:47:07.02916+01	\N	58872960	58870994		http://cdn.rechat.co/58872960.jpg	17	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 5.6, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451306317, "ModifyDate": "2015:12:28 12:38:37", "SubSecTime": "03", "FocalLength": 11, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.005, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 5, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451306317, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 7.625, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.476926+02
2852ac3a-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.626974+01	2016-02-15 17:47:06.907965+01	\N	58872983	58870994		http://cdn.rechat.co/58872983.jpg	19	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 8, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451306332, "ModifyDate": "2015:12:28 12:38:52", "SubSecTime": "03", "FocalLength": 11, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.005, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451306332, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 7.625, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.477209+02
2852582a-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.624754+01	2016-02-15 17:42:04.582683+01	\N	58872981	58870994		http://cdn.rechat.co/58872981.jpg	31	{"ISO": 200, "Make": "Canon", "Flash": 0, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 10, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908237, "ModifyDate": "2016:01:04 11:50:37", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.004, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 6.625, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908237, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 8, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.47721+02
2851f236-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.622191+01	2016-02-15 17:42:04.763241+01	\N	58872980	58870994		http://cdn.rechat.co/58872980.jpg	30	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 11, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908231, "ModifyDate": "2016:01:04 11:50:31", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.005, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 7, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908231, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 7.625, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.47721+02
28535234-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.631224+01	2016-02-15 17:47:06.726019+01	\N	58872987	58870994		http://cdn.rechat.co/58872987.jpg	22	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908566, "ModifyDate": "2016:01:04 11:56:06", "SubSecTime": "88", "FocalLength": 11, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908566, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "88", "SubSecTimeDigitized": "88", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.477211+02
2852e704-b327-11e5-8db9-f23c91c841bd	2016-01-04 22:07:26.628457+01	2016-02-15 17:47:06.806108+01	\N	58872984	58870994		http://cdn.rechat.co/58872984.jpg	20	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 9, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451306336, "ModifyDate": "2015:12:28 12:38:56", "SubSecTime": "43", "FocalLength": 11, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.005, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 6.375, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451306336, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 7.625, "SubSecTimeOriginal": "43", "SubSecTimeDigitized": "43", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.477211+02
10be011e-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.551894+01	2016-01-11 18:49:38.804989+01	\N	59002888	58982003		http://cdn.rechat.co/59002888.jpg	12	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:41", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563454+02
10bd5e6c-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.547735+01	2016-01-11 18:49:38.694661+01	\N	59002884	58982003		http://cdn.rechat.co/59002884.jpg	8	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:39", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563454+02
10be4336-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.553567+01	2016-01-11 18:49:38.118934+01	\N	59002889	58982003		http://cdn.rechat.co/59002889.jpg	13	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:42", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563455+02
e3297dc6-d402-11e5-a454-f23c91c841bd	2016-02-15 17:40:57.083691+01	2016-02-15 17:47:04.293333+01	\N	59704848	58870994		http://cdn.rechat.co/59704848.jpg	30	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 11, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908231, "ModifyDate": "2016:01:04 11:50:31", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.005, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 7, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908231, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 7.625, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.478175+02
e329614c-d402-11e5-a454-f23c91c841bd	2016-02-15 17:40:57.08296+01	2016-02-15 17:47:04.189556+01	\N	59704847	58870994		http://cdn.rechat.co/59704847.jpg	29	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451306239, "ModifyDate": "2015:12:28 12:37:19", "SubSecTime": "03", "FocalLength": 10, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451306239, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "03", "SubSecTimeDigitized": "03", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.478182+02
aefbfeca-b661-11e5-a8b9-f23c91c841bd	2016-01-09 00:43:56.849847+01	2016-02-15 17:47:06.620608+01	\N	58975090	58870994		http://cdn.rechat.co/58975090.jpg	23	{"ISO": 400, "Make": "Canon", "Flash": 9, "Model": "Canon EOS DIGITAL REBEL XSi", "FNumber": 4, "Software": "Photos 1.3", "ColorSpace": 1, "CreateDate": 1451908595, "ModifyDate": "2016:01:04 11:56:35", "SubSecTime": "04", "FocalLength": 11, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 4, "CustomRendered": 0, "ExifImageWidth": 1280, "ResolutionUnit": 2, "ExifImageHeight": 852, "ExposureProgram": 2, "DateTimeOriginal": 1451908595, "MaxApertureValue": 3.5635948210205637, "SceneCaptureType": 0, "ShutterSpeedValue": 6, "SubSecTimeOriginal": "04", "SubSecTimeDigitized": "04", "ExposureCompensation": 0, "FocalPlaneXResolution": 3517.0843373493976, "FocalPlaneYResolution": 3520.5479452054797, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.478298+02
9652afa2-b3e8-11e5-9b53-f23c91c841bd	2016-01-05 21:12:04.045222+01	2016-01-06 18:29:45.172581+01	\N	58900851	58900413		http://cdn.rechat.co/58900851.jpg	0	{"ISO": 80, "Make": "Canon", "Flash": 24, "Model": "Canon PowerShot SD790 IS", "FNumber": 2.8, "ColorSpace": 1, "CreateDate": 1450279036, "ModifyDate": "2015:12:16 15:17:16", "FocalLength": 6.2, "Orientation": 1, "XResolution": 180, "YResolution": 180, "ExposureMode": 0, "ExposureTime": 0.002, "InteropIndex": "R98", "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ApertureValue": 2.96875, "SensingMethod": 2, "CustomRendered": 0, "ExifImageWidth": 3648, "ResolutionUnit": 2, "ExifImageHeight": 2736, "DateTimeOriginal": 1450279036, "DigitalZoomRatio": 1, "MaxApertureValue": 2.96875, "SceneCaptureType": 0, "YCbCrPositioning": 1, "RelatedImageWidth": 3648, "ShutterSpeedValue": 8.96875, "RelatedImageHeight": 2736, "ExposureCompensation": 0, "FocalPlaneXResolution": 15136.929460580914, "FocalPlaneYResolution": 15116.022099447513, "CompressedBitsPerPixel": 2, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.311029+02
87fc7918-b48a-11e5-823f-f23c91c841bd	2016-01-06 16:31:18.462209+01	2016-01-06 16:31:24.910757+01	\N	58913885	58913859		http://cdn.rechat.co/58913885.jpg	0	{}	\N	0	2017-04-08 22:05:48.072578+02
87fcaa5a-b48a-11e5-823f-f23c91c841bd	2016-01-06 16:31:18.463591+01	2016-01-06 16:31:24.41283+01	\N	58913886	58913859		http://cdn.rechat.co/58913886.jpg	1	{}	\N	0	2017-04-08 22:05:48.072593+02
c3444152-bac7-11e5-b835-f23c91c841bd	2016-01-14 15:04:44.195369+01	2016-01-14 15:05:06.401925+01	\N	59063253	58913859		http://cdn.rechat.co/59063253.jpg	8	{}	\N	0	2017-04-08 22:06:04.966467+02
c344061a-bac7-11e5-b835-f23c91c841bd	2016-01-14 15:04:44.193729+01	2016-01-14 15:05:06.463289+01	\N	59063252	58913859		http://cdn.rechat.co/59063252.jpg	7	{}	\N	0	2017-04-08 22:06:04.966468+02
c34372ea-bac7-11e5-b835-f23c91c841bd	2016-01-14 15:04:44.190196+01	2016-01-14 15:05:06.478502+01	\N	59063251	58913859		http://cdn.rechat.co/59063251.jpg	6	{}	\N	0	2017-04-08 22:06:04.966469+02
c3431426-bac7-11e5-b835-f23c91c841bd	2016-01-14 15:04:44.187788+01	2016-01-14 15:05:06.572283+01	\N	59063249	58913859		http://cdn.rechat.co/59063249.jpg	4	{}	\N	0	2017-04-08 22:06:04.96647+02
c342ed98-bac7-11e5-b835-f23c91c841bd	2016-01-14 15:04:44.186787+01	2016-01-14 15:05:06.59228+01	\N	59063248	58913859		http://cdn.rechat.co/59063248.jpg	3	{}	\N	0	2017-04-08 22:06:04.96647+02
c3433cee-bac7-11e5-b835-f23c91c841bd	2016-01-14 15:04:44.188833+01	2016-01-14 15:05:06.652167+01	\N	59063250	58913859		http://cdn.rechat.co/59063250.jpg	5	{}	\N	0	2017-04-08 22:06:04.966471+02
c342c214-bac7-11e5-b835-f23c91c841bd	2016-01-14 15:04:44.185689+01	2016-01-14 15:05:06.660981+01	\N	59063247	58913859		http://cdn.rechat.co/59063247.jpg	2	{}	\N	0	2017-04-08 22:06:04.966471+02
87fcd43a-b48a-11e5-823f-f23c91c841bd	2016-01-06 16:31:18.464646+01	2016-01-14 15:05:10.5395+01	\N	58913887	58913859		http://cdn.rechat.co/58913887.jpg	1	{}	\N	0	2017-04-08 22:06:04.966904+02
10be982c-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.555731+01	2016-01-11 18:49:37.684559+01	\N	59002890	58982003		http://cdn.rechat.co/59002890.jpg	14	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:43", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563443+02
10bc3258-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.539967+01	2016-01-11 18:49:39.378796+01	\N	59002878	58982003		http://cdn.rechat.co/59002878.jpg	2	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:36", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563444+02
10bd2eba-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.546515+01	2016-01-11 18:49:41.166447+01	\N	59002883	58982003		http://cdn.rechat.co/59002883.jpg	7	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:39", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563451+02
10bd8608-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.548751+01	2016-01-11 18:49:38.664542+01	\N	59002885	58982003		http://cdn.rechat.co/59002885.jpg	9	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:40", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563451+02
10bdb61e-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.549966+01	2016-01-11 18:49:38.605446+01	\N	59002886	58982003		http://cdn.rechat.co/59002886.jpg	10	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:40", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563452+02
10bdda86-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.5509+01	2016-01-11 18:49:38.558887+01	\N	59002887	58982003		http://cdn.rechat.co/59002887.jpg	11	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:41", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.563452+02
10bb2bb0-b88b-11e5-ae33-f23c91c841bd	2016-01-11 18:45:12.533325+01	2016-01-11 18:49:40.377055+01	\N	59002876	58982003		http://cdn.rechat.co/59002876.jpg	0	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "CreateDate": 1452270301, "ModifyDate": "2016:01:08 16:46:35", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.544887+02
00a83974-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.062352+01	2016-01-11 18:55:07.558719+01	\N	59003094	58982074		http://cdn.rechat.co/59003094.jpg	2	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:36", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.564087+02
00a814d0-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.061412+01	2016-01-11 18:55:07.606811+01	\N	59003093	58982074		http://cdn.rechat.co/59003093.jpg	1	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:35", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.564088+02
00ab21d4-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.081405+01	2016-01-11 18:55:06.175566+01	\N	59003103	58982074		http://cdn.rechat.co/59003103.jpg	11	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:41", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.564214+02
00ad1c28-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.094306+01	2016-01-11 18:55:04.996164+01	\N	59003111	58982074		http://cdn.rechat.co/59003111.jpg	19	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:46", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.565085+02
00ad632c-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.096102+01	2016-01-11 18:55:04.971052+01	\N	59003112	58982074		http://cdn.rechat.co/59003112.jpg	20	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:46", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.565111+02
00ace51e-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.092855+01	2016-01-11 18:55:05.175103+01	\N	59003110	58982074		http://cdn.rechat.co/59003110.jpg	18	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:45", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.565134+02
00acb198-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.091581+01	2016-01-11 18:55:05.408535+01	\N	59003109	58982074		http://cdn.rechat.co/59003109.jpg	17	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:45", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.566373+02
00ac4e7e-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.089001+01	2016-01-11 18:55:05.455904+01	\N	59003107	58982074		http://cdn.rechat.co/59003107.jpg	15	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:43", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.566374+02
00ac7fa2-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.090308+01	2016-01-11 18:55:05.586566+01	\N	59003108	58982074		http://cdn.rechat.co/59003108.jpg	16	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:44", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.566374+02
00ac13d2-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.087501+01	2016-01-11 18:55:05.733476+01	\N	59003106	58982074		http://cdn.rechat.co/59003106.jpg	14	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:43", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.566375+02
00abd4c6-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.085939+01	2016-01-11 18:55:05.872697+01	\N	59003105	58982074		http://cdn.rechat.co/59003105.jpg	13	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:42", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.566375+02
00ab95d8-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.084333+01	2016-01-11 18:55:06.089662+01	\N	59003104	58982074		http://cdn.rechat.co/59003104.jpg	12	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:41", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.566791+02
00aa542a-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.076139+01	2016-01-11 18:55:06.196516+01	\N	59003102	58982074		http://cdn.rechat.co/59003102.jpg	10	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:40", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.566792+02
00aa29a0-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.075041+01	2016-01-11 18:55:06.285259+01	\N	59003101	58982074		http://cdn.rechat.co/59003101.jpg	9	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:40", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.566799+02
00a9ecc4-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.073494+01	2016-01-11 18:55:06.553773+01	\N	59003100	58982074		http://cdn.rechat.co/59003100.jpg	8	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:39", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.5668+02
00a9c028-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.072279+01	2016-01-11 18:55:06.847716+01	\N	59003099	58982074		http://cdn.rechat.co/59003099.jpg	7	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:39", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.5668+02
00a919c0-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.067766+01	2016-01-11 18:55:07.012636+01	\N	59003098	58982074		http://cdn.rechat.co/59003098.jpg	6	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:38", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.566801+02
00a88514-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.064266+01	2016-01-11 18:55:07.6017+01	\N	59003096	58982074		http://cdn.rechat.co/59003096.jpg	4	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:37", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.566801+02
00a8bd7c-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.065728+01	2016-01-11 18:55:07.081739+01	\N	59003097	58982074		http://cdn.rechat.co/59003097.jpg	5	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:38", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.566861+02
00a85fd0-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.063328+01	2016-01-11 18:55:07.458907+01	\N	59003095	58982074		http://cdn.rechat.co/59003095.jpg	3	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:36", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.566883+02
00a7e686-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.060223+01	2016-01-11 18:55:07.79991+01	\N	59003092	58982074		http://cdn.rechat.co/59003092.jpg	0	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "CreateDate": 1452270301, "ModifyDate": "2016:01:08 16:46:35", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.566884+02
00adcf88-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.098904+01	2016-01-11 18:55:09.398385+01	\N	59003114	58982074		http://cdn.rechat.co/59003114.jpg	22	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:47", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.545272+02
00ad9888-b88c-11e5-90fb-f23c91c841bd	2016-01-11 18:51:55.097471+01	2016-01-11 18:55:12.621823+01	\N	59003113	58982074		http://cdn.rechat.co/59003113.jpg	21	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:47", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.545309+02
fdaaf724-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.543873+01	2016-01-11 19:02:20.516249+01	\N	59003395	58982325		http://cdn.rechat.co/59003395.jpg	4	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:37", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.567133+02
fdace52a-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.556498+01	2016-01-11 19:02:23.641947+01	\N	59003403	58982325		http://cdn.rechat.co/59003403.jpg	12	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:41", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.567133+02
fdac552e-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.552698+01	2016-01-11 19:02:21.978355+01	\N	59003400	58982325		http://cdn.rechat.co/59003400.jpg	9	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:40", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.567169+02
fdac91e2-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.554345+01	2016-01-11 19:02:23.082216+01	\N	59003401	58982325		http://cdn.rechat.co/59003401.jpg	10	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:40", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.567169+02
fdab95b2-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.547936+01	2016-01-11 19:02:17.470974+01	\N	59003399	58982325		http://cdn.rechat.co/59003399.jpg	8	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:39", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.56856+02
fdae6440-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.566281+01	2016-01-11 19:02:19.891602+01	\N	59003410	58982325		http://cdn.rechat.co/59003410.jpg	19	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:46", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.56856+02
fdab49d6-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.545976+01	2016-01-11 19:02:17.821447+01	\N	59003397	58982325		http://cdn.rechat.co/59003397.jpg	6	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:38", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.568645+02
fdae0a54-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.563992+01	2016-01-11 19:02:24.138416+01	\N	59003408	58982325		http://cdn.rechat.co/59003408.jpg	17	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:45", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:35.568774+02
fdaea342-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.567881+01	2016-01-11 19:02:25.786056+01	\N	59003411	58982325		http://cdn.rechat.co/59003411.jpg	20	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:46", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.542412+02
fdadba04-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.561785+01	2016-01-11 19:02:26.205615+01	\N	59003406	58982325		http://cdn.rechat.co/59003406.jpg	15	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:43", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.542413+02
fdade448-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.563005+01	2016-01-11 19:02:18.910388+01	\N	59003407	58982325		http://cdn.rechat.co/59003407.jpg	16	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:44", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.545082+02
fdab215e-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.544936+01	2016-01-11 19:02:21.394272+01	\N	59003396	58982325		http://cdn.rechat.co/59003396.jpg	5	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:38", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.545082+02
fdad799a-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.56024+01	2016-01-11 19:02:24.625049+01	\N	59003405	58982325		http://cdn.rechat.co/59003405.jpg	14	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:43", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.545347+02
fdae3574-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.56507+01	2016-01-11 19:02:16.893412+01	\N	59003409	58982325		http://cdn.rechat.co/59003409.jpg	18	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:45", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.545373+02
fdaefb1c-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.570138+01	2016-01-11 19:02:27.247797+01	\N	59003413	58982325		http://cdn.rechat.co/59003413.jpg	22	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:47", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.545467+02
fdaa2916-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.538389+01	2016-01-11 19:02:17.550617+01	\N	59003391	58982325		http://cdn.rechat.co/59003391.jpg	0	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "CreateDate": 1452270301, "ModifyDate": "2016:01:08 16:46:35", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.545467+02
fdab71a4-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.547008+01	2016-01-11 19:02:19.494831+01	\N	59003398	58982325		http://cdn.rechat.co/59003398.jpg	7	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:39", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.545468+02
fdacc022-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.555559+01	2016-01-11 19:02:21.175118+01	\N	59003402	58982325		http://cdn.rechat.co/59003402.jpg	11	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:41", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.545468+02
fdaad35c-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.54294+01	2016-01-11 19:02:17.040477+01	\N	59003394	58982325		http://cdn.rechat.co/59003394.jpg	3	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:36", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.545469+02
fdaed0ba-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.569033+01	2016-01-11 19:02:26.700253+01	\N	59003412	58982325		http://cdn.rechat.co/59003412.jpg	21	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:47", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.545469+02
fdad1d74-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.557837+01	2016-01-11 19:02:22.734035+01	\N	59003404	58982325		http://cdn.rechat.co/59003404.jpg	13	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:42", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.54547+02
fdaa832a-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.540902+01	2016-01-11 19:02:17.217258+01	\N	59003393	58982325		http://cdn.rechat.co/59003393.jpg	2	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:36", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.54547+02
fdaa5c88-b88c-11e5-ad0e-f23c91c841bd	2016-01-11 18:58:59.539891+01	2016-01-11 19:02:17.281385+01	\N	59003392	58982325		http://cdn.rechat.co/59003392.jpg	1	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "ModifyDate": "2016:01:08 16:46:35", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.545471+02
ac8dc468-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.573674+01	2016-01-13 21:31:10.995872+01	\N	59052176	59052080		http://cdn.rechat.co/59052176.jpg	21	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:31:08", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:47.942212+02
ac8e46b8-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.576967+01	2016-01-13 21:31:11.010206+01	\N	59052178	59052080		http://cdn.rechat.co/59052178.jpg	23	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:31:10", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:47.942213+02
ac8d6dd8-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.571442+01	2016-01-13 21:31:11.165044+01	\N	59052174	59052080		http://cdn.rechat.co/59052174.jpg	19	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:31:07", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:47.942259+02
ac8d4506-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.570427+01	2016-01-13 21:31:11.170764+01	\N	59052173	59052080		http://cdn.rechat.co/59052173.jpg	18	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:31:06", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:47.942275+02
ac8d1d7e-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.56943+01	2016-01-13 21:31:11.283487+01	\N	59052172	59052080		http://cdn.rechat.co/59052172.jpg	17	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:31:05", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:47.942276+02
ac8cd7ec-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.567629+01	2016-01-13 21:31:11.433412+01	\N	59052170	59052080		http://cdn.rechat.co/59052170.jpg	15	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:31:04", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:47.944593+02
ac8cfad8-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.568531+01	2016-01-13 21:31:11.439457+01	\N	59052171	59052080		http://cdn.rechat.co/59052171.jpg	16	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:31:05", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:47.945205+02
ac8b71fe-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.558458+01	2016-01-13 21:31:13.838215+01	\N	59052160	59052080		http://cdn.rechat.co/59052160.jpg	5	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:30:57", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:47.945888+02
ac8a82c6-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.552342+01	2016-01-13 21:31:14.567254+01	\N	59052155	59052080		http://cdn.rechat.co/59052155.jpg	0	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:30:53", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:05:47.946175+02
ac8cb4f6-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.566751+01	2016-01-13 21:31:11.653268+01	\N	59052169	59052080		http://cdn.rechat.co/59052169.jpg	14	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:31:03", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.177382+02
ac8ae55e-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.554825+01	2016-01-13 21:31:14.017027+01	\N	59052157	59052080		http://cdn.rechat.co/59052157.jpg	2	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:30:54", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.177399+02
ac8b4ddc-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.557459+01	2016-01-13 21:31:14.109361+01	\N	59052159	59052080		http://cdn.rechat.co/59052159.jpg	4	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:30:56", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.177399+02
ac8b0bd8-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.555818+01	2016-01-13 21:31:13.999969+01	\N	59052158	59052080		http://cdn.rechat.co/59052158.jpg	3	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:30:55", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.187639+02
ac8de92a-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.574619+01	2016-01-13 21:31:10.892015+01	\N	59052177	59052080		http://cdn.rechat.co/59052177.jpg	22	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:31:09", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.191025+02
ac8d9e70-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.572646+01	2016-01-13 21:31:10.994212+01	\N	59052175	59052080		http://cdn.rechat.co/59052175.jpg	20	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:31:08", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.191026+02
ac8c65f0-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.564707+01	2016-01-13 21:31:12.334666+01	\N	59052167	59052080		http://cdn.rechat.co/59052167.jpg	12	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:31:02", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.191032+02
ac8c45a2-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.563884+01	2016-01-13 21:31:13.098493+01	\N	59052166	59052080		http://cdn.rechat.co/59052166.jpg	11	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:31:01", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.191032+02
ac8c207c-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.562941+01	2016-01-13 21:31:13.488655+01	\N	59052165	59052080		http://cdn.rechat.co/59052165.jpg	10	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:31:00", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.19104+02
ac8bdb4e-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.561167+01	2016-01-13 21:31:13.493046+01	\N	59052163	59052080		http://cdn.rechat.co/59052163.jpg	8	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:30:59", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.191041+02
ac8bfc0a-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.562005+01	2016-01-13 21:31:13.513386+01	\N	59052164	59052080		http://cdn.rechat.co/59052164.jpg	9	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:31:00", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.191041+02
ac8bb9ac-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.560303+01	2016-01-13 21:31:13.549017+01	\N	59052162	59052080		http://cdn.rechat.co/59052162.jpg	7	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:30:58", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.191042+02
ac8b9742-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.55941+01	2016-01-13 21:31:13.896169+01	\N	59052161	59052080		http://cdn.rechat.co/59052161.jpg	6	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:30:57", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.191051+02
ac8c84b8-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.565514+01	2016-01-13 21:31:14.24819+01	\N	59052168	59052080		http://cdn.rechat.co/59052168.jpg	13	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:31:03", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.191064+02
ac8abdd6-ba33-11e5-adc3-f23c91c841bd	2016-01-13 21:24:40.553864+01	2016-01-13 21:31:14.493234+01	\N	59052156	59052080		http://cdn.rechat.co/59052156.jpg	1	{"Software": "Adobe Photoshop Lightroom 6.3 (Macintosh)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:13 12:30:54", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.191067+02
52494fe0-cb9a-11e5-b350-f23c91c841bd	2016-02-05 00:52:17.060481+01	2016-02-05 00:58:08.104173+01	\N	59506342	59505817		http://cdn.rechat.co/59506342.jpg	7	{"XResolution": 300, "YResolution": 300, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.090425+02
5248fac2-cb9a-11e5-b350-f23c91c841bd	2016-02-05 00:52:17.058307+01	2016-02-05 00:58:08.20056+01	\N	59506340	59505817		http://cdn.rechat.co/59506340.jpg	5	{"XResolution": 300, "YResolution": 300, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.090426+02
52492434-cb9a-11e5-b350-f23c91c841bd	2016-02-05 00:52:17.059359+01	2016-02-05 00:58:08.227601+01	\N	59506341	59505817		http://cdn.rechat.co/59506341.jpg	6	{"XResolution": 300, "YResolution": 300, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.090426+02
2eb514e6-be0d-11e5-bd3f-f23c91c841bd	2016-01-18 18:59:13.213799+01	2016-01-18 19:21:51.837179+01	\N	59138067	59095666		http://cdn.rechat.co/59138067.jpg	1	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452769962, "ModifyDate": "2016:01:15 09:58:44", "Saturation": 1, "LightSource": 10, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 7.81015625, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452769962, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.002542+02
2eb78578-be0d-11e5-bd3f-f23c91c841bd	2016-01-18 18:59:13.229796+01	2016-01-18 19:21:59.789449+01	\N	59138077	59095666		http://cdn.rechat.co/59138077.jpg	11	{"ISO": 160, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452771361, "ModifyDate": "2016:01:15 09:58:50", "Saturation": 1, "LightSource": 15, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 2.9, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452771361, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 160}	\N	0	2017-04-08 22:06:04.005272+02
2eb7ad32-be0d-11e5-bd3f-f23c91c841bd	2016-01-18 18:59:13.230814+01	2016-01-18 19:21:58.647918+01	\N	59138078	59095666		http://cdn.rechat.co/59138078.jpg	12	{"ISO": 160, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452771483, "ModifyDate": "2016:01:15 09:58:51", "Saturation": 1, "LightSource": 15, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 3.91171875, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452771483, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 160}	\N	0	2017-04-08 22:06:04.005905+02
2eb4e0ac-be0d-11e5-bd3f-f23c91c841bd	2016-01-18 18:59:13.212463+01	2016-01-18 19:21:50.573614+01	\N	59138066	59095666		http://cdn.rechat.co/59138066.jpg	0	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452769570, "ModifyDate": "2016:01:15 09:58:43", "Saturation": 1, "LightSource": 10, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 7.6421875, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452769570, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -0.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.005942+02
2eb54056-be0d-11e5-bd3f-f23c91c841bd	2016-01-18 18:59:13.214916+01	2016-01-18 19:21:51.421003+01	\N	59138068	59095666		http://cdn.rechat.co/59138068.jpg	2	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452770041, "ModifyDate": "2016:01:15 09:58:44", "Saturation": 1, "LightSource": 10, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 7.0484375, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452770041, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.005945+02
2eb5a87a-be0d-11e5-bd3f-f23c91c841bd	2016-01-18 18:59:13.217558+01	2016-01-18 19:21:55.601973+01	\N	59138070	59095666		http://cdn.rechat.co/59138070.jpg	4	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452770480, "ModifyDate": "2016:01:15 09:58:46", "Saturation": 1, "LightSource": 15, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 2.87265625, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452770480, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.005959+02
5248d1aa-cb9a-11e5-b350-f23c91c841bd	2016-02-05 00:52:17.057178+01	2016-02-05 00:58:08.30994+01	\N	59506339	59505817		http://cdn.rechat.co/59506339.jpg	4	{"XResolution": 300, "YResolution": 300, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.090427+02
5248483e-cb9a-11e5-b350-f23c91c841bd	2016-02-05 00:52:17.053398+01	2016-02-05 00:58:08.534831+01	\N	59506336	59505817		http://cdn.rechat.co/59506336.jpg	1	{"XResolution": 300, "YResolution": 300, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.090427+02
52487fca-cb9a-11e5-b350-f23c91c841bd	2016-02-05 00:52:17.055146+01	2016-02-05 00:58:09.372843+01	\N	59506337	59505817		http://cdn.rechat.co/59506337.jpg	2	{"XResolution": 300, "YResolution": 300, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.090428+02
2eb7135e-be0d-11e5-bd3f-f23c91c841bd	2016-01-18 18:59:13.226791+01	2016-01-18 19:21:58.816682+01	\N	59138075	59095666		http://cdn.rechat.co/59138075.jpg	9	{"ISO": 160, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452771170, "ModifyDate": "2016:01:15 09:58:49", "Saturation": 1, "LightSource": 15, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 1.4, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452771170, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 160}	\N	0	2017-04-08 22:06:04.00596+02
2eb65612-be0d-11e5-bd3f-f23c91c841bd	2016-01-18 18:59:13.222019+01	2016-01-18 19:21:55.009241+01	\N	59138073	59095666		http://cdn.rechat.co/59138073.jpg	7	{"ISO": 160, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452770923, "ModifyDate": "2016:01:15 09:58:48", "Saturation": 1, "LightSource": 15, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 2.15390625, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452770923, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -2.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 160}	\N	0	2017-04-08 22:06:04.005961+02
2eb7d4f6-be0d-11e5-bd3f-f23c91c841bd	2016-01-18 18:59:13.231805+01	2016-01-18 19:21:59.131262+01	\N	59138079	59095666		http://cdn.rechat.co/59138079.jpg	13	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452771593, "ModifyDate": "2016:01:15 09:58:51", "Saturation": 1, "LightSource": 15, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 3.775, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452771593, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.005969+02
2eb62a8e-be0d-11e5-bd3f-f23c91c841bd	2016-01-18 18:59:13.220911+01	2016-01-18 19:21:56.57704+01	\N	59138072	59095666		http://cdn.rechat.co/59138072.jpg	6	{"ISO": 160, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452770834, "ModifyDate": "2016:01:15 09:58:47", "Saturation": 1, "LightSource": 15, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 1.92734375, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452770834, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -2.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 160}	\N	0	2017-04-08 22:06:04.005989+02
2eb56996-be0d-11e5-bd3f-f23c91c841bd	2016-01-18 18:59:13.215962+01	2016-01-18 19:21:52.40272+01	\N	59138069	59095666		http://cdn.rechat.co/59138069.jpg	3	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452770366, "ModifyDate": "2016:01:15 09:58:45", "Saturation": 1, "LightSource": 15, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 1.17734375, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452770366, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.006072+02
2eb5fa3c-be0d-11e5-bd3f-f23c91c841bd	2016-01-18 18:59:13.219638+01	2016-01-18 19:21:52.992457+01	\N	59138071	59095666		http://cdn.rechat.co/59138071.jpg	5	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452770567, "ModifyDate": "2016:01:15 09:58:46", "Saturation": 1, "LightSource": 15, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 1.08359375, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452770567, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.006072+02
00cecae0-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.75378+01	2016-02-06 00:54:29.587903+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20403" ReplyText="No object found.">\n</RETS>\n	59531804	59529693		\N	23	\N	\N	0	2017-04-08 22:06:11.189031+02
00cfc896-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.760289+01	2016-02-06 00:54:29.393315+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20403" ReplyText="No object found.">\n</RETS>\n	59531809	59529693		\N	21	\N	\N	0	2017-04-08 22:06:11.18906+02
00d04122-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.763377+01	2016-02-06 00:54:30.205055+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20403" ReplyText="No object found.">\n</RETS>\n	59531811	59529693		\N	1	\N	\N	0	2017-04-08 22:06:11.189061+02
2eb67ef8-be0d-11e5-bd3f-f23c91c841bd	2016-01-18 18:59:13.22305+01	2016-01-18 19:21:54.493969+01	\N	59138074	59095666		http://cdn.rechat.co/59138074.jpg	8	{"ISO": 160, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452771073, "ModifyDate": "2016:01:15 09:58:48", "Saturation": 1, "LightSource": 15, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 1.790625, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452771073, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 160}	\N	0	2017-04-08 22:06:04.006084+02
2eb7574c-be0d-11e5-bd3f-f23c91c841bd	2016-01-18 18:59:13.228582+01	2016-01-18 19:21:57.612277+01	\N	59138076	59095666		http://cdn.rechat.co/59138076.jpg	10	{"ISO": 160, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452771244, "ModifyDate": "2016:01:15 09:58:50", "Saturation": 1, "LightSource": 15, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 1.0875, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452771244, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 160}	\N	0	2017-04-08 22:06:04.006116+02
d54bb0aa-be10-11e5-b4a9-f23c91c841bd	2016-01-18 19:25:21.192798+01	2016-01-18 19:30:58.008425+01	\N	59138814	59096317		http://cdn.rechat.co/59138814.jpg	1	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452769962, "ModifyDate": "2016:01:15 09:55:27", "Saturation": 1, "LightSource": 10, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 7.81015625, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452769962, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.007208+02
d54d65ee-be10-11e5-b4a9-f23c91c841bd	2016-01-18 19:25:21.204002+01	2016-01-18 19:30:55.01946+01	\N	59138823	59096317		http://cdn.rechat.co/59138823.jpg	10	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7.1 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452772792, "ModifyDate": "2016:01:15 11:27:47", "Saturation": 1, "LightSource": 15, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 2.2359375, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452772792, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.007875+02
d54b5c7c-be10-11e5-b4a9-f23c91c841bd	2016-01-18 19:25:21.190648+01	2016-01-18 19:30:58.834821+01	\N	59138813	59096317		http://cdn.rechat.co/59138813.jpg	0	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452769570, "ModifyDate": "2016:01:15 09:55:26", "Saturation": 1, "LightSource": 10, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 7.6421875, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452769570, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -0.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.007907+02
d54cea42-be10-11e5-b4a9-f23c91c841bd	2016-01-18 19:25:21.200838+01	2016-01-18 19:30:56.142812+01	\N	59138820	59096317		http://cdn.rechat.co/59138820.jpg	7	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7.1 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452772472, "ModifyDate": "2016:01:15 11:27:46", "Saturation": 1, "LightSource": 15, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 0.7125, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452772472, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -2.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.00795+02
00cb39b6-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.73036+01	2016-02-06 00:54:30.187611+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20403" ReplyText="No object found.">\n</RETS>\n	59531791	59529693		\N	12	\N	\N	0	2017-04-08 22:06:11.189353+02
216fee5a-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.988741+01	2016-02-15 20:33:42.978836+01	\N	59710360	59709556		http://cdn.rechat.co/59710360.jpg	21	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:33:09", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485094+02
d54d3268-be10-11e5-b4a9-f23c91c841bd	2016-01-18 19:25:21.202688+01	2016-01-18 19:30:56.545906+01	\N	59138822	59096317		http://cdn.rechat.co/59138822.jpg	9	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7.1 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452772630, "ModifyDate": "2016:01:15 11:27:47", "Saturation": 1, "LightSource": 15, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 1.70859375, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452772630, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.00796+02
d54c2e9a-be10-11e5-b4a9-f23c91c841bd	2016-01-18 19:25:21.195589+01	2016-01-18 19:30:59.120763+01	\N	59138816	59096317		http://cdn.rechat.co/59138816.jpg	3	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7.1 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452771811, "ModifyDate": "2016:01:15 11:27:44", "Saturation": 1, "LightSource": 15, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": -0.4984375, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452771811, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.007986+02
d54cc4ea-be10-11e5-b4a9-f23c91c841bd	2016-01-18 19:25:21.199866+01	2016-01-18 19:31:02.345777+01	\N	59138819	59096317		http://cdn.rechat.co/59138819.jpg	6	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7.1 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452772363, "ModifyDate": "2016:01:15 11:27:45", "Saturation": 1, "LightSource": 15, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 0.9390625, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452772363, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.007999+02
d54bd4f4-be10-11e5-b4a9-f23c91c841bd	2016-01-18 19:25:21.19373+01	2016-01-18 19:31:00.30969+01	\N	59138815	59096317		http://cdn.rechat.co/59138815.jpg	2	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7.1 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452771697, "ModifyDate": "2016:01:15 11:27:43", "Saturation": 1, "LightSource": 10, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 7.51328125, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452771697, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.008003+02
d54d0d4c-be10-11e5-b4a9-f23c91c841bd	2016-01-18 19:25:21.201732+01	2016-01-18 19:31:00.809975+01	\N	59138821	59096317		http://cdn.rechat.co/59138821.jpg	8	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7.1 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452772536, "ModifyDate": "2016:01:15 11:27:46", "Saturation": 1, "LightSource": 15, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 1.884375, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452772536, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -2.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.008015+02
d54c68d8-be10-11e5-b4a9-f23c91c841bd	2016-01-18 19:25:21.197494+01	2016-01-18 19:31:01.239504+01	\N	59138817	59096317		http://cdn.rechat.co/59138817.jpg	4	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7.1 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452772119, "ModifyDate": "2016:01:15 11:27:44", "Saturation": 1, "LightSource": 15, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 0.71640625, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452772119, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.008024+02
938e9224-d3f8-11e5-b062-f23c91c841bd	2016-02-15 16:27:08.561089+01	2016-02-15 16:28:08.149491+01	\N	59702629	59698128		http://cdn.rechat.co/59702629.jpg	5	{}	\N	0	2017-04-08 22:06:11.474436+02
938f5cea-d3f8-11e5-b062-f23c91c841bd	2016-02-15 16:27:08.56627+01	2016-02-15 16:28:09.145822+01	\N	59702633	59698128	Master bath	http://cdn.rechat.co/59702633.jpg	9	{}	\N	0	2017-04-08 22:06:11.474437+02
216c50a6-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.965056+01	2016-02-15 20:33:44.07603+01	\N	59710341	59709556		http://cdn.rechat.co/59710341.jpg	2	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:32:51", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.351487+02
d54c9da8-be10-11e5-b4a9-f23c91c841bd	2016-01-18 19:25:21.198868+01	2016-01-18 19:31:01.913677+01	\N	59138818	59096317		http://cdn.rechat.co/59138818.jpg	5	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7.1 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452772304, "ModifyDate": "2016:01:15 11:27:45", "Saturation": 1, "LightSource": 15, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 0.89609375, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452772304, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.008038+02
0be2b662-be12-11e5-b37a-f23c91c841bd	2016-01-18 19:34:02.276221+01	2016-01-18 19:41:21.129995+01	\N	59139089	59097482		http://cdn.rechat.co/59139089.jpg	8	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:15 12:50:23", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:03.988036+02
0be26d56-be12-11e5-b37a-f23c91c841bd	2016-01-18 19:34:02.274351+01	2016-01-18 19:41:17.43405+01	\N	59139087	59097482		http://cdn.rechat.co/59139087.jpg	6	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:15 12:50:22", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.008651+02
0be300e0-be12-11e5-b37a-f23c91c841bd	2016-01-18 19:34:02.27813+01	2016-01-18 19:41:20.598056+01	\N	59139091	59097482		http://cdn.rechat.co/59139091.jpg	10	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:15 12:50:25", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.008652+02
0be29236-be12-11e5-b37a-f23c91c841bd	2016-01-18 19:34:02.275294+01	2016-01-18 19:41:20.097607+01	\N	59139088	59097482		http://cdn.rechat.co/59139088.jpg	7	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:15 12:50:23", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.010215+02
0be1f920-be12-11e5-b37a-f23c91c841bd	2016-01-18 19:34:02.271363+01	2016-01-18 19:41:13.933061+01	\N	59139084	59097482		http://cdn.rechat.co/59139084.jpg	3	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:15 12:50:20", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.011713+02
0be154c0-be12-11e5-b37a-f23c91c841bd	2016-01-18 19:34:02.267145+01	2016-01-18 19:41:16.042521+01	\N	59139081	59097482		http://cdn.rechat.co/59139081.jpg	0	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452769570, "ModifyDate": "2016:01:15 09:58:43", "Saturation": 1, "LightSource": 10, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 7.6421875, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452769570, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -0.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.011731+02
0be189e0-be12-11e5-b37a-f23c91c841bd	2016-01-18 19:34:02.268491+01	2016-01-18 19:41:16.530659+01	\N	59139082	59097482		http://cdn.rechat.co/59139082.jpg	1	{"ISO": 200, "Make": "SONY", "Flash": 16, "Model": "ILCE-7RM2", "Artist": "Fred Lindgren", "Contrast": 1, "LensInfo": [16, 35, 4, 4], "Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "LensModel": "FE 16-35mm F4 ZA OSS", "Sharpness": 0, "CreateDate": 1452769962, "ModifyDate": "2016:01:15 09:58:44", "Saturation": 1, "LightSource": 10, "XResolution": 240, "YResolution": 240, "ExposureMode": 2, "MeteringMode": 5, "WhiteBalance": 1, "CustomRendered": 0, "ResolutionUnit": 2, "BrightnessValue": 7.81015625, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1452769962, "DigitalZoomRatio": 1, "MaxApertureValue": 4, "SceneCaptureType": 0, "ExposureCompensation": -3.3, "FocalPlaneXResolution": 2164.4328018223237, "FocalPlaneYResolution": 2164.4328018223237, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:04.011735+02
0be1cdc4-be12-11e5-b37a-f23c91c841bd	2016-01-18 19:34:02.2702+01	2016-01-18 19:41:17.107959+01	\N	59139083	59097482		http://cdn.rechat.co/59139083.jpg	2	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:15 12:50:20", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.011735+02
0be22170-be12-11e5-b37a-f23c91c841bd	2016-01-18 19:34:02.272406+01	2016-01-18 19:41:17.965578+01	\N	59139085	59097482		http://cdn.rechat.co/59139085.jpg	4	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:15 12:50:21", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.011736+02
0be24858-be12-11e5-b37a-f23c91c841bd	2016-01-18 19:34:02.273358+01	2016-01-18 19:41:18.431263+01	\N	59139086	59097482		http://cdn.rechat.co/59139086.jpg	5	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:15 12:50:22", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.011736+02
0be2db92-be12-11e5-b37a-f23c91c841bd	2016-01-18 19:34:02.277173+01	2016-01-18 19:41:19.206228+01	\N	59139090	59097482		http://cdn.rechat.co/59139090.jpg	9	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "Copyright": "Fred Lindgren", "ModifyDate": "2016:01:15 12:50:24", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.011737+02
5248a996-cb9a-11e5-b350-f23c91c841bd	2016-02-05 00:52:17.056204+01	2016-02-05 00:58:08.362362+01	\N	59506338	59505817		http://cdn.rechat.co/59506338.jpg	3	{"XResolution": 300, "YResolution": 300, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:06.751815+02
52480b58-cb9a-11e5-b350-f23c91c841bd	2016-02-05 00:52:17.052104+01	2016-02-05 00:58:08.557052+01	\N	59506335	59505817		http://cdn.rechat.co/59506335.jpg	0	{"XResolution": 300, "YResolution": 300, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:06.751816+02
52497f42-cb9a-11e5-b350-f23c91c841bd	2016-02-05 00:52:17.061685+01	2016-02-05 00:58:07.906294+01	\N	59506343	59505817		http://cdn.rechat.co/59506343.jpg	8	{"XResolution": 300, "YResolution": 300, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:06.751835+02
5249a8be-cb9a-11e5-b350-f23c91c841bd	2016-02-05 00:52:17.062765+01	2016-02-05 00:58:07.870406+01	\N	59506344	59505817		http://cdn.rechat.co/59506344.jpg	9	{"XResolution": 300, "YResolution": 300, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.072377+02
5249dc44-cb9a-11e5-b350-f23c91c841bd	2016-02-05 00:52:17.064012+01	2016-02-05 00:58:07.824785+01	\N	59506345	59505817		http://cdn.rechat.co/59506345.jpg	10	{"XResolution": 300, "YResolution": 300, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.090425+02
00c9506a-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.717892+01	2016-02-06 00:54:30.967534+01	\N	59531783	59529693		http://cdn.rechat.co/59531783.jpg	8	{"ISO": 320, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454351341, "ModifyDate": "2016:02:03 21:44:41", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.008, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1334, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454351341, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 6.965784, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 320}	\N	0	2017-04-08 22:06:11.189367+02
00c9f164-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.721963+01	2016-02-06 00:54:30.381996+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20403" ReplyText="No object found.">\n</RETS>\n	59531786	59529693		\N	7	\N	\N	0	2017-04-08 22:06:11.189371+02
00c88112-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.712553+01	2016-02-06 00:54:31.030393+01	\N	59531779	59529693		http://cdn.rechat.co/59531779.jpg	1	{"ISO": 320, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454351130, "ModifyDate": "2016:02:03 22:04:11", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.005, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1335, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454351130, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 7.643856, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 320}	\N	0	2017-04-08 22:06:11.189374+02
00c8f23c-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.715492+01	2016-02-06 00:54:30.601419+01	<?xml version="1.0" ?>\r\n<RETS ReplyCode="20403" ReplyText="No object found.">\n</RETS>\n	59531781	59529693		\N	2	\N	\N	0	2017-04-08 22:06:11.189375+02
00cf61e4-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.757665+01	2016-02-06 00:54:29.835315+01	\N	59531807	59529693	W Residence Entrance	http://cdn.rechat.co/59531807.jpg	26	{"ISO": 500, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark II", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1417540388, "ModifyDate": "2014:12:04 12:17:43", "FocalLength": 18, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.025, "MeteringMode": 5, "SerialNumber": "320209055", "WhiteBalance": 0, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "DateTimeOriginal": 1417540388, "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 5.321928, "SubSecTimeOriginal": "86", "ExposureCompensation": 0, "FocalPlaneXResolution": 3849.2117888965045, "FocalPlaneYResolution": 3908.141962421712, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.199111+02
778325dc-cc5e-11e5-9266-f23c91c841bd	2016-02-06 00:16:20.874142+01	2016-02-06 00:54:24.659579+01	\N	59535519	59529693		http://cdn.rechat.co/59535519.jpg	17	{"ISO": 200, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454350893, "ModifyDate": "2016:02:03 22:12:20", "FocalLength": 16, "Orientation": 1, "XResolution": 300, "YResolution": 300, "ExposureMode": 1, "ExposureTime": 0.01, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454350893, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 6.643856, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:11.199124+02
77836e02-cc5e-11e5-9266-f23c91c841bd	2016-02-06 00:16:20.876016+01	2016-02-06 00:54:24.524625+01	\N	59535520	59529693		http://cdn.rechat.co/59535520.jpg	18	{"ISO": 200, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454352378, "ModifyDate": "2016:02:03 22:40:11", "FocalLength": 16, "Orientation": 1, "XResolution": 300, "YResolution": 300, "ExposureMode": 1, "ExposureTime": 0.02, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454352378, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 5.643856, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:11.199125+02
00cf904c-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.758856+01	2016-02-06 00:54:29.864996+01	\N	59531808	59529693		http://cdn.rechat.co/59531808.jpg	21	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark II", "FNumber": 8, "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1417538743, "ModifyDate": "2014:12:11 11:46:42", "SubSecTime": "61", "FocalLength": 25, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.02, "MeteringMode": 5, "WhiteBalance": 0, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1332, "ExposureProgram": 1, "DateTimeOriginal": 1417538743, "SceneCaptureType": 0, "ShutterSpeedValue": 5.643856, "SubSecTimeOriginal": "61", "SubSecTimeDigitized": "61", "FocalPlaneXResolution": 3849.2117888965045, "FocalPlaneYResolution": 3908.141962421712, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.199126+02
00d000b8-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.761719+01	2016-02-06 00:54:29.758863+01	\N	59531810	59529693		http://cdn.rechat.co/59531810.jpg	0	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1444764546, "ModifyDate": "2015:10:14 22:38:24", "SubSecTime": "00", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 8, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1444764546, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": -3, "SubSecTimeOriginal": "00", "SubSecTimeDigitized": "00", "ExposureCompensation": 0, "FocalPlaneXResolution": 160, "FocalPlaneYResolution": 160, "FocalPlaneResolutionUnit": 4, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.199377+02
00cf361a-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.756532+01	2016-02-06 00:54:29.866426+01	\N	59531806	59529693	W Residences Lounge	http://cdn.rechat.co/59531806.jpg	25	{"ISO": 160, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1416337769, "ModifyDate": "2014:11:20 11:37:52", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 1.6, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1416337769, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": -0.678072, "SubSecTimeOriginal": "95", "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 160}	\N	0	2017-04-08 22:06:11.199389+02
00ce4fb6-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.750569+01	2016-02-06 00:54:30.024197+01	\N	59531803	59529693		http://cdn.rechat.co/59531803.jpg	22	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1416332381, "ModifyDate": "2014:11:20 21:03:37", "SubSecTime": "00", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.003125, "MeteringMode": 5, "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1335, "ExposureProgram": 1, "DateTimeOriginal": 1416332381, "SceneCaptureType": 0, "ShutterSpeedValue": 8.321928, "SubSecTimeDigitized": "00", "FocalPlaneXResolution": 3942.5051334702257, "FocalPlaneYResolution": 3950.617283950617, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.19939+02
00cefbbe-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.755028+01	2016-02-06 00:54:30.054831+01	\N	59531805	59529693	W Hotel & Residences Bliss spa	http://cdn.rechat.co/59531805.jpg	24	{"ISO": 250, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1416332880, "ModifyDate": "2014:11:20 20:42:23", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.05, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1416332880, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 4.321928, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 250}	\N	0	2017-04-08 22:06:11.199391+02
00cd8c66-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.745633+01	2016-02-06 00:54:30.129144+01	\N	59531800	59529693	W Residences Gym	http://cdn.rechat.co/59531800.jpg	23	{"ISO": 800, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1416332116, "ModifyDate": "2014:11:20 20:44:27", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.008, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1335, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1416332116, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 6.965784, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 800}	\N	0	2017-04-08 22:06:11.199392+02
00ccdf28-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.741168+01	2016-02-06 00:54:30.283665+01	\N	59531797	59529693		http://cdn.rechat.co/59531797.jpg	11	{"ISO": 800, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454352981, "ModifyDate": "2016:02:03 22:38:37", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.16666666666666666, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454352981, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 2.584963, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 800}	\N	0	2017-04-08 22:06:11.199404+02
216d13c4-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.970059+01	2016-02-15 20:33:43.81323+01	\N	59710345	59709556		http://cdn.rechat.co/59710345.jpg	4	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:32:54", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.351488+02
00cc6e76-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.738244+01	2016-02-06 00:54:30.617247+01	\N	59531795	59529693		http://cdn.rechat.co/59531795.jpg	10	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454352411, "ModifyDate": "2016:02:03 22:49:10", "SubSecTime": "00", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.1, "MeteringMode": 5, "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1334, "ExposureProgram": 1, "DateTimeOriginal": 1454352411, "SceneCaptureType": 0, "ShutterSpeedValue": 3.321928, "SubSecTimeDigitized": "00", "FocalPlaneXResolution": 3942.5051334702257, "FocalPlaneYResolution": 3950.617283950617, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.199405+02
00cd5890-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.744277+01	2016-02-06 00:54:30.118665+01	\N	59531799	59529693		http://cdn.rechat.co/59531799.jpg	13	{"ISO": 320, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454353062, "ModifyDate": "2016:02:03 22:35:38", "FocalLength": 19, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.02, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454353062, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 5.643856, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 320}	\N	0	2017-04-08 22:06:11.199405+02
00cd0cbe-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.742332+01	2016-02-06 00:54:30.195739+01	\N	59531798	59529693		http://cdn.rechat.co/59531798.jpg	12	{"ISO": 320, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454353048, "ModifyDate": "2016:02:03 22:35:50", "FocalLength": 19, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.02, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454353048, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 5.643856, "SubSecTimeOriginal": "98", "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 320}	\N	0	2017-04-08 22:06:11.199406+02
00cc9ae0-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.73947+01	2016-02-06 00:54:30.338308+01	\N	59531796	59529693		http://cdn.rechat.co/59531796.jpg	5	{"ISO": 250, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454352951, "ModifyDate": "2016:02:03 22:38:57", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.1, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1334, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454352951, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 3.321928, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 250}	\N	0	2017-04-08 22:06:11.199407+02
00ca7896-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.725377+01	2016-02-06 00:54:30.718457+01	\N	59531788	59529693		http://cdn.rechat.co/59531788.jpg	4	{"ISO": 320, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454351608, "ModifyDate": "2016:02:03 22:29:34", "FocalLength": 17, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.01, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1338, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454351608, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 6.643856, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 320}	\N	0	2017-04-08 22:06:11.199408+02
00ca3b1a-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.723905+01	2016-02-06 00:54:30.784581+01	\N	59531787	59529693		http://cdn.rechat.co/59531787.jpg	3	{"ISO": 500, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454351561, "ModifyDate": "2016:02:03 22:29:46", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.02, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454351561, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 5.643856, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 500}	\N	0	2017-04-08 22:06:11.199419+02
216e7b06-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.979248+01	2016-02-15 20:33:43.601224+01	\N	59710352	59709556		http://cdn.rechat.co/59710352.jpg	13	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:33:03", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.351504+02
00cbaaea-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.733256+01	2016-02-06 00:54:30.483071+01	\N	59531793	59529693		http://cdn.rechat.co/59531793.jpg	15	{"ISO": 200, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454351906, "ModifyDate": "2016:02:03 22:42:32", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.008, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454351906, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 6.965784, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:11.19942+02
00cbe4e2-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.734791+01	2016-02-06 00:54:30.591075+01	\N	59531794	59529693		http://cdn.rechat.co/59531794.jpg	14	{"ISO": 200, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454352319, "ModifyDate": "2016:02:03 22:42:13", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.008, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454352319, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 6.965784, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 200}	\N	0	2017-04-08 22:06:11.199421+02
00c98e86-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.71948+01	2016-02-06 00:54:30.889637+01	\N	59531784	59529693		http://cdn.rechat.co/59531784.jpg	6	{"ISO": 1250, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454351373, "ModifyDate": "2016:02:03 22:31:17", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.025, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454351373, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 5.321928, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 1250}	\N	0	2017-04-08 22:06:11.199421+02
00c92068-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.716658+01	2016-02-06 00:54:30.969306+01	\N	59531782	59529693		http://cdn.rechat.co/59531782.jpg	9	{"ISO": 320, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454351325, "ModifyDate": "2016:02:03 21:45:09", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.008, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1334, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454351325, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 6.965784, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 320}	\N	0	2017-04-08 22:06:11.199422+02
00c8bfb0-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.714193+01	2016-02-06 00:54:30.970338+01	\N	59531780	59529693		http://cdn.rechat.co/59531780.jpg	2	{"ISO": 250, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454351167, "ModifyDate": "2016:02:03 22:02:35", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.025, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454351167, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 5.321928, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 250}	\N	0	2017-04-08 22:06:11.199423+02
00cabc66-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.7271+01	2016-02-06 00:54:30.698514+01	\N	59531789	59529693		http://cdn.rechat.co/59531789.jpg	16	{"ISO": 160, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454351674, "ModifyDate": "2016:02:03 22:24:56", "FocalLength": 17, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.016666666666666666, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454351674, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 5.906891, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 160}	\N	0	2017-04-08 22:06:11.199425+02
21702230-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.990158+01	2016-02-15 20:33:42.99125+01	\N	59710361	59709556		http://cdn.rechat.co/59710361.jpg	20	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:33:10", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:04.351532+02
00c9be88-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.720683+01	2016-02-06 00:54:30.813636+01	\N	59531785	59529693		http://cdn.rechat.co/59531785.jpg	7	{"ISO": 800, "Make": "Canon", "Flash": 9, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454351405, "ModifyDate": "2016:02:03 22:31:04", "FocalLength": 16, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.025, "MeteringMode": 5, "SerialNumber": "152027000070", "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1333, "ExposureProgram": 1, "SensitivityType": 2, "DateTimeOriginal": 1454351405, "LensSerialNumber": "000084a7b4", "MaxApertureValue": 3, "SceneCaptureType": 0, "ShutterSpeedValue": 5.321928, "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 800}	\N	0	2017-04-08 22:06:11.199436+02
00cb5e14-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.73133+01	2016-02-06 00:54:33.366533+01	\N	59531792	59529693		http://cdn.rechat.co/59531792.jpg	19	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454351864, "ModifyDate": "2016:02:03 22:50:04", "SubSecTime": "00", "FocalLength": 24, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.04, "MeteringMode": 5, "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1334, "ExposureProgram": 1, "DateTimeOriginal": 1454351864, "SceneCaptureType": 0, "ShutterSpeedValue": 4.643856, "SubSecTimeDigitized": "00", "FocalPlaneXResolution": 3942.5051334702257, "FocalPlaneYResolution": 3950.617283950617, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.199442+02
00caf028-cc54-11e5-8be9-f23c91c841bd	2016-02-05 23:01:26.72853+01	2016-02-06 00:54:33.732828+01	\N	59531790	59529693		http://cdn.rechat.co/59531790.jpg	20	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 8, "LensInfo": [16, 35, null, null], "Software": "Adobe Photoshop CS6 (Windows)", "LensModel": "EF16-35mm f/2.8L II USM", "CreateDate": 1454351801, "ModifyDate": "2016:02:03 22:51:47", "SubSecTime": "00", "FocalLength": 17, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 1, "ExposureTime": 0.04, "MeteringMode": 5, "WhiteBalance": 1, "ApertureValue": 6, "CustomRendered": 0, "ExifImageWidth": 2000, "ResolutionUnit": 2, "ExifImageHeight": 1335, "ExposureProgram": 1, "DateTimeOriginal": 1454351801, "SceneCaptureType": 0, "ShutterSpeedValue": 4.643856, "SubSecTimeDigitized": "00", "FocalPlaneXResolution": 3942.5051334702257, "FocalPlaneYResolution": 3950.617283950617, "FocalPlaneResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.199452+02
728d0658-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.319199+01	2016-02-11 17:23:27.146074+01	\N	59617431	59616961		http://cdn.rechat.co/59617431.jpg	18	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454607043, "ModifyDate": "2016:02:05 08:49:10", "FocalLength": 22, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.25, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454607044, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 2, "SubSecTimeOriginal": "54", "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.337641+02
728d38da-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.320428+01	2016-02-11 17:23:25.022247+01	\N	59617432	59616961		http://cdn.rechat.co/59617432.jpg	19	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454607151, "ModifyDate": "2016:02:05 08:49:11", "FocalLength": 22, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.125, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454607151, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 3, "SubSecTimeOriginal": "8", "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.337654+02
728f2bd6-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.333259+01	2016-02-11 17:23:24.484461+01	\N	59617442	59616961		http://cdn.rechat.co/59617442.jpg	25	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454607850, "ModifyDate": "2016:02:05 08:49:49", "FocalLength": 39, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.16666666666666666, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454607850, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 2.584963, "SubSecTimeOriginal": "65", "ExposureCompensation": 2, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361573+02
9b4e64ec-d418-11e5-b7a0-f23c91c841bd	2016-02-15 20:16:25.457601+01	2016-02-15 20:33:44.892409+01	\N	59709943	59709556		http://cdn.rechat.co/59709943.jpg	1	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:32:48", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.48432+02
728f959e-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.33596+01	2016-02-11 17:23:24.487378+01	\N	59617444	59616961		http://cdn.rechat.co/59617444.jpg	29	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 16, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454608221, "ModifyDate": "2016:02:05 08:50:01", "FocalLength": 23, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.4, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 8, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454608221, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 1.321928, "SubSecTimeOriginal": "15", "ExposureCompensation": 3, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361574+02
728fe828-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.338074+01	2016-02-11 17:23:24.516348+01	\N	59617446	59616961		http://cdn.rechat.co/59617446.jpg	31	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454608471, "ModifyDate": "2016:02:05 08:50:08", "FocalLength": 27, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.5, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454608472, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 1, "SubSecTimeOriginal": "12", "ExposureCompensation": 1, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361574+02
728f634e-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.33467+01	2016-02-11 17:23:24.522271+01	\N	59617443	59616961		http://cdn.rechat.co/59617443.jpg	28	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 16, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454608180, "ModifyDate": "2016:02:05 08:49:58", "FocalLength": 27, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.16666666666666666, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 8, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454608180, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 2.584963, "ExposureCompensation": 3, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361575+02
728fbfec-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.337036+01	2016-02-11 17:23:24.524192+01	\N	59617445	59616961		http://cdn.rechat.co/59617445.jpg	30	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454608360, "ModifyDate": "2016:02:05 08:50:05", "FocalLength": 27, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.16666666666666666, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454608361, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 2.584963, "SubSecTimeOriginal": "56", "ExposureCompensation": 1, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361582+02
72906c9e-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.341449+01	2016-02-11 17:23:24.205277+01	\N	59617449	59616961		http://cdn.rechat.co/59617449.jpg	35	{"ISO": 640, "Make": "Apple", "Flash": 16, "Model": "iPhone 6", "FNumber": 2.2, "GPSSpeed": 0, "LensInfo": [4.15, 4.15, 2.2, 2.2], "LensMake": "Apple", "Software": "8.4.1", "LensModel": "iPhone 6 back camera 4.15mm f/2.2", "ColorSpace": 1, "CreateDate": 1454610856, "ModifyDate": "2016:02:04 18:34:16", "FocalLength": 4.15, "GPSAltitude": 131.97802197802199, "GPSLatitude": 32.78874166666667, "GPSSpeedRef": "K", "Orientation": 1, "SubjectArea": [1631, 1223, 2393, 1077], "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.06666666666666667, "GPSDateStamp": "2016:02:05", "GPSLongitude": -96.80867777777777, "GPSTimeStamp": [0, 34, 0], "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ApertureValue": 2.2750072066878064, "SensingMethod": 2, "ExifImageWidth": 2448, "GPSAltitudeRef": 0, "GPSDestBearing": 117.34448160535118, "GPSLatitudeRef": "N", "ResolutionUnit": 2, "BrightnessValue": -2.28015873015873, "ExifImageHeight": 2448, "ExposureProgram": 2, "GPSImgDirection": 297.3444976076555, "GPSLongitudeRef": "W", "DateTimeOriginal": 1454610856, "SceneCaptureType": 0, "YCbCrPositioning": 1, "GPSDestBearingRef": "T", "ShutterSpeedValue": 3.9070567986230635, "GPSImgDirectionRef": "T", "SubSecTimeOriginal": "452", "SubSecTimeDigitized": "452", "ExposureCompensation": 0, "FocalLengthIn35mmFormat": 39}	\N	0	2017-04-08 22:06:11.361584+02
9b4e3f26-d418-11e5-b7a0-f23c91c841bd	2016-02-15 20:16:25.456624+01	2016-02-15 20:33:45.000434+01	\N	59709942	59709556		http://cdn.rechat.co/59709942.jpg	0	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:32:49", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.484442+02
21706eac-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.992039+01	2016-02-15 20:33:42.8402+01	\N	59710363	59709556		http://cdn.rechat.co/59710363.jpg	24	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:33:12", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485023+02
216f61ce-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.985152+01	2016-02-15 20:33:43.092852+01	\N	59710357	59709556		http://cdn.rechat.co/59710357.jpg	18	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:33:07", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485024+02
7290121c-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.339108+01	2016-02-11 17:23:24.209037+01	\N	59617447	59616961		http://cdn.rechat.co/59617447.jpg	33	{"ISO": 320, "Make": "Apple", "Flash": 16, "Model": "iPhone 6", "FNumber": 2.2, "GPSSpeed": 0, "LensInfo": [4.15, 4.15, 2.2, 2.2], "LensMake": "Apple", "Software": "8.4.1", "LensModel": "iPhone 6 back camera 4.15mm f/2.2", "ColorSpace": 1, "CreateDate": 1454610892, "ModifyDate": "2016:02:04 18:34:52", "FocalLength": 4.15, "GPSAltitude": 133.7193308550186, "GPSLatitude": 32.78833888888889, "GPSSpeedRef": "K", "Orientation": 1, "SubjectArea": [1631, 1223, 2393, 1077], "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.06666666666666667, "GPSDateStamp": "2016:02:05", "GPSLongitude": -96.80893055555555, "GPSTimeStamp": [0, 34, 52], "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ApertureValue": 2.2750072066878064, "SensingMethod": 2, "ExifImageWidth": 2448, "GPSAltitudeRef": 0, "GPSDestBearing": 252.69411764705882, "GPSLatitudeRef": "N", "ResolutionUnit": 2, "BrightnessValue": -0.6699674844812297, "ExifImageHeight": 2448, "ExposureProgram": 2, "GPSImgDirection": 72.6941056910569, "GPSLongitudeRef": "W", "DateTimeOriginal": 1454610892, "SceneCaptureType": 0, "YCbCrPositioning": 1, "GPSDestBearingRef": "T", "ShutterSpeedValue": 3.9070567986230635, "GPSImgDirectionRef": "T", "SubSecTimeOriginal": "706", "SubSecTimeDigitized": "706", "ExposureCompensation": 0, "FocalLengthIn35mmFormat": 39}	\N	0	2017-04-08 22:06:11.361585+02
72903d82-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.340257+01	2016-02-11 17:23:24.210485+01	\N	59617448	59616961		http://cdn.rechat.co/59617448.jpg	34	{"ISO": 250, "Make": "Apple", "Flash": 16, "Model": "iPhone 6", "FNumber": 2.2, "GPSSpeed": 0, "LensInfo": [4.15, 4.15, 2.2, 2.2], "LensMake": "Apple", "Software": "8.4.1", "LensModel": "iPhone 6 back camera 4.15mm f/2.2", "ColorSpace": 1, "CreateDate": 1454610016, "ModifyDate": "2016:02:04 18:20:16", "FocalLength": 4.15, "GPSAltitude": 132.4093567251462, "GPSLatitude": 32.78859722222222, "GPSSpeedRef": "K", "Orientation": 1, "SubjectArea": [1223, 1224, 1345, 1076], "XResolution": 72, "YResolution": 72, "ExposureMode": 0, "ExposureTime": 0.058823529411764705, "GPSDateStamp": "2016:02:05", "GPSLongitude": -96.8089, "GPSTimeStamp": [0, 19, 56], "MeteringMode": 5, "OffsetSchema": 0, "WhiteBalance": 0, "ApertureValue": 2.2750072066878064, "SensingMethod": 2, "ExifImageWidth": 2448, "GPSAltitudeRef": 0, "GPSDestBearing": 214.03559870550163, "GPSLatitudeRef": "N", "ResolutionUnit": 2, "BrightnessValue": -0.24989808397880148, "ExifImageHeight": 2448, "ExposureProgram": 2, "GPSImgDirection": 34.035616438356165, "GPSLongitudeRef": "W", "DateTimeOriginal": 1454610016, "DigitalZoomRatio": 1.0671316477768091, "SceneCaptureType": 0, "YCbCrPositioning": 1, "GPSDestBearingRef": "T", "ShutterSpeedValue": 4.100087796312555, "GPSImgDirectionRef": "T", "SubSecTimeOriginal": "847", "SubSecTimeDigitized": "847", "ExposureCompensation": 0, "FocalLengthIn35mmFormat": 31}	\N	0	2017-04-08 22:06:11.361586+02
728dfd10-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.325492+01	2016-02-11 17:23:24.831702+01	\N	59617435	59616961		http://cdn.rechat.co/59617435.jpg	32	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [24, 105, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF24-105mm f/4L IS USM", "CreateDate": 1454604303, "ModifyDate": "2016:02:05 08:46:54", "FocalLength": 58, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.005, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454604303, "LensSerialNumber": "0000311fa7", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 7.643856, "SubSecTimeOriginal": "44", "ExposureCompensation": 2, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361593+02
728dcdae-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.324289+01	2016-02-11 17:23:24.844741+01	\N	59617434	59616961		http://cdn.rechat.co/59617434.jpg	21	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454607381, "ModifyDate": "2016:02:05 08:49:21", "FocalLength": 25, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.25, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454607381, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 2, "SubSecTimeOriginal": "99", "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361594+02
728e277c-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.326599+01	2016-02-11 17:23:24.914996+01	\N	59617436	59616961		http://cdn.rechat.co/59617436.jpg	0	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454605936, "ModifyDate": "2016:02:05 08:47:35", "FocalLength": 23, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.05, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454605937, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 4.321928, "SubSecTimeOriginal": "23", "ExposureCompensation": 1, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361602+02
216f321c-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.983937+01	2016-02-15 20:33:43.265798+01	\N	59710356	59709556		http://cdn.rechat.co/59710356.jpg	17	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:33:06", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.48508+02
728e5382-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.327708+01	2016-02-11 17:23:24.954614+01	\N	59617437	59616961		http://cdn.rechat.co/59617437.jpg	22	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454607313, "ModifyDate": "2016:02:05 08:49:26", "FocalLength": 23, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 1, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454607314, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 0, "SubSecTimeOriginal": "98", "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361603+02
728d72b4-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.321959+01	2016-02-11 17:23:25.026076+01	\N	59617433	59616961		http://cdn.rechat.co/59617433.jpg	20	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454607445, "ModifyDate": "2016:02:05 08:49:18", "FocalLength": 23, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.25, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454607446, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 2, "SubSecTimeOriginal": "25", "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361604+02
728efe4a-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.332067+01	2016-02-11 17:23:24.637215+01	\N	59617441	59616961		http://cdn.rechat.co/59617441.jpg	24	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454607831, "ModifyDate": "2016:02:05 08:49:45", "FocalLength": 22, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.125, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454607831, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 3, "SubSecTimeOriginal": "54", "ExposureCompensation": 2, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361612+02
728ed65e-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.331024+01	2016-02-11 17:23:24.67602+01	\N	59617440	59616961		http://cdn.rechat.co/59617440.jpg	26	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454607635, "ModifyDate": "2016:02:05 08:49:40", "FocalLength": 22, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.025, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454607635, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 5.321928, "SubSecTimeOriginal": "16", "ExposureCompensation": 2, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361612+02
728e7cae-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.32878+01	2016-02-11 17:23:24.730841+01	\N	59617438	59616961		http://cdn.rechat.co/59617438.jpg	23	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454607592, "ModifyDate": "2016:02:05 08:49:31", "FocalLength": 35, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.03333333333333333, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454607592, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 4.906891, "SubSecTimeOriginal": "47", "ExposureCompensation": 2, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361613+02
728ea882-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.329896+01	2016-02-11 17:23:24.823203+01	\N	59617439	59616961		http://cdn.rechat.co/59617439.jpg	27	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454607616, "ModifyDate": "2016:02:05 08:49:36", "FocalLength": 22, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.03333333333333333, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454607616, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 4.906891, "SubSecTimeOriginal": "09", "ExposureCompensation": 2, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361615+02
728c75da-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.315418+01	2016-02-11 17:23:25.14758+01	\N	59617427	59616961		http://cdn.rechat.co/59617427.jpg	16	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454606668, "ModifyDate": "2016:02:05 08:48:54", "FocalLength": 23, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.025, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454606668, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 5.321928, "SubSecTimeOriginal": "52", "ExposureCompensation": -1, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361616+02
728ca582-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.316679+01	2016-02-11 17:23:25.078557+01	\N	59617428	59616961		http://cdn.rechat.co/59617428.jpg	14	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454608816, "ModifyDate": "2016:02:05 08:48:58", "FocalLength": 35, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.03333333333333333, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454608817, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 4.906891, "SubSecTimeOriginal": "07", "ExposureCompensation": -0.3333333333333333, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361616+02
728cdb4c-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.318063+01	2016-02-11 17:23:25.095899+01	\N	59617429	59616961		http://cdn.rechat.co/59617429.jpg	17	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454606686, "ModifyDate": "2016:02:05 08:49:02", "FocalLength": 22, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.06666666666666667, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454606686, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 3.906891, "SubSecTimeOriginal": "65", "ExposureCompensation": -1, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361623+02
728c0ea6-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.312789+01	2016-02-11 17:23:25.437025+01	\N	59617425	59616961		http://cdn.rechat.co/59617425.jpg	8	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 4, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454606425, "ModifyDate": "2016:02:05 08:48:47", "FocalLength": 40, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.0025, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 4, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454606425, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 8.643856, "SubSecTimeOriginal": "93", "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361624+02
728bc82e-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.310927+01	2016-02-11 17:23:25.465956+01	\N	59617424	59616961		http://cdn.rechat.co/59617424.jpg	6	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454608729, "ModifyDate": "2016:02:05 08:48:39", "FocalLength": 28, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.1, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454608729, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 3.321928, "SubSecTimeOriginal": "88", "ExposureCompensation": -0.3333333333333333, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361625+02
728c3d36-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.314009+01	2016-02-11 17:23:25.289517+01	\N	59617426	59616961		http://cdn.rechat.co/59617426.jpg	15	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454608769, "ModifyDate": "2016:02:05 08:48:50", "FocalLength": 23, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.07692307692307693, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454608769, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 3.70044, "SubSecTimeOriginal": "89", "ExposureCompensation": -0.3333333333333333, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361627+02
728b62b2-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.308405+01	2016-02-11 17:23:25.667178+01	\N	59617422	59616961		http://cdn.rechat.co/59617422.jpg	2	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454606291, "ModifyDate": "2016:02:05 08:48:27", "FocalLength": 28, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.025, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454606291, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 5.321928, "SubSecTimeOriginal": "81", "ExposureCompensation": 1, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361628+02
728b2cde-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.307043+01	2016-02-11 17:23:25.917052+01	\N	59617421	59616961		http://cdn.rechat.co/59617421.jpg	9	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454606249, "ModifyDate": "2016:02:05 08:48:26", "FocalLength": 22, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.025, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454606250, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 5.321928, "SubSecTimeOriginal": "12", "ExposureCompensation": 1, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361635+02
728af5fc-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.305661+01	2016-02-11 17:23:25.933577+01	\N	59617420	59616961		http://cdn.rechat.co/59617420.jpg	1	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454606181, "ModifyDate": "2016:02:05 08:48:16", "FocalLength": 22, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.025, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454606182, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 5.321928, "SubSecTimeOriginal": "27", "ExposureCompensation": 1, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361636+02
728ac460-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.304393+01	2016-02-11 17:23:25.937672+01	\N	59617419	59616961		http://cdn.rechat.co/59617419.jpg	5	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454606147, "ModifyDate": "2016:02:05 08:48:16", "FocalLength": 23, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.03333333333333333, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454606147, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 4.906891, "SubSecTimeOriginal": "67", "ExposureCompensation": 1, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361636+02
728b9854-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.30974+01	2016-02-11 17:23:25.784266+01	\N	59617423	59616961		http://cdn.rechat.co/59617423.jpg	7	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454606361, "ModifyDate": "2016:02:05 08:48:38", "FocalLength": 25, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.16666666666666666, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454606362, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 2.584963, "SubSecTimeOriginal": "37", "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361638+02
728a9c88-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.303285+01	2016-02-11 17:23:26.026526+01	\N	59617418	59616961		http://cdn.rechat.co/59617418.jpg	10	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454605753, "ModifyDate": "2016:02:05 08:47:15", "FocalLength": 22, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.25, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454605754, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 2, "SubSecTimeOriginal": "67", "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361638+02
728a6dd0-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.301782+01	2016-02-11 17:23:26.185577+01	\N	59617417	59616961		http://cdn.rechat.co/59617417.jpg	12	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454605702, "ModifyDate": "2016:02:05 08:47:05", "FocalLength": 30, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.06666666666666667, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454605702, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 3.906891, "SubSecTimeOriginal": "74", "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361639+02
7286e5de-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.279031+01	2016-02-11 17:23:26.317037+01	\N	59617416	59616961		http://cdn.rechat.co/59617416.jpg	11	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454605660, "ModifyDate": "2016:02:05 08:47:03", "FocalLength": 22, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.2, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454605661, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 2.321928, "SubSecTimeOriginal": "06", "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361649+02
72864cdc-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.275021+01	2016-02-11 17:23:26.743408+01	\N	59617413	59616961		http://cdn.rechat.co/59617413.jpg	3	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454606081, "ModifyDate": "2016:02:05 08:48:04", "FocalLength": 21, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.06666666666666667, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454606082, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 3.906891, "SubSecTimeOriginal": "08", "ExposureCompensation": 1, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.36165+02
7286b3c0-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.277731+01	2016-02-11 17:23:26.455765+01	\N	59617415	59616961		http://cdn.rechat.co/59617415.jpg	4	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454606116, "ModifyDate": "2016:02:05 08:48:05", "FocalLength": 23, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.05, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454606116, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 4.321928, "SubSecTimeOriginal": "71", "ExposureCompensation": 1, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.36165+02
7286804e-d03a-11e5-a20b-f23c91c841bd	2016-02-10 22:08:35.276386+01	2016-02-11 17:23:26.759952+01	\N	59617414	59616961		http://cdn.rechat.co/59617414.jpg	13	{"ISO": 100, "Make": "Canon", "Flash": 16, "Model": "Canon EOS 5D Mark III", "FNumber": 7.1, "LensInfo": [17, 40, null, null], "Software": "Adobe Photoshop Lightroom 6.0 (Macintosh)", "Copyright": "B)2015 Unique Exposure Photography", "LensModel": "EF17-40mm f/4L USM", "CreateDate": 1454605808, "ModifyDate": "2016:02:05 08:47:19", "FocalLength": 32, "Orientation": 1, "XResolution": 72, "YResolution": 72, "ExposureMode": 2, "ExposureTime": 0.125, "MeteringMode": 5, "SerialNumber": "032023005174", "WhiteBalance": 1, "ApertureValue": 5.655638, "CustomRendered": 0, "ResolutionUnit": 2, "ExposureProgram": 3, "SensitivityType": 2, "DateTimeOriginal": 1454605808, "LensSerialNumber": "0000000000", "MaxApertureValue": 4, "SceneCaptureType": 0, "ShutterSpeedValue": 3, "SubSecTimeOriginal": "88", "ExposureCompensation": 0, "FocalPlaneXResolution": 1600, "FocalPlaneYResolution": 1600, "FocalPlaneResolutionUnit": 3, "RecommendedExposureIndex": 100}	\N	0	2017-04-08 22:06:11.361652+02
938e3ba8-d3f8-11e5-b062-f23c91c841bd	2016-02-15 16:27:08.558859+01	2016-02-15 16:28:04.989456+01	\N	59702627	59698128		http://cdn.rechat.co/59702627.jpg	3	{}	\N	0	2017-04-08 22:06:04.294115+02
938cc138-d3f8-11e5-b062-f23c91c841bd	2016-02-15 16:27:08.549157+01	2016-02-15 16:28:05.521453+01	\N	59702624	59698128		http://cdn.rechat.co/59702624.jpg	0	{}	\N	0	2017-04-08 22:06:04.294115+02
938d60e8-d3f8-11e5-b062-f23c91c841bd	2016-02-15 16:27:08.553125+01	2016-02-15 16:28:06.093186+01	\N	59702625	59698128		http://cdn.rechat.co/59702625.jpg	1	{}	\N	0	2017-04-08 22:06:04.294116+02
938e64c0-d3f8-11e5-b062-f23c91c841bd	2016-02-15 16:27:08.559927+01	2016-02-15 16:28:06.702516+01	\N	59702628	59698128		http://cdn.rechat.co/59702628.jpg	4	{}	\N	0	2017-04-08 22:06:04.294116+02
938ec82a-d3f8-11e5-b062-f23c91c841bd	2016-02-15 16:27:08.562463+01	2016-02-15 16:28:07.706482+01	\N	59702630	59698128	Den	http://cdn.rechat.co/59702630.jpg	6	{}	\N	0	2017-04-08 22:06:04.294117+02
938ef8ea-d3f8-11e5-b062-f23c91c841bd	2016-02-15 16:27:08.563692+01	2016-02-15 16:28:08.708567+01	\N	59702631	59698128	Den	http://cdn.rechat.co/59702631.jpg	7	{}	\N	0	2017-04-08 22:06:04.294117+02
939003fc-d3f8-11e5-b062-f23c91c841bd	2016-02-15 16:27:08.570404+01	2016-02-15 16:28:09.801454+01	\N	59702636	59698128		http://cdn.rechat.co/59702636.jpg	12	{}	\N	0	2017-04-08 22:06:04.294118+02
938f9372-d3f8-11e5-b062-f23c91c841bd	2016-02-15 16:27:08.567639+01	2016-02-15 16:28:10.099885+01	\N	59702634	59698128		http://cdn.rechat.co/59702634.jpg	10	{}	\N	0	2017-04-08 22:06:04.294118+02
938fc5e0-d3f8-11e5-b062-f23c91c841bd	2016-02-15 16:27:08.568913+01	2016-02-15 16:27:54.186068+01	\N	59702635	59698128		http://cdn.rechat.co/59702635.jpg	11	{}	\N	0	2017-04-08 22:06:04.294325+02
938e01ce-d3f8-11e5-b062-f23c91c841bd	2016-02-15 16:27:08.55725+01	2016-02-15 16:27:59.942113+01	\N	59702626	59698128		http://cdn.rechat.co/59702626.jpg	2	{}	\N	0	2017-04-08 22:06:11.473821+02
938f2dce-d3f8-11e5-b062-f23c91c841bd	2016-02-15 16:27:08.565045+01	2016-02-15 16:28:07.071445+01	\N	59702632	59698128	Master Bedroom	http://cdn.rechat.co/59702632.jpg	8	{}	\N	0	2017-04-08 22:06:11.474436+02
216ed3a8-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.981521+01	2016-02-15 20:33:43.355604+01	\N	59710354	59709556		http://cdn.rechat.co/59710354.jpg	15	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:33:04", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485094+02
216ea6b2-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.980367+01	2016-02-15 20:33:43.379978+01	\N	59710353	59709556		http://cdn.rechat.co/59710353.jpg	14	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:33:04", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485095+02
216e4bea-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.978041+01	2016-02-15 20:33:43.54057+01	\N	59710351	59709556		http://cdn.rechat.co/59710351.jpg	12	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:33:02", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485095+02
216f0242-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.9827+01	2016-02-15 20:33:43.263659+01	\N	59710355	59709556		http://cdn.rechat.co/59710355.jpg	16	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:33:05", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485107+02
216e1a62-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.976763+01	2016-02-15 20:33:43.533469+01	\N	59710350	59709556		http://cdn.rechat.co/59710350.jpg	11	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:33:01", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485108+02
216d8e94-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.973154+01	2016-02-15 20:33:43.744758+01	\N	59710347	59709556		http://cdn.rechat.co/59710347.jpg	8	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:32:58", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485108+02
216dbd1a-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.974386+01	2016-02-15 20:33:43.802851+01	\N	59710348	59709556		http://cdn.rechat.co/59710348.jpg	9	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:32:59", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485109+02
216ce778-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.96891+01	2016-02-15 20:33:43.86266+01	\N	59710344	59709556		http://cdn.rechat.co/59710344.jpg	5	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:32:53", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485109+02
216cbb86-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.967783+01	2016-02-15 20:33:43.893535+01	\N	59710343	59709556		http://cdn.rechat.co/59710343.jpg	6	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:32:52", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.48511+02
216d583e-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.971783+01	2016-02-15 20:33:43.996522+01	\N	59710346	59709556		http://cdn.rechat.co/59710346.jpg	7	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:32:56", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.48511+02
216c8ddc-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.966619+01	2016-02-15 20:33:44.082702+01	\N	59710342	59709556		http://cdn.rechat.co/59710342.jpg	3	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:32:51", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485111+02
217043d2-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.991027+01	2016-02-15 20:33:43.012341+01	\N	59710362	59709556		http://cdn.rechat.co/59710362.jpg	23	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:33:12", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485145+02
216fbc50-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.987471+01	2016-02-15 20:33:43.235595+01	\N	59710359	59709556		http://cdn.rechat.co/59710359.jpg	22	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:33:08", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485146+02
216f8e60-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.986297+01	2016-02-15 20:33:44.795237+01	\N	59710358	59709556		http://cdn.rechat.co/59710358.jpg	19	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:33:08", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485147+02
216deb14-d41a-11e5-9582-f23c91c841bd	2016-02-15 20:27:19.975567+01	2016-02-15 20:33:47.296248+01	\N	59710349	59709556		http://cdn.rechat.co/59710349.jpg	10	{"Software": "Adobe Photoshop Lightroom 5.7 (Windows)", "ModifyDate": "2015:08:22 11:32:59", "XResolution": 72, "YResolution": 72, "ResolutionUnit": 2}	\N	0	2017-04-08 22:06:11.485235+02
49d9c904-a2e4-11e5-8de9-f23c91c841bd	2015-12-15 05:28:27.991914+01	2016-01-24 07:57:45.21778+01	\N	18182195	1441103		http://cdn.rechat.co/18182195.jpg	0	{}	\N	0	2017-04-08 22:05:48.497581+02
482efe58-a2e4-11e5-8de9-f23c91c841bd	2015-12-15 05:28:25.194841+01	2016-01-24 07:58:37.577044+01	\N	18181095	1462373		http://cdn.rechat.co/18181095.jpg	0	{}	\N	0	2017-04-08 22:05:49.627906+02
4810884c-a2e4-11e5-8de9-f23c91c841bd	2015-12-15 05:28:24.99525+01	2016-01-24 07:58:40.94434+01	\N	18181015	1463691		http://cdn.rechat.co/18181015.jpg	0	{}	\N	0	2017-04-08 22:05:49.627923+02
\.


--
-- Data for Name: properties; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY properties (id, bedroom_count, bathroom_count, address_id, description, square_meters, created_at, updated_at, matrix_unique_id, property_type, property_subtype, lot_square_meters, year_built, accessibility_features, commercial_features, community_features, energysaving_features, exterior_features, interior_features, farmranch_features, fireplace_features, lot_features, parking_features, pool_features, security_features, bedroom_bathroom_features, parking_spaces_covered_total, half_bathroom_count, full_bathroom_count, heating, flooring, utilities, utilities_other, architectural_style, structural_style, number_of_stories, number_of_stories_in_building, number_of_parking_spaces, parking_spaces_carport, parking_spaces_garage, garage_length, garage_width, number_of_dining_areas, number_of_living_areas, fireplaces_total, lot_number, soil_type, construction_materials, construction_materials_walls, foundation_details, roof, pool_yn, handicap_yn, elementary_school_name, intermediate_school_name, high_school_name, junior_high_school_name, middle_school_name, primary_school_name, senior_high_school_name, school_district, subdivision_name, appliances_yn, building_number, ceiling_height, green_building_certification, green_energy_efficient, lot_size, lot_size_area, lot_size_dimensions, map_coordinates, number_of_pets_allowed, number_of_units, pets_yn, photo_count, room_count, subdivided_yn, surface_rights, unit_count, year_built_details, zoning, security_system_yn, deleted_at, building_square_meters) FROM stdin;
dbb1fe44-c1f4-11e5-9606-f23c91c841bd	2	1	db2b568c-c1f4-11e5-9606-f23c91c841bd	UPDATED GLENRIDGE ESTATES COTTAGE!FANTASTIC KIT W/SOLID SURFACE COUNTERS, TILE BKSPLSH,REPLACED CABINETRY (SOME GLASSFRONT!) GRT APPLIANCES!HDWDS REFINISHED,WALLS FRESHLY PAINTED/TEXTURED,WINDOWS REPLACED.BEAUTIFUL OUT- DOOR LIVING SPACE W/DECK.SQ FOOTAGE SEEMS MUCH LARGER.DSL!ELEC UPDATED ALSO	97.3615756224451872	2016-01-23 18:15:10.672078+01	2016-01-23 18:15:10.672078+01	1463691	Residential	RES-Single Family	0	\N	{}	{}	{}	{"Gas Water Heater"}	{}	{Other,"Sound System Wiring"}	{}	{"Gas Starter","Wood Burning"}	{"Interior Lot"}	{Attached}	{}	{}	{}	2	\N	1	{"Central Air-Elec","Central Heat-Gas"}	{Wood}	{"City Sewer","City Water"}	{}	{Traditional}	Single Detached	1	\N	\N	1	1	\N	\N	1	1	1	7		Brick		Pier & Beam	Composition	f	f	Walnuthill		\N		Cary				GLENRIDGE ESTATES	f		\N			\N	\N	60 X 125	T	\N	\N	f	1	6	f		\N	Preowned		f	\N	\N
9c1dd5a0-bcc7-11e5-914b-f23c91c841bd	1	1	9bc473ca-bcc7-11e5-914b-f23c91c841bd	Great opportunity! one bedroom on the 7th floor in the south tower of the W residences. Open floor plan with great views of downtown and a spacious terrace area. Updated kitchen with Subzero Kupperbusch and Miela appliances. Floor to ceiling windows with Lutron electric shades. Exquisite furnishings. Pools, fitness club, concierge svc, valet parking and much more. Unit is being rehabbed with new flooring & fresh paint.You can pick your colors	124.117428465254562	2016-01-17 04:08:40.837918+01	2016-01-17 04:08:40.837918+01	2442473	Residential	RES-Condo	6669.16387959866279	\N	{}	{}	{"Common Elevator","Community Pool","Guarded Entrance",Sauna}	{"Ceiling Fans","Low E Windows"}	{}	{"Decorative Lighting","Electric Shades","Flat Screen Wiring","High Speed Internet Available"}	{}	{}	{}	{Other}	{}	{}	{}	1	\N	1	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,Wood}	{"City Sewer","City Water","Community Mailbox","Underground Utilities"}	{}	{Contemporary/Modern}	Condo/Townhome	1	\N	\N	\N	1	\N	\N	1	1	\N			Concrete		Slab	Composition	t	f	Houston		\N		Rusk			Dallas ISD	South Tower Residences	f		\N			1	1.64799999999999991		J	\N	\N	f	9	5	f		\N	Preowned		f	\N	\N
4b66cc84-bc95-11e5-92d4-f23c91c841bd	3	2.10000000000000009	4ac35a68-bc95-11e5-92d4-f23c91c841bd	BEAUTIFUL TRADITIONAL HOME IN A MATURE NEIGHBORHOOD; CIRCULAR DRIVE; FM DINING ROOM W BAYWINDOW; HUGH LR WITH WET BAR AND ICEMAKER; BUILT-INS IN FAMILY ROOM; NEW S STEEL APPLIANCES INSTALLED IN KITCHEN IN 2010; NEW AC UNITS INSTALLED IN 2010; NEW ROOF INTALLED IN 2012; LARGE BACK YARD WITH ARBOR-GAZEBO; STORAGE IN GARAGE; OWNER IS RECARPETING AND ADDING TERRAZZO TILE TO HOUSE; SIDE BY SIDE REFRIGERATOR IN UTILITY ROOM	287.997027127461934	2016-01-16 22:08:30.584138+01	2016-01-16 22:08:30.584138+01	1101151	Residential Lease	LSE-House	1173.57859531772579	\N	{}	{}	{}	{"Ceiling Fans"}	{"Covered Porch(es)",Deck,"Patio Covered","Satellite Dish","Sprinkler System"}	{"Bay Windows","Cable TV Available","Decorative Lighting","Flat Screen Wiring","High Speed Internet Available",Paneling,Skylights,"Vaulted Ceilings","Wet Bar"}	{}	{"Wood Burning"}	{"Lrg. Backyard Grass","Some Trees"}	{Garage,"Garage Door Opener"}	{}	{Burglar,"Carbon Monoxide Detector","Exterior Security Light(s)",Fire/Smoke,Monitored,"Smoke Detector"}	{}	2	1	2	{"Central Air-Elec","Central Heat-Elec","Heat Pump"}	{Carpet,"Ceramic Tile",Wood}	{"All Weather Road",Alley,"City Sewer","City Water",Sidewalk}	{}	{Traditional}	Single Detached	1	\N	\N	\N	\N	23	23	2	2	1	31		Brick,Wood				f	f	Prestonhol		\N		Franklin			Dallas ISD	Meadows 03	t		\N			\N	0.28999999999999998		M	\N	\N	f	2	11	f		\N	Preowned		f	\N	\N
c8266a92-ba9f-11e5-bb20-f23c91c841bd	\N	\N	c7dde498-ba9f-11e5-bb20-f23c91c841bd	Price Reduced! Single Family LOT $13 PSF DIM:50 X 150 in Historic District of Junius Heights. Price includes SOIL REPORT, SURVEY, Landmark commission approved Certificate of Appropriateness, Building Plans & Home Elevations for a 2,181 SQFT Home. Neighborhood allows even a 3,200 + SQFT home . Your chance to build a dream home in a Historic Neighborhood and not delay waiting on City Approvals. www.bablu.org Click Investments	0	2016-01-14 10:18:32.519137+01	2016-01-14 10:18:32.519137+01	49874310	Lots & Acreage	LND-Residential	696.767001114827281	\N	{}	{}	{}	{}	{}	{}	{}	{}	{"Interior Lot",Subdivision}	{}	{}	{}	{}	\N	\N	\N	{}	{}	{Alley,"City Sewer","City Water",Curbs,Sidewalk}	{Electric,"Natural Gas","No Water Meter"}	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	15						f	f	Lipscomb		\N		Long			Dallas ISD	Junius Heights	f		\N			\N	7500	50 X 150		\N	\N	f	23	\N	f		\N		Residential	f	\N	\N
2dbdbd5a-c31b-11e5-913c-f23c91c841bd	4	3.10000000000000009	2d7fc43c-c31b-11e5-913c-f23c91c841bd	Beautiful architectural details throughout! This home is elegant and comfortable with vaulted ceilings, neutral color tones and open floor plan! The upstairs game room overlooks the family room with fireplace  & views of the kitchen through beautiful window cutout. Master suite is located downstairs and has a large private bath. This home has been meticulously maintained! This home is approved for Homepath & HP Renovation Financing.	270.903010033444843	2016-01-25 05:22:00.36072+01	2016-01-25 05:22:00.36072+01	2119751	Residential	RES-Single Family	1096.68896321070247	\N	{}	{}	{"Gated Entrance"}	{}	{}	{"Decorative Lighting","Vaulted Ceilings"}	{}	{"Wood Burning"}	{"Interior Lot"}	{Attached,Covered,Front}	{}	{}	{}	2	1	3	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,"Ceramic Tile"}	{"City Sewer","City Water",Sidewalk}	{}	{}	Single Detached	2	\N	\N	\N	2	20	20	1	3	1	12		Brick		Slab	Composition	f	f	Leeumphre		\N	Young				Dallas ISD	Enchanted Villas	f		\N			\N	0.271000000000000019	101X117	W	\N	\N	f	7	11	f		\N	Preowned		f	\N	\N
022f23c4-c2f1-11e5-9af8-f23c91c841bd	\N	\N	017b87e2-c2f1-11e5-9af8-f23c91c841bd	Vacant Lot in good area and very good price, hableme en Espanol.para hacer un trato..(((Owner Financing))))asi de facil	0	2016-01-25 00:20:08.421307+01	2016-01-25 00:20:08.421307+01	1219390	Lots & Acreage	LND-Residential	946.488294314381278	\N	{}	{}	{}	{}	{}	{}	{}	{}	{}	{}	{}	{}	{}	\N	\N	\N	{}	{}	{"City Sewer","City Water"}	{"Cable Available","City Electric"}	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	11						f	f	Degolyer	Wilson	\N		Marsh			Dallas ISD	Webster Grove	f		\N			\N	10188	80X127	G	\N	\N	f	-1	\N	f		\N		Residential	f	\N	\N
cd907dc0-a40f-11e5-a8b8-f23c91c841bd	2	2.10000000000000009	c5ba66b0-a40f-11e5-a8b8-f23c91c841bd	Must see!  Exquisite fully renovated, 2 bedroom, 2.1 bath, custom home at the prestigious Drexel Highlander - with 2,255 interior square feet.  Direct elevator access into private entry foyer.  Stone flooring throughout.  Open kitchen with Wolf gas stove and double oven, Sub-Zero refrigerator and abundant custom cabinetry.  Hunter Douglas electric window shades throughout.  Amenities include concierge service, fitness center and swimming pool.	209.494611668524726	2015-12-16 17:12:28.492429+01	2016-02-08 18:33:09.983693+01	58615835	Residential	RES-Condo	2662.80936454849507	2004	{Elevator}	{}	{"Comm. Sprinkler System"}	{}	{}	{"Cable TV Available","Decorative Lighting","Electric Shades",Elevator,"Flat Screen Wiring","High Speed Internet Available",Other,"Sound System Wiring","Wet Bar","Window Coverings"}	{}	{Decorative}	{Landscaped}	{"Assigned Garage","Assigned Spaces",Attached,"Common Garage",Covered}	{"Cleaning System",Heated,"In Ground Gunite","Lap Pool"}	{}	{}	2	1	2	{"Central Air-Elec","Central Heat-Elec"}	{Marble,Other}	{"City Sewer","City Water"}	{}	{Contemporary/Modern}	Condo/Townhome	1	\N	\N	2	2	\N	\N	2	2	1	12B		Concrete		Pier & Beam	Tile/Slate	t	f	Milam		\N		Rusk			Dallas ISD	Drexel Highlander Condos	f		\N			1	0.658000000000000029			\N	\N	f	25	5	f		\N	Preowned		f	\N	\N
6ee3d4f4-c1f9-11e5-9b8c-f23c91c841bd	4	2.10000000000000009	6e8fb45a-c1f9-11e5-9b8c-f23c91c841bd	Two story traditional, 4-2.5-0, with pool and plenty of living space. This home has a wonderful lay-out with plenty of space for entertaining. Master bedroom and one additional bedroom on first floor and two bedrooms on 2nd floor. Ready for up-dating. Get ready for summer with this beautiful back-yard pool. This house should not be missed. Owners are MOTIVATED AND READY TO GO. ALL OFFERS WILL BE CONSIDERED AND REVIEWED.	249.628390932738768	2016-01-23 18:47:55.610468+01	2016-01-23 18:47:55.610468+01	2015306	Residential	RES-Single Family	0	\N	{}	{}	{}	{"Ceiling Fans","Double Pane Windows"}	{Gutters,"Patio Covered"}	{"Cable TV Available",Intercom,"Wet Bar"}	{}	{Brick,"Wood Burning"}	{"Interior Lot"}	{"Circle Drive",Front,Rear}	{"Cleaning System",Diving,Heated,"In Ground Gunite"}	{Monitored}	{}	\N	1	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,"Ceramic Tile",Laminate}	{Alley,"City Sewer","City Water",Concrete,Curbs,"Overhead Utilities",Sidewalk}	{}	{Traditional}	Single Detached	2	\N	\N	2	\N	\N	\N	2	3	1	2	Other	Brick		Pier & Beam,Slab	Composition	t	f	Rogers		\N		Franklin			Dallas ISD	Lovers Lane East	f		\N			\N	\N	77x100	C	\N	\N	f	1	14	f		\N	Preowned		t	\N	\N
0cb6d6ca-bc39-11e5-b04f-f23c91c841bd	3	2	0c491220-bc39-11e5-b04f-f23c91c841bd	Hard-to-find three bed, two bath in Rosemont School for under $200,000. Located one block south of Kessler Park in Kings Highway Conservation District . Bring your decorating ideas or add extra space to make this a dream home. Great features like wraparound porch, tall ceilings, hardwood floors, updated kitchen, separate utility room and spacious back yard.	125.975473801560767	2016-01-16 11:08:11.712911+01	2016-01-16 11:08:11.712911+01	2529072	Residential	RES-Single Family	728.428093645484978	\N	{}	{}	{}	{"Ceiling Fans"}	{"Covered Porch(es)",Deck}	{Other,"Window Coverings"}	{}	{Decorative}	{Corner,"Lrg. Backyard Grass","Some Trees"}	{None}	{}	{}	{}	\N	\N	2	{"Central Air-Elec","Central Heat-Gas"}	{"Ceramic Tile",Wood}	{"City Sewer","City Water",Curbs,Sidewalk}	{}	{Traditional}	Single Detached	1	\N	\N	\N	\N	\N	\N	1	1	2	20		Wood		Pier & Beam	Composition	f	f	Rosemont		\N		Greiner			Dallas ISD	Oak Cliff Annex	f		\N			\N	0.179999999999999993	50x150	B	\N	\N	f	20	9	f		\N	Preowned		f	\N	\N
2ea54e2a-c2d2-11e5-84f5-f23c91c841bd	1	1	2e153c0e-c2d2-11e5-84f5-f23c91c841bd		111.482720178372361	2016-01-24 20:39:28.617001+01	2016-01-24 20:39:28.617001+01	1375600	Residential Lease	LSE-Duplex	724.38127090301009	\N	{}	{}	{}	{}	{}	{}	{}	{}	{}	{Other}	{}	{}	{}	\N	\N	1	{}	{}	{}	{}	{}	Attached or 1/2 Duplex	1	\N	\N	\N	\N	\N	\N	1	1	\N	12						f	f	King		\N		Dade			Dallas ISD	J C Hugules & Clouds Wendelkin	f		\N			\N	0.178999999999999992	50X153	X	\N	\N	t	-1	\N	f		\N	Preowned		f	\N	\N
ff95786e-325b-11e5-b020-0a995b070205	3	2.10000000000000009	ff66bfa6-325b-11e5-b020-0a995b070205	3 bedroom 2.5 bath in Gated community in the prime of far north Dallas. Remodeled gourmet kitchen, beautiful hand-scraped hardwood floors & open floor plan make this a space you will enjoy coming home to. Separate master retreat with remodeled master bath is a must see.  Secondary bedrooms with Jack & Jill bath. Back patio & yard create an inviting space to entertain. Community pool, near walking trails, shopping & easy access to major highways.	199.646971386101825	2015-07-25 01:30:41.606277+02	2015-08-31 21:48:26.910183+02	55789812	Residential	RES-Single Family	485.618729096989966	\N	{}	{}	{"Community Pool","Gated Entrance","Guarded Entrance"}	{"Ceiling Fans","Gas Water Heater","Programmable Thermostat","Storm Door(s)","Thermo Windows"}	{Gutters,"Lighting System","Patio Open","Sprinkler System"}	{"Built-in Wine Cooler","Cable TV Available","High Speed Internet Available","Vaulted Ceilings","Window Coverings"}	{}	{"Gas Logs","Gas Starter"}	{Greenbelt,"Interior Lot",Irregular,"Some Trees",Subdivision}	{Attached,Opener,Rear}	{}	{Burglar,Fire/Smoke,Owned}	{}	2	1	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,"Ceramic Tile",Wood}	{Alley,"City Sewer","City Water",Curbs}	{}	{}	Single Detached	2	0	0	0	2	20	20	2	2	1	20		Brick		Slab	Composition	f	f	Jackson		\N		Frankford		Plano West	Plano ISD	Highland Creek Manor	f		0			0	0.119999999999999996			0	0	f	25	12	f		0	Preowned		t	\N	\N
8a18124c-c368-11e5-92b3-f23c91c841bd	3	2	89b06f84-c368-11e5-92b3-f23c91c841bd	Great buy on this very cute open floor plan, split bedrooms. Convenient to I-20. Will not last long, better hurry. Up to 3.5PC closing cost offer for home buyers. Buyer to verify all information.	157.93385358602751	2016-01-25 14:35:46.551261+01	2016-01-25 14:35:46.551261+01	1988905	Residential	RES-Single Family	0	\N	{}	{}	{}	{}	{Gutters,"Patio Open","Sprinkler System"}	{Other}	{}	{}	{"Interior Lot",Subdivision}	{Attached,Front}	{}	{}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,Vinyl}	{"City Sewer","City Water",Curbs,Sidewalk}	{}	{Traditional}	Single Detached	1	\N	\N	2	2	\N	\N	1	1	\N	7		Brick		Slab	Composition	f	f	Kleberg		\N		Seagoville			Dallas ISD	Arbor Ridge	f		\N			\N	\N	66x113	K	\N	\N	f	1	8	f		\N	Preowned		f	\N	\N
69d7a2b8-b88c-11e5-a56f-f23c91c841bd	3	3.20000000000000018	68410c8c-b88c-11e5-a56f-f23c91c841bd	Lrg crnr unit in heart of Oak Lawn, 1 blk frm Highland Park. Lrg encl yard, 5 patios & rooftop balc. Oak HW floors throughout; prewired for home theater. Lrg kitchen w walkin pantry feat granite counters & SS appl, incl dbl ovens with convection & wine cooler. Master ste feat bay windows, lrg walkin closet w storage, & bath w glass-enclosed shower w travertine marble. Lrg 1st floor bed & bath. Top flr is 2nd LA or 4th BR w half bath & access to**	272.761055369751034	2016-01-11 18:54:51.533525+01	2016-01-22 17:04:21.72007+01	58982074	Residential	RES-Condo	0	2006	{}	{}	{"Comm. Sprinkler System"}	{"Ceiling Fans","Energy Star Appliances","Programmable Thermostat"}	{Balcony,Gutters,"Lighting System","Patio Covered","Patio Open","Roof Top Deck/Patio","Sprinkler System"}	{"Bay Windows","Built-in Wine Cooler","Cable TV Available","Central Vac","Decorative Lighting","High Speed Internet Available","Multiple Staircases","Sound System Wiring"}	{}	{"Gas Logs","Gas Starter"}	{Corner,"Heavily Treed",Landscaped}	{Attached,Garage,"Garage Door Opener","On Street"}	{}	{Burglar,Fire/Smoke}	{}	2	2	3	{"Central Air-Elec","Central Heat-Gas","Window Unit",Zoned}	{Carpet,"Ceramic Tile",Wood}	{"City Sewer","City Water","Community Mailbox",Curbs,"Individual Gas Meter",Sidewalk}	{}	{Traditional}	Condo/Townhome	3	\N	\N	\N	2	20	20	1	2	1	1A		Brick,Common Wall		Slab	Composition	f	f	Milam		\N		Rusk			Dallas ISD	Donald H Gale Add	f		\N			\N	\N			\N	\N	f	23	13	f		\N	Preowned		t	\N	\N
5927d1ca-a50b-11e5-89c6-f23c91c841bd	2	2.10000000000000009	50be8f1a-a50b-11e5-89c6-f23c91c841bd	Luxury Living at its BEST! The Highlander is known for its attentive staff & superb location!  Privacy with Direct Elevator to your unit. Gourmet Kitchen - Subzero Refrigerator, Wolf 6 top gas burner. French Balconies South East View overlooking Highland Park & Downtown. 2 bedrooms with 10 ft ceilings. Master bath has double vanity, separate tub & shower. 2nd bedroom has private bath & large closet. 2 living areas & 2 assigned parking spaces.	217.762913415087354	2015-12-17 23:13:06.366148+01	2016-01-03 14:01:22.844277+01	58665269	Residential	RES-Condo	2662.80936454849507	2004	{Elevator,"Wide Doorways"}	{}	{"Common Elevator","Guarded Entrance"}	{}	{Other}	{"Built-in Wine Cooler","Cable TV Available","Decorative Lighting",Elevator,"Flat Screen Wiring","High Speed Internet Available","Window Coverings"}	{}	{"Gas Logs"}	{}	{"Assigned Spaces","Common Garage",Opener,"Shared Garage"}	{"In Ground Gunite"}	{Other}	{}	2	1	2	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,Stone,Wood}	{"City Sewer","City Water","Community Mailbox",Curbs,Sidewalk}	{}	{Traditional}	Condo/Townhome	1	9	\N	\N	2	1	1	1	2	1	12B	Unknown	Block		Other	Tile/Slate	t	t	Milam		\N		Rusk			Dallas ISD	Drexel Highlander Condo	f		\N			\N	0.658000000000000029			\N	\N	f	28	6	f		\N	Preowned		f	\N	\N
0f4cdde2-c1e5-11e5-a301-f23c91c841bd	3	2	0f0bd75c-c1e5-11e5-a301-f23c91c841bd	An Investor's DREAM at $259,900! Reduced over $145,000 from Original Listing Price and is now READY TO SELL. Bring Investors or First Time Home Buyers because this home is priced to sell. One of the lowest prices in the area. Charming home with wood floors throughout. 101x135 treed lot. Large deck for entertaining. Wonderful Family Home! Great Rental Property. PRIME location south of LBJ.	206.707543664065412	2016-01-23 16:22:05.303177+01	2016-01-23 16:22:05.303177+01	2065316	Residential	RES-Single Family	1266.65551839464888	\N	{}	{}	{}	{"Attic Fan","Gas Water Heater",Turbines}	{"Covered Porch(es)",Deck,Gutters,"Lighting System","Patio Open","Satellite Dish","Sprinkler System"}	{"Bay Windows","Cable TV Available","Decorative Lighting","Dry Bar","High Speed Internet Available",Paneling,"Plantation Shutters",Skylights,"Vaulted Ceilings",Wainscoting,"Window Coverings"}	{}	{Brick,"Gas Logs","Gas Starter","Wood Burning"}	{Landscaped,"Lrg. Backyard Grass","Some Trees"}	{Rear,Uncovered}	{}	{"Carbon Monoxide Detector",Pre-Wired,"Smoke Detector"}	{}	\N	\N	2	{"Central Air-Elec","Central Heat-Gas","Window Unit"}	{Brick/Adobe,Carpet,"Ceramic Tile",Wood}	{Asphalt,"City Sewer","City Water",Curbs,Sidewalk}	{}	{Ranch}	Single Detached	1	\N	\N	\N	\N	\N	\N	1	3	1	3	Clay	Brick,Wood		Pier & Beam	Composition	f	f	Pershing		\N		Franklin			Dallas ISD	Huffhines Hill	f		\N			\N	0.313	101X135	U	\N	\N	f	1	11	f		\N	Preowned		f	\N	\N
02f86300-a9c0-11e5-8893-f23c91c841bd	2	2.10000000000000009	019db172-a9c0-11e5-8893-f23c91c841bd	Two split bedroom, den and 2.1 baths at The Drexel Highlander. Direct elevator to your foyer guides you to an open living & dining room. Kitchen equipped with SS appliances including a 6 gas burner Wolf cook top, Sub-Zero Refrigerator,Ascot dishwasher,double convection ovens, microwave,granite counter top.Wonderful master bedroom with en-suite bath,2 sinks,separate shower,tub and large walk in closet. Enjoy 24 hr concierge, pool & fitness center.	200.018580453363086	2015-12-23 22:56:25.331074+01	2016-02-08 18:38:36.836563+01	58731414	Residential	RES-Condo	2662.80936454849507	2004	{}	{}	{"Community Pool","Gated Entrance"}	{}	{}	{"Cable TV Available",Elevator,"Flat Screen Wiring","High Speed Internet Available","Window Coverings"}	{}	{}	{Corner,Landscaped}	{"Assigned Spaces"}	{}	{"Carbon Monoxide Detector","Fire Sprinkler System",Fire/Smoke}	{}	2	1	2	{"Central Air-Elec","Central Heat-Elec",Zoned}	{Carpet,"Ceramic Tile"}	{"City Sewer","City Water"}	{}	{Traditional}	Condo/Townhome	1	\N	\N	2	2	\N	\N	1	2	\N	12B		Frame/Brick Trim		Other	Other	t	f	Milam		\N		Rusk			Dallas ISD	Drexel Highlander Condos	f		\N			0.5	0.658000000000000029			\N	\N	f	23	6	f		\N	Preowned		t	\N	\N
6a0b8c76-0f23-11e5-b3f9-0a95648eeb58	\N	\N	674b3270-0f23-11e5-a2e0-0a95648eeb58	Builders, what a great opportunity to build an affordable house on a developed lot. There are almost 300 more lots available. Some restrictions apply so call for more information. Purchaser to verify lot sizes and schools.	0	2015-06-10 05:47:28.207813+02	2015-10-02 15:16:34.048086+02	47867079	Lots & Acreage	LND-Residential	441.10367892976592	\N	{}	{}	{}	{}	{}	{}	{}	{}	{Subdivision}	{}	{}	{}	{}	\N	\N	\N	{}	{}	{"City Sewer","City Water"}	{"Other Utilities"}	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	20						f	f	Dunbar		\N		Anderson			Dallas ISD	W G Bowlings	f		\N			\N	0.109		R	\N	\N	f	-1	\N	f		\N		Residential	f	\N	\N
7fded1f4-cc63-11e5-913f-f23c91c841bd	2	2.10000000000000009	7f58e562-cc63-11e5-913f-f23c91c841bd	A must-see place to enjoy the best views & living experience Dallas offers! Newly updated bath, cabinets and paint. Exceptional downtown views from 25th Floor of W Residences North Tower. Amenities: 24-hour concierge & valet, W Hotel & resident lounges, Bliss Spa, exercise room, hotel & resident pools. Total SF includes 396 sf terrace. Buyer to verify all room measurements & HOA dues.	238.758825715347456	2016-02-06 00:52:22.379791+01	2016-02-08 16:09:22.932951+01	59529693	Residential	RES-Condo	6632.74247491638835	2004	{}	{}	{"Common Elevator","Community Pool","Guarded Entrance"}	{}	{Balcony}	{"Built-in Wine Cooler","Cable TV Available","Decorative Lighting","Electric Shades","Flat Screen Wiring","High Speed Internet Available","Sound System Wiring","Window Coverings"}	{}	{}	{}	{"Assigned Spaces"}	{Heated}	{"Carbon Monoxide Detector",Monitored}	{}	2	1	2	{"Central Air-Elec","Central Heat-Elec"}	{Stone}	{"City Sewer","City Water"}	{}	{Contemporary/Modern}	Condo/Townhome	1	\N	\N	\N	2	20	20	1	1	\N	11A		Other		Piered Beam Slab	Other	t	f	Houston		\N		Rusk			Dallas ISD	Residences	f		\N			1	1.63900000000000001			\N	\N	f	27	4	f		\N	Preowned		t	\N	\N
3369d720-d0db-11e5-b351-f23c91c841bd	1	2	32d3b42a-d0db-11e5-b351-f23c91c841bd	Rare Opportunity to own this Corner unit in the W North Tower with Breathtaking South, East and West Panoramic Views of Downtown! Luxury Finish with Floor to Ceiling Windows,Hardwood Floors,\r\nElectric Shades,Custom Window Treatments,Over-Sized Soaking Tub,Rain Shower,Spacious Kitchen Island with High-End Appliances,Built-in Refrigerator and Wine Cooler. 60' Terrace,2 Garage Spaces + Storage Unit. Study can easily be converted to 2nd bedroom.	189.613526570048322	2016-02-11 17:19:18.365219+01	2016-02-15 06:51:57.455513+01	59616961	Residential	RES-Condo	6669.16387959866279	2004	{}	{}	{"Club House","Comm. Sprinkler System","Common Elevator","Community Pool","Gated Entrance","Guarded Entrance",Sauna,Spa}	{}	{Balcony,"Covered Porch(es)","Patio Covered"}	{"Bay Windows","Built-in Wine Cooler","Cable TV Available","Decorative Lighting","Electric Shades","Flat Screen Wiring","High Speed Internet Available","Sound System Wiring","Window Coverings"}	{}	{}	{}	{"Assigned Garage","Assigned Spaces","Garage Under Building"}	{"Infinity Edge"}	{Burglar,"Carbon Monoxide Detector","Exterior Security Light(s)","Fire Sprinkler System",Fire/Smoke,Firewall(s),Monitored,Owned,Pre-Wired,"Smoke Detector"}	{}	2	\N	2	{"Central Air-Elec","Central Air-Gas","Central Heat-Elec","Central Heat-Gas"}	{"Ceramic Tile",Wood}	{"City Sewer","City Water"}	{}	{Contemporary/Modern,Traditional}	Condo/Townhome	1	\N	\N	\N	2	\N	\N	1	1	\N	11A	Unknown	Concrete		Other,Piered Beam Slab	Tar/Gravel	t	f	Houston		\N		Rusk			Dallas ISD	W Residences	f		\N			\N	1.64799999999999991			\N	\N	f	36	6	f		\N	Preowned		t	\N	\N
75829fc8-c2d2-11e5-84f5-f23c91c841bd	\N	\N	752c5384-c2d2-11e5-84f5-f23c91c841bd		0	2016-01-24 20:41:27.507989+01	2016-01-24 20:41:27.507989+01	1399174	Multi-Family	MUL-Full Duplex	1125.01672240802691	\N	{}	{}	{}	{}	{Gutters,"Lighting System","Patio Open"}	{Paneling,"Window Coverings"}	{}	{"Gas Starter","Wood Burning"}	{"Interior Lot",Landscaped,Subdivision}	{Detached,"Garage Door Opener",Rear}	{}	{}	{}	\N	\N	\N	{"Central Air-Elec","Central Heat-Elec"}	{Brick/Adobe,Carpet,"Ceramic Tile",Laminate,Vinyl}	{"City Sewer","City Water"}	{}	{}		1	\N	4	\N	\N	\N	\N	\N	\N	\N	9		Brick		Slab	Composition	f	f	Northwood		\N	Westwood				Richardson ISD	Northwood Park	f		\N			\N	0.278000000000000025	86X141	E	\N	2	f	-1	2	f		\N	Preowned		f	\N	3976
5680bac8-c260-11e5-9530-f23c91c841bd	3	2	5625cff0-c260-11e5-9530-f23c91c841bd	Three bedroom, 2 bath home. Priced to sell, located on quiet street with easy access to 190, needs a little TLC but priced below market. No disclosure or survey on file. Buyer to verify all information.	149.47974730583428	2016-01-24 07:04:32.85885+01	2016-01-24 07:04:32.85885+01	2025784	Residential	RES-Single Family	0	\N	{}	{}	{}	{}	{}	{Other}	{}	{}	{}	{Attached}	{}	{}	{}	2	\N	2	{"Central Air-Elec",Other}	{Other}	{"City Sewer"}	{}	{}	Single Detached	1	\N	\N	\N	2	\N	\N	1	1	1	7		Brick		Slab	Composition	f	f	Mcwhorter		\N		Polk			Carrollton-Farmers Branch ISD	Villas Midway Ph 02	f		\N			\N	\N	0.110	A	\N	\N	f	1	10	f		\N	Preowned		f	\N	\N
fd018b04-be12-11e5-a1cd-f23c91c841bd	2	2	fc4ff4fc-be12-11e5-a1cd-f23c91c841bd	Updated 3 story townhome in desirable North Oak Lawn area. 2 bedrooms and 3 bathroom. Property features updated open kitchen, hardwoods throughout, fire place, private patio and attached 2-car garage. Upstairs master includes updated master bath and walk-in closet.  Walking distance to restaurants, grocery store and more.	185.52582683017468	2016-01-18 19:40:46.808928+01	2016-01-19 08:04:02.571311+01	59097482	Residential	RES-Townhouse	744.615384615384642	2008	{}	{}	{}	{"Ceiling Fans"}	{Balcony,"Patio Open"}	{"Cable TV Available","High Speed Internet Available","Window Coverings"}	{}	{Brick}	{"Interior Lot"}	{Attached,Garage,"Garage Door Opener"}	{}	{}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Gas"}	{"Ceramic Tile",Wood}	{"City Sewer","City Water",Sidewalk}	{}	{Traditional}	Condo/Townhome	2	\N	\N	\N	2	\N	\N	\N	1	1	9		Brick,Rock/Stone		Slab	Composition	f	f	Milam		\N		Rusk			Dallas ISD	North Oak Lawn	f		\N			\N	0.183999999999999997			\N	\N	f	11	5	f		\N	Preowned		f	\N	\N
0f6e002e-c2cd-11e5-aa15-f23c91c841bd	4	2	0f26c704-c2cd-11e5-aa15-f23c91c841bd	Large 4-2-2 Charming. Professionally updated 1950's Brick Bungalow in Junius Heights!Great Floor Plan and Lots of closet space,Rare to the area!Recent updates: paint,refinished hardwoods,plumbing,electric. Charming Amenities include:claw foot tubs,interior & exterior beveled glass doors,10ft ceilings,huge front porch,abundant windows,Antique light fixtures,private rear porch,spaciouse entry,decorative-slate fireplace.  Ready to MOVE IN!	207.35785953177259	2016-01-24 20:02:48.761581+01	2016-01-24 20:02:48.761581+01	1311841	Residential Lease	LSE-House	0	\N	{}	{}	{}	{Other}	{"Covered Porch(es)"}	{"Decorative Lighting"}	{}	{Decorative}	{}	{"Individual Carport"}	{}	{}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,Wood}	{"City Sewer","City Water"}	{}	{Prairie}	Single Detached	2	\N	\N	\N	\N	\N	\N	1	2	1	16		Brick				f	f	Lipscomb		\N		Long			Dallas ISD	JUNIUS HEIGHTS	t		\N			\N	\N	50X150	C	\N	\N	t	1	11	f		\N	Preowned		f	\N	\N
57908b86-c171-11e5-a880-f23c91c841bd	4	2.10000000000000009	573e24a4-c171-11e5-a880-f23c91c841bd	Very nicely updated spacious home on a manicured landscape offers many upgrades thru-out. Equipped with formals,large new kitchen complete with granite overlooks the 2nd living space with FP, refinished original wood floors, tile bathrooms and dual vanities in mstr, 4th bdrm can be Game room with half bath. enclosed sun-room w spa with dual french doors to access the cozy backyard to the detached 2 car garage.	206.521739130434781	2016-01-23 02:33:44.921882+01	2016-01-23 02:33:44.921882+01	2351891	Residential	RES-Single Family	930.769230769230717	\N	{}	{}	{}	{"13-15 SEER AC","Ceiling Fans","Energy Star Appliances","Gas Water Heater"}	{"Covered Porch(es)",Deck}	{"Bay Windows","Cable TV Available","Decorative Lighting"}	{}	{Brick,Decorative,"Wood Burning"}	{"Heavily Treed","Interior Lot",Landscaped,Subdivision}	{Detached,Opener,Oversized,Rear}	{"Attached Spa","Separate Spa/Hot Tub"}	{}	{}	\N	1	2	{"Central Air-Elec","Central Heat-Gas",Zoned}	{Carpet,"Ceramic Tile",Wood}	{Alley,"City Sewer","City Water",Concrete,Curbs,Dirt,"Overhead Utilities",Sidewalk}	{}	{Traditional}	Single Detached	1	\N	\N	\N	2	20	20	2	2	1	15	Unknown	Brick,Wood		Pier & Beam	Composition	f	f	Tolbert		\N		Browne			Dallas ISD	Kimball Estates	f		\N			\N	0.23000000000000001		A	\N	\N	f	25	12	f		\N	Preowned		t	\N	\N
6b53219e-c2d2-11e5-84f5-f23c91c841bd	\N	\N	6b09f186-c2d2-11e5-84f5-f23c91c841bd	Great location, half a block east of Greenville Ave. Well maintained Fourplex. Balconies above. Ample parking in back.	0	2016-01-24 20:41:10.419528+01	2016-01-24 20:41:10.419528+01	1396847	Multi-Family	MUL-Fourplex	0	\N	{}	{}	{}	{}	{}	{"Cable TV Available"}	{}	{}	{}	{Rear}	{}	{}	{}	\N	\N	\N	{"Central Air-Elec","Central Heat-Gas"}	{Wood}	{Alley,Asphalt,"City Sewer","City Water"}	{}	{}		2	\N	8	\N	\N	\N	\N	\N	\N	\N	6		Brick		Pier & Beam	Composition	f	f	Leerobert		\N		Long			Dallas ISD	DELMAR HEIGHTS	f		\N			\N	\N	50X140	T	\N	4	f	1	1	f		\N	Preowned		f	\N	3614
f3c44814-c269-11e5-ba2b-f23c91c841bd	2	2	f3725702-c269-11e5-ba2b-f23c91c841bd	COMPLETELY REFURBISHED 2 BDRM/2 BATH/ MOVE-IN READY CONDO ON 1ST FLOOR IN QUIET/GATED/WELL MAINTAINED COMPLEX. RECENT CARPET, BLINDS, STOVE, PAINT 04/05. SPACIOUS STEP DOWN LR W/WBFP. MST BDRM W/FULL BATH & LARGE WIC. LGT/ BRIGHT KITCHEN W/STOVE/REFRIG/DW/PANTRY/BRKFST BAR. FRONT PARKING. GREAT	89.5577852099591354	2016-01-24 08:13:22.174616+01	2016-01-24 08:13:22.174616+01	1657963	Residential	RES-Condo	0	\N	{}	{}	{"Comm. Sprinkler System","Gated Entrance",Park}	{"Storm Door(s)"}	{"Patio Covered"}	{"Window Coverings"}	{}	{"Wood Burning"}	{Landscaped,"Some Trees"}	{"Assigned Spaces",Covered}	{}	{}	{}	1	\N	2	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,Vinyl}	{"City Sewer","City Water",Concrete,Curbs}	{}	{Other}	Condo/Townhome	1	\N	\N	1	\N	\N	\N	1	1	1		Unknown	Brick		Slab	Composition	f	f	Whiterock		\N		Lakehighla			Richardson ISD	SKILLMAN BEND CONDOMINIUM	f		\N			\N	\N	CONDO	S	\N	\N	f	1	8	f		\N	Preowned		f	\N	\N
e4a358dc-c2ca-11e5-9f0d-f23c91c841bd	\N	\N	e458a71a-c2ca-11e5-9f0d-f23c91c841bd	Located on I35 down from Laurel Land Cemetry.  Former auto repair and storage warehouse with an office and one bath.  Plenty of parking on side and back.  Storage yard in the back.  Zoning permits many other uses.	0	2016-01-24 19:47:17.975559+01	2016-01-24 19:47:17.975559+01	1157723	Commercial	COM-Sale	2571.34894091415845	\N	{}	{"Inside Storage","Outside Storage"}	{}	{}	{}	{}	{}	{}	{}	{"Fenced Open Lot"}	{}	{}	{}	\N	\N	\N	{"Central Air-Elec","Central Air-Gas","Central Heat-Elec"}	{Concrete}	{"City Sewer","City Water"}	{}	{}		1	\N	\N	\N	\N	\N	\N	\N	\N	\N	1a		Metal	Other	Slab	Other	f	f			\N						Parnian 02	f		\N			0.5	27678		V	\N	1	f	1	\N	f		\N	Preowned		f	\N	1792
68f779d6-3317-11e5-92b3-0a995b070205	3	2	68cb2f16-3317-11e5-92b3-0a995b070205	Nice home in a great neighborhood! Large living & dining area with vaulted ceiling and fireplace. Lots of closets!  Custom built-ins. Energy efficient. Awesome workshop (21x11) with workbench. Great for entertaining with pass through window from kitchen. Large covered patio. Oversized garage. Won't last! Buyer to pay survey. Multiple offers. Highest and best due by Tuesday, July 28 at noon.	148.736529171311787	2015-07-25 23:52:14.297704+02	2015-09-18 16:32:52.451954+02	55864068	Residential	RES-Single Family	975.28428093645482	1972	{}	{}	{}	{"Ceiling Fans","Electric Water Heater"}	{"Covered Porch(es)",Gardens,Gutters,"Patio Covered","Workshop w/Electric"}	{"Cable TV Available","High Speed Internet Available","Vaulted Ceilings","Window Coverings"}	{}	{Stone,"Wood Burning"}	{"Interior Lot",Landscaped,"Lrg. Backyard Grass","Some Trees",Subdivision}	{Attached,Garage,Rear}	{}	{}	{}	2	0	2	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,Vinyl}	{"City Sewer","City Water",Sidewalk}	{}	{Traditional}	Single Detached	1	0	0	0	2	21	22	2	2	1	28A		Brick,Rock/Stone		Slab	Composition	f	f	Gill		\N		Hill			Dallas ISD	Braeburn Glen	f		0			0	0.240999999999999992			0	0	f	20	7	f		0	Preowned		f	\N	\N
cd920d68-cb9a-11e5-b4c2-f23c91c841bd	5	7.29999999999999982	cd160c18-cb9a-11e5-b4c2-f23c91c841bd	30th floor of Victory Parks W Residence Tower. Step from elevator  to the secure entry, a sublime transition to Dallas defining penthouse, almost 11,000 sq ft of spatial symmetry finished with a fineness of detail that is striking yet unpretentious. Five bedrooms, seven full, three half baths, two living, two dining areas, fitness, massage rooms, media room & two studies. All surrounded by sky & skyline in glass-defined space w 12-ft ceilings	1096.89706428836871	2016-02-05 00:55:43.896566+01	2016-02-05 09:02:50.583339+01	59505817	Residential	RES-Condo	6669.16387959866279	2004	{}	{}	{"Comm. Sprinkler System","Common Elevator","Community Pool","Gated Entrance"}	{"Double Pane Windows","Programmable Thermostat","Tinted Windows","Variable Speed HVAC"}	{}	{"Built-in Wine Cooler","Cable TV Available","Dry Bar","Electric Shades","Flat Screen Wiring","High Speed Internet Available",Intercom,Paneling,"Plantation Shutters","Sound System Wiring","Wet Bar","Window Coverings"}	{}	{"Direct Vent","Gas Logs"}	{}	{"Assigned Spaces",Attached}	{}	{"Carbon Monoxide Detector","Fire Sprinkler System",Monitored,Owned,"Smoke Detector"}	{}	4	3	7	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,"Ceramic Tile",Stone,Wood}	{Curbs}	{}	{Contemporary/Modern}	Condo/Townhome	1	\N	\N	\N	4	\N	\N	2	2	3	11A		Other		Other	Other	t	f	Milam		\N		Spence			Dallas ISD	Residences	f		\N			\N	1.64799999999999991			\N	\N	f	11	16	f		\N	Preowned		t	\N	\N
2a158482-c1f7-11e5-8b8e-f23c91c841bd	4	3	297ab5a6-c1f7-11e5-8b8e-f23c91c841bd	GREAT HOME IN MOSS CREEK NORTH. MANY UPDATES, VERY OPEN FLOOR PLAN, VAULTED CEILINGS,VERY BRIGHT,GREAT FLOW.2BDRMS DOWN,2UP,3 LIVING AREAS, 2WET BARS,MASTER WITH BIG SEATING AREA,GREAT POOL WITH SPA,PALM TREES AND OTHER TREES, BIG GRASSY AREA, SIDE YARD WITH PLAY SET FOR CHILDREN.ELECTRIC GATE ACROSS DRIVEWAY! NEW GRANITE, NEW WINDOW TREATMENTS + MORE.PLANO SCHOOLS!WON'T LAST LONG!	364.548494983277635	2016-01-23 18:31:41.179821+01	2016-01-23 18:31:41.179821+01	1753662	Residential	RES-Single Family	0	\N	{Other}	{}	{Park,Playground,Tennis}	{"Ceiling Fans"}	{Gutters,"Lighting System","Patio Open","Satellite Dish","Sprinkler System"}	{"Cable TV Available","Decorative Lighting","Vaulted Ceilings","Window Coverings"}	{}	{"Gas Starter"}	{Corner,"Cul De Sac","Heavily Treed",Landscaped,Subdivision}	{Attached,Rear}	{"Attached Spa","Cleaning System",Heated}	{Owned}	{}	2	\N	3	{"Central Air-Elec","Central Heat-Gas",Zoned}	{Carpet,"Ceramic Tile"}	{"City Sewer","City Water"}	{}	{Contemporary/Modern,Traditional}	Single Detached	2	\N	\N	2	2	\N	\N	2	3	1		Other	Brick		Slab	Composition	t	f	Haggar		\N		Frankford		Planowest	Plano ISD	Moss Creek North	f		\N			\N	\N		B	\N	\N	f	1	14	f		\N	Preowned		t	\N	\N
6c16d084-c16b-11e5-8832-f23c91c841bd	2	2	6bc0a696-c16b-11e5-8832-f23c91c841bd	Sophisticated luxury loft near the central business district on the east side.  One of the finest properties in the area. Features gated entrance & secure perimeter entries, dedicated garage door entrance, extensive common area artwork, roof deck with a 360 degree unobstructed view including a spectacular downtown view, New York style parking garage, exercise room, swimming pool & fountain. Unit has finest material and equipment installed.	231.976960237829815	2016-01-23 01:51:22.375923+01	2016-01-23 01:51:22.375923+01	2272071	Residential	RES-Condo	4406.98996655518386	\N	{Elevator}	{}	{"Common Elevator","Community Pool","Gated Entrance","Perimeter Fencing"}	{"Thermo Windows"}	{Balcony,"Covered Porch(es)",Deck,Gardens,Gazebo/Pergola,"Lighting System","Outdoor Fireplace/Pit","Outdoor Living Center","Patio Open"}	{"Built-in Wine Cooler","Cable TV Available","Decorative Lighting","Electric Shades",Elevator,"Flat Screen Wiring","High Speed Internet Available",Skylights,"Vaulted Ceilings","Water Filter"}	{}	{}	{}	{"Assigned Spaces",Covered}	{}	{"Exterior Security Light(s)","Smoke Detector"}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Elec"}	{Marble,Wood}	{"City Sewer","City Water",Concrete,Curbs,Sidewalk}	{}	{Contemporary/Modern,Loft}	Condo/Townhome	1	4	\N	\N	2	14	44	1	1	\N		Unknown	Brick,Common Wall		Slab	Tar/Gravel	t	f	Ray		\N		Spence			Dallas ISD	Thirty Thirty Bryan Condo	f		\N			1	1.08899999999999997		H	\N	\N	f	1	8	f		\N	Preowned		t	\N	\N
84730ae8-ba8c-11e5-a6ab-f23c91c841bd	2	2.10000000000000009	8402e3c6-ba8c-11e5-a6ab-f23c91c841bd	Well-maintained, comfortable and spacious 2 level condo located less than 10 minutes from Baylor Hospital. Close to downtown and Swiss Avenue Historic District. Beautiful hardwood floor on the first level. Fireplaces in living room and master bedroom. Walk-in closets in both bedrooms. Private balcony. Two garage parking spaces. Washer, dryer and refrigerator included in the lease. Owner pays water bills.	116.12783351913788	2016-01-14 08:00:38.498368+01	2016-01-14 08:00:38.498368+01	50557280	Residential Lease	LSE-Condo/Townhome	3613.8127090301009	\N	{}	{}	{"Community Pool","Gated Entrance"}	{"Ceiling Fans","Double Pane Windows","Gas Water Heater"}	{Balcony}	{"Cable TV Available","High Speed Internet Available","Window Coverings"}	{}	{"Wood Burning"}	{}	{"Assigned Spaces","Shared Garage"}	{}	{Burglar,Fire/Smoke}	{}	2	1	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,"Ceramic Tile",Wood}	{"City Sewer","City Water"}	{}	{Traditional}	Condo/Townhome	2	\N	\N	\N	2	\N	\N	1	1	2	11A		Frame/Brick Trim				t	f	Lipscomb		\N		Long			Dallas ISD	Ascot Place Condos	t		\N			\N	0.893000000000000016			1	\N	t	19	9	f		\N	Preowned		t	\N	\N
335d4106-b88d-11e5-9634-f23c91c841bd	3	3.20000000000000018	3079aa9c-b88d-11e5-9634-f23c91c841bd	Large corner unit in heart of Oak Lawn, 1 blk frm Highland Park. Two patios on courtyard. Oak hardwood floors throughout; pre-wired for home theater. Large kitchen w walk-in pantry feat granite counters & SS appl, incl dbl ovens with convection & wine cooler. Master suite feat bay windows, large walk-in closet w storage, and bath w glass-enclosed shower w travertine marble. Top floor is 2nd LA or 4th BR w half bath & access to**	235.878855444072855	2016-01-11 19:00:29.631193+01	2016-01-22 17:04:21.841707+01	58982325	Residential	RES-Condo	0	2006	{}	{}	{"Comm. Sprinkler System"}	{"Ceiling Fans","Energy Star Appliances","Programmable Thermostat"}	{Balcony,Gutters,"Lighting System","Patio Covered","Patio Open","Roof Top Deck/Patio","Sprinkler System"}	{"Bay Windows","Built-in Wine Cooler","Cable TV Available","Central Vac","Decorative Lighting","High Speed Internet Available","Multiple Staircases","Sound System Wiring"}	{}	{"Gas Logs","Gas Starter"}	{Corner,"Heavily Treed",Landscaped}	{Attached,Garage,"Garage Door Opener","On Street"}	{}	{Burglar,Fire/Smoke}	{}	2	2	3	{"Central Air-Elec","Central Heat-Gas","Window Unit",Zoned}	{Carpet,"Ceramic Tile",Wood}	{"City Sewer","City Water","Community Mailbox",Curbs,"Individual Gas Meter",Sidewalk}	{}	{Traditional}	Condo/Townhome	3	\N	\N	\N	2	20	20	1	2	1	1A		Brick		Slab	Composition	f	f	Milam		\N		Rusk			Dallas ISD	Donald H Gale Add	f		\N			\N	\N			\N	\N	f	23	13	f		\N	Preowned		t	\N	\N
d6bc050a-d41a-11e5-bf12-f23c91c841bd	2	2.10000000000000009	d6361666-d41a-11e5-bf12-f23c91c841bd	Pristine W Dallas South Tower condo on the 8th floor with downtown views.1678 square feet interior + 245 sq ft of terrace.This open plan features eat in kitchen,Sub Zero,European cabinetry,Kupperbush,hardwood floors and floor to ceiling windows.Large master suite with spa like bathroom that leads into a walk in closet with A custom California closet system.Custom closets in guest room and hallway closet.Unit has excellent parking spaces.	178.651059085841695	2016-02-15 20:32:24.154762+01	2016-02-18 13:17:46.415603+01	59709556	Residential	RES-Condo	6632.74247491638835	2005	{}	{}	{}	{}	{}	{"Electric Shades","High Speed Internet Available"}	{}	{}	{}	{"Assigned Garage","Assigned Spaces","Shared Garage"}	{}	{}	{}	2	1	2	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,Stone,Wood}	{"Community Mailbox"}	{}	{Contemporary/Modern}	Hi Rise	1	\N	\N	\N	2	\N	\N	1	1	\N	11A		Concrete		Other	Other	t	f	Houston		\N		Rusk			Dallas ISD	South Tower Residences	f		\N			\N	1.63900000000000001			\N	\N	f	25	4	f		\N	Preowned		f	\N	0
e88fac6a-f7ec-11e4-b318-0a95648eeb58	3	2.10000000000000009	e8207750-f7ec-11e4-b937-0a95648eeb58	Built in 1911 for physician, David L. Bettison, this stately Prairie home is an impeccable example of the arts and crafts style and movement.  Featured on the 2013 Munger Place Home Tour, this intricately restored home boasts a gorgeous kitchen, unusual patterned and inlaid maple floors, richly stained woodwork, an enormous master suite, a charming sleeping porch, three fully updated and modernized bathrooms, and large, landscaped yard.	239.409141583054634	2015-05-11 16:49:21.401436+02	2015-08-03 22:43:19.45139+02	52656456	Residential	RES-Single Family	0	\N	{}	{}	{}	{"16+ SEER AC","Ceiling Fans","Energy Star Appliances"}	{Balcony,"Covered Deck","Covered Porch(es)",Gutters,"Patio Covered","Sprinkler System"}	{"Cable TV Available","Decorative Lighting","Dry Bar","High Speed Internet Available"}	{}	{Brick,"Gas Logs"}	{"Interior Lot",Landscaped,"Lrg. Backyard Grass"}	{Front}	{}	{Burglar,"Carbon Monoxide Detector",Fire/Smoke,Monitored}	{}	0	1	2	{"Central Air-Elec","Central Heat-Gas",Zoned}	{"Ceramic Tile",Stone,Wood}	{Alley,"City Sewer","City Water",Concrete,Curbs,"Individual Gas Meter","Individual Water Meter"}	{}	{Prairie}	Historical/Conservation Dist.,Single Detached	2	0	0	0	0	0	0	2	3	1	14		Siding,Wood		Pier & Beam	Composition	f	f	Lipscomb		\N		Long			Dallas ISD	Munger Place	f		0		Low Flow Fixtures,Rain / Freeze Sensors	0	0	56X122		0	0	f	25	9	f		0	Preowned		t	\N	\N
63824fc6-c219-11e5-b5d8-f23c91c841bd	2	2.10000000000000009	63334408-c219-11e5-b5d8-f23c91c841bd	Located in the heart of Oaklawn, this fantastic 3-level Townhome is move-in ready for the ultimate In-Town living experience. Features include Granite, Slate, Stainless- Steel Appliances, Hardwood Flooring, Pre- Wired U-Verse, and Security. Study doubles as Home Office or Additional Bedroom. Balconies with views and on-site Private Pool make this Townhome nothing short of Amazing!!	151.244890375325156	2016-01-23 22:36:40.411928+01	2016-01-23 22:36:40.411928+01	1379463	Residential Lease	LSE-Condo/Townhome	10242.5083612040144	\N	{}	{}	{"Comm. Sprinkler System","Community Pool"}	{"Ceiling Fans","Gas Water Heater","Insulated Doors","Thermo Windows"}	{Balcony,Gutters,"Lighting System","Sprinkler System"}	{"Cable TV Available","Decorative Lighting","High Speed Internet Available","Plantation Shutters"}	{}	{}	{"Some Trees"}	{Garage,"Garage Door Opener"}	{"Cleaning System","In Ground Gunite","Pool Perimeter Fence"}	{Burglar,"Carbon Monoxide Detector","Exterior Security Light(s)","Fire Sprinkler System",Firewall(s),Pre-Wired,"Smoke Detector"}	{}	2	1	2	{"Central Air-Elec","Central Heat-Gas",Zoned}	{Carpet,Stone,Wood}	{"City Sewer","City Water",Concrete,Curbs,"Overhead Utilities",Sidewalk}	{}	{Contemporary/Modern,"Split Level"}	Condo/Townhome	3	\N	\N	\N	2	20	20	1	1	\N			Brick,Fiber Cement,Other				t	f	Houston		\N		Rusk			Dallas ISD	Palo Alto Twnhms Condo	t		\N			\N	2.53100000000000014		D	1	\N	t	1	10	f		\N	Preowned		t	\N	\N
f5ee1bdc-ba9a-11e5-87de-f23c91c841bd	4	4.09999999999999964	f58e13c2-ba9a-11e5-87de-f23c91c841bd	Stunning custom Mediterranean home on family-friendly street in Lakewood proper. 4585 sq ft of elegant finish outs including dream kitchen w stnlss appliances, travertine, hrdwds, exposed beams, 2 stone FPs, custom shutters and tile roof (C3). Features 4 BRs, 4.5 BAs, 3 LAs, study, game room, media room and beautiful landscaping. Perfect location 2 blks to exemplary Lakewood elementary-park, 12 min to downtown, 1.6 mi to lake, 1 mi to Whole Foods	425.956893348197696	2016-01-14 09:44:01.841445+01	2016-01-14 09:44:01.841445+01	50791870	Residential	RES-Single Family	700.100334448160538	\N	{}	{}	{}	{"Ceiling Fans","Double Pane Windows","Energy Star Appliances","Programmable Thermostat","Storm Window(s)","Tankless Water Heater","Thermo Windows"}	{"Covered Deck","Covered Porch(es)"}	{"Plantation Shutters"}	{}	{"Gas Logs","Gas Starter"}	{Landscaped,"Some Trees"}	{Attached,Front}	{}	{Burglar,"Exterior Security Light(s)",Pre-Wired,Wireless}	{}	4	1	4	{"Central Air-Elec","Central Heat-Gas",Zoned}	{Carpet,Wood}	{"City Sewer","City Water",Curbs,Sidewalk}	{}	{Mediterranean}	Single Detached	2	\N	\N	\N	2	22	25	2	3	2	4	Unknown	Stucco		Slab	Tile/Slate	f	f	Lakewood		\N		Long			Dallas ISD	Lakewood Estates	f		\N			\N	0.172999999999999987	59x125		\N	\N	f	25	11	f		\N	Preowned		t	\N	\N
ca2dd3f6-ba5f-11e5-a555-f23c91c841bd	3	2	c9c064a6-ba5f-11e5-a555-f23c91c841bd	Gorgeous home updated throughout great for entertaining inside & out. High ceilings, large downstairs living & \r\ndining room open to eat-in kitchen with cherry cabinets & SS appliances. Large upstairs suite with skylights & vaulted ceiling.  Huge master bedroom down, bath with trav & granite, jetted tub & separate vanities w ample storage. Step out the back to huge deck w flagstone paths. Over-sized garage protected by electronic gated drive.	191.192865105908595	2016-01-14 02:40:28.132237+01	2016-01-14 02:40:28.132237+01	51490207	Residential	RES-Single Family	0	\N	{}	{}	{}	{}	{Balcony,Deck,Gutters,"Lighting System"}	{"Decorative Lighting",Skylights,"Vaulted Ceilings"}	{}	{"Gas Logs"}	{"Interior Lot","Some Trees"}	{Detached,Garage}	{}	{Burglar,Fire/Smoke}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,Stone,Wood}	{"City Sewer","City Water",Concrete,Curbs,Sidewalk}	{}	{Prairie,Traditional}	Historical/Conservation Dist.,Single Detached	2	\N	\N	2	2	24	21	1	2	1			Brick		Pier & Beam	Composition	f	f	Leerobert		\N		Long			Dallas ISD	Belmont Suburban	f		\N			\N	\N	60 x 175		\N	\N	f	20	9	f		\N	Preowned		t	\N	\N
8d4008de-9ecf-11e5-8199-f23c91c841bd	1	1.10000000000000009	8ad20322-9ecf-11e5-8199-f23c91c841bd	Superb 1 BR condo in The Crestpark. Wonderfully updated in the last couple of years - fabulous kitchen, pretty hardwoods, great built-ins, Nicely master bath and powder room. 7th floor unit with downtown view.	96.0609438870308452	2015-12-10 00:49:56.986539+01	2016-01-04 15:53:40.542635+01	58545058	Residential	RES-Condo	14192.2073578595337	1950	{Elevator}	{}	{"Community Pool"}	{}	{}	{"Bay Windows"}	{}	{Brick}	{}	{Attached,"Common Garage"}	{}	{}	{}	1	1	1	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,Wood}	{"City Water"}	{}	{}	Condo/Townhome	1	\N	\N	\N	1	\N	\N	1	1	1	6A		Brick		Basement	Tar/Gravel	f	t	Bradfield	Mcculloch	\N		Highlandpa			Highland Park ISD	Crestpark Highland Park Condo	f		\N			\N	3.50700000000000012			\N	\N	f	25	4	f		\N	Preowned		t	\N	\N
77358c56-c1f9-11e5-9b8c-f23c91c841bd	3	2.10000000000000009	76d726ca-c1f9-11e5-9b8c-f23c91c841bd	Exceptional JuNel split level home on oversized private lot. 3 bedrooms, 2.5 bath home w-3 living areas is perfect for entertaining or for families. Everything has been updated w-discriminating taste: Ebony-stained maple floors downstairs leading to stained concrete outdoor spaces. Open kitchen & living area w-granite counters, stainless, Jenn-Air & Subzero appliances & original teak cabinets & built-ins. Floating staircase leads to upper living	208.658491267186946	2016-01-23 18:48:09.567876+01	2016-01-23 18:48:09.567876+01	2034018	Residential	RES-Single Family	991.471571906354598	\N	{}	{}	{}	{"Ceiling Fans","Gas Water Heater","Programmable Thermostat",Turbines}	{Gutters,"Lighting System","Patio Open","Sprinkler System","Storage Building"}	{"Decorative Lighting",Skylights,"Wet Bar"}	{}	{"Wood Burning"}	{"Adjacent to Greenbelt","Heavily Treed","Interior Lot",Landscaped,"Lrg. Backyard Grass","Tank/ Pond"}	{Attached}	{}	{Burglar,"Smoke Detector"}	{}	2	1	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,Concrete,Stone,Wood}	{"City Sewer","City Water"}	{}	{Contemporary/Modern}	Single Detached	2	\N	\N	\N	2	\N	\N	1	3	1	11		Brick		Pier & Beam	Composition	f	f	Hotchkiss		\N		Franklin			Dallas ISD	University Manor	f		\N			\N	0.244999999999999996	80X127	X	\N	\N	f	1	13	f		\N	Preowned		t	\N	\N
732ff23a-b48a-11e5-b2ad-f23c91c841bd	1	1.10000000000000009	71a39b6a-b48a-11e5-b2ad-f23c91c841bd	Nikko Condominiums is comprised of 30 boutique residences priced from mid $200,000 - $300,000. The building is nestled in a tree-lined street steps away from Whole Foods.  Convenient access to all major attractions of town and Dallas Love Field Airport make Nikko a great location for anyone seeking a lock-and-leave lifestyle.  Open floor plans and modern finishes add the finishing touches making Nikko Condominiums a must see for your buyers.	106.465997770345609	2016-01-06 16:30:43.566805+01	2016-01-14 15:04:37.895671+01	58913859	Residential	RES-Condo	0	2008	{}	{}	{}	{}	{Balcony}	{"Cable TV Available","High Speed Internet Available","Window Coverings"}	{}	{}	{}	{"Assigned Garage",Uncovered}	{}	{Burglar,"Fire Sprinkler System",Pre-Wired}	{}	\N	1	1	{"Central Air-Elec","Central Heat-Elec"}	{Wood}	{"City Sewer","City Water"}	{}	{Contemporary/Modern}	Condo/Townhome	1	4	\N	\N	1	\N	\N	\N	1	\N			Concrete,Stucco,Wood		Slab	Built-Up	f	f	Milam		\N		Rusk			Dallas ISD	Nikko Condominiums	f		\N			\N	\N			\N	\N	f	9	1	f		\N	Preowned		t	\N	\N
2adae04a-bb2d-11e5-b859-f23c91c841bd	4	2	2a4e9f68-bb2d-11e5-b859-f23c91c841bd	Beautifully newly updated 4 bedroom 2 bath home. Contemporary paint, new carpet, wood laminate flooring in wet areas, updated fixtures and more the home looks brand new inside! Home provides a spacious floorplan on a corner lot. Must see.	131.921218877740614	2016-01-15 03:10:37.157324+01	2016-01-15 03:10:37.157324+01	49605397	Residential	RES-Single Family	0	\N	{}	{}	{}	{}	{}	{"Cable TV Available","High Speed Internet Available","Window Coverings"}	{}	{}	{}	{Garage}	{}	{}	{}	1	\N	2	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,Laminate}	{"City Sewer",Concrete,Curbs,Sidewalk}	{}	{}	Single Detached	1	\N	\N	\N	1	\N	\N	1	1	\N	19B		Frame/Brick Trim		Slab	Composition	f	f	Burleson		\N		Comstock			Dallas ISD	Rustic Hills Rev	f		\N			0.5	0.170000000000000012			\N	\N	f	17	\N	f		\N	Preowned		f	\N	\N
5580dd58-c281-11e5-a984-f23c91c841bd	4	2	5532f5f2-c281-11e5-a984-f23c91c841bd	Close by OCT31 & request 3.5% of final sales price to be used as closing cost assistance! Selling agents may receive a bonus. Check HomePath site special offers for more details. Eligibility restricitions apply. Investor's delight! Large 2 story home with loads of potential! Lots of shade trees on large corner lot. Covered patio with deck, converted garage, carport, spacious rooms, living area with fireplace and much more!	226.867335562987762	2016-01-24 11:00:44.574268+01	2016-01-24 11:00:44.574268+01	2248275	Residential	RES-Single Family	1282.84280936454866	\N	{}	{}	{}	{}	{Deck,"Patio Covered","Sprinkler System"}	{"Cable TV Available"}	{}	{Brick,"Gas Starter","Wood Burning"}	{Corner,Landscaped,"Some Trees",Subdivision}	{Covered,"Garage Conversion",Rear}	{}	{}	{}	2	\N	2	{"Central Heat-Gas","No Air"}	{Carpet,"Ceramic Tile"}	{"City Sewer","City Water",Curbs,Sidewalk}	{}	{Traditional}	Single Detached	2	\N	\N	2	\N	\N	\N	1	2	1	1		Brick,Siding		Slab	Composition	f	f	Gill		\N		Hill			Dallas ISD	Braeburn Glen	f		\N			\N	0.317000000000000004	100X118	F	\N	\N	f	8	10	f		\N	Preowned		f	\N	\N
647e3cf0-bce7-11e5-aa38-f23c91c841bd	2	2	6463e77e-bce7-11e5-aa38-f23c91c841bd	There is ONLY ONE 3525 and it is by far the most recognized address in Dallas. Unique opportunity to purchase a rarely available upper floor  E unit. The main reasons are the view and the very usable floorplan. This unit has just been redone by Alex and Tony Rossi with NEW Wood Floors, Carpet, Tile, Trim, Paint, and a all New kitchen.. BRING ALL OFFERS...	185.154217762913419	2016-01-17 07:56:11.412621+01	2016-01-17 07:56:11.412621+01	2445371	Residential	RES-Condo	11428.2274247491641	\N	{}	{}	{"Comm. Sprinkler System","Common Elevator","Community Pool","Guarded Entrance",Laundry,Sauna}	{}	{}	{"Cable TV Available",Elevator}	{}	{}	{}	{Other}	{}	{}	{}	2	\N	2	{Other,Zoned}	{"Ceramic Tile",Wood}	{"City Sewer","City Water",Concrete,Curbs,Sidewalk}	{}	{}	Hi Rise	1	\N	\N	\N	2	35	10	2	1	1			Other		Other	Other	t	f	Milam		\N		Spence			Dallas ISD	Condo 3525	f		\N			1	2.82399999999999984		X	\N	\N	f	-1	7	f		\N	Preowned		f	\N	\N
03b3b586-c1f5-11e5-9606-f23c91c841bd	4	4.20000000000000018	0347f1ca-c1f5-11e5-9606-f23c91c841bd	Wonderful home - can be Southwestern Contemporary, etc. Slate floors. Lots of glass overlooking pool/beautiful landscaping. Large kitchen & breakfast room opens to side yard. Wet bar with wine cooler. This home is perfect for entertaining and offers privacy with a separate master and study.	420.754366406540328	2016-01-23 18:16:17.791878+01	2016-01-23 18:16:17.791878+01	1569942	Residential	RES-Single Family	0	\N	{}	{}	{}	{}	{"Patio Open","Sprinkler System"}	{"Wet Bar"}	{}	{"Wood Burning"}	{"Interior Lot",Landscaped}	{Attached}	{"Attached Spa","In Ground Gunite"}	{Burglar,Fire/Smoke}	{}	2	2	4	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,Slate}	{"City Sewer","City Water"}	{}	{Traditional}	Single Detached	1	\N	\N	\N	2	\N	\N	2	3	2	8B0		Brick		Slab	Tile/Slate	t	f	Prestonhol		\N		Franklin			Dallas ISD	LOUGHMILLERS	f		\N			\N	\N	130X150	K	\N	\N	f	1	13	f		\N	Preowned		t	\N	\N
575f478e-c175-11e5-8a87-f23c91c841bd	3	2	56ea26d4-c175-11e5-8a87-f23c91c841bd	Charming Drive Up  Rare, cul de sac creek lot. Adorable 3.2.2 cottage. Towering trees, herb garden, designer colors with skip trowell walls,open kitchen, granite inlaid tile backsplash, gas cooktop,beautiful views to oversized yard.  Recently freshened hardwoods.Ceramic tile flooring in kitchen,breakfast and second living area.  Beautifully updated  hall bathroom. Wonderful flow with views of yard from two bedrooms, kitchen and breakfast area.	146.042363433667788	2016-01-23 03:02:22.585833+01	2016-01-23 03:02:22.585833+01	2412482	Residential	RES-Single Family	0	\N	{}	{}	{}	{"Ceiling Fans","Gas Water Heater"}	{Gutters,"Lighting System","Patio Open"}	{"Cable TV Available","Decorative Lighting","High Speed Internet Available",Other}	{}	{}	{Creek,"Cul De Sac","Heavily Treed","Interior Lot",Landscaped,"Lrg. Backyard Grass"}	{Attached,Covered,Front}	{}	{Burglar}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Gas"}	{"Ceramic Tile",Wood}	{"City Sewer","City Water",Curbs,Sidewalk}	{}	{Traditional}	Single Detached	1	\N	\N	\N	2	\N	\N	2	2	\N	2	Other	Brick		Pier & Beam	Composition	f	f	Reinhardt		\N		Gaston			Dallas ISD	Ferguson Heights	f		\N			\N	\N	TBV	Q	\N	\N	f	24	10	f		\N	Preowned		t	\N	\N
7f8f0864-b326-11e5-9d3c-f23c91c841bd	1	1	7dee0712-b326-11e5-9d3c-f23c91c841bd	Gorgeous one bedroom one bath plus study condo in prime downtown LOCATION in the heart of Victory Park, House of Blues, area-site of American Airlines Center with a spectacular view from your fifth floor balcony. Walk to Harwood District, Katy Trail. Contemporary finish out, open kitchen with SS appliances & natural stone countertops. \r\nEnjoy the amenities of the community, Concierge, pool, sun deck, fitness & garage parking.New Carpet,Paint,etc	80.267558528428097	2016-01-04 22:02:43.487233+01	2016-02-15 19:43:42.003774+01	58870994	Residential	RES-Condo	3690.70234113712422	2005	{}	{}	{"Community Pool","Gated Entrance"}	{"Ceiling Fans","Double Pane Windows"}	{Balcony}	{"Cable TV Available",Elevator,"High Speed Internet Available",Other}	{}	{}	{Landscaped}	{"Assigned Spaces",Attached}	{}	{}	{}	1	\N	1	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,"Ceramic Tile",Wood}	{"City Sewer","City Water",Sidewalk}	{}	{Contemporary/Modern}	Condo/Townhome	1	\N	\N	\N	1	\N	\N	1	1	\N	4		Brick		Other	Other	t	f	Central		\N		Rusk			Dallas ISD	Terrace Condos	f		\N			\N	0.912000000000000033			\N	\N	f	31	5	f		\N	Preowned		t	\N	\N
34bec076-9eb9-11e5-a82d-f23c91c841bd	1	2	2f265020-9eb9-11e5-a82d-f23c91c841bd	Stunning sunset views from large terrace that overlooks the pool!  One bed unit with study and two full baths includes wall mounted flat screen TV’s, and washer-dryer.  European kitchen with SS appl opens to LA with floor to ceiling windows.  Large master faces west and offers gorgeous sunset views. Master bath has oversized soaking tub, marble floors and counters, huge customized master closet and additional storage closet off the patio.	107.859531772575252	2015-12-09 22:09:59.57164+01	2016-02-02 18:13:17.051433+01	58544147	Residential	RES-Condo	6632.74247491638835	2005	{"Meets ADA Requirements"}	{}	{"Comm. Sprinkler System","Common Elevator","Community Pool","Guarded Entrance",Other,Sauna,Spa}	{"Insulated Doors","Thermo Windows","Tinted Windows"}	{Balcony,"Lighting System","Patio Covered","Sprinkler System"}	{"Cable TV Available","Decorative Lighting","Flat Screen Wiring","High Speed Internet Available","Window Coverings"}	{}	{}	{}	{"Assigned Garage",Covered}	{}	{}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,Marble,Wood}	{"City Sewer","City Water","Community Mailbox",Concrete,Curbs,Sidewalk,"Underground Utilities"}	{}	{Contemporary/Modern}	Condo/Townhome,Hi Rise	1	\N	\N	\N	2	\N	\N	1	1	\N	11A	Unknown	Common Wall,Concrete,Fiber Cement,Other,Rock/Stone		Other	Other	t	t	Houston		\N		Rusk			Dallas ISD	Victory Plaza	f		\N			\N	1.63900000000000001			\N	\N	f	12	4	f		\N	Preowned		t	\N	\N
1aeef592-c16b-11e5-8832-f23c91c841bd	5	2.10000000000000009	1a486268-c16b-11e5-8832-f23c91c841bd	LARGE 5 BEDROOM HOME, TWO LARGE LIVING AERAS, ZONED AC-HEAT, NEWISH PAINT, NEWISH DIGITAL THERMOSTATS, NEEDS SOME UPDATING. PRICED TO SELL NOW, WAY BELOW CURRENT APPRAISAL. THIS IS A WONDERFUL HOME THAT NEEDS A FAMILY TO ENJOY IT. GREAT VIEWS OF THE HILLS BEHIND HOME. MOVE IN READY.	232.998885172798225	2016-01-23 01:49:06.219134+01	2016-01-23 01:49:06.219134+01	2203370	Residential	RES-Single Family	724.38127090301009	\N	{}	{}	{Other}	{"Ceiling Fans","Double Pane Windows","Gas Water Heater",Other,"Programmable Thermostat"}	{Other,Gutters,"Patio Open","Sprinkler System"}	{"Cable TV Available","Decorative Lighting",Other}	{Other}	{Brick,"Gas Starter",Other}	{"Adjacent to Greenbelt","Interior Lot",Landscaped,"Some Trees"}	{Attached,Front,Opener,Other}	{Diving,"In Ground Gunite",Other}	{Burglar,Other,Owned}	{}	2	1	2	{"Central Air-Elec","Central Heat-Gas",Other,Zoned}	{Carpet,"Ceramic Tile",Other}	{"City Sewer","City Water",Curbs,Other,"Underground Utilities"}	{}	{Traditional}	Single Detached	2	\N	\N	\N	2	24	24	2	2	1	59	Other,Unknown	Brick,Other,Siding		Slab	Composition,Other	t	f	Acton	Daniel	\N					Duncanville ISD	Mountain Creek Meadows 01 Ph 0	f		\N			\N	0.178999999999999992	60X130	H	\N	\N	f	16	10	f		\N	Preowned		t	\N	\N
357b8f4c-bbc1-11e5-9490-f23c91c841bd	4	2.10000000000000009	3531a3d2-bbc1-11e5-9490-f23c91c841bd	Beautiful 4 bedroom, 2.5 bath Ju-Nel in the sought after Lake Ridge Estates neighborhood in Lake Highlands.  Terazzo tile entry gives way to open living and kitchen with lovely views of the outdoor living area and oversized back yard.  Updated baths, hardwood floors throughout and replaced windows are but a few of the wonderful amenities this home offers.	181.252322556670407	2016-01-15 20:50:20.503545+01	2016-01-15 20:50:20.503545+01	43529959	Residential	RES-Single Family	979.331103678929821	\N	{}	{}	{}	{"Ceiling Fans","Low E Windows"}	{Other,Deck,Gazebo/Pergola,Gutters,"Patio Covered","Patio Open","Sprinkler System"}	{"Cable TV Available","Decorative Lighting",Paneling}	{}	{}	{"Interior Lot",Landscaped,"Lrg. Backyard Grass","Some Trees"}	{Attached,Front,Opener,"Outside Entry"}	{}	{}	{}	2	1	2	{"Central Air-Elec","Central Heat-Gas"}	{"Ceramic Tile",Terrazzo,Wood}	{"City Sewer","City Water",Concrete,Curbs,Sidewalk}	{}	{Traditional}	Single Detached	1	\N	\N	\N	2	19	23	2	2	\N	21	Unknown	Brick		Pier & Beam	Composition	f	f	Lakehighla		\N	Lakehighla				Richardson ISD	Lake Ridge Estates	f		\N			\N	0.241999999999999993	75x119		\N	\N	f	25	10	f		\N	Preowned		f	\N	\N
f9b40374-c1ea-11e5-bcc6-f23c91c841bd	3	3.10000000000000009	f96d7c9c-c1ea-11e5-bcc6-f23c91c841bd	Great location! Built in 2007, the this 3 bedroom,3.5 bath condo has granite countertops, stainless steel appliances, gas cooktop and hardwood floors. The open floor plan boasts a fireplace, 10' ceilings, 2 car garage and private entry. The master bath has separate tub and shower. Perfect for roommate situation. Excellent value in East Dallas!	168.338907469342274	2016-01-23 17:04:26.04965+01	2016-01-23 17:04:26.04965+01	2047261	Residential	RES-Condo	0	\N	{}	{}	{"Comm. Sprinkler System"}	{"Ceiling Fans","Gas Water Heater"}	{"Patio Covered"}	{"Cable TV Available","Decorative Lighting","Multiple Staircases"}	{}	{}	{"Interior Lot",Landscaped}	{Attached,Opener}	{}	{}	{}	2	1	3	{"Central Air-Elec","Central Heat-Gas",Zoned}	{Carpet,"Ceramic Tile",Wood}	{"City Sewer","City Water"}	{}	{Traditional}	Condo/Townhome	3	\N	\N	\N	2	20	20	1	1	1			Brick,Siding		Slab	Composition	f	f	Leerobert		\N		Long			Dallas ISD	5743 Prospect Condominiums	f		\N			\N	\N		T	\N	\N	f	1	7	f		\N	Preowned		f	\N	\N
eb3c8adc-ba2e-11e5-af60-f23c91c841bd	5	6.09999999999999964	eaedf0de-ba2e-11e5-af60-f23c91c841bd	Rare Opportunity To Lease This 1.5 Million Dollar Estate Situated On A  Heavily Treed .67 Acre Lot In The Heart Of The City! This Gem Was Totally Rebuilt & Renovated in 2006! Beautiful Grounds With Tranquil Pool & Covered Veranda With Fireplace! Guest Quarters* Duel Staircases* Formals* Media* Downstairs Master Retreat With His & Hers Bath & Cozy Fireplace* Gourmet's Island Kitchen Boasts Sub-Zero, Dacor, Viking & Granite*  Free Pool & Yard Care!	570.512820512820554	2016-01-13 20:50:38.253891+01	2016-01-13 20:50:38.253891+01	50633269	Residential Lease	LSE-House	2719.46488294314395	\N	{}	{}	{}	{"Ceiling Fans","Gas Water Heater"}	{Balcony,"Covered Porch(es)",Gardens,"Guest Quarters",Gutters,"Lighting System","Outdoor Fireplace/Pit","Patio Covered","Patio Open","Sprinkler System","Storage Building"}	{"Built-in Wine Cooler","Cable TV Available","Decorative Lighting","High Speed Internet Available","Multiple Staircases",Paneling,"Sound System Wiring",Wainscoting,"Wet Bar","Window Coverings"}	{}	{Brick,"Gas Logs","Wood Burning"}	{Corner,"Heavily Treed",Landscaped,"Lrg. Backyard Grass"}	{Attached,Front,Garage,"Garage Door Opener",Oversized}	{"Cleaning System","In Ground Gunite","Water Feature"}	{Burglar,Fire/Smoke,Owned,"Smoke Detector"}	{}	3	1	6	{"Central Air-Elec","Central Heat-Gas",Zoned}	{Carpet,"Ceramic Tile",Marble,Stone,Wood}	{"City Sewer","City Water"}	{}	{Colonial,Traditional}	Single Detached	2	\N	\N	\N	3	30	27	2	3	4	6		Brick				t	f	Walnuthill		\N		Cary			Dallas ISD	Lansdowne Estates	t		\N			0.5	0.672000000000000042			1	\N	t	25	20	f		\N	Preowned		t	\N	\N
06b3c6c4-be10-11e5-a85f-f23c91c841bd	3	3.10000000000000009	05f8566e-be10-11e5-a85f-f23c91c841bd	Updated 3 story townhome in desirable North Oak Lawn area. 3 bedrooms and 3.5 bathroom. Property features updated open kitchen, hardwoods throughout, private patio and attached 2-car garage. Upstairs master includes fire place, updated master bath and walk-in closet.  Walking distance to restaurants, grocery store and more.	167.967298402081013	2016-01-18 19:19:34.586155+01	2016-01-19 08:04:02.567513+01	59095666	Residential	RES-Townhouse	744.615384615384642	2008	{}	{}	{}	{"Ceiling Fans"}	{Balcony,"Patio Open"}	{"Cable TV Available","High Speed Internet Available","Window Coverings"}	{}	{Brick}	{"Interior Lot"}	{Attached,Garage,"Garage Door Opener"}	{}	{}	{}	2	1	3	{"Central Air-Elec","Central Heat-Gas"}	{"Ceramic Tile",Wood}	{"City Sewer","City Water",Sidewalk}	{}	{Traditional}	Condo/Townhome	3	\N	\N	\N	2	\N	\N	\N	1	2	9		Brick,Rock/Stone		Slab	Composition	f	f	Milam		\N		Rusk			Dallas ISD	North Oak Lawn	f		\N			\N	0.183999999999999997			\N	\N	f	14	6	f		\N	Preowned		f	\N	\N
ba8632fc-c2cc-11e5-aa15-f23c91c841bd	2	2.10000000000000009	b9ea9ae0-c2cc-11e5-aa15-f23c91c841bd	LOFTS...STUDIOS...OFFICE FOR LIVING OFFICE OR COMBO. NOW AVAILABLE FOR MOVE-IN. LARGE OPEN LIVING-LOFT SPACE, 2 BEDROOM, 2 FIREPLACE, 2.5 BATH, 2 CAR GARAGE WITH WORKBENCH, PRIVATE COURTYARD, DECK WITH DOWNTOWN VIEW AND SEPERATE BALCONY OFF THE MASTER BEDROOM. CONVENIENT LOCATION AND A MULTITUDE OF AMENITIES. TWO ELECTRIC FIREPLACES, ONE IN THE MASTER BEDROOM.	206.521739130434781	2016-01-24 20:00:26.313846+01	2016-01-24 20:00:26.313846+01	1289260	Residential Lease	LSE-Condo/Townhome	1003.61204013377926	\N	{}	{}	{}	{}	{}	{}	{}	{}	{}	{Garage}	{}	{}	{}	2	1	2	{"Central Air-Elec","Central Heat-Elec"}	{Concrete,Wood}	{}	{}	{}	Condo/Townhome	2	\N	\N	\N	2	2	2	1	1	2	4						f	f	Adamsjohnq	Patton	\N					Dallas ISD	Gaston Homestead	t		\N			\N	0.247999999999999998		J	\N	\N	t	8	4	f		\N	Preowned		f	\N	\N
7bf304c0-a814-11e5-8e1e-f23c91c841bd	1	1	7a65575c-a814-11e5-8e1e-f23c91c841bd	W Dallas North Tower condo on the 23rd floor.Enjoy a wall of windows with western sunset views.Walk into this open plan with a long hallway that is perfect to display art work.Home features limestone floors,window treatments,gas cooktop,Sub Zero,private terrace and spa like bathroom with soaking tub and separate shower.All the W Hotel amenities.Washer and Dryer included.Storage unit can be purchased separately.Walk to Perot Museum and Katy Trail.	76.6443701226310026	2015-12-21 19:56:03.699405+01	2016-01-22 17:02:46.449042+01	58705917	Residential	RES-Condo	6669.16387959866279	2006	{}	{}	{}	{}	{}	{"Cable TV Available","High Speed Internet Available"}	{}	{}	{}	{"Assigned Garage","Assigned Spaces",Garage,"Shared Garage"}	{}	{}	{}	1	\N	1	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,Stone}	{"Community Mailbox"}	{}	{Contemporary/Modern}	Condo/Townhome,Hi Rise	1	\N	\N	\N	1	\N	\N	1	1	\N	11A		Brick		Slab	Other	t	f	Houston		\N		Rusk			Dallas ISD	Residential Condo	f		\N			\N	1.64799999999999991			\N	\N	f	28	3	f		\N	Preowned		f	\N	\N
0a39ec70-c2c9-11e5-96da-f23c91c841bd	1	1.10000000000000009	09ebb8ac-c2c9-11e5-96da-f23c91c841bd	FABULOUS FURNISHED ONE BEDROOM,1.1BATH OPEN FLOORPLAN* PERFECT FOR AN EXECUTIVE* UNFURNISHED AT $2,200* STUDY* GOURMET KITCHEN W,STNLS STEEL APPLIANCES,WARMING DRAWER,GRANITE COUTNERS,WINE RERFIG*LARGE MASTER SUITE W,SEP SHOWER AND TUB,OVERSIZED CLOSET*PERSONAL STORAGE ROOM ON SAME FLOOR*AMENITIES GALORE INCLUDE:24 HOUR VALET &CONCIERGE,PARTY ROOM W,BILLIARDS,TV,WINE VAULT &PERSONAL WINE LOCKER,STATE OF THE ART	121.980676328502426	2016-01-24 19:34:02.044763+01	2016-01-24 19:34:02.044763+01	1137861	Residential Lease	LSE-Condo/Townhome	0	\N	{}	{}	{"Common Elevator","Community Pool","Gated Entrance","Guarded Entrance"}	{}	{}	{"Built-in Wine Cooler"}	{}	{}	{}	{"Assigned Spaces",Garage}	{"In Ground Gunite"}	{Fire/Smoke}	{}	1	1	1	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,Wood}	{"City Sewer","City Water","Community Mailbox"}	{}	{Traditional}	Hi Rise	1	\N	\N	\N	1	\N	\N	1	1	1			Brick				t	f	Travis		\N		Washington				BLK 75	t		\N			\N	\N		L	\N	\N	f	1	7	f		\N	New Construction - Incomplete		f	\N	\N
53e4c01c-c1f1-11e5-bc6c-f23c91c841bd	2	2	5356ee40-c1f1-11e5-bc6c-f23c91c841bd	This is a great house! Hardwood floors throughout, except for Kitchen and Baths that have tile. Big back yard with a pool! Blue Ribbon, exemplary rated Stonewall Jackson Elementaery school district. Surrounding area has restuarants, shopping, SMU. Whiterock Lake, Dart. Available Now!!	117.149758454106291	2016-01-23 17:49:54.344363+01	2016-01-23 17:49:54.344363+01	1383273	Residential Lease	LSE-House	683.913043478260988	\N	{}	{}	{}	{}	{}	{"Cable TV Available"}	{}	{}	{}	{Uncovered}	{}	{}	{}	\N	\N	2	{"Central Air-Elec","Central Heat-Elec"}	{"Ceramic Tile",Wood}	{"City Sewer","City Water"}	{}	{Traditional}	Single Detached	1	\N	\N	\N	\N	\N	\N	1	1	1	4		Rock/Stone				t	f	Jacksonsto		\N		Long			Dallas ISD	Stonewall Park	t		\N			\N	0.169000000000000011	58X124	K	\N	\N	f	1	4	f		\N	Preowned		f	\N	\N
281c2270-c171-11e5-a880-f23c91c841bd	2	2.10000000000000009	271a5b9e-c171-11e5-a880-f23c91c841bd	Katy Trail Gem!Rare 2 story townhome w-extensive exterior renovation including low maintenance cement fiber siding,contemp steel balconies completed this spring.25-ft ceils w-excellent natural light,balcony off MBR,front courtyd,huge priv patio w-direct access to Trail enhance the simplicity of Urban Living.Concrete flrs,eat-in kit,granite CT,builtin wine cooler,WBFP add to orig charm.Bonus rm above gar would make great office-studio.NO HOA fees!	156.540319583797867	2016-01-23 02:32:25.306175+01	2016-01-23 02:32:25.306175+01	2339947	Residential	RES-Townhouse	0	\N	{}	{}	{}	{"Attic Fan"}	{Balcony,"Patio Open"}	{"Cable TV Available","Decorative Lighting","High Speed Internet Available",Skylights,"Vaulted Ceilings"}	{}	{"Wood Burning"}	{}	{Attached,Opener}	{}	{}	{}	1	1	2	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,"Ceramic Tile",Concrete}	{"City Sewer","City Water",Sidewalk}	{}	{Contemporary/Modern}	Condo/Townhome	2	\N	\N	\N	1	11	20	1	2	1	8f	Unknown	Brick,Wood		Slab	Composition	f	f	Milam		\N		Spence			Dallas ISD	Villa	f		\N			\N	\N	0X0	U	\N	\N	f	1	9	f		\N	Preowned		f	\N	\N
3b6d57ea-c171-11e5-a880-f23c91c841bd	2	2	3b1ca3a4-c171-11e5-a880-f23c91c841bd	Beautifully renovated open floor plan. Loft like feel, granite kitchen with custom cabinets and stainless appliances. Kitchen, living room, dining room and den all open. Hardwoods throughout. Master has a suite like feel. Bathrooms updated. Inviting wood deck and beautifully landscaped backyard.	165.273132664437014	2016-01-23 02:32:57.71513+01	2016-01-23 02:32:57.71513+01	2343937	Residential	RES-Single Family	687.959866220735762	\N	{}	{}	{}	{}	{}	{"Cable TV Available","Flat Screen Wiring"}	{}	{Decorative}	{Landscaped}	{Detached}	{}	{}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Gas"}	{Wood}	{"City Sewer","City Water"}	{}	{Tudor}	Single Detached	1	\N	\N	\N	2	20	20	1	2	1	18		Brick		Pier & Beam	Composition	f	f	Jacksonsto		\N		Long			Dallas ISD	Greenland Hills 1st Sec	f		\N			\N	0.170000000000000012	50x145	N	\N	\N	f	1	9	f		\N	Preowned		t	\N	\N
4f83785a-af4b-11e5-a878-f23c91c841bd	3	3.10000000000000009	46ace298-af4b-11e5-a878-f23c91c841bd	Fabulous finish out w hardwood floors down, spacious room sizes, lovely back yard and patio area. Kitchen is well equipped with granite, center island, and quiet breakfast area. Master bedroom has private study loft. 3rd floor has gameroom den, br, and bath. Lease for current tenant expires on March 31st, 2016.	313.080639167595734	2015-12-31 00:16:09.608605+01	2016-02-10 06:05:16.930021+01	58804924	Residential	RES-Townhouse	331.839464882943162	1998	{}	{}	{}	{}	{"Patio Open"}	{"Flat Screen Wiring","High Speed Internet Available",Loft}	{}	{"Gas Logs"}	{}	{Attached}	{}	{Burglar}	{}	2	1	3	{"Central Air-Elec","Central Heat-Gas"}	{Wood}	{"City Sewer","City Water"}	{}	{Traditional}	Condo/Townhome	3	\N	\N	\N	2	\N	\N	2	4	1	6A		Brick		Slab	Composition	f	f	Houston		\N		Rusk			Dallas ISD	Perry Homes Wycliff	f		\N			\N	0.0820000000000000034	Townhm		\N	\N	f	11	11	f		\N	Preowned		t	\N	\N
fe2ee120-ba52-11e5-acec-f23c91c841bd	2	2	fdd6678e-ba52-11e5-acec-f23c91c841bd	Every window overlooks downtown Dallas!  Modern condo w $16,500+ of upgrades in highly sought-after The Beat highrise! Valuable upgrades in media include LED lighting & designer fans, amazing wall art by local graffiti artist in guest bath, added ventiliation for bedrooms, upgraded master shower door, flat screen wiring in beds & living, custom closet systems, commercial window tint for added efficiency, custom paint, sec system, elect blinds,...	107.766629505759951	2016-01-14 01:08:51.923294+01	2016-01-14 01:08:51.923294+01	50547026	Residential	RES-Condo	3816.15384615384664	\N	{Elevator}	{}	{"Comm. Sprinkler System","Common Elevator","Community Pool","Gated Entrance",Other}	{"Ceiling Fans","Energy Star Appliances","Low E Windows","Programmable Thermostat","Tinted Windows"}	{Balcony,"Patio Covered"}	{"Cable TV Available","Decorative Lighting","Electric Shades","Flat Screen Wiring","High Speed Internet Available","Window Coverings"}	{}	{}	{}	{"Assigned Spaces","Common Garage","Garage Door Opener","Garage Under Building",Opener,"Other Parking/Garage"}	{}	{Burglar,"Fire Sprinkler System",Fire/Smoke}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Elec"}	{Concrete}	{"City Sewer","City Water"}	{}	{Contemporary/Modern}	Condo/Townhome	1	\N	\N	1	1	1	1	1	1	\N	1		Concrete		Slab	Built-Up	t	f	King		\N		Dade			Dallas ISD	Beat At The South Side Station	f	1	\N			\N	0.942999999999999949			\N	\N	f	23	4	f		\N	Preowned		t	\N	\N
2aa5e9fa-bcb6-11e5-84b0-f23c91c841bd	2	2.10000000000000009	2a07f510-bcb6-11e5-84b0-f23c91c841bd	LOCATION, LOCATION - TWO LARGE BEDROOMS WITH STUDY  + 2 CAR GARAGE--2 STORY  APPLIANCES, GAS LOG FIREPLACE, FENCED YARD WITH PATIO AND DECK. EXCELLENT LOCATION, NEAR BEAUTIFUL PARK. VACANT EASY TO SHOW.	142.883686361947241	2016-01-17 02:03:49.025046+01	2016-01-17 02:03:49.025046+01	1090971	Residential Lease	LSE-House	0	\N	{}	{}	{}	{}	{"Sprinkler System"}	{Other,"Window Coverings"}	{}	{"Gas Logs"}	{"Cul De Sac"}	{Garage,"Garage Door Opener"}	{Other}	{Burglar,"Smoke Detector"}	{}	\N	1	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,"Ceramic Tile"}	{"City Sewer","City Water",Concrete,Curbs,Sidewalk}	{}	{Traditional}	Single Detached	2	\N	\N	\N	2	22	22	1	2	1	36		Brick				f	f	Haggar		\N		Renner				LLOYD TRACT 08	t		\N			\N	\N		B	\N	\N	t	13	14	f		\N	Preowned		t	\N	\N
578b93e0-9f54-11e5-a0f8-f23c91c841bd	2	2.10000000000000009	5252dfd2-9f54-11e5-a0f8-f23c91c841bd	WOW is only a start. 50' long x 8' balcony faces center of Downtown and 180 degree view, LR and DR together is 37' long next to balcony, 20' Kitchen overlooks DR, 14' Bar - Serving Bar. Top appliances include SubZero Ref-Frz, Miele dishwasher, Thermador ovens, micro convection, 12 bottle wine cooler, Niles intercom and sound, marble and carpet floors, granite tops, 2 attached Samsung TV, Sexy Bath.   HOTEL SERVES FOOD - DRINKS TO YOUR DOOR !!	191.564474173169828	2015-12-10 16:40:29.949647+01	2015-12-13 22:56:33.769823+01	58554075	Residential	RES-Condo	6632.74247491638835	2004	{}	{}	{"Common Elevator","Guarded Entrance"}	{}	{Balcony,"Lighting System"}	{"Built-in Wine Cooler","Cable TV Available","Decorative Lighting","Electric Shades",Elevator,"Flat Screen Wiring","High Speed Internet Available",Intercom,"Multiple Staircases"}	{}	{}	{}	{"Assigned Spaces",Attached,"Common Garage","Garage Under Building"}	{"In Ground Gunite",Other}	{Burglar,"Fire Sprinkler System","Smoke Detector"}	{}	2	1	2	{"Central Air-Elec","Central Air-Gas",Evaporation,Other,Zoned}	{Carpet,Marble}	{"City Sewer","City Water","Co-op Water","Community Mailbox",Other}	{}	{Contemporary/Modern}	Condo/Townhome	1	\N	\N	\N	2	20	10	1	1	\N	11A		Concrete,Glass,Other		Other	Other	t	f	Esperanza Medrano		\N	Young				Dallas ISD	Residences	f		\N			\N	1.63900000000000001			\N	\N	f	13	6	f		\N	Preowned		t	\N	\N
89877df0-bcbe-11e5-b338-f23c91c841bd	5	5.09999999999999964	8932e808-bcbe-11e5-b338-f23c91c841bd	PRICED TO SELL-Best value in the area.2 lots just cleared on this street for new custom homes, area is hot! Open family room with wdburning fplace. Handscraped hdwds. Huge island kit,2 DW, exotic granite, Wolf & Sub-Zero appliances, btlrs pantry. Wet bar,wine cooler. Large bdrms. Guest room down. Craft room, media, gameroom. Luxurious master suite & bath,jet tub,custom closet w-built-in dresser. Energy saving features. Outdoor liv. Electric gate.	592.623560014864438	2016-01-17 03:03:44.183015+01	2016-01-17 03:03:44.183015+01	2435482	Residential	RES-Single Family	1679.43143812709059	\N	{}	{}	{}	{"Ceiling Fans","Gas Water Heater","Low E Windows","Programmable Thermostat","Radiant Barrier"}	{"Attached Grill",Gutters,"Lighting System","Outdoor Living Center","Patio Covered","Sprinkler System"}	{"Bay Windows","Built-in Wine Cooler","Cable TV Available","Decorative Lighting","Flat Screen Wiring","High Speed Internet Available","Multiple Staircases",Paneling,"Plantation Shutters","Sound System Wiring","Vaulted Ceilings","Wet Bar","Window Coverings"}	{}	{Stone,"Wood Burning"}	{"Heavily Treed","Interior Lot",Landscaped,"Lrg. Backyard Grass",Subdivision}	{Attached,Opener,Oversized,Side}	{}	{Burglar,"Carbon Monoxide Detector",Owned,"Smoke Detector"}	{}	4	1	5	{"Central Air-Elec","Central Heat-Gas",Zoned}	{Carpet,"Ceramic Tile",Marble,Stone,Wood}	{"City Sewer","City Water",Concrete,Curbs,Sidewalk}	{}	{Other}	Single Detached	2	\N	\N	\N	4	43	22	2	4	3	2	Unknown	Rock/Stone		Slab	Composition	f	f	Adamsnatha		\N		Walker			Dallas ISD	Preston Dell Estates	f		\N			0.5	0.41499999999999998		S	\N	\N	f	25	27	f		\N	Preowned		t	\N	\N
8609903c-c367-11e5-93fd-f23c91c841bd	3	1	85dace6e-c367-11e5-93fd-f23c91c841bd	3 BEDROOM, 1 BATH, 1 CAR GARAGE, UTILITY ROOM, LARGE BACKYARD WITH OPEN PATIO.  THE HOME IS TO BE SOLD IN AS IS CONDITION.  NO REPAIRS WILL BE MADE BY THE SELLER.  THE HOME IS PRICED IN AS IS CONDITION. ROOM SIZES ARE ESTIMATED.  THE PRICE HAS BEEN REDUCED FOR A QUICK SALE. THE HOUSE HAS BEEN A RENT HOUSE FOR THE PAST SEVERAL YEARS RENTED AT 850 PER MONTH.  THIS IS AN EXCELLENT INVESTMENT PROPERTY.	87.8855444072835468	2016-01-25 14:28:30.248457+01	2016-01-25 14:28:30.248457+01	1991939	Residential	RES-Single Family	700.100334448160538	\N	{}	{}	{}	{}	{"Patio Open"}	{Other}	{}	{}	{"Interior Lot"}	{Attached,Front}	{}	{}	{}	1	\N	1	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,Vinyl}	{Alley,"City Sewer","City Water",Curbs,Sidewalk}	{}	{Traditional}	Single Detached	1	\N	\N	\N	1	10	20	\N	1	\N	40	Other	Brick,Siding		Slab	Composition	f	f	Casaview		\N		Hill			Dallas ISD	Casa View Heights	f		\N			\N	0.172999999999999987	60X125	D	\N	\N	f	1	6	f		\N	Preowned		f	\N	\N
92940c52-c23a-11e5-92d3-f23c91c841bd	2	2	923f9f5a-c23a-11e5-92d3-f23c91c841bd	**REDUCED**Great property for a great price in a great location. Completely renovated downstairs property with new floors and countertops. Near main highways and shopping centers. Property also has storm windows, 2 parking places, and washer & dryer accesible inside and outside of property. Storage unit available also. Beautiful courtyard with nature setting in the back of the property along with a nice pool area to relax in. Utilities Included.	109.903381642512088	2016-01-24 02:34:12.773114+01	2016-01-24 02:34:12.773114+01	2228463	Residential	RES-Condo	9291.50501672240898	\N	{}	{}	{"Community Pool","Gated Entrance",Laundry}	{"Storm Window(s)"}	{Gardens}	{"Cable TV Available","Decorative Lighting","Window Coverings"}	{}	{"Metal Box","Wood Burning"}	{}	{"Assigned Spaces",Covered,Uncovered}	{}	{"Smoke Detector"}	{}	1	\N	2	{"Central Air-Elec","Central Heat-Elec"}	{Laminate}	{"City Sewer","City Water"}	{}	{Traditional}	Condo/Townhome	1	2	\N	1	\N	\N	\N	1	1	1	2		Brick		Slab	Composition	t	f	Kramer		\N		Franklin			Dallas ISD	Royal Oaks Condo	f	7832	\N			\N	2.29599999999999982	501	E	\N	\N	f	1	7	f		\N	Preowned		f	\N	\N
8d1a8b12-bc99-11e5-936d-f23c91c841bd	3	2	8b229390-bc99-11e5-936d-f23c91c841bd	WOW! Where do I start!! This 3 bedroom, 2 bath home will rival any model home. Kitchen has a large island under a sky lite. Lighting has been upgraded thru-out. There a covered patio for those great back yard BBQs. Huge master bedroom with gorgeous master bath. Get over here now before its too late!	173.820141211445559	2016-01-16 22:38:58.800933+01	2016-01-16 22:38:58.800933+01	2497853	Residential	RES-Single Family	793.177257525083633	\N	{}	{}	{"Community Pool",Playground}	{"13-15 SEER AC","Gas Water Heater","Programmable Thermostat","Solar Screens"}	{"Patio Covered","Sprinkler System"}	{"Cable TV Available","Decorative Lighting","High Speed Internet Available",Intercom,Skylights}	{}	{"Gas Logs","Gas Starter"}	{Corner}	{Attached,Opener}	{}	{Burglar,Owned}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,"Ceramic Tile"}	{"City Sewer","City Water",Sidewalk,"Underground Utilities"}	{}	{Contemporary/Modern}	Single Detached	1	\N	\N	\N	2	20	20	2	1	1	11	Unknown	Frame/Brick Trim		Slab	Composition	f	f	Hyman		\N		Kennemer			Duncanville ISD	Summit Parc 04	f		\N			\N	0.196000000000000008		X	\N	\N	f	1	10	f		\N	Preowned		t	\N	\N
a1f16db0-b88b-11e5-9643-f23c91c841bd	3	3.20000000000000018	a0611040-b88b-11e5-9643-f23c91c841bd	Lrg int unit in heart of Oak Lawn, 1 blk frm Highland Park. French drs lead to 1st flr patio w encl yard. 3 patios & rooftop balc w dtown views. Oak hardwood floors throughout; pre-wired for home theater. Lrg kitch w walkin pantry feat granite counters & SS appl, dbl ovens & wine cooler. Master ste feat bay windows, lrg walkin closet, and bath w glass-enclosed shower w travertine marble. Top flr is 2nd LA or 4th BR w half bath & access to**	240.059457450761812	2016-01-11 18:49:16.157842+01	2016-01-22 17:04:21.65906+01	58982003	Residential	RES-Condo	0	2006	{}	{}	{"Comm. Sprinkler System"}	{"Ceiling Fans","Energy Star Appliances","Programmable Thermostat"}	{Balcony,Gutters,"Lighting System","Patio Covered","Patio Open","Roof Top Deck/Patio","Sprinkler System"}	{"Bay Windows","Built-in Wine Cooler","Cable TV Available","Central Vac","Decorative Lighting","High Speed Internet Available","Multiple Staircases","Sound System Wiring"}	{}	{"Gas Logs","Gas Starter"}	{Corner,"Heavily Treed",Landscaped}	{Attached,Garage,"Garage Door Opener","On Street"}	{}	{Burglar,Fire/Smoke}	{}	2	2	3	{"Central Air-Elec","Central Heat-Gas","Window Unit",Zoned}	{Carpet,"Ceramic Tile",Wood}	{"City Sewer","City Water","Community Mailbox",Curbs,"Individual Gas Meter",Sidewalk}	{}	{Traditional}	Condo/Townhome	3	\N	\N	\N	2	20	20	1	2	1	1A		Brick		Slab	Composition	f	f	Milam		\N		Rusk			Dallas ISD	Donald H Gale Add	f		\N			\N	\N			\N	\N	f	23	13	f		\N	Preowned		t	\N	\N
6cae03e0-bc12-11e5-9fef-f23c91c841bd	3	2	6c5bbf54-bc12-11e5-9fef-f23c91c841bd	Discover this gated community, Enclave At White Rock, w-a private park, pond & jogging trail! An open floorplan & an appealing decor enhanced this gem with an elegant DR, a spacious LR w-WBFP, a study, a large master w-lavish bath & a 2nd level $14k Media Room! The kitchen has a chef's island w-a Stainless Viking 6 burner range w-drop vent! A covered patio, a rear board on board fence & water feature highlight the lovely backyard.	256.688963210702354	2016-01-16 06:31:42.34413+01	2016-01-16 06:31:42.34413+01	2360683	Residential	RES-Single Family	566.555183946488341	\N	{}	{}	{"Comm. Sprinkler System","Gated Entrance",Greenbelt,Marina,"Perimeter Fencing"}	{}	{"Patio Covered","Sprinkler System"}	{"Built-in Wine Cooler","Decorative Lighting","Window Coverings"}	{}	{"Wood Burning"}	{"Interior Lot",Landscaped,"Lrg. Backyard Grass"}	{Attached}	{"Water Feature"}	{}	{}	2	\N	2	{"Central Heat-Gas",Zoned}	{Carpet,Wood}	{"City Sewer","City Water"}	{}	{Traditional}	Single Detached	2	\N	\N	\N	2	22	22	2	2	1	131		Brick,Frame/Brick Trim		Slab	Composition	f	f	Sanger		\N		Gaston			Dallas ISD	Enclave At White Rock Ph 02	f		\N			\N	0.140000000000000013	120	C	\N	\N	f	24	13	f		\N	Preowned		t	\N	\N
0c0416d4-b49b-11e5-a450-f23c91c841bd	3	1	0a2afef4-b49b-11e5-a450-f23c91c841bd	Great Investor Property! Cute exterior, interior needs TLC! Large fenced backyard and original hardwood floors throughout. Tons of charm and potential in this 1950's home! Contact agent for showings!	120.772946859903385	2016-01-06 18:29:31.918892+01	2016-01-27 20:35:42.263583+01	58900413	Residential	RES-Single Family	0	1951	{}	{}	{}	{}	{}	{Other}	{}	{}	{"Interior Lot","Some Trees"}	{Attached,Front,Garage}	{}	{}	{}	1	\N	1	{"Central Air-Elec","Central Heat-Elec"}	{"Ceramic Tile",Wood}	{"City Sewer","City Water"}	{}	{}	Single Detached	1	\N	\N	\N	1	\N	\N	1	1	\N	5		Brick		Pier & Beam	Composition	f	f	Jordan		\N		Brown			Dallas ISD	East-O-Kiest Park	f		\N			\N	\N	60 x 140		\N	\N	f	1	\N	f		\N	Preowned		f	\N	\N
9415efb4-c1e0-11e5-bc01-f23c91c841bd	2	2.10000000000000009	93e27ad0-c1e0-11e5-bc01-f23c91c841bd	FORECLOSURE, THREE STORY CONDO, TWO BEDROOM, TWO AND HALF BATHS, TWO LIVING AREAS.  FIREPLACE. HARDWOOD FLOORS, GRANITE KITCHEN ISLAND.  TWO CAR ATTACHED GARAGE.	177.350427350427367	2016-01-23 15:50:00.59629+01	2016-01-23 15:50:00.59629+01	2388816	Residential	RES-Condo	0	\N	{}	{}	{}	{}	{Balcony,"Patio Open"}	{"Built-in Wine Cooler",Skylights}	{}	{"Wood Burning"}	{}	{Attached}	{}	{}	{}	2	1	2	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,Wood}	{"City Sewer","City Water"}	{}	{Traditional}	Condo/Townhome	3	3	\N	\N	2	20	20	1	2	1			Brick		Slab	Other	f	f	Mcmillan		\N		Rusk			Dallas ISD	Avondale Twnhms 4103	f		\N			\N	\N		T	\N	\N	f	10	11	f		\N	Preowned		f	\N	\N
f33a27ee-c1f4-11e5-9606-f23c91c841bd	4	4	f2e796e6-c1f4-11e5-9606-f23c91c841bd	BEAUTIFULLY UPDATED HOME ON 1 ACRE CREEK LOT,LA'S W/12 FT CEILS.FAB POOL W/ OUTDOOR FP,INCREDIBLE KIT W/STAINLESS APPLS,3-CAR GAR,HDWDS IN ALL LA'S, OPEN KIT/DEN,BEDROOMS SPLIT,OFFICE OR EXERCISE ROOM - VERY ATTRACTIVE, SHOWS GREAT!	420.011148272017863	2016-01-23 18:15:50.152016+01	2016-01-23 18:15:50.152016+01	1528396	Residential	RES-Single Family	4046.82274247491659	\N	{}	{}	{}	{"Insulated Doors","Thermo Windows"}	{"Covered Porch(es)","Patio Open","Sprinkler System"}	{"Cable TV Available","Plantation Shutters","Window Coverings"}	{}	{Brick,"Wood Burning"}	{"Heavily Treed",Landscaped,"Lrg. Backyard Grass"}	{Attached,Front,Opener}	{Heated,"In Ground Gunite"}	{}	{}	3	\N	4	{"Central Air-Elec","Central Heat-Gas",Zoned}	{Carpet,Wood}	{"City Sewer","City Water"}	{}	{Traditional}	Single Detached	1	\N	\N	\N	3	\N	\N	2	2	2	3	Unknown	Brick,Wood		Pier & Beam	Composition	t	f	Walnuthill		\N		Cary			Dallas ISD	INWOOD PARK ESTATES	f		\N			1	1	00X00	R	\N	\N	f	1	13	f		\N	Preowned		f	\N	\N
66971532-c293-11e5-8bcd-f23c91c841bd	2	2.10000000000000009	665270d0-c293-11e5-8bcd-f23c91c841bd	Beautiful 2 bedroom with 2 full and 1 half bath. Views of Downtown from the living room, Kitchen and the Master Bedroom. The Balcony has room for chairs to enjoy the views of the city. The unit has surround sound and can be rented fully furnished if desired.	191.564474173169828	2016-01-24 13:10:04.182286+01	2016-01-24 13:10:04.182286+01	1354359	Residential Lease	LSE-Condo/Townhome	6632.74247491638835	\N	{}	{}	{"Common Elevator","Community Pool","Guarded Entrance"}	{}	{Balcony}	{"Built-in Wine Cooler","Cable TV Available","Decorative Lighting","High Speed Internet Available","Sound System Wiring","Window Coverings"}	{}	{}	{}	{"Assigned Spaces"}	{}	{}	{}	2	1	2	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,"Ceramic Tile"}	{"City Sewer","City Water","Community Mailbox"}	{}	{Contemporary/Modern}	Condo/Townhome	1	\N	\N	\N	2	\N	\N	1	1	\N							t	f	Houston		\N		Rusk			Dallas ISD	Residences	t		\N			\N	1.63900000000000001		E	\N	\N	f	1	9	f		\N	Preowned		f	\N	\N
cfcf6210-c1f4-11e5-9606-f23c91c841bd	2	1.10000000000000009	cf275f34-c1f4-11e5-9606-f23c91c841bd	UPDATED,PAINTED & READY TO MOVE IN! CLOSE TO WHITE ROCK W/BEAUTIFUL TREES. KITCHEN OPENS INTO DECORATVE BEAMED DEN.HDWDS RE-FINISHED IN BRS & HALL. CARPET REPLACED IN LR/DR/DEN.CEILING FANS.UPDATED BATHS.MINI-BLINDS.2-CAR DETACHED GARAGE W/OPENER.FENCED YD FOR BCKYD COOKOUTS.BRING ALL OFFERS.	116.592344853214428	2016-01-23 18:14:50.73185+01	2016-01-23 18:14:50.73185+01	1441103	Residential	RES-Single Family	687.959866220735762	\N	{}	{}	{}	{"Ceiling Fans"}	{"Patio Open"}	{"Window Coverings"}	{}	{}	{"Some Trees"}	{Detached}	{}	{Unknown}	{}	2	1	1	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,Vinyl,Wood}	{"City Sewer","City Water",Curbs}	{}	{Traditional}	Single Detached	1	\N	\N	\N	2	\N	\N	1	2	\N	10	Unknown	Brick		Pier & Beam	Composition	f	f	Lakewood		\N		Long				BOB O LINKS DOWNS	f		\N			\N	0.170000000000000012	57 X 135	E	\N	\N	f	1	10	f		\N	Unknown		f	\N	\N
0ef2bad2-c1f5-11e5-9606-f23c91c841bd	4	5.09999999999999964	0e9f74e4-c1f5-11e5-9606-f23c91c841bd	Breathtaking lakefront prop-updated w/fresh paint, carpet&granite counters. Master down has exer. rm w/sauna. Study down! 3 bedrooms and gameroomm up with balcony overlooking lake. Island kitchen with granite counter tops. 3-car garage, circle drive and fabulous views. Meticulously maintained!!	615.198810850984842	2016-01-23 18:16:36.659986+01	2016-01-23 18:16:36.659986+01	1600249	Residential	RES-Single Family	0	\N	{}	{}	{"Comm. Sprinkler System","Community Pool","Gated Entrance","Guarded Entrance",Playground,"Private Lake/Pond",Tennis}	{"Ceiling Fans","Gas Water Heater"}	{Balcony,Gutters,"Sprinkler System"}	{"Cable TV Available",Intercom,"Multiple Staircases",Paneling,"Plantation Shutters",Skylights,"Vaulted Ceilings",Wainscoting,"Wet Bar","Window Coverings"}	{}	{"Gas Logs","Gas Starter"}	{Corner,Landscaped,"Some Trees"}	{Attached,"Circle Drive","Has Sink in Garage"}	{}	{Burglar,Fire/Smoke,Monitored,"Smoke Detector"}	{}	3	1	5	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,Marble,Parquet,Stone}	{Alley,"City Sewer","City Water",Curbs,Sidewalk}	{}	{Traditional}	Garden/Zero Lot Line	2	\N	\N	\N	3	\N	\N	2	4	3	1		Brick,Siding		Slab	Composition	f	f	Prestonhol		\N		Franklin			Dallas ISD	GLEN LAKES  SIXTH SECTION	f		\N			\N	\N	0X0	N	\N	\N	f	1	22	f		\N	Preowned		t	\N	\N
839bd89c-c1f9-11e5-9b8c-f23c91c841bd	2	1	83516ca8-c1f9-11e5-9b8c-f23c91c841bd	Darling 2 bedroom 1 bath with a Sunroom. Newly refinished hardwoods and recently painted. Great location! Wonderful Drive-up appeal.	139.260497956150147	2016-01-23 18:48:30.371067+01	2016-01-23 18:48:30.371067+01	2062249	Residential	RES-Single Family	853.8795986622074	\N	{}	{}	{}	{}	{Other}	{Other}	{Other}	{"Wood Burning"}	{"Heavily Treed"}	{Detached,Front}	{}	{}	{}	1	\N	1	{"Central Air-Elec","Central Heat-Gas"}	{Wood}	{"City Sewer","City Water"}	{}	{Traditional}	Single Detached	1	\N	\N	\N	1	\N	\N	2	2	1	15	Unknown	Brick		Pier & Beam	Composition	f	f	Lakewood		\N		Long			Dallas ISD	Burke S R	f		\N			\N	0.210999999999999993	65X140	N	\N	\N	f	1	9	f		\N	Preowned		f	\N	\N
ff6ed78e-c23b-11e5-8f6a-f23c91c841bd	3	2.10000000000000009	ff122ea8-c23b-11e5-8f6a-f23c91c841bd	Large lot, Big backyard live guarded gate in Plano ISD ! Large master suite. Enjoy the two-sided fireplace from the mastr bedroom or from the large jetted tub. Kitchen features island, double oven and 42  cabinets. Other features include mature trees, fresh exterior paint, dual water heaters, sink in garage. Great opportunity for good lot & location!	218.599033816425134	2016-01-24 02:44:24.897585+01	2016-01-24 02:44:24.897585+01	2245733	Residential	RES-Single Family	558.461538461538453	\N	{}	{}	{}	{"Ceiling Fans"}	{"Patio Open"}	{"Decorative Lighting"}	{}	{Brick,"Gas Logs","Gas Starter"}	{Corner,Landscaped,"Lrg. Backyard Grass","Some Trees",Subdivision}	{Attached,Front,Opener}	{}	{}	{}	2	1	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,"Ceramic Tile"}	{"City Sewer","City Water",Concrete,Curbs,Sidewalk}	{}	{Traditional}	Single Detached	2	\N	\N	\N	2	21	18	2	2	2	89		Brick		Slab	Composition	f	f	Jackson		\N		Frankford		Planowest	Plano ISD	Highland Creek Manor	f		\N			\N	0.138000000000000012		H	\N	\N	f	1	14	f		\N	Preowned		f	\N	\N
5f8f8290-c146-11e5-8192-f23c91c841bd	3	3	5f45ec02-c146-11e5-8192-f23c91c841bd	THIS CUSTOM GAGEWOOD BUILT HOME IS A ONE OF A KIND! HAS SO MUCH PERSONALITY! HARDWOOD FLOORS IN HUGE FAMILY, DINING, KITCHEN AND BREAKFAST ROOM.TRAY CEILINGS, LAYERED CROWN MOULDINGS, CHAIR RAIL, NEW CARPET AND FRESH PAINT.  TWO MASTER SUITES! HUGE WALK-IN CLOSETS. 3RD BATHROOM HAS BEEN COMPLETELY REMODELED WTIH WALK-IN SHOWER.POOL AND SPA ARE PRIVATE!OVERSIZED DRIVEWAY WITH EXTRA STORAGE ON SIDE OF GARAGE. 2.5 CAR GARAGE WITH WORKROOM.	232.25566703827576	2016-01-22 21:26:09.977648+01	2016-01-22 21:26:09.977648+01	2175635	Residential	RES-Single Family	748.662207357859643	\N	{}	{}	{Park}	{"Ceiling Fans","Gas Water Heater","Programmable Thermostat","Storm Door(s)","Thermo Windows"}	{"Covered Porch(es)",Gutters,"Lighting System","Patio Covered","Sprinkler System",Workshop}	{"Cable TV Available","High Speed Internet Available","Vaulted Ceilings","Window Coverings"}	{}	{"Gas Starter","Wood Burning"}	{"Heavily Treed","Interior Lot",Landscaped,Subdivision}	{Attached,Opener,Oversized,Rear}	{"Attached Spa","Cleaning System","In Ground Gunite"}	{Owned,"Smoke Detector"}	{}	2	\N	3	{"Additional Water Heater(s)","Central Air-Elec","Central Heat-Gas"}	{Carpet,"Ceramic Tile",Wood}	{Alley,"City Sewer","City Water",Concrete,Curbs,Sidewalk}	{}	{Ranch}	Single Detached	1	\N	\N	\N	2	23	25	2	1	1	13	Unknown	Brick,Wood		Slab	Composition	t	f	Jackson		\N		Frankford		Planowest	Plano ISD	Preston Highlands 04	f		\N			\N	0.184999999999999998	72x120	D	\N	\N	f	1	13	f		\N	Preowned		t	\N	\N
44992778-c21f-11e5-8149-f23c91c841bd	2	2	4461609a-c21f-11e5-8149-f23c91c841bd	As close to a new unit as you can get.  One end of this building caught on fire 2011.  Whole building was renovated by insurance Co.  New 2011 &12: HVAC, windows, carpet, vinyl, paint, sheetrock, cabinets, appliances and more.  Seller financing available; have payments less than rent!  See Media for details.  Also for rent for $850 per month.	104.700854700854705	2016-01-23 23:18:45.532427+01	2016-01-23 23:18:45.532427+01	2356489	Residential	RES-Condo	32657.8595317725776	\N	{}	{}	{}	{"Thermo Windows"}	{}	{"Window Coverings"}	{}	{"Wood Burning"}	{}	{"Assigned Spaces",Covered,Detached}	{}	{}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,Vinyl}	{"City Sewer","City Water"}	{}	{Traditional}	Condo/Townhome	2	3	\N	2	\N	\N	\N	1	1	1			Stucco		Slab	Composition	f	f	Vickerymea		\N		Tasby			Dallas ISD	Tealwood-On-The-Creek Condo	f	P	\N			\N	8.07000000000000028		U	\N	\N	f	5	8	f		\N	Preowned		f	\N	\N
8e0ae0a2-be11-11e5-aac7-f23c91c841bd	3	3.10000000000000009	8d4bdf72-be11-11e5-aac7-f23c91c841bd	Updated 3 story townhome in desirable North Oak Lawn area. 3 bedrooms and 3.5 bathroom. Property features updated open kitchen, hardwoods throughout, private patio and attached 2-car garage. Upstairs master includes fire place, updated master bath and walk-in closet.  Walking distance to restaurants, grocery store and more.	170.382757339279095	2016-01-18 19:30:31.146083+01	2016-01-19 08:04:02.56923+01	59096317	Residential	RES-Townhouse	744.615384615384642	2008	{}	{}	{}	{"Ceiling Fans"}	{Balcony,"Patio Open"}	{"Cable TV Available","High Speed Internet Available","Window Coverings"}	{}	{Brick}	{"Interior Lot"}	{Attached,Garage,"Garage Door Opener"}	{}	{}	{}	2	1	3	{"Central Air-Elec","Central Heat-Gas"}	{"Ceramic Tile",Wood}	{"City Sewer","City Water"}	{}	{Traditional}	Condo/Townhome	3	\N	\N	\N	2	\N	\N	\N	1	2	9		Brick,Rock/Stone		Slab	Composition	f	f	Milam		\N		Rusk			Dallas ISD	North Oak Lawn	f		\N			\N	0.183999999999999997			\N	\N	f	11	6	f		\N	Preowned		f	\N	\N
83676f52-ba34-11e5-849e-f23c91c841bd	3	3.10000000000000009	827b4abe-ba34-11e5-849e-f23c91c841bd	Ideally located just outside HP. Modern-traditional end-unit townhome with a wonderful rare iron gated front yard. Beautifully maintained, great curb appeal. 3 BR with 3.5 baths, spacious Master BR,BA, enormous closet. Kitchen includes 42-inch maple cabinets, dark granite countertops, SS appls. Wood floors throughout the kitchen, dining, living areas. Gracious, large balcony with a storage closet is located on the 2nd flr with access to kitchen.	209.401709401709411	2016-01-13 21:30:41.03213+01	2016-02-18 13:14:06.387414+01	59052080	Residential	RES-Townhouse	0	2005	{}	{}	{}	{"Attic Fan","Ceiling Fans","Double Pane Windows","Gas Water Heater","Programmable Thermostat"}	{Balcony,"Covered Porch(es)"}	{"Cable TV Available","High Speed Internet Available","Plantation Shutters","Vaulted Ceilings","Window Coverings"}	{}	{"Gas Logs","Gas Starter"}	{"Interior Lot","No Backyard Grass"}	{Attached,Covered,"Garage Door Opener",Rear}	{}	{Burglar,Fire/Smoke,Owned,Pre-Wired}	{}	2	1	3	{"Central Air-Elec","Central Heat-Gas",Zoned}	{Carpet,"Ceramic Tile",Wood}	{"City Sewer","City Water",Curbs,Sidewalk}	{}	{Contemporary/Modern,Traditional}	Condo/Townhome	3	\N	\N	\N	2	\N	\N	1	1	1	2C	Unknown	Brick		Slab	Composition	f	f	Milam		\N		Rusk			Dallas ISD	Holland Ave Sec 02	f		\N			\N	\N			\N	\N	f	24	8	f		\N	Preowned		t	\N	0
db74d546-bb28-11e5-b7d3-f23c91c841bd	2	2.10000000000000009	dad9743e-bb28-11e5-b7d3-f23c91c841bd	Magnificent townhome ideally situated in the heart of the city, just minutes away from all of the Dallas hotspots. This exceptional updated townhome spans over three levels offering exceptional entertaining space, island kitchen, open floor plan, high ceilings, custom floors, moldings, gourmet kitchen with gas range, granite countertops, spacious living quarters, and amazing third floor balcony with views of the city.	222.686733556298776	2016-01-15 02:39:45.961736+01	2016-01-15 02:39:45.961736+01	37919010	Residential	RES-Townhouse	2885.38461538461524	\N	{}	{}	{Other}	{"Ceiling Fans","Double Pane Windows","Gas Water Heater","Programmable Thermostat"}	{Balcony,Gutters,"Sprinkler System"}	{"Cable TV Available","Decorative Lighting","Flat Screen Wiring","High Speed Internet Available",Other,"Sound System Wiring","Vaulted Ceilings","Window Coverings"}	{}	{}	{Corner,"Heavily Treed",Landscaped}	{Attached,Covered,Other,Rear}	{}	{Burglar,"Fire Sprinkler System",Fire/Smoke,"Smoke Detector"}	{}	2	1	2	{"Central Air-Elec","Central Air-Gas"}	{Carpet,"Ceramic Tile",Wood}	{"City Sewer","City Water"}	{}	{Contemporary/Modern}	Condo/Townhome	3	\N	\N	\N	2	\N	\N	1	1	\N	3j		Brick,Rock/Stone,Stucco		Slab	Composition	f	f	Houston		\N		Spence			Dallas ISD	Marc Condo	f		\N			\N	0.712999999999999967	TBD	X	\N	\N	f	24	11	f		\N	Preowned		t	\N	\N
19c42550-c31b-11e5-913c-f23c91c841bd	3	2	19161474-c31b-11e5-913c-f23c91c841bd	Clean house at end on tear drop cul-de-sac. Overlooks pond. Has a storage building or playhouse. Hot tub of huge covered porch. Very private backyard. See it today!	109.345968041620225	2016-01-25 05:21:26.84829+01	2016-01-25 05:21:26.84829+01	1640052	Residential	RES-Single Family	0	\N	{}	{}	{}	{}	{"Covered Porch(es)","Patio Covered","Sprinkler System","Storage Building"}	{Skylights}	{}	{"Gas Starter","Wood Burning"}	{"Cul De Sac"}	{Attached}	{"Separate Spa/Hot Tub"}	{}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,Vinyl}	{"City Sewer","City Water"}	{}	{Traditional}	Single Detached	1	\N	\N	\N	2	18	23	1	1	1	13	Black	Brick,Wood		Slab	Composition	f	f	Pleasantgr		\N		Florence			Dallas ISD	LAKE EAST ESTS	f		\N			\N	\N	39X170	E	\N	\N	f	1	6	f		\N	Preowned		f	\N	\N
61315caa-ba74-11e5-8082-f23c91c841bd	2	2.10000000000000009	60b86750-ba74-11e5-8082-f23c91c841bd	CityScape Plaza:39 MODERN GATED TOWNHOMES IN THE VIBRANT & CONVENIENT ROSS AVE CORRIDOR.FANTASTIC LOCATION BETWEEN BEAUTIFUL WHITE ROCK LAKE AND THE MANY ATTRACTIONS OF THE DALLAS ARTS DISTRICT,UPTOWN & DOWNTOWN!TOP NOTCH FINISH OUT,BOSCH&BERTAZZONI PREMIUM SS APPLIANCE PKG. STD!!LARGE UNITS,HIGH CEILINGS,LARGE CLOSETS,HARD WEARING&BEAUTIFUL COMMERCIAL GRADE FLOORING IN LIV.AREAS,PATIOS,PRIVATE GARAGES, AVAILABLE BALCONIES&ROOFTOP DECKS!DOG PARK!	178.372352285395777	2016-01-14 05:07:51.426095+01	2016-01-14 05:07:51.426095+01	51177813	Residential	RES-Townhouse	0	\N	{}	{}	{"Gated Entrance",Park,"Perimeter Fencing"}	{"13-15 SEER AC"}	{Balcony,Gutters,"Lighting System","Patio Open"}	{"Cable TV Available","Decorative Lighting","High Speed Internet Available","Smart Home System"}	{}	{}	{"Interior Lot",Landscaped}	{Attached,"Garage Door Opener"}	{}	{Burglar,"Exterior Security Light(s)",Fire/Smoke,"Smoke Detector"}	{}	2	1	2	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,"Ceramic Tile",Laminate}	{"City Sewer","City Water","Individual Water Meter"}	{}	{Contemporary/Modern,Traditional}	Condo/Townhome	3	\N	\N	\N	2	23	20	1	1	\N			Rock/Stone,Stucco		Slab	Composition	f	f	Chavez		\N		Spence			Dallas ISD	CITYSCAPE PLAZA TOWNHOMES	f		\N		Low Flow Commode	\N	\N			\N	\N	f	-1	\N	f		\N	New Construction - Incomplete		t	\N	\N
ba173518-c1fb-11e5-9ed4-f23c91c841bd	3	2.20000000000000018	b9c79116-c1fb-11e5-9ed4-f23c91c841bd	With its gray stucco exterior and magnificent windows, this 2,821-square-foot residence boasts 10-foot ceilings, hardwood cabinets and a marvelous getaway room on the third level and covered terrace. In addition to a fabulous master suite with sitting room and two guestrooms and bath on the second level, the ground level is ideal for entertaining. And it's on a quiet street in the ever-active Oak Lawn neighborhood.	262.077294685990353	2016-01-23 19:04:20.769933+01	2016-01-23 19:04:20.769933+01	2317178	Residential	RES-Single Family	0	\N	{}	{}	{}	{}	{Balcony,Gutters,"Lighting System","Patio Open"}	{"Cable TV Available","Decorative Lighting","Flat Screen Wiring","High Speed Internet Available","Multiple Staircases","Plantation Shutters","Sound System Wiring","Vaulted Ceilings","Wet Bar","Window Coverings"}	{}	{"Gas Logs","Gas Starter"}	{Landscaped,"Some Trees"}	{Attached,Front,Opener}	{}	{Burglar,Fire/Smoke,"Smoke Detector"}	{}	2	2	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,Stone,Wood}	{"City Sewer","City Water",Curbs,Sidewalk}	{}	{Mediterranean,Traditional}	Single Detached	3	\N	\N	\N	2	\N	\N	1	2	1	14B	Unknown	Stucco		Slab	Composition	f	f	Milam		\N		Rusk			Dallas ISD	Entrusca	f		\N			\N	\N	Zero Lot line	T	\N	\N	f	22	16	f		\N	Preowned		t	\N	\N
2b716938-c2c7-11e5-a9d7-f23c91c841bd	4	2.10000000000000009	2b2d6954-c2c7-11e5-a9d7-f23c91c841bd	Spacious 4 bedroom 2.5 bath and large deck with a stunning creek view.	287.718320327015988	2016-01-24 19:20:38.779793+01	2016-01-24 19:20:38.779793+01	1119877	Residential Lease	LSE-House	0	\N	{}	{}	{}	{}	{Deck}	{}	{}	{Brick}	{"Heavily Treed"}	{"Individual Carport"}	{}	{}	{}	2	1	2	{}	{Carpet,"Ceramic Tile"}	{}	{}	{Mediterranean}	Single Detached	1	\N	\N	2	\N	\N	\N	2	2	1	1		Brick				f	f	Wallace		\N	Lakehighla				Richardson ISD	THE HIGHLANDS	t		\N			\N	\N	63X132	N	2	\N	t	1	3	f		\N	Preowned		t	\N	\N
ed0fefce-c2cc-11e5-aa15-f23c91c841bd	3	2	ecac6710-c2cc-11e5-aa15-f23c91c841bd	WONDERFUL PROPERTY IN GREAT NORTHEAST DALLAS LOCATION! CLOSE TO MAJOR HWYS, SHOPPING & DINING. PROPERTY IS IN GREAT CONDITION AND HAS BEEN WELL MAINTAINED. PARQUET WOOD FLOORING THROUGHOUT, NEW CEILING FAN, NEW MICROWAVE AND MORE UPDATES. GREAT HUGE FENCED-IN BACKYARD, KIDS' PLAYHOUSE, STORAGE SHED, ADDITIONAL PARKING AREA WITH BACKGATE. REFRIGERATOR AND WASHER & DRYER INCLUDED IN MONTHLY RENT. $35 APPLICATION FEE PER PERSON.	127.276105536975109	2016-01-24 20:01:51.102603+01	2016-01-24 20:01:51.102603+01	1298515	Residential Lease	LSE-House	930.769230769230717	\N	{}	{}	{Other}	{"Ceiling Fans"}	{"Covered Porch(es)",Gutters,"Patio Covered","Patio Open","Sprinkler System"}	{"Cable TV Available",Other}	{}	{}	{Corner,"Some Trees"}	{Garage,"Garage Door Opener"}	{}	{"Smoke Detector"}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Gas"}	{Parquet,Wood}	{Alley,"City Sewer","City Water"}	{}	{Traditional}	Single Detached	1	\N	\N	\N	2	19	19	1	2	\N	11		Brick				f	f	Highlndmea		\N		Hill			Dallas ISD	Barkley Square 02	t		\N			\N	0.23000000000000001	85X120	X	\N	\N	t	-1	9	f		\N	Preowned		f	\N	\N
6f241cc2-c1e9-11e5-af0e-f23c91c841bd	3	2	6ec90d46-c1e9-11e5-af0e-f23c91c841bd	Updated half duplex with 3 good size bedrooms and 2 full baths. Nice kitchen with replaced appliances, both baths updated. Great location.	171.218877740616875	2016-01-23 16:53:24.083711+01	2016-01-23 16:53:24.083711+01	2083889	Residential	RES-Half Duplex	0	\N	{}	{}	{}	{}	{Deck,"Patio Open","Sprinkler System"}	{"Cable TV Available"}	{}	{Brick,"Gas Starter"}	{Landscaped}	{Attached,Opener,Rear}	{}	{}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,"Ceramic Tile",Wood}	{"City Sewer","City Water",Curbs,Sidewalk}	{}	{Traditional}	Attached or 1/2 Duplex	1	\N	\N	\N	2	\N	\N	1	1	1	5	Unknown	Brick,Common Wall,Wood		Slab	Composition,Tar/Gravel	f	f	Kramer		\N		Franklin			Dallas ISD	Crest Meadow Estates	f		\N			\N	\N	ZERO	J	\N	\N	f	1	9	f		\N	Preowned		f	\N	\N
dae2b0d0-c1f4-11e5-9606-f23c91c841bd	4	2	da554a56-c1f4-11e5-9606-f23c91c841bd	MEDITERRANEAN STYLE HOME FABULOUSLY RENOVATED INCLUDING HARDWOODS IN MASTER BEDROOM,LIVING,DINING,RECESSED LIGHTING,GOURMET KITCHEN WITH SLATE FLOORS+ GRANITE COUNTERTOPS. KITCHEN BOASTS STAINLESS STEEL APPLIANCES.FRENCH DOORS TO DECK.MATURE TREES.MASTER BATH WITH SLATE SHOWER+FLOOR+PEDESTAL SINK.	200.297287253809003	2016-01-23 18:15:09.313504+01	2016-01-23 18:15:09.313504+01	1462373	Residential	RES-Single Family	768.89632107023408	\N	{}	{}	{}	{"Ceiling Fans"}	{Deck,"Sprinkler System"}	{"Sound System Wiring","Vaulted Ceilings"}	{}	{"Wood Burning"}	{Corner}	{Attached,Rear}	{}	{}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,Slate,Wood}	{"City Sewer","City Water"}	{}	{Mediterranean}	Single Detached	1	\N	\N	\N	2	\N	\N	2	1	1	10	Unknown	Brick		Slab	Composition	f	f	Lakewood		\N		Long				LAKEWOOD NORTH ESTS	f		\N			\N	0.190000000000000002	75 X 110	J	\N	\N	f	1	7	f		\N	Preowned		f	\N	\N
7bbb9658-ba9c-11e5-b276-f23c91c841bd	3	3	7b7b206e-ba9c-11e5-b276-f23c91c841bd	1909 Victorian, original acantheus crowns, fluted columns, front porch, 2nd story, balcony. Original duplex converted 1990. Huge living room, wonderful kitchen, great condition, painted, inside sprinkler outside. New roof, new drive way.	234.856930509104444	2016-01-14 09:54:55.821981+01	2016-01-14 09:54:55.821981+01	50830245	Residential	RES-Single Family	651.538461538461547	\N	{}	{}	{}	{"Ceiling Fans","Gas Water Heater","High Efficiency Water Heater",Turbines}	{Balcony,"Covered Porch(es)","Guest Quarters","Patio Open","Sprinkler System","Storage Building"}	{"Plantation Shutters"}	{}	{}	{}	{"Outside Entry",Rear}	{}	{Owned}	{}	4	\N	3	{"Central Air-Elec","Central Air-Gas"}	{Wood}	{"City Sewer","City Water","Individual Gas Meter","Individual Water Meter",Sidewalk}	{}	{Victorian}	Historical/Conservation Dist.	2	\N	\N	\N	\N	\N	\N	2	3	\N	8	Unknown	Wood		Bois DArc Post,Pier & Beam	Composition	f	f	Lipscomb		\N		Long			Dallas ISD	Munger Place Add	f		\N			\N	0.161000000000000004	141x53		\N	\N	f	25	5	f		\N	Preowned		t	\N	\N
e36a4528-bcc8-11e5-b3df-f23c91c841bd	4	3	e31e4e70-bcc8-11e5-b3df-f23c91c841bd	Cul-de-sac setting in N. Dallas. Home has 2 beds down.  Large family & formal living.  Panoramic views of pool spa from 3 sides of home. Great wood floors thruout entry, walkways, kitchen & breakfast nook. Both down living areas w fp. Huge master bed w updated bath. Upstairs has loft w built-in bookshelves, 2 beds & J & J bath.  Kit w double oven, compactor, built-in MW, lots of cabinets & counters. Recent updts: all interior paint & carpeting.	296.822742474916424	2016-01-17 04:17:49.953709+01	2016-01-17 04:17:49.953709+01	2450807	Residential	RES-Single Family	809.364548494983296	\N	{}	{}	{}	{"Ceiling Fans","Gas Water Heater","Programmable Thermostat","Thermo Windows"}	{Gutters,"Lighting System","Patio Covered","Sprinkler System"}	{"Cable TV Available","High Speed Internet Available",Intercom,Loft,"Wet Bar","Window Coverings"}	{}	{"Gas Logs","Gas Starter","Wood Burning"}	{"Cul De Sac",Irregular,Landscaped,"Some Trees",Subdivision}	{Attached,Opener,Rear}	{"Attached Spa","Cleaning System","In Ground Gunite","Play Pool"}	{Burglar,Owned,"Smoke Detector"}	{}	3	\N	3	{"Central Air-Elec","Central Heat-Gas",Zoned}	{Carpet,"Ceramic Tile",Parquet,Vinyl}	{"City Sewer","City Water",Concrete,Curbs,Sidewalk}	{}	{Traditional}	Single Detached	2	\N	\N	\N	3	18	22	2	3	2	9		Brick		Slab	Composition	t	f	Jackson		\N		Frankford		Planowest	Plano ISD	Highland Creek Estates	f		\N			\N	0.200000000000000011	19x21x120x41x96x85	D	\N	\N	f	25	15	f		\N	Preowned		t	\N	\N
a507cefc-c2ce-11e5-beb0-f23c91c841bd	3	2	a4b751e8-c2ce-11e5-beb0-f23c91c841bd	BEAUTIFUL TWO STORY TOWNHOME IN WONDERFUL CUL DE SAC WITH LARGE LIVING & DINING AREA WITH HARDWOOD FLOORS AND FIREPLACE.ONE BEDROOM DOWN WITH FULL BATH.TWO BEDROOMS UP WITH JACK AND JILL BATH.FULL SIZE WASHER & DRYER CONNECTIONS.FENCED YARD.YARD SERVICE INCLUDED.NO PETS OR SMOKERS.L	144.184318097361597	2016-01-24 20:14:09.246832+01	2016-01-24 20:14:09.246832+01	1320842	Residential Lease	LSE-Condo/Townhome	0	\N	{}	{}	{}	{"Ceiling Fans"}	{"Patio Open"}	{}	{}	{"Wood Burning"}	{"Cul De Sac"}	{Garage,"Garage Door Opener"}	{}	{}	{"Jack & Jill Bath","Walk-in Closets"}	2	\N	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,Wood}	{}	{}	{}	Condo/Townhome	2	\N	\N	\N	2	20	20	1	1	1	16A		Brick				f	f			\N					Dallas ISD	LOUANN #3	t		\N			\N	\N	20X115	D	\N	\N	f	-1	2	f		\N	Preowned		f	\N	\N
735fbdd2-c1fd-11e5-a990-f23c91c841bd	1	1	731948f2-c1fd-11e5-a990-f23c91c841bd	Luxury 1BR condo at Victory Park offers FULL DOWNTOWN VIEW and a LARGE PRIVATE PATIO (approx. 290sf).  Upscale window treatments and energy efficient washer & dryer included.  Pool and gym on property.  Live in the middle of one of the most exciting new urban developments in the nation.  Walk to AA Center, W Hotel, Ghost Bar, Downtown Dallas, DART rail and numerous restaurants, bars and cultural facilities.  Unit repainted and recarpeted in 2009.	71.9992567818654834	2016-01-23 19:16:41.120459+01	2016-01-23 19:16:41.120459+01	1380895	Residential Lease	LSE-Condo/Townhome	3690.70234113712422	\N	{Elevator}	{}	{"Common Elevator","Community Pool","Guarded Entrance"}	{"Double Pane Windows","Programmable Thermostat"}	{"Patio Open"}	{"Cable TV Available","Decorative Lighting","High Speed Internet Available"}	{}	{}	{}	{"Assigned Spaces",Garage}	{}	{Burglar,"Fire Sprinkler System","Smoke Detector"}	{}	1	\N	1	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,"Ceramic Tile",Wood}	{}	{}	{Contemporary/Modern}	Condo/Townhome	1	\N	\N	\N	1	20	10	1	1	\N			Brick				t	f	Citypark		\N		Medrano			Dallas ISD	Terrace Condos	t		\N			\N	0.912000000000000033		J	2	\N	t	1	4	f		\N	Preowned		t	\N	\N
1e9020d2-bb43-11e5-bcc2-f23c91c841bd	4	2	1e464ac0-bb43-11e5-bcc2-f23c91c841bd	Lovely 4 bedroom home in established Druid Hills neighborhood on large lot. Home features master bedroom down and 3 bedrooms upstairs. Two large living areas and areas dining areas. Large covered patio in backyard. Oversized garage, additional carport, and additional parking pad in rear. Opportunity to enclose entire backyard with privacy fence and gate to open up backyard area. Less than 8 miles to downtown Dallas and 5 miles to Bishop Arts.	192.679301374953553	2016-01-15 05:47:45.462836+01	2016-01-15 05:47:45.462836+01	44370476	Residential	RES-Single Family	914.581939799331167	\N	{}	{}	{}	{"Ceiling Fans","Gas Water Heater"}	{"Covered Porch(es)",Gutters,"Patio Covered","Patio Open","Sprinkler System"}	{"Cable TV Available","High Speed Internet Available","Window Coverings"}	{}	{Brick}	{Landscaped,"Lrg. Backyard Grass","Some Trees"}	{Attached,Opener,Rear}	{}	{Burglar}	{}	4	\N	2	{"Central Air-Elec","Central Heat-Gas"}	{Carpet,Parquet,Vinyl}	{"City Sewer","City Water"}	{}	{Traditional}	Single Detached	2	\N	\N	2	2	20	23	2	2	1	2		Brick,Rock/Stone		Pier & Beam	Composition	f	f	Carpenter		\N		Browne			Dallas ISD	Druid Hills 02	f		\N			\N	0.226000000000000006			\N	\N	f	25	12	f		\N	Preowned		t	\N	\N
ff8dd628-d36d-11e5-89e7-f23c91c841bd	3	3	ff3f4080-d36d-11e5-89e7-f23c91c841bd	Luxury Tuscany townhome in SOHIP neighborhood is one of five with manicured grounds, stucco walls, & red tile roofs. Plantation shutters, hdwd floors, tankless hot water heater & an abundance of storage contributes to the high end finish out of this home. Gourmet kitchen with 2 Jenn-Aire gas ranges, built in fridge freezer, & separate pantry are a cook's dream. Each floor boasts one bedroom each having their own private bath.	268.766257896692707	2016-02-14 23:55:09.704087+01	2016-02-16 07:05:20.357876+01	59698128	Residential	RES-Townhouse	0	2005	{}	{}	{}	{"Double Pane Windows"}	{"Patio Open","Sprinkler System"}	{"Cable TV Available","High Speed Internet Available","Plantation Shutters","Sound System Wiring","Water Filter"}	{}	{"Gas Logs"}	{Landscaped}	{Attached,"Garage Door Opener",Opener}	{}	{Burglar,Fire/Smoke,"Smoke Detector"}	{}	2	\N	3	{"Central Air-Elec","Central Heat-Gas",Zoned}	{Carpet,"Ceramic Tile",Wood}	{"City Sewer","City Water"}	{}	{Mediterranean}	Condo/Townhome	3	\N	\N	\N	2	18	20	1	2	1	15D	Unknown	Stucco		Slab	Other,Tile/Slate	f	f	Milam		\N		Rusk			Dallas ISD	Lexington Bristol	f		\N			\N	\N			\N	\N	f	13	9	f		\N	Preowned		t	\N	\N
561a689a-c1f7-11e5-8b8e-f23c91c841bd	5	4.09999999999999964	55bece4a-c1f7-11e5-8b8e-f23c91c841bd	Lovely, well maintained traditional in exclusive Windsor Park. Split floor plan offers 4 or 5 bedrooms, 4 full baths plus powder room. Large brick fireplace-hearth in Family Room with beamed, vaulted cieling & indirect lighting. Elegant Master suite complete with walk in closets, dressing area and marble bath. Additional amenities include crown molding, plantation shutters, wet bar, sprinkler and security systems and 3 car garage.	316.610925306577485	2016-01-23 18:32:55.031647+01	2016-01-23 18:32:55.031647+01	1863063	Residential	RES-Single Family	0	\N	{}	{}	{}	{}	{"Covered Porch(es)"}	{"Bay Windows"}	{}	{"Gas Starter"}	{"Interior Lot"}	{Attached}	{}	{}	{}	3	1	4	{"Central Air-Elec","Central Heat-Elec"}	{Wood}	{"City Water"}	{}	{Traditional}	Single Detached	1	\N	\N	\N	3	34	23	2	2	1	13		Brick		Slab	Composition	f	f	Prestonhol		\N		Franklin			Dallas ISD	WINDSOR PARK	f		\N			\N	\N	86X140	R	\N	\N	f	1	11	f		\N	Preowned		t	\N	\N
b46a7bd4-c30e-11e5-9a55-f23c91c841bd	3	2	b4195f4c-c30e-11e5-9a55-f23c91c841bd	Oversized lot! Must see!	160.720921590486824	2016-01-25 03:52:42.849947+01	2016-01-25 03:52:42.849947+01	1933053	Residential	RES-Single Family	813.411371237458184	\N	{}	{}	{}	{}	{}	{"Vaulted Ceilings"}	{}	{"Wood Burning"}	{Corner,Landscaped}	{Attached,Rear}	{}	{Fire/Smoke,Pre-Wired}	{}	2	\N	2	{"Central Air-Elec","Central Heat-Elec"}	{Carpet,Vinyl}	{"City Sewer","City Water"}	{}	{Traditional}	Single Detached	1	\N	\N	\N	2	20	18	2	1	1	10		Brick		Slab	Composition	f	f	Moseley		\N		Comstock			Dallas ISD	Brierwood Heights Ph 02	f		\N			\N	0.201000000000000012	62X124	G	\N	\N	f	1	7	f		\N	New Construction - Complete		f	\N	\N
219a00de-c22f-11e5-bacf-f23c91c841bd	\N	\N	20e8bdec-c22f-11e5-bacf-f23c91c841bd	5135 Lawnview     Approximately 6500 square feet zoned light industrial with road frontage on Lawnview.  Located .5 miles off 1-30 and Ferguson.  Seller will sell separately or as a package with 5115, 5121-23, 5125, 5137,5141 Lawnview.  Seller will consider Seller Financing.	0	2016-01-24 01:12:18.765685+01	2016-01-24 01:12:18.765685+01	1164904	Commercial	COM-Sale	0	\N	{}	{"Fenced Outside Storage","Loading Dock",Other}	{}	{}	{}	{}	{}	{}	{}	{Open}	{}	{}	{}	\N	\N	\N	{"Gas Jets",Other}	{Concrete}	{"City Sewer","City Water",Concrete,Other}	{}	{}		1	\N	\N	\N	\N	\N	\N	\N	\N	\N			Brick,Metal	Other	Slab	Built-Up,Metal	f	f			\N						TR 27	f		15			\N	\N		F	\N	1	f	1	\N	f		\N	Preowned		f	\N	6500
\.


--
-- Data for Name: property_rooms; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY property_rooms (id, matrix_unique_id, matrix_modified_dt, description, length, width, features, listing_mui, level, room_type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: property_units; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY property_units (id, dining_length, dining_width, kitchen_length, kitchen_width, lease, listing_mui, living_length, living_width, master_length, master_width, matrix_unique_id, matrix_modified_dt, full_bath, half_bath, beds, units, square_feet, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: recommendations; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY recommendations (id, source, source_url, room, created_at, updated_at, listing, recommendation_type, matrix_unique_id, referring_objects, deleted_at, hidden, last_update) FROM stdin;
\.


--
-- Data for Name: recommendations_eav; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY recommendations_eav (id, "user", action, created_at, recommendation) FROM stdin;
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY reviews (id, created_at, deleted_at, deal, file, envelope_document) FROM stdin;
\.


--
-- Data for Name: reviews_history; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY reviews_history (id, created_at, created_by, review, state, comment) FROM stdin;
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY rooms (id, title, owner, created_at, updated_at, deleted_at, room_type) FROM stdin;
\.


--
-- Name: rooms_room_code_seq; Type: SEQUENCE SET; Schema: public; Owner: emilsedgh
--

SELECT pg_catalog.setval('rooms_room_code_seq', 3183, true);


--
-- Data for Name: rooms_users; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY rooms_users (id, room, "user", created_at, updated_at, push_enabled, phone_handler, archived, reference) FROM stdin;
\.


--
-- Data for Name: seamless_phone_pool; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY seamless_phone_pool (id, phone_number, enabled) FROM stdin;
5b22c256-9474-11e6-81a7-0242ac110005	+18587324287	t
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY sessions (id, device_id, device_name, client_version, created_at) FROM stdin;
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: stripe_charges; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY stripe_charges (id, created_at, updated_at, "user", customer, amount, charge) FROM stdin;
\.


--
-- Data for Name: stripe_customers; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY stripe_customers (id, owner, customer_id, source, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY users (username, first_name, last_name, email, phone_number, created_at, id, password, address_id, cover_image_url, profile_image_url, updated_at, user_status, profile_image_thumbnail_url, cover_image_thumbnail_url, email_confirmed, timezone, user_type, deleted_at, phone_confirmed, agent, secondary_password, is_shadow, personal_room, brand, fake_email, facebook_access_token, features) FROM stdin;
\N	Unit	Test	test@rechat.com	+4368120265807	2017-04-25 12:18:18.770362+02	80a227b2-29a0-11e7-b636-e4a7a08e15d4	$2a$05$ZR/hk8PNLI8ufjQHPMyU4.YLf7Si0eljscmM0BZ7yNchctjZp0Cje	\N	\N	\N	2017-04-25 12:18:18.770744+02	Active	\N	\N	t	America/Chicago	Admin	\N	f	\N	206cc0a36c8ecfa37639a4d0dc682c73	f	\N	\N	f	\N	["Deals"]
\.


--
-- Name: users_user_code_seq; Type: SEQUENCE SET; Schema: public; Owner: emilsedgh
--

SELECT pg_catalog.setval('users_user_code_seq', 2014, true);


--
-- Data for Name: websites; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY websites (id, created_at, updated_at, "user") FROM stdin;
\.


--
-- Data for Name: websites_hostnames; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY websites_hostnames (id, website, hostname, "default") FROM stdin;
\.


--
-- Data for Name: websites_snapshots; Type: TABLE DATA; Schema: public; Owner: emilsedgh
--

COPY websites_snapshots (id, website, created_at, updated_at, brand, template, attributes) FROM stdin;
\.


SET search_path = tiger, pg_catalog;

--
-- Data for Name: foo; Type: TABLE DATA; Schema: tiger; Owner: emilsedgh
--

COPY foo (geom, title) FROM stdin;
\.


SET search_path = public, pg_catalog;

--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: agents_images agents_images_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY agents_images
    ADD CONSTRAINT agents_images_pkey PRIMARY KEY (id);


--
-- Name: agents agents_matrix_unique_id_key; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY agents
    ADD CONSTRAINT agents_matrix_unique_id_key UNIQUE (matrix_unique_id);


--
-- Name: agents agents_mlsid; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY agents
    ADD CONSTRAINT agents_mlsid UNIQUE (mlsid);


--
-- Name: agents agents_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY agents
    ADD CONSTRAINT agents_pkey PRIMARY KEY (id);


--
-- Name: alerts alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (id);


--
-- Name: attachments_eav attachments_eav_object_attachment_key; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY attachments_eav
    ADD CONSTRAINT attachments_eav_object_attachment_key UNIQUE (object, attachment);


--
-- Name: attachments attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- Name: brands_parents brands_parents_brand_key; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY brands_parents
    ADD CONSTRAINT brands_parents_brand_key UNIQUE (brand);


--
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: deals deals_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY deals
    ADD CONSTRAINT deals_pkey PRIMARY KEY (id);


--
-- Name: deals_roles deals_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY deals_roles
    ADD CONSTRAINT deals_roles_pkey PRIMARY KEY (id);


--
-- Name: docusign_users docusign_user_code; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY docusign_users
    ADD CONSTRAINT docusign_user_code UNIQUE ("user");


--
-- Name: docusign_users docusign_users_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY docusign_users
    ADD CONSTRAINT docusign_users_pkey PRIMARY KEY (id);


--
-- Name: envelopes_documents envelopes_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY envelopes_documents
    ADD CONSTRAINT envelopes_documents_pkey PRIMARY KEY (id);


--
-- Name: envelopes envelopes_docusign_id_key; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY envelopes
    ADD CONSTRAINT envelopes_docusign_id_key UNIQUE (docusign_id);


--
-- Name: envelopes envelopes_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY envelopes
    ADD CONSTRAINT envelopes_pkey PRIMARY KEY (id);


--
-- Name: envelopes_recipients envelopes_recipients_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY envelopes_recipients
    ADD CONSTRAINT envelopes_recipients_pkey PRIMARY KEY (id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: files_relations files_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY files_relations
    ADD CONSTRAINT files_relations_pkey PRIMARY KEY (id);


--
-- Name: forms_data forms_data_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY forms_data
    ADD CONSTRAINT forms_data_pkey PRIMARY KEY (id);


--
-- Name: forms forms_formstack_id_key; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT forms_formstack_id_key UNIQUE (formstack_id);


--
-- Name: forms forms_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT forms_pkey PRIMARY KEY (id);


--
-- Name: forms_submissions forms_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY forms_submissions
    ADD CONSTRAINT forms_submissions_pkey PRIMARY KEY (id);


--
-- Name: godaddy_domains godaddy_domains_name_key; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY godaddy_domains
    ADD CONSTRAINT godaddy_domains_name_key UNIQUE (name);


--
-- Name: godaddy_shoppers godaddy_shoppers_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY godaddy_shoppers
    ADD CONSTRAINT godaddy_shoppers_pkey PRIMARY KEY (id);


--
-- Name: listings listings_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (id);


--
-- Name: messages_acks messages_acks_message_room_user_key; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY messages_acks
    ADD CONSTRAINT messages_acks_message_room_user_key UNIQUE (message, room, "user");


--
-- Name: messages_acks messages_acks_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY messages_acks
    ADD CONSTRAINT messages_acks_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: notifications_tokens notification_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY notifications_tokens
    ADD CONSTRAINT notification_tokens_pkey PRIMARY KEY (id);


--
-- Name: notifications_tokens notification_tokens_user_device_id; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY notifications_tokens
    ADD CONSTRAINT notification_tokens_user_device_id UNIQUE ("user", device_id);


--
-- Name: notifications_deliveries notifications_deliveries_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY notifications_deliveries
    ADD CONSTRAINT notifications_deliveries_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: notifications_users notifications_users_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY notifications_users
    ADD CONSTRAINT notifications_users_pkey PRIMARY KEY (id);


--
-- Name: offices offices_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY offices
    ADD CONSTRAINT offices_pkey PRIMARY KEY (id);


--
-- Name: open_houses open_houses_matrix_unique_id_key; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY open_houses
    ADD CONSTRAINT open_houses_matrix_unique_id_key UNIQUE (matrix_unique_id);


--
-- Name: photos photos_matrix_unique_id_key; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT photos_matrix_unique_id_key UNIQUE (matrix_unique_id);


--
-- Name: properties properties_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY properties
    ADD CONSTRAINT properties_pkey PRIMARY KEY (id);


--
-- Name: property_rooms property_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY property_rooms
    ADD CONSTRAINT property_rooms_pkey PRIMARY KEY (id);


--
-- Name: recommendations_eav recommendations_eav_user_recommendation_action_key; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY recommendations_eav
    ADD CONSTRAINT recommendations_eav_user_recommendation_action_key UNIQUE ("user", recommendation, action);


--
-- Name: recommendations recommendations_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY recommendations
    ADD CONSTRAINT recommendations_pkey PRIMARY KEY (id);


--
-- Name: recommendations recommendations_room_listing_key; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY recommendations
    ADD CONSTRAINT recommendations_room_listing_key UNIQUE (room, listing);


--
-- Name: reviews_history reviews_history_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY reviews_history
    ADD CONSTRAINT reviews_history_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: invitation_records rooms_invitation_records_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY invitation_records
    ADD CONSTRAINT rooms_invitation_records_pkey PRIMARY KEY (id);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: rooms_users rooms_users_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY rooms_users
    ADD CONSTRAINT rooms_users_pkey PRIMARY KEY (id);


--
-- Name: rooms_users rooms_users_room_user_key; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY rooms_users
    ADD CONSTRAINT rooms_users_room_user_key UNIQUE (room, "user");


--
-- Name: seamless_phone_pool seamless_phone_pool_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY seamless_phone_pool
    ADD CONSTRAINT seamless_phone_pool_pkey PRIMARY KEY (id);


--
-- Name: stripe_charges stripe_charges_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY stripe_charges
    ADD CONSTRAINT stripe_charges_pkey PRIMARY KEY (id);


--
-- Name: stripe_customers stripe_customers_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY stripe_customers
    ADD CONSTRAINT stripe_customers_pkey PRIMARY KEY (id);


--
-- Name: godaddy_shoppers unique_user; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY godaddy_shoppers
    ADD CONSTRAINT unique_user UNIQUE ("user");


--
-- Name: property_units units_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY property_units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_phone_number_key UNIQUE (phone_number);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: websites_hostnames websites_hostnames_key; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY websites_hostnames
    ADD CONSTRAINT websites_hostnames_key UNIQUE (hostname);


--
-- Name: websites websites_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY websites
    ADD CONSTRAINT websites_pkey PRIMARY KEY (id);


--
-- Name: websites_snapshots websites_snapshots_pkey; Type: CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY websites_snapshots
    ADD CONSTRAINT websites_snapshots_pkey PRIMARY KEY (id);


--
-- Name: addresses_location_gix; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX addresses_location_gix ON addresses USING gist (location);


--
-- Name: addresses_location_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX addresses_location_idx ON addresses USING btree (location);


--
-- Name: addresses_matrix_unique_id_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE UNIQUE INDEX addresses_matrix_unique_id_idx ON addresses USING btree (matrix_unique_id);


--
-- Name: agents_emails_email; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX agents_emails_email ON agents_emails USING btree (lower(email));


--
-- Name: agents_emails_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE UNIQUE INDEX agents_emails_idx ON agents_emails USING btree (id);


--
-- Name: agents_emails_mui; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX agents_emails_mui ON agents_emails USING btree (mui);


--
-- Name: agents_phones_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE UNIQUE INDEX agents_phones_idx ON agents_phones USING btree (id);


--
-- Name: agents_phones_mui; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX agents_phones_mui ON agents_phones USING btree (mui);


--
-- Name: agents_phones_phone; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX agents_phones_phone ON agents_phones USING btree (phone);


--
-- Name: agents_regexp_replace_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX agents_regexp_replace_idx ON agents USING btree (regexp_replace(upper(mlsid), '^0*'::text, ''::text, 'g'::text));


--
-- Name: alerts_created_by_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX alerts_created_by_idx ON alerts USING btree (created_by);


--
-- Name: alerts_maximum_lot_square_meters_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX alerts_maximum_lot_square_meters_idx ON alerts USING btree (maximum_lot_square_meters);


--
-- Name: alerts_maximum_price_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX alerts_maximum_price_idx ON alerts USING btree (maximum_price);


--
-- Name: alerts_maximum_square_meters_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX alerts_maximum_square_meters_idx ON alerts USING btree (maximum_square_meters);


--
-- Name: alerts_maximum_year_built_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX alerts_maximum_year_built_idx ON alerts USING btree (maximum_year_built);


--
-- Name: alerts_minimum_lot_square_meters_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX alerts_minimum_lot_square_meters_idx ON alerts USING btree (minimum_lot_square_meters);


--
-- Name: alerts_minimum_price_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX alerts_minimum_price_idx ON alerts USING btree (minimum_price);


--
-- Name: alerts_minimum_square_meters_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX alerts_minimum_square_meters_idx ON alerts USING btree (minimum_square_meters);


--
-- Name: alerts_minimum_year_built_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX alerts_minimum_year_built_idx ON alerts USING btree (minimum_year_built);


--
-- Name: alerts_pool_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX alerts_pool_idx ON alerts USING btree (pool);


--
-- Name: alerts_property_subtypes_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX alerts_property_subtypes_idx ON alerts USING btree (property_subtypes);


--
-- Name: alerts_room_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX alerts_room_idx ON alerts USING btree (room);


--
-- Name: brands_agents_agent; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX brands_agents_agent ON brands_agents USING btree (agent);


--
-- Name: brands_agents_brand; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX brands_agents_brand ON brands_agents USING btree (brand);


--
-- Name: brands_offices_brand; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX brands_offices_brand ON brands_offices USING btree (brand);


--
-- Name: brands_offices_office; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX brands_offices_office ON brands_offices USING btree (office);


--
-- Name: brands_users_brand; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX brands_users_brand ON brands_users USING btree (brand);


--
-- Name: brands_users_user; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX brands_users_user ON brands_users USING btree ("user");


--
-- Name: contacts_emails_email_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX contacts_emails_email_idx ON contacts_emails USING btree (email);


--
-- Name: contacts_phone_numbers_phone_number_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX contacts_phone_numbers_phone_number_idx ON contacts_phone_numbers USING btree (phone_number);


--
-- Name: county_title_gim; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX county_title_gim ON counties USING gin (title gin_trgm_ops);


--
-- Name: listings_close_date_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_close_date_idx ON listings USING btree (close_date);


--
-- Name: listings_filters_address; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_filters_address ON listings_filters USING gin (to_tsvector('english'::regconfig, address));


--
-- Name: listings_filters_address_trgm; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_filters_address_trgm ON listings_filters USING gin (address gin_trgm_ops);


--
-- Name: listings_filters_architecture; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_filters_architecture ON listings_filters USING gin (architectural_style);


--
-- Name: listings_filters_close_price; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_filters_close_price ON listings_filters USING btree (close_price);


--
-- Name: listings_filters_id; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE UNIQUE INDEX listings_filters_id ON listings_filters USING btree (id);


--
-- Name: listings_filters_list_agent; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_filters_list_agent ON listings_filters USING btree (list_agent_mls_id);


--
-- Name: listings_filters_list_office; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_filters_list_office ON listings_filters USING btree (list_office_mls_id);


--
-- Name: listings_filters_location; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_filters_location ON listings_filters USING gist (location);


--
-- Name: listings_filters_mls_area_major; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_filters_mls_area_major ON listings_filters USING btree (mls_area_major);


--
-- Name: listings_filters_mls_area_minor; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_filters_mls_area_minor ON listings_filters USING btree (mls_area_minor);


--
-- Name: listings_filters_mls_number; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_filters_mls_number ON listings_filters USING btree (mls_number);


--
-- Name: listings_filters_price; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_filters_price ON listings_filters USING btree (price);


--
-- Name: listings_filters_status; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_filters_status ON listings_filters USING btree (status);


--
-- Name: listings_filters_status_order; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_filters_status_order ON listings_filters USING btree (order_listings(status));


--
-- Name: listings_list_date_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_list_date_idx ON listings USING btree (list_date);


--
-- Name: listings_matrix_unique_id_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE UNIQUE INDEX listings_matrix_unique_id_idx ON listings USING btree (matrix_unique_id);


--
-- Name: listings_mls_area_major_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_mls_area_major_idx ON listings USING btree (mls_area_major);


--
-- Name: listings_mls_area_minor_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_mls_area_minor_idx ON listings USING btree (mls_area_minor);


--
-- Name: listings_mls_number_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_mls_number_idx ON listings USING btree (mls_number);


--
-- Name: listings_price_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_price_idx ON listings USING btree (price);


--
-- Name: listings_property_id_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_property_id_idx ON listings USING btree (property_id);


--
-- Name: listings_status_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX listings_status_idx ON listings USING btree (status);


--
-- Name: messages_acks_message_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX messages_acks_message_idx ON messages_acks USING btree (message);


--
-- Name: messages_acks_room_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX messages_acks_room_idx ON messages_acks USING btree (room);


--
-- Name: messages_acks_user_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX messages_acks_user_idx ON messages_acks USING btree ("user");


--
-- Name: messages_author_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX messages_author_idx ON messages USING btree (author);


--
-- Name: messages_object_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX messages_object_idx ON messages USING btree (recommendation);


--
-- Name: messages_room_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX messages_room_idx ON messages USING btree (room);


--
-- Name: mls_areas_parent; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX mls_areas_parent ON mls_areas USING btree (parent);


--
-- Name: mls_areas_title_gin; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX mls_areas_title_gin ON mls_areas USING gin (title gin_trgm_ops);


--
-- Name: mls_data_matrix_unique_id_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE UNIQUE INDEX mls_data_matrix_unique_id_idx ON mls_data USING btree (matrix_unique_id);


--
-- Name: notification_tokens_user_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX notification_tokens_user_idx ON notifications_tokens USING btree ("user");


--
-- Name: notifications_auxiliary_object_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX notifications_auxiliary_object_idx ON notifications USING btree (auxiliary_object);


--
-- Name: notifications_auxiliary_subject_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX notifications_auxiliary_subject_idx ON notifications USING btree (auxiliary_subject);


--
-- Name: notifications_object_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX notifications_object_idx ON notifications USING btree (object);


--
-- Name: notifications_recommendation_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX notifications_recommendation_idx ON notifications USING btree (recommendation);


--
-- Name: notifications_room_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX notifications_room_idx ON notifications USING btree (room);


--
-- Name: notifications_subject_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX notifications_subject_idx ON notifications USING btree (auxiliary_subject);


--
-- Name: offices_mui_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE UNIQUE INDEX offices_mui_idx ON offices USING btree (matrix_unique_id);


--
-- Name: open_houses_listing_mui_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX open_houses_listing_mui_idx ON open_houses USING btree (listing_mui);


--
-- Name: phone_verifications_phone_number; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE UNIQUE INDEX phone_verifications_phone_number ON phone_verifications USING btree (phone_number);


--
-- Name: photos_last_processed; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX photos_last_processed ON photos USING btree (processed_at);


--
-- Name: photos_listing_mui_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX photos_listing_mui_idx ON photos USING btree (listing_mui);


--
-- Name: photos_to_be_processed_at; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX photos_to_be_processed_at ON photos USING btree (to_be_processed_at);


--
-- Name: properties_address_id_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX properties_address_id_idx ON properties USING btree (address_id);


--
-- Name: properties_bedroom_count_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX properties_bedroom_count_idx ON properties USING btree (bedroom_count);


--
-- Name: properties_full_bathroom_count_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX properties_full_bathroom_count_idx ON properties USING btree (full_bathroom_count);


--
-- Name: properties_half_bathroom_count_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX properties_half_bathroom_count_idx ON properties USING btree (half_bathroom_count);


--
-- Name: properties_lot_square_meters_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX properties_lot_square_meters_idx ON properties USING btree (lot_square_meters);


--
-- Name: properties_matrix_unique_id_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE UNIQUE INDEX properties_matrix_unique_id_idx ON properties USING btree (matrix_unique_id);


--
-- Name: properties_pool_yn_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX properties_pool_yn_idx ON properties USING btree (pool_yn);


--
-- Name: properties_property_subtype_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX properties_property_subtype_idx ON properties USING btree (property_subtype);


--
-- Name: properties_property_type_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX properties_property_type_idx ON properties USING btree (property_type);


--
-- Name: properties_square_meters_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX properties_square_meters_idx ON properties USING btree (square_meters);


--
-- Name: properties_year_built_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX properties_year_built_idx ON properties USING btree (year_built);


--
-- Name: property_rooms_mui_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE UNIQUE INDEX property_rooms_mui_idx ON property_rooms USING btree (matrix_unique_id);


--
-- Name: recommendations_object_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX recommendations_object_idx ON recommendations USING btree (listing);


--
-- Name: recommendations_room_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX recommendations_room_idx ON recommendations USING btree (room);


--
-- Name: rooms_owner_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX rooms_owner_idx ON rooms USING btree (owner);


--
-- Name: rooms_users_room_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX rooms_users_room_idx ON rooms_users USING btree (room);


--
-- Name: rooms_users_user_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX rooms_users_user_idx ON rooms_users USING btree ("user");


--
-- Name: school_district_gin; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX school_district_gin ON schools USING gin (district gin_trgm_ops);


--
-- Name: school_name_gin; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX school_name_gin ON schools USING gin (name gin_trgm_ops);


--
-- Name: subdivision_title_gin; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX subdivision_title_gin ON subdivisions USING gin (title gin_trgm_ops);


--
-- Name: units_mui_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE UNIQUE INDEX units_mui_idx ON property_units USING btree (matrix_unique_id);


--
-- Name: users_address_id_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX users_address_id_idx ON users USING btree (address_id);


--
-- Name: words_idx; Type: INDEX; Schema: public; Owner: emilsedgh
--

CREATE INDEX words_idx ON words USING gin (word gin_trgm_ops);


--
-- Name: users falsify_email_confirmed; Type: TRIGGER; Schema: public; Owner: emilsedgh
--

CREATE TRIGGER falsify_email_confirmed AFTER UPDATE ON users FOR EACH ROW WHEN ((old.email IS DISTINCT FROM new.email)) EXECUTE PROCEDURE falsify_email_confirmed();


--
-- Name: users falsify_phone_confirmed; Type: TRIGGER; Schema: public; Owner: emilsedgh
--

CREATE TRIGGER falsify_phone_confirmed AFTER UPDATE ON users FOR EACH ROW WHEN ((old.phone_number IS DISTINCT FROM new.phone_number)) EXECUTE PROCEDURE falsify_phone_confirmed();


--
-- Name: users toggle_phone_confirmed; Type: TRIGGER; Schema: public; Owner: emilsedgh
--

CREATE TRIGGER toggle_phone_confirmed AFTER UPDATE ON users FOR EACH ROW WHEN ((old.phone_number IS DISTINCT FROM new.phone_number)) EXECUTE PROCEDURE toggle_phone_confirmed();


--
-- Name: alerts alerts_room_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY alerts
    ADD CONSTRAINT alerts_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);


--
-- Name: attachments_eav attachments_eav_attachment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY attachments_eav
    ADD CONSTRAINT attachments_eav_attachment_fkey FOREIGN KEY (attachment) REFERENCES attachments(id);


--
-- Name: attachments attachments_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY attachments
    ADD CONSTRAINT attachments_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: brands_agents brands_agents_agent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY brands_agents
    ADD CONSTRAINT brands_agents_agent_fkey FOREIGN KEY (agent) REFERENCES agents(id);


--
-- Name: brands_agents brands_agents_brand_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY brands_agents
    ADD CONSTRAINT brands_agents_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);


--
-- Name: brands_hostnames brands_hostnames_brand_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY brands_hostnames
    ADD CONSTRAINT brands_hostnames_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);


--
-- Name: brands_offices brands_offices_brand_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY brands_offices
    ADD CONSTRAINT brands_offices_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);


--
-- Name: brands_offices brands_offices_office_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY brands_offices
    ADD CONSTRAINT brands_offices_office_fkey FOREIGN KEY (office) REFERENCES offices(id);


--
-- Name: brands_parents brands_parents_brand_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY brands_parents
    ADD CONSTRAINT brands_parents_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);


--
-- Name: brands_parents brands_parents_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY brands_parents
    ADD CONSTRAINT brands_parents_parent_fkey FOREIGN KEY (parent) REFERENCES brands(id);


--
-- Name: brands_users brands_users_brand_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY brands_users
    ADD CONSTRAINT brands_users_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);


--
-- Name: brands_users brands_users_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY brands_users
    ADD CONSTRAINT brands_users_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: cmas cmas_main_listing_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY cmas
    ADD CONSTRAINT cmas_main_listing_fkey FOREIGN KEY (main_listing) REFERENCES listings(id);


--
-- Name: cmas cmas_room_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY cmas
    ADD CONSTRAINT cmas_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);


--
-- Name: cmas cmas_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY cmas
    ADD CONSTRAINT cmas_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: contacts_attributes contacts_attributes_contact_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY contacts_attributes
    ADD CONSTRAINT contacts_attributes_contact_fkey FOREIGN KEY (contact) REFERENCES contacts(id);


--
-- Name: contacts_emails contacts_emails_contact_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY contacts_emails
    ADD CONSTRAINT contacts_emails_contact_fkey FOREIGN KEY (contact) REFERENCES contacts(id);


--
-- Name: contacts_phone_numbers contacts_phone_numbers_contact_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY contacts_phone_numbers
    ADD CONSTRAINT contacts_phone_numbers_contact_fkey FOREIGN KEY (contact) REFERENCES contacts(id);


--
-- Name: contacts contacts_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: deals deals_brand_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY deals
    ADD CONSTRAINT deals_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);


--
-- Name: deals deals_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY deals
    ADD CONSTRAINT deals_created_by_fkey FOREIGN KEY (created_by) REFERENCES users(id);


--
-- Name: deals deals_listing_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY deals
    ADD CONSTRAINT deals_listing_fkey FOREIGN KEY (listing) REFERENCES listings(id);


--
-- Name: deals_roles deals_roles_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY deals_roles
    ADD CONSTRAINT deals_roles_created_by_fkey FOREIGN KEY (created_by) REFERENCES users(id);


--
-- Name: deals_roles deals_roles_deal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY deals_roles
    ADD CONSTRAINT deals_roles_deal_fkey FOREIGN KEY (deal) REFERENCES deals(id);


--
-- Name: deals_roles deals_roles_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY deals_roles
    ADD CONSTRAINT deals_roles_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: docusign_users docusign_users_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY docusign_users
    ADD CONSTRAINT docusign_users_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: envelopes envelopes_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY envelopes
    ADD CONSTRAINT envelopes_created_by_fkey FOREIGN KEY (created_by) REFERENCES users(id);


--
-- Name: envelopes envelopes_deal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY envelopes
    ADD CONSTRAINT envelopes_deal_fkey FOREIGN KEY (deal) REFERENCES deals(id);


--
-- Name: envelopes_documents envelopes_documents_envelope_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY envelopes_documents
    ADD CONSTRAINT envelopes_documents_envelope_fkey FOREIGN KEY (envelope) REFERENCES envelopes(id);


--
-- Name: envelopes_documents envelopes_documents_submission_revision_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY envelopes_documents
    ADD CONSTRAINT envelopes_documents_submission_revision_fkey FOREIGN KEY (submission_revision) REFERENCES forms_data(id);


--
-- Name: envelopes_recipients envelopes_recipients_envelope_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY envelopes_recipients
    ADD CONSTRAINT envelopes_recipients_envelope_fkey FOREIGN KEY (envelope) REFERENCES envelopes(id);


--
-- Name: envelopes_recipients envelopes_recipients_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY envelopes_recipients
    ADD CONSTRAINT envelopes_recipients_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: files files_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY files
    ADD CONSTRAINT files_created_by_fkey FOREIGN KEY (created_by) REFERENCES users(id);


--
-- Name: files_relations files_relations_file_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY files_relations
    ADD CONSTRAINT files_relations_file_fkey FOREIGN KEY (file) REFERENCES files(id);


--
-- Name: forms_data forms_data_author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY forms_data
    ADD CONSTRAINT forms_data_author_fkey FOREIGN KEY (author) REFERENCES users(id);


--
-- Name: forms_data forms_data_form_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY forms_data
    ADD CONSTRAINT forms_data_form_fkey FOREIGN KEY (form) REFERENCES forms(id);


--
-- Name: forms_data forms_data_submission_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY forms_data
    ADD CONSTRAINT forms_data_submission_fkey FOREIGN KEY (submission) REFERENCES forms_submissions(id);


--
-- Name: forms_submissions forms_submissions_deal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY forms_submissions
    ADD CONSTRAINT forms_submissions_deal_fkey FOREIGN KEY (deal) REFERENCES deals(id);


--
-- Name: forms_submissions forms_submissions_form_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY forms_submissions
    ADD CONSTRAINT forms_submissions_form_fkey FOREIGN KEY (form) REFERENCES forms(id);


--
-- Name: godaddy_domains godaddy_domains_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY godaddy_domains
    ADD CONSTRAINT godaddy_domains_owner_fkey FOREIGN KEY (owner) REFERENCES users(id);


--
-- Name: godaddy_shoppers godaddy_shoppers_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY godaddy_shoppers
    ADD CONSTRAINT godaddy_shoppers_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: listings listings_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_property_id_fkey FOREIGN KEY (property_id) REFERENCES properties(id);


--
-- Name: rooms_users message_rooms_users_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY rooms_users
    ADD CONSTRAINT message_rooms_users_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: messages_acks messages_acks_message_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY messages_acks
    ADD CONSTRAINT messages_acks_message_fkey FOREIGN KEY (message) REFERENCES messages(id);


--
-- Name: messages_acks messages_acks_room_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY messages_acks
    ADD CONSTRAINT messages_acks_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);


--
-- Name: messages_acks messages_acks_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY messages_acks
    ADD CONSTRAINT messages_acks_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: messages messages_author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_author_fkey FOREIGN KEY (author) REFERENCES users(id);


--
-- Name: messages messages_notification_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_notification_fkey FOREIGN KEY (notification) REFERENCES notifications(id);


--
-- Name: messages messages_recommendation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_recommendation_fkey FOREIGN KEY (recommendation) REFERENCES recommendations(id);


--
-- Name: messages messages_reference_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_reference_fkey FOREIGN KEY (reference) REFERENCES messages(id);


--
-- Name: messages messages_room_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);


--
-- Name: notifications_tokens notification_tokens_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY notifications_tokens
    ADD CONSTRAINT notification_tokens_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: notifications_deliveries notifications_deliveries_notification_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY notifications_deliveries
    ADD CONSTRAINT notifications_deliveries_notification_fkey FOREIGN KEY (notification) REFERENCES notifications(id);


--
-- Name: notifications_deliveries notifications_deliveries_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY notifications_deliveries
    ADD CONSTRAINT notifications_deliveries_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: notifications notifications_recommendation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_recommendation_fkey FOREIGN KEY (recommendation) REFERENCES recommendations(id);


--
-- Name: notifications notifications_room_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);


--
-- Name: notifications_users notifications_users_notification_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY notifications_users
    ADD CONSTRAINT notifications_users_notification_fkey FOREIGN KEY (notification) REFERENCES notifications(id);


--
-- Name: notifications_users notifications_users_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY notifications_users
    ADD CONSTRAINT notifications_users_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: password_recovery_records password_recovery_records_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY password_recovery_records
    ADD CONSTRAINT password_recovery_records_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: properties properties_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY properties
    ADD CONSTRAINT properties_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(id);


--
-- Name: properties properties_address_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY properties
    ADD CONSTRAINT properties_address_id_fkey1 FOREIGN KEY (address_id) REFERENCES addresses(id);


--
-- Name: recommendations_eav recommendations_eav_recommendation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY recommendations_eav
    ADD CONSTRAINT recommendations_eav_recommendation_fkey FOREIGN KEY (recommendation) REFERENCES recommendations(id);


--
-- Name: recommendations_eav recommendations_eav_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY recommendations_eav
    ADD CONSTRAINT recommendations_eav_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: recommendations recommendations_object_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY recommendations
    ADD CONSTRAINT recommendations_object_fkey FOREIGN KEY (listing) REFERENCES listings(id);


--
-- Name: recommendations recommendations_room_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY recommendations
    ADD CONSTRAINT recommendations_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);


--
-- Name: reviews reviews_deal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY reviews
    ADD CONSTRAINT reviews_deal_fkey FOREIGN KEY (deal) REFERENCES deals(id);


--
-- Name: reviews reviews_envelope_document_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY reviews
    ADD CONSTRAINT reviews_envelope_document_fkey FOREIGN KEY (envelope_document) REFERENCES envelopes_documents(id);


--
-- Name: reviews reviews_file_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY reviews
    ADD CONSTRAINT reviews_file_fkey FOREIGN KEY (file) REFERENCES files(id);


--
-- Name: reviews_history reviews_history_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY reviews_history
    ADD CONSTRAINT reviews_history_created_by_fkey FOREIGN KEY (created_by) REFERENCES users(id);


--
-- Name: reviews_history reviews_history_review_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY reviews_history
    ADD CONSTRAINT reviews_history_review_fkey FOREIGN KEY (review) REFERENCES reviews(id);


--
-- Name: invitation_records rooms_invitation_records_invited_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY invitation_records
    ADD CONSTRAINT rooms_invitation_records_invited_user_fkey FOREIGN KEY (invited_user) REFERENCES users(id);


--
-- Name: invitation_records rooms_invitation_records_inviting_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY invitation_records
    ADD CONSTRAINT rooms_invitation_records_inviting_user_fkey FOREIGN KEY (inviting_user) REFERENCES users(id);


--
-- Name: invitation_records rooms_invitation_records_room_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY invitation_records
    ADD CONSTRAINT rooms_invitation_records_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);


--
-- Name: rooms_users rooms_users_phone_handler_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY rooms_users
    ADD CONSTRAINT rooms_users_phone_handler_fkey FOREIGN KEY (phone_handler) REFERENCES seamless_phone_pool(id);


--
-- Name: rooms_users rooms_users_room_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY rooms_users
    ADD CONSTRAINT rooms_users_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);


--
-- Name: rooms shortlists_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT shortlists_owner_fkey FOREIGN KEY (owner) REFERENCES users(id);


--
-- Name: stripe_charges stripe_charges_customer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY stripe_charges
    ADD CONSTRAINT stripe_charges_customer_fkey FOREIGN KEY (customer) REFERENCES stripe_customers(id);


--
-- Name: stripe_charges stripe_charges_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY stripe_charges
    ADD CONSTRAINT stripe_charges_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: stripe_customers stripe_customers_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY stripe_customers
    ADD CONSTRAINT stripe_customers_owner_fkey FOREIGN KEY (owner) REFERENCES users(id);


--
-- Name: users users_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(id);


--
-- Name: users users_agents_agent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_agents_agent_fkey FOREIGN KEY (agent) REFERENCES agents(id);


--
-- Name: users users_brand_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);


--
-- Name: users users_personal_room_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_personal_room_fkey FOREIGN KEY (personal_room) REFERENCES rooms(id);


--
-- Name: websites_hostnames websites_hostnames_website_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY websites_hostnames
    ADD CONSTRAINT websites_hostnames_website_fkey FOREIGN KEY (website) REFERENCES websites(id);


--
-- Name: websites_snapshots websites_snapshots_brand_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY websites_snapshots
    ADD CONSTRAINT websites_snapshots_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);


--
-- Name: websites_snapshots websites_snapshots_website_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY websites_snapshots
    ADD CONSTRAINT websites_snapshots_website_fkey FOREIGN KEY (website) REFERENCES websites(id);


--
-- Name: websites websites_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: emilsedgh
--

ALTER TABLE ONLY websites
    ADD CONSTRAINT websites_user_fkey FOREIGN KEY ("user") REFERENCES users(id);


--
-- Name: agents_emails; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: emilsedgh
--

REFRESH MATERIALIZED VIEW agents_emails;


--
-- Name: agents_phones; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: emilsedgh
--

REFRESH MATERIALIZED VIEW agents_phones;


--
-- Name: counties; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: emilsedgh
--

REFRESH MATERIALIZED VIEW counties;


--
-- Name: listings_filters; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: emilsedgh
--

REFRESH MATERIALIZED VIEW listings_filters;


--
-- Name: mls_areas; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: emilsedgh
--

REFRESH MATERIALIZED VIEW mls_areas;


--
-- Name: schools; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: emilsedgh
--

REFRESH MATERIALIZED VIEW schools;


--
-- Name: subdivisions; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: emilsedgh
--

REFRESH MATERIALIZED VIEW subdivisions;


--
-- Name: words; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: emilsedgh
--

REFRESH MATERIALIZED VIEW words;


--
-- PostgreSQL database dump complete
--

