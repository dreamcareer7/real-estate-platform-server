PGDMP         4                u        
   nanorechat    9.6.2    9.6.2 �   7           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            8           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            9           1262    157847 
   nanorechat    DATABASE     |   CREATE DATABASE nanorechat WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE nanorechat;
          	   emilsedgh    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            :           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    6                        2615    17947    shortlisted    SCHEMA        CREATE SCHEMA shortlisted;
    DROP SCHEMA shortlisted;
          	   emilsedgh    false                        2615    17948    tiger    SCHEMA        CREATE SCHEMA tiger;
    DROP SCHEMA tiger;
          	   emilsedgh    false                        2615    17949    topology    SCHEMA        CREATE SCHEMA topology;
    DROP SCHEMA topology;
          	   emilsedgh    false                        3079    12393    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            ;           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1                        3079    17873    pg_trgm 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;
    DROP EXTENSION pg_trgm;
                  false    6            <           0    0    EXTENSION pg_trgm    COMMENT     e   COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';
                       false    2                        3079    16389    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                  false    6            =           0    0    EXTENSION postgis    COMMENT     g   COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';
                       false    4                        3079    17862 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                  false    6            >           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                       false    3            	           1247    144956    activity_type    TYPE       CREATE TYPE activity_type AS ENUM (
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
     DROP TYPE public.activity_type;
       public    	   emilsedgh    false    6            �           1247    17952    client_type    TYPE     N   CREATE TYPE client_type AS ENUM (
    'Buyer',
    'Seller',
    'Unknown'
);
    DROP TYPE public.client_type;
       public    	   emilsedgh    false    6            �           1247    17960    contact_source_type    TYPE     �   CREATE TYPE contact_source_type AS ENUM (
    'BrokerageWidget',
    'IOSAddressBook',
    'SharesRoom',
    'ExplicitlyCreated'
);
 &   DROP TYPE public.contact_source_type;
       public    	   emilsedgh    false    6            �           1247    17970    country_code_3    TYPE     �
  CREATE TYPE country_code_3 AS ENUM (
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
 !   DROP TYPE public.country_code_3;
       public    	   emilsedgh    false    6            �           1247    18472    country_name    TYPE     �  CREATE TYPE country_name AS ENUM (
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
    DROP TYPE public.country_name;
       public    	   emilsedgh    false    6            �           1247    18974    currency_code    TYPE     �  CREATE TYPE currency_code AS ENUM (
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
     DROP TYPE public.currency_code;
       public    	   emilsedgh    false    6            �           1247    19292 	   deal_role    TYPE       CREATE TYPE deal_role AS ENUM (
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
    DROP TYPE public.deal_role;
       public    	   emilsedgh    false    6            �           1247    19318 	   deal_type    TYPE     ?   CREATE TYPE deal_type AS ENUM (
    'Buying',
    'Selling'
);
    DROP TYPE public.deal_type;
       public    	   emilsedgh    false    6            �           1247    19324    envelope_recipient_status    TYPE     �   CREATE TYPE envelope_recipient_status AS ENUM (
    'Sent',
    'Delivered',
    'Completed',
    'Declined',
    'AuthenticationFailed',
    'AutoResponded'
);
 ,   DROP TYPE public.envelope_recipient_status;
       public    	   emilsedgh    false    6            �           1247    19338    envelope_status    TYPE     �   CREATE TYPE envelope_status AS ENUM (
    'sent',
    'Sent',
    'Delivered',
    'Completed',
    'Declined',
    'Voided'
);
 "   DROP TYPE public.envelope_status;
       public    	   emilsedgh    false    6            �           1247    19352    form_revision_status    TYPE     F   CREATE TYPE form_revision_status AS ENUM (
    'Draft',
    'Fair'
);
 '   DROP TYPE public.form_revision_status;
       public    	   emilsedgh    false    6            �           1247    19358    geo_confidence    TYPE     �   CREATE TYPE geo_confidence AS ENUM (
    'Google_ROOFTOP',
    'Google_RANGE_INTERPOLATED',
    'Google_GEOMETRIC_CENTER',
    'Google_APPROXIMATE',
    'Bing_High',
    'Bing_Medium',
    'Bing_Low',
    'OSM_NA'
);
 !   DROP TYPE public.geo_confidence;
       public    	   emilsedgh    false    6            �           1247    19376    geo_confidence_bing    TYPE     Q   CREATE TYPE geo_confidence_bing AS ENUM (
    'High',
    'Medium',
    'Low'
);
 &   DROP TYPE public.geo_confidence_bing;
       public    	   emilsedgh    false    6            �           1247    19384    geo_confidence_google    TYPE     �   CREATE TYPE geo_confidence_google AS ENUM (
    'APPROXIMATE',
    'RANGE_INTERPOLATED',
    'GEOMETRIC_CENTER',
    'ROOFTOP'
);
 (   DROP TYPE public.geo_confidence_google;
       public    	   emilsedgh    false    6            �           1247    19394 
   geo_source    TYPE     �   CREATE TYPE geo_source AS ENUM (
    'OSM',
    'Google',
    'Yahoo',
    'Bing',
    'Geonames',
    'Unknown',
    'None'
);
    DROP TYPE public.geo_source;
       public    	   emilsedgh    false    6            �           1247    19410    listing_status    TYPE     g  CREATE TYPE listing_status AS ENUM (
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
 !   DROP TYPE public.listing_status;
       public    	   emilsedgh    false    6            �           1247    19444    mam_behaviour    TYPE     A   CREATE TYPE mam_behaviour AS ENUM (
    'A',
    'N',
    'R'
);
     DROP TYPE public.mam_behaviour;
       public    	   emilsedgh    false    6            �           1247    19452    mam_direction    TYPE     8   CREATE TYPE mam_direction AS ENUM (
    'I',
    'O'
);
     DROP TYPE public.mam_direction;
       public    	   emilsedgh    false    6            �           1247    19458    message_room_status    TYPE     k   CREATE TYPE message_room_status AS ENUM (
    'Active',
    'Inactive',
    'Restricted',
    'Blocked'
);
 &   DROP TYPE public.message_room_status;
       public    	   emilsedgh    false    6            �           1247    19468    message_type    TYPE     E   CREATE TYPE message_type AS ENUM (
    'TopLevel',
    'SubLevel'
);
    DROP TYPE public.message_type;
       public    	   emilsedgh    false    6            �           1247    19474 
   note_types    TYPE     6   CREATE TYPE note_types AS ENUM (
    'Transaction'
);
    DROP TYPE public.note_types;
       public    	   emilsedgh    false    6            �           1247    19478    notification_action    TYPE     O  CREATE TYPE notification_action AS ENUM (
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
 &   DROP TYPE public.notification_action;
       public    	   emilsedgh    false    6            �           1247    19550    notification_object_class    TYPE     �  CREATE TYPE notification_object_class AS ENUM (
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
 ,   DROP TYPE public.notification_object_class;
       public    	   emilsedgh    false    6            �           1247    19606    office_status    TYPE     w   CREATE TYPE office_status AS ENUM (
    'N',
    'Deceased',
    '',
    'Terminated',
    'Active',
    'Inactive'
);
     DROP TYPE public.office_status;
       public    	   emilsedgh    false    6            �           1247    19620    property_subtype    TYPE     Q  CREATE TYPE property_subtype AS ENUM (
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
 #   DROP TYPE public.property_subtype;
       public    	   emilsedgh    false    6            �           1247    19672    property_type    TYPE     �   CREATE TYPE property_type AS ENUM (
    'Residential',
    'Residential Lease',
    'Multi-Family',
    'Commercial',
    'Lots & Acreage',
    'Unknown'
);
     DROP TYPE public.property_type;
       public    	   emilsedgh    false    6            �           1247    19686    recommendation_eav_action    TYPE     o   CREATE TYPE recommendation_eav_action AS ENUM (
    'Favorited',
    'Read',
    'TourRequested',
    'Hid'
);
 ,   DROP TYPE public.recommendation_eav_action;
       public    	   emilsedgh    false    6            	           1247    153197    recommendation_last_update    TYPE     }   CREATE TYPE recommendation_last_update AS ENUM (
    'New',
    'PriceDrop',
    'StatusChange',
    'OpenHouseAvailable'
);
 -   DROP TYPE public.recommendation_last_update;
       public    	   emilsedgh    false    6            �           1247    19696    recommendation_status    TYPE     b   CREATE TYPE recommendation_status AS ENUM (
    'Unacknowledged',
    'Pinned',
    'Unpinned'
);
 (   DROP TYPE public.recommendation_status;
       public    	   emilsedgh    false    6            �           1247    19704    recommendation_type    TYPE     l   CREATE TYPE recommendation_type AS ENUM (
    'Listing',
    'Agent',
    'Bank',
    'Card',
    'User'
);
 &   DROP TYPE public.recommendation_type;
       public    	   emilsedgh    false    6            	           1247    144970    reference_type    TYPE     B   CREATE TYPE reference_type AS ENUM (
    'User',
    'Contact'
);
 !   DROP TYPE public.reference_type;
       public    	   emilsedgh    false    6            "	           1247    153382    review_state    TYPE     T   CREATE TYPE review_state AS ENUM (
    'Pending',
    'Rejected',
    'Approved'
);
    DROP TYPE public.review_state;
       public    	   emilsedgh    false    6            �           1247    19716    room_status    TYPE     �   CREATE TYPE room_status AS ENUM (
    'New',
    'Searching',
    'Touring',
    'OnHold',
    'Closing',
    'ClosedCanceled',
    'ClosedSuccess',
    'Archived'
);
    DROP TYPE public.room_status;
       public    	   emilsedgh    false    6            �           1247    19734 	   room_type    TYPE     M   CREATE TYPE room_type AS ENUM (
    'Group',
    'Direct',
    'Personal'
);
    DROP TYPE public.room_type;
       public    	   emilsedgh    false    6            �           1247    19742    source_type    TYPE     g   CREATE TYPE source_type AS ENUM (
    'MLS',
    'Zillow',
    'RCRRE',
    'Trulia',
    'Realtor'
);
    DROP TYPE public.source_type;
       public    	   emilsedgh    false    6            �           1247    19754 	   tag_types    TYPE     �   CREATE TYPE tag_types AS ENUM (
    'contact',
    'room',
    'listing',
    'user',
    'Contact',
    'Room',
    'Listing',
    'User'
);
    DROP TYPE public.tag_types;
       public    	   emilsedgh    false    6            �           1247    19772    task_status    TYPE     H   CREATE TYPE task_status AS ENUM (
    'New',
    'Done',
    'Later'
);
    DROP TYPE public.task_status;
       public    	   emilsedgh    false    6            �           1247    19780    transaction_type    TYPE     e   CREATE TYPE transaction_type AS ENUM (
    'Buyer',
    'Seller',
    'Buyer/Seller',
    'Lease'
);
 #   DROP TYPE public.transaction_type;
       public    	   emilsedgh    false    6            �           1247    19790    user_image_type    TYPE     D   CREATE TYPE user_image_type AS ENUM (
    'Profile',
    'Cover'
);
 "   DROP TYPE public.user_image_type;
       public    	   emilsedgh    false    6            �           1247    19796    user_on_room_status    TYPE     G   CREATE TYPE user_on_room_status AS ENUM (
    'Active',
    'Muted'
);
 &   DROP TYPE public.user_on_room_status;
       public    	   emilsedgh    false    6            �           1247    19802    user_status    TYPE     u   CREATE TYPE user_status AS ENUM (
    'Deleted',
    'De-Activated',
    'Restricted',
    'Banned',
    'Active'
);
    DROP TYPE public.user_status;
       public    	   emilsedgh    false    6            �           1247    19814 	   user_type    TYPE     [   CREATE TYPE user_type AS ENUM (
    'Client',
    'Agent',
    'Brokerage',
    'Admin'
);
    DROP TYPE public.user_type;
       public    	   emilsedgh    false    6                       1247    21506    message_room_status    TYPE     k   CREATE TYPE message_room_status AS ENUM (
    'Active',
    'Inactive',
    'Restricted',
    'Blocked'
);
 +   DROP TYPE shortlisted.message_room_status;
       shortlisted    	   emilsedgh    false    7            �           1255    21515    agent_exp(text)    FUNCTION     `  CREATE FUNCTION agent_exp(mlsid text) RETURNS text
    LANGUAGE plpgsql
    AS $$  BEGIN    CASE substring(mlsid from 0 for 3)      WHEN '02' THEN RETURN '25-40';      WHEN '03' THEN RETURN '15-25';      WHEN '04' THEN RETURN '10-15';      WHEN '05' THEN RETURN '5-10';      WHEN '06' THEN RETURN '0-5';      ELSE RETURN '20+';    END CASE;  END;  $$;
 ,   DROP FUNCTION public.agent_exp(mlsid text);
       public    	   emilsedgh    false    6    1            �           1255    145097    brand_children(uuid)    FUNCTION     x  CREATE FUNCTION brand_children(id uuid) RETURNS SETOF uuid
    LANGUAGE sql
    AS $_$
  WITH RECURSIVE get_brand_children AS (
    SELECT brand, parent FROM brands_parents WHERE parent = $1
    UNION
    SELECT a.brand, a.parent FROM brands_parents a JOIN get_brand_children b ON (a.parent = b.brand)
  )

  SELECT $1 AS brand UNION SELECT brand FROM get_brand_children
$_$;
 .   DROP FUNCTION public.brand_children(id uuid);
       public    	   emilsedgh    false    6            �           1255    21516    falsify_email_confirmed()    FUNCTION       CREATE FUNCTION falsify_email_confirmed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$                BEGIN                UPDATE users                SET email_confirmed = false                WHERE id = NEW.id;                RETURN NEW;                END;                $$;
 0   DROP FUNCTION public.falsify_email_confirmed();
       public    	   emilsedgh    false    6    1            �           1255    21517    falsify_phone_confirmed()    FUNCTION       CREATE FUNCTION falsify_phone_confirmed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$                BEGIN                UPDATE users                SET phone_confirmed = false                WHERE id = NEW.id;                RETURN NEW;                END;                $$;
 0   DROP FUNCTION public.falsify_phone_confirmed();
       public    	   emilsedgh    false    6    1            �           1255    21518    fix_geocodes()    FUNCTION     �
  CREATE FUNCTION fix_geocodes() RETURNS void
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
 %   DROP FUNCTION public.fix_geocodes();
       public    	   emilsedgh    false    6    1            �           1255    145090    get_brand_agents(uuid)    FUNCTION     n  CREATE FUNCTION get_brand_agents(id uuid) RETURNS SETOF uuid
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
 0   DROP FUNCTION public.get_brand_agents(id uuid);
       public    	   emilsedgh    false    6            �           1255    145082    get_brand_users(uuid)    FUNCTION     �  CREATE FUNCTION get_brand_users(id uuid) RETURNS SETOF uuid
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
 /   DROP FUNCTION public.get_brand_users(id uuid);
       public    	   emilsedgh    false    6            �           1255    153464    order_listings(listing_status)    FUNCTION     R  CREATE FUNCTION order_listings(listing_status) RETURNS integer
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
 5   DROP FUNCTION public.order_listings(listing_status);
       public    	   emilsedgh    false    6    1977            �           1255    21520    toggle_phone_confirmed()    FUNCTION       CREATE FUNCTION toggle_phone_confirmed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$                BEGIN                UPDATE users                SET phone_confirmed = false                WHERE id = NEW.id;                RETURN NEW;                END;                $$;
 /   DROP FUNCTION public.toggle_phone_confirmed();
       public    	   emilsedgh    false    1    6            �           1255    21521    uuid_timestamp(uuid)    FUNCTION     �  CREATE FUNCTION uuid_timestamp(id uuid) RETURNS timestamp with time zone
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  select TIMESTAMP WITH TIME ZONE 'epoch' +
      ( ( ( ('x' || lpad(split_part(id::text, '-', 1), 16, '0'))::bit(64)::bigint) +
      (('x' || lpad(split_part(id::text, '-', 2), 16, '0'))::bit(64)::bigint << 32) +
      ((('x' || lpad(split_part(id::text, '-', 3), 16, '0'))::bit(64)::bigint&4095) << 48) - 122192928000000000) / 10) * INTERVAL '1 microsecond';    
$$;
 .   DROP FUNCTION public.uuid_timestamp(id uuid);
       public    	   emilsedgh    false    6            �           1255    21522    wipe_everything()    FUNCTION     L  CREATE FUNCTION wipe_everything() RETURNS void
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
 (   DROP FUNCTION public.wipe_everything();
       public    	   emilsedgh    false    6    1            �           1255    21527    wipe_everything()    FUNCTION     '  CREATE FUNCTION wipe_everything() RETURNS void
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
 -   DROP FUNCTION shortlisted.wipe_everything();
       shortlisted    	   emilsedgh    false    7    1            �           1255    21528 
   exec(text)    FUNCTION     o   CREATE FUNCTION exec(text) RETURNS text
    LANGUAGE plpgsql
    AS $_$ BEGIN EXECUTE $1; RETURN $1; END; $_$;
     DROP FUNCTION tiger.exec(text);
       tiger    	   emilsedgh    false    12    1                       1259    144975 
   activities    TABLE     �  CREATE TABLE activities (
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
    DROP TABLE public.activities;
       public      	   emilsedgh    false    3    6    2326    1998    2323    6            �            1259    21529 	   addresses    TABLE     (  CREATE TABLE addresses (
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
    DROP TABLE public.addresses;
       public      	   emilsedgh    false    3    6    1974    1968    6    4    4    6    4    6    4    6    4    6    6    4    6    4    6    4    6    1944    1971    1941    4    4    6    4    6    4    6    4    6    6    4    6    4    6    4    6    1974    4    4    6    4    6    4    6    4    6    6    4    6    4    6    4    6            �            1259    21541    agents    TABLE     w  CREATE TABLE agents (
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
    DROP TABLE public.agents;
       public      	   emilsedgh    false    3    6    6            �            1259    21550    listings    TABLE     W  CREATE TABLE listings (
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
    DROP TABLE public.listings;
       public      	   emilsedgh    false    3    6    1947    1977    6    1977            �            1259    21559    agents_emails    MATERIALIZED VIEW     �  CREATE MATERIALIZED VIEW agents_emails AS
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
 -   DROP MATERIALIZED VIEW public.agents_emails;
       public      	   emilsedgh    false    208    208    208    208    208    208    208    208    208    208    207    207    207    207    6            �            1259    21567    agents_images    TABLE     �   CREATE TABLE agents_images (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    mui bigint,
    url text,
    image_type user_image_type,
    date timestamp with time zone
);
 !   DROP TABLE public.agents_images;
       public      	   emilsedgh    false    3    6    6    2037            �            1259    21574    agents_phones    MATERIALIZED VIEW       CREATE MATERIALIZED VIEW agents_phones AS
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
 -   DROP MATERIALIZED VIEW public.agents_phones;
       public      	   emilsedgh    false    208    208    208    208    208    208    208    207    207    207    207    207    208    208    208    6            �            1259    21582    alerts    TABLE     %  CREATE TABLE alerts (
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
    DROP TABLE public.alerts;
       public      	   emilsedgh    false    3    6    1977    6    2007    2004    4    4    6    4    6    4    6    4    6    6    4    6    4    6    4    6            �            1259    21591    attachments    TABLE     y  CREATE TABLE attachments (
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
    DROP TABLE public.attachments;
       public      	   emilsedgh    false    3    6    6            �            1259    21601    attachments_eav    TABLE     �   CREATE TABLE attachments_eav (
    id uuid DEFAULT uuid_generate_v4(),
    object uuid NOT NULL,
    attachment uuid NOT NULL
);
 #   DROP TABLE public.attachments_eav;
       public      	   emilsedgh    false    3    6    6            �            1259    21605    brands    TABLE       CREATE TABLE brands (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    palette jsonb,
    assets jsonb,
    messages jsonb
);
    DROP TABLE public.brands;
       public      	   emilsedgh    false    3    6    6            �            1259    21614    brands_agents    TABLE     �   CREATE TABLE brands_agents (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    brand uuid NOT NULL,
    agent uuid NOT NULL
);
 !   DROP TABLE public.brands_agents;
       public      	   emilsedgh    false    3    6    6            �            1259    21618    brands_hostnames    TABLE     �   CREATE TABLE brands_hostnames (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    brand uuid NOT NULL,
    hostname text,
    "default" boolean DEFAULT false NOT NULL
);
 $   DROP TABLE public.brands_hostnames;
       public      	   emilsedgh    false    3    6    6            �            1259    21626    brands_offices    TABLE     �   CREATE TABLE brands_offices (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    brand uuid NOT NULL,
    office uuid NOT NULL
);
 "   DROP TABLE public.brands_offices;
       public      	   emilsedgh    false    3    6    6            �            1259    21630    brands_parents    TABLE     �   CREATE TABLE brands_parents (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    brand uuid NOT NULL,
    parent uuid NOT NULL
);
 "   DROP TABLE public.brands_parents;
       public      	   emilsedgh    false    3    6    6            �            1259    21634    brands_users    TABLE     �   CREATE TABLE brands_users (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    brand uuid NOT NULL,
    "user" uuid NOT NULL,
    role text
);
     DROP TABLE public.brands_users;
       public      	   emilsedgh    false    3    6    6            �            1259    21641    clients    TABLE     �   CREATE TABLE clients (
    id uuid DEFAULT uuid_generate_v1(),
    version character varying(10),
    response jsonb,
    secret character varying(255),
    name character varying(255)
);
    DROP TABLE public.clients;
       public      	   emilsedgh    false    3    6    6            �            1259    21648    cmas    TABLE     �  CREATE TABLE cmas (
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
    DROP TABLE public.cmas;
       public      	   emilsedgh    false    3    6    6            �            1259    21663    contacts    TABLE     �  CREATE TABLE contacts (
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
    DROP TABLE public.contacts;
       public      	   emilsedgh    false    3    6    6            �            1259    21673    contacts_attributes    TABLE     W  CREATE TABLE contacts_attributes (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    contact uuid NOT NULL,
    attribute_type text NOT NULL,
    attribute jsonb,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone
);
 '   DROP TABLE public.contacts_attributes;
       public      	   emilsedgh    false    3    6    6            �            1259    21682    contacts_emails    TABLE     <  CREATE TABLE contacts_emails (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    contact uuid NOT NULL,
    email text,
    data jsonb,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone
);
 #   DROP TABLE public.contacts_emails;
       public      	   emilsedgh    false    3    6    6            �            1259    21691    contacts_phone_numbers    TABLE     J  CREATE TABLE contacts_phone_numbers (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    contact uuid NOT NULL,
    phone_number text,
    data jsonb,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone
);
 *   DROP TABLE public.contacts_phone_numbers;
       public      	   emilsedgh    false    3    6    6            �            1259    21700    counties    MATERIALIZED VIEW     �   CREATE MATERIALIZED VIEW counties AS
 SELECT DISTINCT addresses.county_or_parish AS title
   FROM addresses
  ORDER BY addresses.county_or_parish
  WITH NO DATA;
 (   DROP MATERIALIZED VIEW public.counties;
       public      	   emilsedgh    false    206    6            �            1259    21707    deals    TABLE     U  CREATE TABLE deals (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    listing uuid,
    created_by uuid,
    brand uuid,
    context jsonb DEFAULT '{}'::jsonb
);
    DROP TABLE public.deals;
       public      	   emilsedgh    false    3    6    6            �            1259    21716    deals_roles    TABLE     j  CREATE TABLE deals_roles (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    created_by uuid NOT NULL,
    role deal_role NOT NULL,
    deal uuid NOT NULL,
    "user" uuid NOT NULL
);
    DROP TABLE public.deals_roles;
       public      	   emilsedgh    false    3    6    1950    6                       1259    128411    docusign_users    TABLE     �   CREATE TABLE docusign_users (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    "user" uuid NOT NULL,
    access_token text NOT NULL,
    refresh_token text NOT NULL,
    base_url text NOT NULL,
    account_id uuid NOT NULL
);
 "   DROP TABLE public.docusign_users;
       public      	   emilsedgh    false    3    6    6            �            1259    21722    email_verifications    TABLE     �   CREATE TABLE email_verifications (
    id uuid DEFAULT uuid_generate_v1(),
    code text NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    email text
);
 '   DROP TABLE public.email_verifications;
       public      	   emilsedgh    false    3    6    6            �            1259    21730 	   envelopes    TABLE     }  CREATE TABLE envelopes (
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
    DROP TABLE public.envelopes;
       public      	   emilsedgh    false    3    6    3    6    6    1959            �            1259    21740    envelopes_documents    TABLE     �   CREATE TABLE envelopes_documents (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    envelope uuid NOT NULL,
    title text,
    document_id smallint,
    submission_revision uuid
);
 '   DROP TABLE public.envelopes_documents;
       public      	   emilsedgh    false    3    6    6            �            1259    21747    envelopes_recipients    TABLE     ~  CREATE TABLE envelopes_recipients (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    signed_at timestamp with time zone,
    envelope uuid NOT NULL,
    role deal_role NOT NULL,
    "user" uuid NOT NULL,
    status envelope_recipient_status
);
 (   DROP TABLE public.envelopes_recipients;
       public      	   emilsedgh    false    3    6    1956    1950    6                       1259    136731    files    TABLE     E  CREATE TABLE files (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    created_by uuid NOT NULL,
    path text NOT NULL,
    name text NOT NULL
);
    DROP TABLE public.files;
       public      	   emilsedgh    false    3    6    6                       1259    136747    files_relations    TABLE     L  CREATE TABLE files_relations (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    file uuid NOT NULL,
    role text NOT NULL,
    role_id uuid NOT NULL
);
 #   DROP TABLE public.files_relations;
       public      	   emilsedgh    false    3    6    6            �            1259    21753    foo    TABLE     &   CREATE TABLE foo (
    value jsonb
);
    DROP TABLE public.foo;
       public      	   emilsedgh    false    6            �            1259    21759    forms    TABLE     D  CREATE TABLE forms (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    formstack_id integer,
    fields json DEFAULT '{}'::json,
    name text
);
    DROP TABLE public.forms;
       public      	   emilsedgh    false    3    6    6            �            1259    21769 
   forms_data    TABLE     �  CREATE TABLE forms_data (
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
    DROP TABLE public.forms_data;
       public      	   emilsedgh    false    3    6    1962    1962    6            �            1259    21779    forms_submissions    TABLE     D  CREATE TABLE forms_submissions (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    form uuid,
    formstack_id integer,
    deal uuid NOT NULL
);
 %   DROP TABLE public.forms_submissions;
       public      	   emilsedgh    false    3    6    6            �            1259    21785    godaddy_domains    TABLE     #  CREATE TABLE godaddy_domains (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    name text,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    owner uuid,
    order_id integer,
    hosted_zone text
);
 #   DROP TABLE public.godaddy_domains;
       public      	   emilsedgh    false    3    6    6            �            1259    21794    godaddy_shoppers    TABLE     =  CREATE TABLE godaddy_shoppers (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    "user" uuid NOT NULL,
    shopper_id text,
    email text NOT NULL,
    password text NOT NULL
);
 $   DROP TABLE public.godaddy_shoppers;
       public      	   emilsedgh    false    3    6    6            �            1259    21812    invitation_records    TABLE     �  CREATE TABLE invitation_records (
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
 &   DROP TABLE public.invitation_records;
       public      	   emilsedgh    false    3    6    6            �            1259    21822 
   properties    TABLE     �
  CREATE TABLE properties (
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
    DROP TABLE public.properties;
       public      	   emilsedgh    false    3    6    6    2007    2004                       1259    157809    listings_filters    MATERIALIZED VIEW     v  CREATE MATERIALIZED VIEW listings_filters AS
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
 0   DROP MATERIALIZED VIEW public.listings_filters;
       public      	   emilsedgh    false    208    208    208    208    206    206    206    206    206    206    206    206    206    206    206    206    206    206    206    206    241    241    241    241    241    241    241    241    241    241    241    241    241    241    241    241    241    241    241    241    241    208    208    208    208    208    208    208    208    208    208    208    208    208    208    208    1977    6    4    4    6    4    6    4    6    4    6    6    4    6    4    6    4    6    2004    2007            �            1259    21839    messages    TABLE       CREATE TABLE messages (
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
    DROP TABLE public.messages;
       public      	   emilsedgh    false    3    6    1989    6            �            1259    21848    messages_acks    TABLE     �   CREATE TABLE messages_acks (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    message uuid NOT NULL,
    room uuid NOT NULL,
    "user" uuid NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp()
);
 !   DROP TABLE public.messages_acks;
       public      	   emilsedgh    false    3    6    6            �            1259    21853 
   migrations    TABLE     p   CREATE TABLE migrations (
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    state jsonb
);
    DROP TABLE public.migrations;
       public      	   emilsedgh    false    6            �            1259    21860 	   mls_areas    MATERIALIZED VIEW     �  CREATE MATERIALIZED VIEW mls_areas AS
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
 )   DROP MATERIALIZED VIEW public.mls_areas;
       public      	   emilsedgh    false    208    208    6            �            1259    21868    mls_data    TABLE     �   CREATE TABLE mls_data (
    id uuid DEFAULT uuid_generate_v1(),
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    value jsonb,
    class character varying,
    resource character varying,
    matrix_unique_id integer
);
    DROP TABLE public.mls_data;
       public      	   emilsedgh    false    3    6    6            �            1259    21876    mls_jobs    TABLE     \  CREATE TABLE mls_jobs (
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
    DROP TABLE public.mls_jobs;
       public      	   emilsedgh    false    3    6    6            �            1259    21902    notifications    TABLE     0  CREATE TABLE notifications (
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
 !   DROP TABLE public.notifications;
       public      	   emilsedgh    false    3    6    1998    1995    6    1998    1998    1998    1998    1998            �            1259    21916    notifications_deliveries    TABLE     j  CREATE TABLE notifications_deliveries (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    "user" uuid NOT NULL,
    notification uuid NOT NULL,
    device_token text,
    type text,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone
);
 ,   DROP TABLE public.notifications_deliveries;
       public      	   emilsedgh    false    3    6    6            �            1259    21893    notifications_tokens    TABLE     +  CREATE TABLE notifications_tokens (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    "user" uuid NOT NULL,
    device_token text NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    device_id text
);
 (   DROP TABLE public.notifications_tokens;
       public      	   emilsedgh    false    3    6    6            �            1259    21925    notifications_users    TABLE     �  CREATE TABLE notifications_users (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    "user" uuid NOT NULL,
    notification uuid NOT NULL,
    acked_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    seen_at timestamp with time zone
);
 '   DROP TABLE public.notifications_users;
       public      	   emilsedgh    false    3    6    6            �            1259    21931    offices    TABLE     �  CREATE TABLE offices (
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
    DROP TABLE public.offices;
       public      	   emilsedgh    false    3    6    2001    6            �            1259    21940    open_houses    TABLE     �  CREATE TABLE open_houses (
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
    DROP TABLE public.open_houses;
       public      	   emilsedgh    false    3    6    6            �            1259    21949    password_recovery_records    TABLE     �  CREATE TABLE password_recovery_records (
    id uuid DEFAULT uuid_generate_v1(),
    email text NOT NULL,
    "user" uuid NOT NULL,
    token text NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    expires_at timestamp with time zone DEFAULT (now() + ((2)::double precision * '1 day'::interval)) NOT NULL
);
 -   DROP TABLE public.password_recovery_records;
       public      	   emilsedgh    false    3    6    6            �            1259    21959    phone_verifications    TABLE     �   CREATE TABLE phone_verifications (
    id uuid DEFAULT uuid_generate_v1(),
    code character(5),
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    phone_number text NOT NULL
);
 '   DROP TABLE public.phone_verifications;
       public      	   emilsedgh    false    3    6    6                        1259    21967    photos    TABLE     �  CREATE TABLE photos (
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
    DROP TABLE public.photos;
       public      	   emilsedgh    false    3    6    6                       1259    21976    property_rooms    TABLE     �  CREATE TABLE property_rooms (
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
 "   DROP TABLE public.property_rooms;
       public      	   emilsedgh    false    3    6    6                       1259    21983    property_units    TABLE     z  CREATE TABLE property_units (
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
 "   DROP TABLE public.property_units;
       public      	   emilsedgh    false    3    6    6                       1259    21989    recommendations    TABLE     J  CREATE TABLE recommendations (
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
 #   DROP TABLE public.recommendations;
       public      	   emilsedgh    false    2334    3    6    2334    2025    2016    6                       1259    21999    recommendations_eav    TABLE       CREATE TABLE recommendations_eav (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    "user" uuid NOT NULL,
    action recommendation_eav_action NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    recommendation uuid NOT NULL
);
 '   DROP TABLE public.recommendations_eav;
       public      	   emilsedgh    false    3    6    2010    6                       1259    153389    reviews    TABLE     �   CREATE TABLE reviews (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    deleted_at timestamp with time zone,
    deal uuid NOT NULL,
    file uuid,
    envelope_document uuid
);
    DROP TABLE public.reviews;
       public      	   emilsedgh    false    3    6    6                       1259    153411    reviews_history    TABLE     �   CREATE TABLE reviews_history (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    created_by uuid NOT NULL,
    review uuid NOT NULL,
    state review_state NOT NULL,
    comment text
);
 #   DROP TABLE public.reviews_history;
       public      	   emilsedgh    false    3    6    2338    6                       1259    22004    rooms    TABLE     9  CREATE TABLE rooms (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    title text,
    owner uuid,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone,
    room_type room_type NOT NULL
);
    DROP TABLE public.rooms;
       public      	   emilsedgh    false    3    6    6    2022                       1259    22013    rooms_room_code_seq    SEQUENCE     x   CREATE SEQUENCE rooms_room_code_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.rooms_room_code_seq;
       public    	   emilsedgh    false    6                       1259    22015    rooms_users    TABLE     }  CREATE TABLE rooms_users (
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
    DROP TABLE public.rooms_users;
       public      	   emilsedgh    false    3    6    6                       1259    22023    schools    MATERIALIZED VIEW     �  CREATE MATERIALIZED VIEW schools AS
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
 '   DROP MATERIALIZED VIEW public.schools;
       public      	   emilsedgh    false    241    241    241    241    241    241    241    6            	           1259    22031    seamless_phone_pool    TABLE     �   CREATE TABLE seamless_phone_pool (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    phone_number text NOT NULL,
    enabled boolean DEFAULT true
);
 '   DROP TABLE public.seamless_phone_pool;
       public      	   emilsedgh    false    3    6    6            
           1259    22039    sessions    TABLE        CREATE TABLE sessions (
    id uuid DEFAULT uuid_generate_v1(),
    device_id character varying(255),
    device_name character varying(255),
    client_version character varying(30),
    created_at timestamp without time zone DEFAULT clock_timestamp()
);
    DROP TABLE public.sessions;
       public      	   emilsedgh    false    3    6    6                       1259    22047    stripe_charges    TABLE     3  CREATE TABLE stripe_charges (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    "user" uuid NOT NULL,
    customer uuid NOT NULL,
    amount integer,
    charge jsonb
);
 "   DROP TABLE public.stripe_charges;
       public      	   emilsedgh    false    3    6    6                       1259    22056    stripe_customers    TABLE     U  CREATE TABLE stripe_customers (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    owner uuid NOT NULL,
    customer_id text NOT NULL,
    source jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    deleted_at timestamp with time zone
);
 $   DROP TABLE public.stripe_customers;
       public      	   emilsedgh    false    3    6    6                       1259    22065    subdivisions    MATERIALIZED VIEW     �   CREATE MATERIALIZED VIEW subdivisions AS
 SELECT DISTINCT properties.subdivision_name AS title,
    count(*) AS appearances
   FROM properties
  GROUP BY properties.subdivision_name
  ORDER BY properties.subdivision_name
  WITH NO DATA;
 ,   DROP MATERIALIZED VIEW public.subdivisions;
       public      	   emilsedgh    false    241    6                       1259    22118    users    TABLE     ,  CREATE TABLE users (
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
    DROP TABLE public.users;
       public      	   emilsedgh    false    3    6    2043    2046    6    2043    2046                       1259    22135    users_user_code_seq    SEQUENCE     x   CREATE SEQUENCE users_user_code_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.users_user_code_seq;
       public    	   emilsedgh    false    6                       1259    22137    websites    TABLE     �   CREATE TABLE websites (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    "user" uuid NOT NULL
);
    DROP TABLE public.websites;
       public      	   emilsedgh    false    3    6    6                       1259    22143    websites_hostnames    TABLE     �   CREATE TABLE websites_hostnames (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    website uuid NOT NULL,
    hostname text,
    "default" boolean DEFAULT false NOT NULL
);
 &   DROP TABLE public.websites_hostnames;
       public      	   emilsedgh    false    3    6    6                       1259    22151    websites_snapshots    TABLE     /  CREATE TABLE websites_snapshots (
    id uuid DEFAULT uuid_generate_v1() NOT NULL,
    website uuid NOT NULL,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    brand uuid,
    template text,
    attributes jsonb
);
 &   DROP TABLE public.websites_snapshots;
       public      	   emilsedgh    false    3    6    6                       1259    22160    words    MATERIALIZED VIEW     �   CREATE MATERIALIZED VIEW words AS
 SELECT ts_stat.word,
    ts_stat.ndoc AS occurances
   FROM ts_stat('SELECT to_tsvector(''simple'', address) FROM listings_filters'::text) ts_stat(word, ndoc, nentry)
  WITH NO DATA;
 %   DROP MATERIALIZED VIEW public.words;
       public      	   emilsedgh    false    6                       1259    22465    foo    TABLE     K   CREATE TABLE foo (
    geom public.geometry(Point,4326),
    title text
);
    DROP TABLE tiger.foo;
       tiger      	   emilsedgh    false    12    4    4    6    4    6    4    6    4    6    6    4    6    4    6    4    6            1          0    144975 
   activities 
   TABLE DATA               �   COPY activities (id, reference, reference_type, created_at, updated_at, deleted_at, object, object_class, object_sa, action) FROM stdin;
    public    	   emilsedgh    false    280   �      �          0    21529 	   addresses 
   TABLE DATA               k  COPY addresses (title, subtitle, street_number, street_name, city, state, state_code, postal_code, neighborhood, id, street_suffix, unit_number, country, country_code, created_at, updated_at, location_google, matrix_unique_id, geocoded, geo_source, partial_match_google, county_or_parish, direction, street_dir_prefix, street_dir_suffix, street_number_searchable, geo_source_formatted_address_google, geocoded_google, geocoded_bing, location_bing, geo_source_formatted_address_bing, geo_confidence_google, geo_confidence_bing, location, approximate, corrupted, corrupted_google, corrupted_bing, deleted_at) FROM stdin;
    public    	   emilsedgh    false    206   �      �          0    21541    agents 
   TABLE DATA                 COPY agents (id, email, mlsid, fax, full_name, first_name, last_name, middle_name, phone_number, nar_number, office_mui, status, office_mlsid, work_phone, generational_name, matrix_unique_id, matrix_modified_dt, updated_at, deleted_at, created_at) FROM stdin;
    public    	   emilsedgh    false    207   D>      �          0    21567    agents_images 
   TABLE DATA               @   COPY agents_images (id, mui, url, image_type, date) FROM stdin;
    public    	   emilsedgh    false    210   a>      �          0    21582    alerts 
   TABLE DATA               �  COPY alerts (id, minimum_price, maximum_price, minimum_square_meters, maximum_square_meters, created_by, created_at, updated_at, room, minimum_bedrooms, minimum_bathrooms, property_subtypes, points, minimum_year_built, pool, title, minimum_lot_square_meters, maximum_lot_square_meters, maximum_year_built, deleted_at, listing_statuses, open_house, minimum_sold_date, property_types, list_agents, list_offices, counties, minimum_parking_spaces, architectural_styles, subdivisions, school_districts, primary_schools, elementary_schools, senior_high_schools, junior_high_schools, intermediate_schools, sort_order, sort_office, selling_offices, selling_agents, mls_areas, middle_schools, offices, agents, high_schools, excluded_listing_ids, postal_codes) FROM stdin;
    public    	   emilsedgh    false    212   ~>      �          0    21591    attachments 
   TABLE DATA               x   COPY attachments (id, "user", url, metadata, created_at, updated_at, deleted_at, info, private, attributes) FROM stdin;
    public    	   emilsedgh    false    213   �>      �          0    21601    attachments_eav 
   TABLE DATA               :   COPY attachments_eav (id, object, attachment) FROM stdin;
    public    	   emilsedgh    false    214   �>      �          0    21605    brands 
   TABLE DATA               P   COPY brands (id, created_at, updated_at, palette, assets, messages) FROM stdin;
    public    	   emilsedgh    false    215   �>      �          0    21614    brands_agents 
   TABLE DATA               2   COPY brands_agents (id, brand, agent) FROM stdin;
    public    	   emilsedgh    false    216   �>      �          0    21618    brands_hostnames 
   TABLE DATA               C   COPY brands_hostnames (id, brand, hostname, "default") FROM stdin;
    public    	   emilsedgh    false    217   ?      �          0    21626    brands_offices 
   TABLE DATA               4   COPY brands_offices (id, brand, office) FROM stdin;
    public    	   emilsedgh    false    218   ,?      �          0    21630    brands_parents 
   TABLE DATA               4   COPY brands_parents (id, brand, parent) FROM stdin;
    public    	   emilsedgh    false    219   I?      �          0    21634    brands_users 
   TABLE DATA               8   COPY brands_users (id, brand, "user", role) FROM stdin;
    public    	   emilsedgh    false    220   f?      �          0    21641    clients 
   TABLE DATA               ?   COPY clients (id, version, response, secret, name) FROM stdin;
    public    	   emilsedgh    false    221   �?      �          0    21648    cmas 
   TABLE DATA               �   COPY cmas (id, "user", room, suggested_price, comment, listings, created_at, updated_at, deleted_at, lowest_price, average_price, highest_price, lowest_dom, average_dom, highest_dom, main_listing) FROM stdin;
    public    	   emilsedgh    false    222    A      �          0    21663    contacts 
   TABLE DATA               �   COPY contacts (id, "user", created_at, updated_at, deleted_at, refs, merged, ios_address_book_id, android_address_book_id) FROM stdin;
    public    	   emilsedgh    false    223   =A      �          0    21673    contacts_attributes 
   TABLE DATA               r   COPY contacts_attributes (id, contact, attribute_type, attribute, created_at, updated_at, deleted_at) FROM stdin;
    public    	   emilsedgh    false    224   ZA      �          0    21682    contacts_emails 
   TABLE DATA               `   COPY contacts_emails (id, contact, email, data, created_at, updated_at, deleted_at) FROM stdin;
    public    	   emilsedgh    false    225   wA      �          0    21691    contacts_phone_numbers 
   TABLE DATA               n   COPY contacts_phone_numbers (id, contact, phone_number, data, created_at, updated_at, deleted_at) FROM stdin;
    public    	   emilsedgh    false    226   �A      �          0    21707    deals 
   TABLE DATA               e   COPY deals (id, created_at, updated_at, deleted_at, listing, created_by, brand, context) FROM stdin;
    public    	   emilsedgh    false    228   �A      �          0    21716    deals_roles 
   TABLE DATA               f   COPY deals_roles (id, created_at, updated_at, deleted_at, created_by, role, deal, "user") FROM stdin;
    public    	   emilsedgh    false    229   �A      .          0    128411    docusign_users 
   TABLE DATA               `   COPY docusign_users (id, "user", access_token, refresh_token, base_url, account_id) FROM stdin;
    public    	   emilsedgh    false    277   �A      �          0    21722    email_verifications 
   TABLE DATA               C   COPY email_verifications (id, code, created_at, email) FROM stdin;
    public    	   emilsedgh    false    230   B                 0    21730 	   envelopes 
   TABLE DATA               u   COPY envelopes (id, created_at, updated_at, created_by, deal, docusign_id, status, title, webhook_token) FROM stdin;
    public    	   emilsedgh    false    231   %B                0    21740    envelopes_documents 
   TABLE DATA               ]   COPY envelopes_documents (id, envelope, title, document_id, submission_revision) FROM stdin;
    public    	   emilsedgh    false    232   BB                0    21747    envelopes_recipients 
   TABLE DATA               n   COPY envelopes_recipients (id, created_at, updated_at, signed_at, envelope, role, "user", status) FROM stdin;
    public    	   emilsedgh    false    233   _B      /          0    136731    files 
   TABLE DATA               X   COPY files (id, created_at, updated_at, deleted_at, created_by, path, name) FROM stdin;
    public    	   emilsedgh    false    278   |B      0          0    136747    files_relations 
   TABLE DATA               _   COPY files_relations (id, created_at, updated_at, deleted_at, file, role, role_id) FROM stdin;
    public    	   emilsedgh    false    279   �B                0    21753    foo 
   TABLE DATA                  COPY foo (value) FROM stdin;
    public    	   emilsedgh    false    234   �B                0    21759    forms 
   TABLE DATA               \   COPY forms (id, created_at, updated_at, deleted_at, formstack_id, fields, name) FROM stdin;
    public    	   emilsedgh    false    235   �B                0    21769 
   forms_data 
   TABLE DATA               �   COPY forms_data (id, created_at, updated_at, deleted_at, submission, form, author, "values", formstack_response, state) FROM stdin;
    public    	   emilsedgh    false    236   C                0    21779    forms_submissions 
   TABLE DATA               f   COPY forms_submissions (id, created_at, updated_at, deleted_at, form, formstack_id, deal) FROM stdin;
    public    	   emilsedgh    false    237   *C                0    21785    godaddy_domains 
   TABLE DATA               b   COPY godaddy_domains (id, name, created_at, updated_at, owner, order_id, hosted_zone) FROM stdin;
    public    	   emilsedgh    false    238   GC                0    21794    godaddy_shoppers 
   TABLE DATA               d   COPY godaddy_shoppers (id, created_at, updated_at, "user", shopper_id, email, password) FROM stdin;
    public    	   emilsedgh    false    239   dC      	          0    21812    invitation_records 
   TABLE DATA               �   COPY invitation_records (id, invited_user, email, room, created_at, updated_at, accepted, inviting_user, deleted_at, phone_number, url, invitee_first_name, invitee_last_name) FROM stdin;
    public    	   emilsedgh    false    240   �C      �          0    21550    listings 
   TABLE DATA               �  COPY listings (id, property_id, alerting_agent_id, listing_agent_id, listing_agency_id, created_at, updated_at, cover_image_url, currency, price, gallery_image_urls, matrix_unique_id, original_price, last_price, low_price, status, association_fee, mls_number, association_fee_frequency, association_fee_includes, association_type, unexempt_taxes, financing_proposed, list_office_mui, list_office_mls_id, list_office_name, list_office_phone, possession, co_list_office_mui, co_list_office_mls_id, co_list_office_name, co_list_office_phone, selling_office_mui, selling_office_mls_id, selling_office_name, selling_office_phone, co_selling_office_mui, co_selling_office_mls_id, co_selling_office_name, co_selling_office_phone, list_agent_mui, list_agent_direct_work_phone, list_agent_email, list_agent_full_name, list_agent_mls_id, co_list_agent_mui, co_list_agent_direct_work_phone, co_list_agent_email, co_list_agent_full_name, co_list_agent_mls_id, selling_agent_mui, selling_agent_direct_work_phone, selling_agent_email, selling_agent_full_name, selling_agent_mls_id, co_selling_agent_mui, co_selling_agent_direct_work_phone, co_selling_agent_email, co_selling_agent_full_name, co_selling_agent_mls_id, listing_agreement, capitalization_rate, compensation_paid, date_available, last_status, mls_area_major, mls_area_minor, mls, move_in_date, permit_address_internet_yn, permit_comments_reviews_yn, permit_internet_yn, price_change_timestamp, matrix_modified_dt, property_association_fees, showing_instructions_type, special_notes, tax_legal_description, total_annual_expenses_include, transaction_type, virtual_tour_url_branded, virtual_tour_url_unbranded, active_option_contract_date, keybox_type, keybox_number, close_date, close_price, back_on_market_date, deposit_amount, photo_count, deleted_at, dom, cdom, buyers_agency_commission, sub_agency_commission, list_date, showing_instructions, appointment_phone, appointment_phone_ext, appointment_call, owner_name, seller_type, occupancy, private_remarks, photos_checked_at) FROM stdin;
    public    	   emilsedgh    false    208   �C                0    21839    messages 
   TABLE DATA               �   COPY messages (id, comment, image_url, document_url, video_url, recommendation, author, created_at, updated_at, room, message_type, image_thumbnail_url, deleted_at, notification, reference, mentions) FROM stdin;
    public    	   emilsedgh    false    242   П                0    21848    messages_acks 
   TABLE DATA               G   COPY messages_acks (id, message, room, "user", created_at) FROM stdin;
    public    	   emilsedgh    false    243   �                0    21853 
   migrations 
   TABLE DATA               0   COPY migrations (created_at, state) FROM stdin;
    public    	   emilsedgh    false    244   
�                0    21868    mls_data 
   TABLE DATA               U   COPY mls_data (id, created_at, value, class, resource, matrix_unique_id) FROM stdin;
    public    	   emilsedgh    false    246   ��                0    21876    mls_jobs 
   TABLE DATA               �   COPY mls_jobs (id, created_at, last_modified_date, last_id, results, query, is_initial_completed, name, "limit", "offset") FROM stdin;
    public    	   emilsedgh    false    247   ��                0    21902    notifications 
   TABLE DATA               /  COPY notifications (id, object, message, created_at, updated_at, room, action, object_class, subject, auxiliary_object_class, auxiliary_object, recommendation, auxiliary_subject, subject_class, auxiliary_subject_class, extra_subject_class, extra_object_class, deleted_at, exclude, specific) FROM stdin;
    public    	   emilsedgh    false    249   ��                0    21916    notifications_deliveries 
   TABLE DATA               }   COPY notifications_deliveries (id, "user", notification, device_token, type, created_at, updated_at, deleted_at) FROM stdin;
    public    	   emilsedgh    false    250   ޵                0    21893    notifications_tokens 
   TABLE DATA               d   COPY notifications_tokens (id, "user", device_token, created_at, updated_at, device_id) FROM stdin;
    public    	   emilsedgh    false    248   ��                0    21925    notifications_users 
   TABLE DATA               w   COPY notifications_users (id, "user", notification, acked_at, created_at, updated_at, deleted_at, seen_at) FROM stdin;
    public    	   emilsedgh    false    251   �                0    21931    offices 
   TABLE DATA               �  COPY offices (id, board, email, fax, office_mui, office_mls_id, license_number, address, care_of, city, postal_code, postal_code_plus4, state, matrix_unique_id, matrix_modified_dt, mls, mls_id, mls_provider, nar_number, contact_mui, contact_mls_id, long_name, name, status, phone, other_phone, st_address, st_city, st_country, st_postal_code, st_postal_code_plus4, st_state, url, created_at, updated_at) FROM stdin;
    public    	   emilsedgh    false    252   5�                0    21940    open_houses 
   TABLE DATA               �   COPY open_houses (id, start_time, end_time, description, listing_mui, refreshments, type, matrix_unique_id, created_at, updated_at, deleted_at) FROM stdin;
    public    	   emilsedgh    false    253   R�                0    21949    password_recovery_records 
   TABLE DATA               j   COPY password_recovery_records (id, email, "user", token, created_at, updated_at, expires_at) FROM stdin;
    public    	   emilsedgh    false    254   o�                0    21959    phone_verifications 
   TABLE DATA               J   COPY phone_verifications (id, code, created_at, phone_number) FROM stdin;
    public    	   emilsedgh    false    255   ��                0    21967    photos 
   TABLE DATA               �   COPY photos (id, created_at, processed_at, error, matrix_unique_id, listing_mui, description, url, "order", exif, deleted_at, revision, to_be_processed_at) FROM stdin;
    public    	   emilsedgh    false    256   ��      
          0    21822 
   properties 
   TABLE DATA               �  COPY properties (id, bedroom_count, bathroom_count, address_id, description, square_meters, created_at, updated_at, matrix_unique_id, property_type, property_subtype, lot_square_meters, year_built, accessibility_features, commercial_features, community_features, energysaving_features, exterior_features, interior_features, farmranch_features, fireplace_features, lot_features, parking_features, pool_features, security_features, bedroom_bathroom_features, parking_spaces_covered_total, half_bathroom_count, full_bathroom_count, heating, flooring, utilities, utilities_other, architectural_style, structural_style, number_of_stories, number_of_stories_in_building, number_of_parking_spaces, parking_spaces_carport, parking_spaces_garage, garage_length, garage_width, number_of_dining_areas, number_of_living_areas, fireplaces_total, lot_number, soil_type, construction_materials, construction_materials_walls, foundation_details, roof, pool_yn, handicap_yn, elementary_school_name, intermediate_school_name, high_school_name, junior_high_school_name, middle_school_name, primary_school_name, senior_high_school_name, school_district, subdivision_name, appliances_yn, building_number, ceiling_height, green_building_certification, green_energy_efficient, lot_size, lot_size_area, lot_size_dimensions, map_coordinates, number_of_pets_allowed, number_of_units, pets_yn, photo_count, room_count, subdivided_yn, surface_rights, unit_count, year_built_details, zoning, security_system_yn, deleted_at, building_square_meters) FROM stdin;
    public    	   emilsedgh    false    241   z                0    21976    property_rooms 
   TABLE DATA               �   COPY property_rooms (id, matrix_unique_id, matrix_modified_dt, description, length, width, features, listing_mui, level, room_type, created_at, updated_at) FROM stdin;
    public    	   emilsedgh    false    257   ��                0    21983    property_units 
   TABLE DATA                 COPY property_units (id, dining_length, dining_width, kitchen_length, kitchen_width, lease, listing_mui, living_length, living_width, master_length, master_width, matrix_unique_id, matrix_modified_dt, full_bath, half_bath, beds, units, square_feet, created_at, updated_at) FROM stdin;
    public    	   emilsedgh    false    258                    0    21989    recommendations 
   TABLE DATA               �   COPY recommendations (id, source, source_url, room, created_at, updated_at, listing, recommendation_type, matrix_unique_id, referring_objects, deleted_at, hidden, last_update) FROM stdin;
    public    	   emilsedgh    false    259   0                 0    21999    recommendations_eav 
   TABLE DATA               V   COPY recommendations_eav (id, "user", action, created_at, recommendation) FROM stdin;
    public    	   emilsedgh    false    260   M       2          0    153389    reviews 
   TABLE DATA               U   COPY reviews (id, created_at, deleted_at, deal, file, envelope_document) FROM stdin;
    public    	   emilsedgh    false    281   j       3          0    153411    reviews_history 
   TABLE DATA               V   COPY reviews_history (id, created_at, created_by, review, state, comment) FROM stdin;
    public    	   emilsedgh    false    282   �                 0    22004    rooms 
   TABLE DATA               Y   COPY rooms (id, title, owner, created_at, updated_at, deleted_at, room_type) FROM stdin;
    public    	   emilsedgh    false    261   �       ?           0    0    rooms_room_code_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('rooms_room_code_seq', 3183, true);
            public    	   emilsedgh    false    262                       0    22015    rooms_users 
   TABLE DATA               z   COPY rooms_users (id, room, "user", created_at, updated_at, push_enabled, phone_handler, archived, reference) FROM stdin;
    public    	   emilsedgh    false    263   �       "          0    22031    seamless_phone_pool 
   TABLE DATA               A   COPY seamless_phone_pool (id, phone_number, enabled) FROM stdin;
    public    	   emilsedgh    false    265   �       #          0    22039    sessions 
   TABLE DATA               S   COPY sessions (id, device_id, device_name, client_version, created_at) FROM stdin;
    public    	   emilsedgh    false    266   -      g          0    16686    spatial_ref_sys 
   TABLE DATA               Q   COPY spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public       postgres    false    192   J      $          0    22047    stripe_charges 
   TABLE DATA               _   COPY stripe_charges (id, created_at, updated_at, "user", customer, amount, charge) FROM stdin;
    public    	   emilsedgh    false    267   g      %          0    22056    stripe_customers 
   TABLE DATA               g   COPY stripe_customers (id, owner, customer_id, source, created_at, updated_at, deleted_at) FROM stdin;
    public    	   emilsedgh    false    268   �      '          0    22118    users 
   TABLE DATA               �  COPY users (username, first_name, last_name, email, phone_number, created_at, id, password, address_id, cover_image_url, profile_image_url, updated_at, user_status, profile_image_thumbnail_url, cover_image_thumbnail_url, email_confirmed, timezone, user_type, deleted_at, phone_confirmed, agent, secondary_password, is_shadow, personal_room, brand, fake_email, facebook_access_token, features) FROM stdin;
    public    	   emilsedgh    false    270   �      @           0    0    users_user_code_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('users_user_code_seq', 2014, true);
            public    	   emilsedgh    false    271            )          0    22137    websites 
   TABLE DATA               ?   COPY websites (id, created_at, updated_at, "user") FROM stdin;
    public    	   emilsedgh    false    272   �      *          0    22143    websites_hostnames 
   TABLE DATA               G   COPY websites_hostnames (id, website, hostname, "default") FROM stdin;
    public    	   emilsedgh    false    273   �      +          0    22151    websites_snapshots 
   TABLE DATA               g   COPY websites_snapshots (id, website, created_at, updated_at, brand, template, attributes) FROM stdin;
    public    	   emilsedgh    false    274   �      -          0    22465    foo 
   TABLE DATA               #   COPY foo (geom, title) FROM stdin;
    tiger    	   emilsedgh    false    276   �      0           2606    126749    addresses addresses_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.addresses DROP CONSTRAINT addresses_pkey;
       public      	   emilsedgh    false    206    206            G           2606    126751     agents_images agents_images_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY agents_images
    ADD CONSTRAINT agents_images_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.agents_images DROP CONSTRAINT agents_images_pkey;
       public      	   emilsedgh    false    210    210            2           2606    126753 "   agents agents_matrix_unique_id_key 
   CONSTRAINT     b   ALTER TABLE ONLY agents
    ADD CONSTRAINT agents_matrix_unique_id_key UNIQUE (matrix_unique_id);
 L   ALTER TABLE ONLY public.agents DROP CONSTRAINT agents_matrix_unique_id_key;
       public      	   emilsedgh    false    207    207            4           2606    126755    agents agents_mlsid 
   CONSTRAINT     H   ALTER TABLE ONLY agents
    ADD CONSTRAINT agents_mlsid UNIQUE (mlsid);
 =   ALTER TABLE ONLY public.agents DROP CONSTRAINT agents_mlsid;
       public      	   emilsedgh    false    207    207            6           2606    126757    agents agents_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY agents
    ADD CONSTRAINT agents_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.agents DROP CONSTRAINT agents_pkey;
       public      	   emilsedgh    false    207    207            U           2606    126759    alerts alerts_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.alerts DROP CONSTRAINT alerts_pkey;
       public      	   emilsedgh    false    212    212            \           2606    126761 5   attachments_eav attachments_eav_object_attachment_key 
   CONSTRAINT     w   ALTER TABLE ONLY attachments_eav
    ADD CONSTRAINT attachments_eav_object_attachment_key UNIQUE (object, attachment);
 _   ALTER TABLE ONLY public.attachments_eav DROP CONSTRAINT attachments_eav_object_attachment_key;
       public      	   emilsedgh    false    214    214    214            Z           2606    126763    attachments attachments_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.attachments DROP CONSTRAINT attachments_pkey;
       public      	   emilsedgh    false    213    213            d           2606    126765 '   brands_parents brands_parents_brand_key 
   CONSTRAINT     \   ALTER TABLE ONLY brands_parents
    ADD CONSTRAINT brands_parents_brand_key UNIQUE (brand);
 Q   ALTER TABLE ONLY public.brands_parents DROP CONSTRAINT brands_parents_brand_key;
       public      	   emilsedgh    false    219    219            ^           2606    126767    brands brands_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.brands DROP CONSTRAINT brands_pkey;
       public      	   emilsedgh    false    215    215            h           2606    126769    contacts contacts_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.contacts DROP CONSTRAINT contacts_pkey;
       public      	   emilsedgh    false    223    223            m           2606    126771    deals deals_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY deals
    ADD CONSTRAINT deals_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.deals DROP CONSTRAINT deals_pkey;
       public      	   emilsedgh    false    228    228            o           2606    126773    deals_roles deals_roles_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY deals_roles
    ADD CONSTRAINT deals_roles_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.deals_roles DROP CONSTRAINT deals_roles_pkey;
       public      	   emilsedgh    false    229    229            �           2606    136775 !   docusign_users docusign_user_code 
   CONSTRAINT     W   ALTER TABLE ONLY docusign_users
    ADD CONSTRAINT docusign_user_code UNIQUE ("user");
 K   ALTER TABLE ONLY public.docusign_users DROP CONSTRAINT docusign_user_code;
       public      	   emilsedgh    false    277    277            �           2606    128416 "   docusign_users docusign_users_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY docusign_users
    ADD CONSTRAINT docusign_users_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.docusign_users DROP CONSTRAINT docusign_users_pkey;
       public      	   emilsedgh    false    277    277            u           2606    126775 ,   envelopes_documents envelopes_documents_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY envelopes_documents
    ADD CONSTRAINT envelopes_documents_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.envelopes_documents DROP CONSTRAINT envelopes_documents_pkey;
       public      	   emilsedgh    false    232    232            q           2606    126777 #   envelopes envelopes_docusign_id_key 
   CONSTRAINT     ^   ALTER TABLE ONLY envelopes
    ADD CONSTRAINT envelopes_docusign_id_key UNIQUE (docusign_id);
 M   ALTER TABLE ONLY public.envelopes DROP CONSTRAINT envelopes_docusign_id_key;
       public      	   emilsedgh    false    231    231            s           2606    126779    envelopes envelopes_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY envelopes
    ADD CONSTRAINT envelopes_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.envelopes DROP CONSTRAINT envelopes_pkey;
       public      	   emilsedgh    false    231    231            w           2606    126781 .   envelopes_recipients envelopes_recipients_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY envelopes_recipients
    ADD CONSTRAINT envelopes_recipients_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.envelopes_recipients DROP CONSTRAINT envelopes_recipients_pkey;
       public      	   emilsedgh    false    233    233            �           2606    136741    files files_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.files DROP CONSTRAINT files_pkey;
       public      	   emilsedgh    false    278    278            �           2606    136757 $   files_relations files_relations_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY files_relations
    ADD CONSTRAINT files_relations_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.files_relations DROP CONSTRAINT files_relations_pkey;
       public      	   emilsedgh    false    279    279            }           2606    126783    forms_data forms_data_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY forms_data
    ADD CONSTRAINT forms_data_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.forms_data DROP CONSTRAINT forms_data_pkey;
       public      	   emilsedgh    false    236    236            y           2606    126785    forms forms_formstack_id_key 
   CONSTRAINT     X   ALTER TABLE ONLY forms
    ADD CONSTRAINT forms_formstack_id_key UNIQUE (formstack_id);
 F   ALTER TABLE ONLY public.forms DROP CONSTRAINT forms_formstack_id_key;
       public      	   emilsedgh    false    235    235            {           2606    126787    forms forms_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY forms
    ADD CONSTRAINT forms_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.forms DROP CONSTRAINT forms_pkey;
       public      	   emilsedgh    false    235    235                       2606    126789 (   forms_submissions forms_submissions_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY forms_submissions
    ADD CONSTRAINT forms_submissions_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.forms_submissions DROP CONSTRAINT forms_submissions_pkey;
       public      	   emilsedgh    false    237    237            �           2606    126791 (   godaddy_domains godaddy_domains_name_key 
   CONSTRAINT     \   ALTER TABLE ONLY godaddy_domains
    ADD CONSTRAINT godaddy_domains_name_key UNIQUE (name);
 R   ALTER TABLE ONLY public.godaddy_domains DROP CONSTRAINT godaddy_domains_name_key;
       public      	   emilsedgh    false    238    238            �           2606    126793 &   godaddy_shoppers godaddy_shoppers_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY godaddy_shoppers
    ADD CONSTRAINT godaddy_shoppers_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.godaddy_shoppers DROP CONSTRAINT godaddy_shoppers_pkey;
       public      	   emilsedgh    false    239    239            ?           2606    126797    listings listings_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.listings DROP CONSTRAINT listings_pkey;
       public      	   emilsedgh    false    208    208            �           2606    126799 1   messages_acks messages_acks_message_room_user_key 
   CONSTRAINT     v   ALTER TABLE ONLY messages_acks
    ADD CONSTRAINT messages_acks_message_room_user_key UNIQUE (message, room, "user");
 [   ALTER TABLE ONLY public.messages_acks DROP CONSTRAINT messages_acks_message_room_user_key;
       public      	   emilsedgh    false    243    243    243    243            �           2606    126801     messages_acks messages_acks_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY messages_acks
    ADD CONSTRAINT messages_acks_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.messages_acks DROP CONSTRAINT messages_acks_pkey;
       public      	   emilsedgh    false    243    243            �           2606    126803    messages messages_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.messages DROP CONSTRAINT messages_pkey;
       public      	   emilsedgh    false    242    242            �           2606    126809 -   notifications_tokens notification_tokens_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY notifications_tokens
    ADD CONSTRAINT notification_tokens_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY public.notifications_tokens DROP CONSTRAINT notification_tokens_pkey;
       public      	   emilsedgh    false    248    248            �           2606    126811 7   notifications_tokens notification_tokens_user_device_id 
   CONSTRAINT     x   ALTER TABLE ONLY notifications_tokens
    ADD CONSTRAINT notification_tokens_user_device_id UNIQUE ("user", device_id);
 a   ALTER TABLE ONLY public.notifications_tokens DROP CONSTRAINT notification_tokens_user_device_id;
       public      	   emilsedgh    false    248    248    248            �           2606    126815 6   notifications_deliveries notifications_deliveries_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY notifications_deliveries
    ADD CONSTRAINT notifications_deliveries_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.notifications_deliveries DROP CONSTRAINT notifications_deliveries_pkey;
       public      	   emilsedgh    false    250    250            �           2606    126817     notifications notifications_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_pkey;
       public      	   emilsedgh    false    249    249            �           2606    126819 ,   notifications_users notifications_users_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY notifications_users
    ADD CONSTRAINT notifications_users_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.notifications_users DROP CONSTRAINT notifications_users_pkey;
       public      	   emilsedgh    false    251    251            �           2606    126821    offices offices_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY offices
    ADD CONSTRAINT offices_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.offices DROP CONSTRAINT offices_pkey;
       public      	   emilsedgh    false    252    252            �           2606    126823 ,   open_houses open_houses_matrix_unique_id_key 
   CONSTRAINT     l   ALTER TABLE ONLY open_houses
    ADD CONSTRAINT open_houses_matrix_unique_id_key UNIQUE (matrix_unique_id);
 V   ALTER TABLE ONLY public.open_houses DROP CONSTRAINT open_houses_matrix_unique_id_key;
       public      	   emilsedgh    false    253    253            �           2606    126825 "   photos photos_matrix_unique_id_key 
   CONSTRAINT     b   ALTER TABLE ONLY photos
    ADD CONSTRAINT photos_matrix_unique_id_key UNIQUE (matrix_unique_id);
 L   ALTER TABLE ONLY public.photos DROP CONSTRAINT photos_matrix_unique_id_key;
       public      	   emilsedgh    false    256    256            �           2606    126827    properties properties_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY properties
    ADD CONSTRAINT properties_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.properties DROP CONSTRAINT properties_pkey;
       public      	   emilsedgh    false    241    241            �           2606    126836 "   property_rooms property_rooms_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY property_rooms
    ADD CONSTRAINT property_rooms_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.property_rooms DROP CONSTRAINT property_rooms_pkey;
       public      	   emilsedgh    false    257    257            �           2606    126838 F   recommendations_eav recommendations_eav_user_recommendation_action_key 
   CONSTRAINT     �   ALTER TABLE ONLY recommendations_eav
    ADD CONSTRAINT recommendations_eav_user_recommendation_action_key UNIQUE ("user", recommendation, action);
 p   ALTER TABLE ONLY public.recommendations_eav DROP CONSTRAINT recommendations_eav_user_recommendation_action_key;
       public      	   emilsedgh    false    260    260    260    260            �           2606    126840 $   recommendations recommendations_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY recommendations
    ADD CONSTRAINT recommendations_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.recommendations DROP CONSTRAINT recommendations_pkey;
       public      	   emilsedgh    false    259    259            �           2606    126842 0   recommendations recommendations_room_listing_key 
   CONSTRAINT     m   ALTER TABLE ONLY recommendations
    ADD CONSTRAINT recommendations_room_listing_key UNIQUE (room, listing);
 Z   ALTER TABLE ONLY public.recommendations DROP CONSTRAINT recommendations_room_listing_key;
       public      	   emilsedgh    false    259    259    259            �           2606    153420 $   reviews_history reviews_history_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY reviews_history
    ADD CONSTRAINT reviews_history_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.reviews_history DROP CONSTRAINT reviews_history_pkey;
       public      	   emilsedgh    false    282    282            �           2606    153395    reviews reviews_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_pkey;
       public      	   emilsedgh    false    281    281            �           2606    126844 0   invitation_records rooms_invitation_records_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY invitation_records
    ADD CONSTRAINT rooms_invitation_records_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.invitation_records DROP CONSTRAINT rooms_invitation_records_pkey;
       public      	   emilsedgh    false    240    240            �           2606    126846    rooms rooms_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.rooms DROP CONSTRAINT rooms_pkey;
       public      	   emilsedgh    false    261    261            �           2606    126848    rooms_users rooms_users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY rooms_users
    ADD CONSTRAINT rooms_users_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.rooms_users DROP CONSTRAINT rooms_users_pkey;
       public      	   emilsedgh    false    263    263            �           2606    126850 %   rooms_users rooms_users_room_user_key 
   CONSTRAINT     a   ALTER TABLE ONLY rooms_users
    ADD CONSTRAINT rooms_users_room_user_key UNIQUE (room, "user");
 O   ALTER TABLE ONLY public.rooms_users DROP CONSTRAINT rooms_users_room_user_key;
       public      	   emilsedgh    false    263    263    263            �           2606    126852 ,   seamless_phone_pool seamless_phone_pool_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY seamless_phone_pool
    ADD CONSTRAINT seamless_phone_pool_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.seamless_phone_pool DROP CONSTRAINT seamless_phone_pool_pkey;
       public      	   emilsedgh    false    265    265            �           2606    126854 "   stripe_charges stripe_charges_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY stripe_charges
    ADD CONSTRAINT stripe_charges_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.stripe_charges DROP CONSTRAINT stripe_charges_pkey;
       public      	   emilsedgh    false    267    267            �           2606    126856 &   stripe_customers stripe_customers_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY stripe_customers
    ADD CONSTRAINT stripe_customers_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.stripe_customers DROP CONSTRAINT stripe_customers_pkey;
       public      	   emilsedgh    false    268    268            �           2606    126874    godaddy_shoppers unique_user 
   CONSTRAINT     R   ALTER TABLE ONLY godaddy_shoppers
    ADD CONSTRAINT unique_user UNIQUE ("user");
 F   ALTER TABLE ONLY public.godaddy_shoppers DROP CONSTRAINT unique_user;
       public      	   emilsedgh    false    239    239            �           2606    126876    property_units units_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY property_units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);
 C   ALTER TABLE ONLY public.property_units DROP CONSTRAINT units_pkey;
       public      	   emilsedgh    false    258    258            �           2606    126878    users users_email_key 
   CONSTRAINT     J   ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public      	   emilsedgh    false    270    270            �           2606    126880    users users_phone_number_key 
   CONSTRAINT     X   ALTER TABLE ONLY users
    ADD CONSTRAINT users_phone_number_key UNIQUE (phone_number);
 F   ALTER TABLE ONLY public.users DROP CONSTRAINT users_phone_number_key;
       public      	   emilsedgh    false    270    270            �           2606    126882    users users_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public      	   emilsedgh    false    270    270            �           2606    126884 )   websites_hostnames websites_hostnames_key 
   CONSTRAINT     a   ALTER TABLE ONLY websites_hostnames
    ADD CONSTRAINT websites_hostnames_key UNIQUE (hostname);
 S   ALTER TABLE ONLY public.websites_hostnames DROP CONSTRAINT websites_hostnames_key;
       public      	   emilsedgh    false    273    273            �           2606    126886    websites websites_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY websites
    ADD CONSTRAINT websites_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.websites DROP CONSTRAINT websites_pkey;
       public      	   emilsedgh    false    272    272            �           2606    126888 *   websites_snapshots websites_snapshots_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY websites_snapshots
    ADD CONSTRAINT websites_snapshots_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.websites_snapshots DROP CONSTRAINT websites_snapshots_pkey;
       public      	   emilsedgh    false    274    274            ,           1259    126987    addresses_location_gix    INDEX     H   CREATE INDEX addresses_location_gix ON addresses USING gist (location);
 *   DROP INDEX public.addresses_location_gix;
       public      	   emilsedgh    false    206    4    4    4    6    6    4    6    4    4    6    4    6    4    6    4    6    6    4    6    4    6    4    6    4    6    6            -           1259    126988    addresses_location_idx    INDEX     I   CREATE INDEX addresses_location_idx ON addresses USING btree (location);
 *   DROP INDEX public.addresses_location_idx;
       public      	   emilsedgh    false    206    4    4    6    6    4    4    6    4    6    4    6    4    6    6    4    6    4    6    4    6            .           1259    126989    addresses_matrix_unique_id_idx    INDEX     `   CREATE UNIQUE INDEX addresses_matrix_unique_id_idx ON addresses USING btree (matrix_unique_id);
 2   DROP INDEX public.addresses_matrix_unique_id_idx;
       public      	   emilsedgh    false    206            C           1259    126990    agents_emails_email    INDEX     N   CREATE INDEX agents_emails_email ON agents_emails USING btree (lower(email));
 '   DROP INDEX public.agents_emails_email;
       public      	   emilsedgh    false    209    209            D           1259    126991    agents_emails_idx    INDEX     I   CREATE UNIQUE INDEX agents_emails_idx ON agents_emails USING btree (id);
 %   DROP INDEX public.agents_emails_idx;
       public      	   emilsedgh    false    209            E           1259    126992    agents_emails_mui    INDEX     C   CREATE INDEX agents_emails_mui ON agents_emails USING btree (mui);
 %   DROP INDEX public.agents_emails_mui;
       public      	   emilsedgh    false    209            H           1259    126993    agents_phones_idx    INDEX     I   CREATE UNIQUE INDEX agents_phones_idx ON agents_phones USING btree (id);
 %   DROP INDEX public.agents_phones_idx;
       public      	   emilsedgh    false    211            I           1259    126994    agents_phones_mui    INDEX     C   CREATE INDEX agents_phones_mui ON agents_phones USING btree (mui);
 %   DROP INDEX public.agents_phones_mui;
       public      	   emilsedgh    false    211            J           1259    126995    agents_phones_phone    INDEX     G   CREATE INDEX agents_phones_phone ON agents_phones USING btree (phone);
 '   DROP INDEX public.agents_phones_phone;
       public      	   emilsedgh    false    211            7           1259    126996    agents_regexp_replace_idx    INDEX        CREATE INDEX agents_regexp_replace_idx ON agents USING btree (regexp_replace(upper(mlsid), '^0*'::text, ''::text, 'g'::text));
 -   DROP INDEX public.agents_regexp_replace_idx;
       public      	   emilsedgh    false    207    207            K           1259    126997    alerts_created_by_idx    INDEX     G   CREATE INDEX alerts_created_by_idx ON alerts USING btree (created_by);
 )   DROP INDEX public.alerts_created_by_idx;
       public      	   emilsedgh    false    212            L           1259    126998 $   alerts_maximum_lot_square_meters_idx    INDEX     e   CREATE INDEX alerts_maximum_lot_square_meters_idx ON alerts USING btree (maximum_lot_square_meters);
 8   DROP INDEX public.alerts_maximum_lot_square_meters_idx;
       public      	   emilsedgh    false    212            M           1259    126999    alerts_maximum_price_idx    INDEX     M   CREATE INDEX alerts_maximum_price_idx ON alerts USING btree (maximum_price);
 ,   DROP INDEX public.alerts_maximum_price_idx;
       public      	   emilsedgh    false    212            N           1259    127000     alerts_maximum_square_meters_idx    INDEX     ]   CREATE INDEX alerts_maximum_square_meters_idx ON alerts USING btree (maximum_square_meters);
 4   DROP INDEX public.alerts_maximum_square_meters_idx;
       public      	   emilsedgh    false    212            O           1259    127001    alerts_maximum_year_built_idx    INDEX     W   CREATE INDEX alerts_maximum_year_built_idx ON alerts USING btree (maximum_year_built);
 1   DROP INDEX public.alerts_maximum_year_built_idx;
       public      	   emilsedgh    false    212            P           1259    127002 $   alerts_minimum_lot_square_meters_idx    INDEX     e   CREATE INDEX alerts_minimum_lot_square_meters_idx ON alerts USING btree (minimum_lot_square_meters);
 8   DROP INDEX public.alerts_minimum_lot_square_meters_idx;
       public      	   emilsedgh    false    212            Q           1259    127003    alerts_minimum_price_idx    INDEX     M   CREATE INDEX alerts_minimum_price_idx ON alerts USING btree (minimum_price);
 ,   DROP INDEX public.alerts_minimum_price_idx;
       public      	   emilsedgh    false    212            R           1259    127004     alerts_minimum_square_meters_idx    INDEX     ]   CREATE INDEX alerts_minimum_square_meters_idx ON alerts USING btree (minimum_square_meters);
 4   DROP INDEX public.alerts_minimum_square_meters_idx;
       public      	   emilsedgh    false    212            S           1259    127005    alerts_minimum_year_built_idx    INDEX     W   CREATE INDEX alerts_minimum_year_built_idx ON alerts USING btree (minimum_year_built);
 1   DROP INDEX public.alerts_minimum_year_built_idx;
       public      	   emilsedgh    false    212            V           1259    127006    alerts_pool_idx    INDEX     ;   CREATE INDEX alerts_pool_idx ON alerts USING btree (pool);
 #   DROP INDEX public.alerts_pool_idx;
       public      	   emilsedgh    false    212            W           1259    127007    alerts_property_subtypes_idx    INDEX     U   CREATE INDEX alerts_property_subtypes_idx ON alerts USING btree (property_subtypes);
 0   DROP INDEX public.alerts_property_subtypes_idx;
       public      	   emilsedgh    false    212            X           1259    127008    alerts_room_idx    INDEX     ;   CREATE INDEX alerts_room_idx ON alerts USING btree (room);
 #   DROP INDEX public.alerts_room_idx;
       public      	   emilsedgh    false    212            _           1259    145088    brands_agents_agent    INDEX     G   CREATE INDEX brands_agents_agent ON brands_agents USING btree (agent);
 '   DROP INDEX public.brands_agents_agent;
       public      	   emilsedgh    false    216            `           1259    145085    brands_agents_brand    INDEX     G   CREATE INDEX brands_agents_brand ON brands_agents USING btree (brand);
 '   DROP INDEX public.brands_agents_brand;
       public      	   emilsedgh    false    216            a           1259    145086    brands_offices_brand    INDEX     I   CREATE INDEX brands_offices_brand ON brands_offices USING btree (brand);
 (   DROP INDEX public.brands_offices_brand;
       public      	   emilsedgh    false    218            b           1259    145089    brands_offices_office    INDEX     K   CREATE INDEX brands_offices_office ON brands_offices USING btree (office);
 )   DROP INDEX public.brands_offices_office;
       public      	   emilsedgh    false    218            e           1259    145084    brands_users_brand    INDEX     E   CREATE INDEX brands_users_brand ON brands_users USING btree (brand);
 &   DROP INDEX public.brands_users_brand;
       public      	   emilsedgh    false    220            f           1259    145087    brands_users_user    INDEX     E   CREATE INDEX brands_users_user ON brands_users USING btree ("user");
 %   DROP INDEX public.brands_users_user;
       public      	   emilsedgh    false    220            i           1259    127009    contacts_emails_email_idx    INDEX     O   CREATE INDEX contacts_emails_email_idx ON contacts_emails USING btree (email);
 -   DROP INDEX public.contacts_emails_email_idx;
       public      	   emilsedgh    false    225            j           1259    127010 '   contacts_phone_numbers_phone_number_idx    INDEX     k   CREATE INDEX contacts_phone_numbers_phone_number_idx ON contacts_phone_numbers USING btree (phone_number);
 ;   DROP INDEX public.contacts_phone_numbers_phone_number_idx;
       public      	   emilsedgh    false    226            k           1259    127011    county_title_gim    INDEX     J   CREATE INDEX county_title_gim ON counties USING gin (title gin_trgm_ops);
 $   DROP INDEX public.county_title_gim;
       public      	   emilsedgh    false    227    2    2    6    6            8           1259    127012    listings_close_date_idx    INDEX     K   CREATE INDEX listings_close_date_idx ON listings USING btree (close_date);
 +   DROP INDEX public.listings_close_date_idx;
       public      	   emilsedgh    false    208            �           1259    157827    listings_filters_address    INDEX     r   CREATE INDEX listings_filters_address ON listings_filters USING gin (to_tsvector('english'::regconfig, address));
 ,   DROP INDEX public.listings_filters_address;
       public      	   emilsedgh    false    283    283            �           1259    157823    listings_filters_address_trgm    INDEX     a   CREATE INDEX listings_filters_address_trgm ON listings_filters USING gin (address gin_trgm_ops);
 1   DROP INDEX public.listings_filters_address_trgm;
       public      	   emilsedgh    false    2    2    6    6    283            �           1259    157830    listings_filters_architecture    INDEX     `   CREATE INDEX listings_filters_architecture ON listings_filters USING gin (architectural_style);
 1   DROP INDEX public.listings_filters_architecture;
       public      	   emilsedgh    false    283            �           1259    157829    listings_filters_close_price    INDEX     Y   CREATE INDEX listings_filters_close_price ON listings_filters USING btree (close_price);
 0   DROP INDEX public.listings_filters_close_price;
       public      	   emilsedgh    false    283            �           1259    157817    listings_filters_id    INDEX     N   CREATE UNIQUE INDEX listings_filters_id ON listings_filters USING btree (id);
 '   DROP INDEX public.listings_filters_id;
       public      	   emilsedgh    false    283                        1259    157826    listings_filters_list_agent    INDEX     ^   CREATE INDEX listings_filters_list_agent ON listings_filters USING btree (list_agent_mls_id);
 /   DROP INDEX public.listings_filters_list_agent;
       public      	   emilsedgh    false    283                       1259    157825    listings_filters_list_office    INDEX     `   CREATE INDEX listings_filters_list_office ON listings_filters USING btree (list_office_mls_id);
 0   DROP INDEX public.listings_filters_list_office;
       public      	   emilsedgh    false    283                       1259    157818    listings_filters_location    INDEX     R   CREATE INDEX listings_filters_location ON listings_filters USING gist (location);
 -   DROP INDEX public.listings_filters_location;
       public      	   emilsedgh    false    4    4    4    6    6    4    6    4    4    6    4    6    4    6    4    6    6    4    6    4    6    4    6    4    6    6    283                       1259    157819    listings_filters_mls_area_major    INDEX     _   CREATE INDEX listings_filters_mls_area_major ON listings_filters USING btree (mls_area_major);
 3   DROP INDEX public.listings_filters_mls_area_major;
       public      	   emilsedgh    false    283                       1259    157820    listings_filters_mls_area_minor    INDEX     _   CREATE INDEX listings_filters_mls_area_minor ON listings_filters USING btree (mls_area_minor);
 3   DROP INDEX public.listings_filters_mls_area_minor;
       public      	   emilsedgh    false    283                       1259    157821    listings_filters_mls_number    INDEX     W   CREATE INDEX listings_filters_mls_number ON listings_filters USING btree (mls_number);
 /   DROP INDEX public.listings_filters_mls_number;
       public      	   emilsedgh    false    283                       1259    157828    listings_filters_price    INDEX     M   CREATE INDEX listings_filters_price ON listings_filters USING btree (price);
 *   DROP INDEX public.listings_filters_price;
       public      	   emilsedgh    false    283                       1259    157822    listings_filters_status    INDEX     O   CREATE INDEX listings_filters_status ON listings_filters USING btree (status);
 +   DROP INDEX public.listings_filters_status;
       public      	   emilsedgh    false    283                       1259    157824    listings_filters_status_order    INDEX     e   CREATE INDEX listings_filters_status_order ON listings_filters USING btree (order_listings(status));
 1   DROP INDEX public.listings_filters_status_order;
       public      	   emilsedgh    false    283    283    1499            9           1259    127027    listings_list_date_idx    INDEX     I   CREATE INDEX listings_list_date_idx ON listings USING btree (list_date);
 *   DROP INDEX public.listings_list_date_idx;
       public      	   emilsedgh    false    208            :           1259    127028    listings_matrix_unique_id_idx    INDEX     ^   CREATE UNIQUE INDEX listings_matrix_unique_id_idx ON listings USING btree (matrix_unique_id);
 1   DROP INDEX public.listings_matrix_unique_id_idx;
       public      	   emilsedgh    false    208            ;           1259    127029    listings_mls_area_major_idx    INDEX     S   CREATE INDEX listings_mls_area_major_idx ON listings USING btree (mls_area_major);
 /   DROP INDEX public.listings_mls_area_major_idx;
       public      	   emilsedgh    false    208            <           1259    127030    listings_mls_area_minor_idx    INDEX     S   CREATE INDEX listings_mls_area_minor_idx ON listings USING btree (mls_area_minor);
 /   DROP INDEX public.listings_mls_area_minor_idx;
       public      	   emilsedgh    false    208            =           1259    127031    listings_mls_number_idx    INDEX     K   CREATE INDEX listings_mls_number_idx ON listings USING btree (mls_number);
 +   DROP INDEX public.listings_mls_number_idx;
       public      	   emilsedgh    false    208            @           1259    127032    listings_price_idx    INDEX     A   CREATE INDEX listings_price_idx ON listings USING btree (price);
 &   DROP INDEX public.listings_price_idx;
       public      	   emilsedgh    false    208            A           1259    127058    listings_property_id_idx    INDEX     M   CREATE INDEX listings_property_id_idx ON listings USING btree (property_id);
 ,   DROP INDEX public.listings_property_id_idx;
       public      	   emilsedgh    false    208            B           1259    127059    listings_status_idx    INDEX     C   CREATE INDEX listings_status_idx ON listings USING btree (status);
 '   DROP INDEX public.listings_status_idx;
       public      	   emilsedgh    false    208            �           1259    127060    messages_acks_message_idx    INDEX     O   CREATE INDEX messages_acks_message_idx ON messages_acks USING btree (message);
 -   DROP INDEX public.messages_acks_message_idx;
       public      	   emilsedgh    false    243            �           1259    127061    messages_acks_room_idx    INDEX     I   CREATE INDEX messages_acks_room_idx ON messages_acks USING btree (room);
 *   DROP INDEX public.messages_acks_room_idx;
       public      	   emilsedgh    false    243            �           1259    127062    messages_acks_user_idx    INDEX     K   CREATE INDEX messages_acks_user_idx ON messages_acks USING btree ("user");
 *   DROP INDEX public.messages_acks_user_idx;
       public      	   emilsedgh    false    243            �           1259    127063    messages_author_idx    INDEX     C   CREATE INDEX messages_author_idx ON messages USING btree (author);
 '   DROP INDEX public.messages_author_idx;
       public      	   emilsedgh    false    242            �           1259    127064    messages_object_idx    INDEX     K   CREATE INDEX messages_object_idx ON messages USING btree (recommendation);
 '   DROP INDEX public.messages_object_idx;
       public      	   emilsedgh    false    242            �           1259    127065    messages_room_idx    INDEX     ?   CREATE INDEX messages_room_idx ON messages USING btree (room);
 %   DROP INDEX public.messages_room_idx;
       public      	   emilsedgh    false    242            �           1259    127066    mls_areas_parent    INDEX     A   CREATE INDEX mls_areas_parent ON mls_areas USING btree (parent);
 $   DROP INDEX public.mls_areas_parent;
       public      	   emilsedgh    false    245            �           1259    127067    mls_areas_title_gin    INDEX     N   CREATE INDEX mls_areas_title_gin ON mls_areas USING gin (title gin_trgm_ops);
 '   DROP INDEX public.mls_areas_title_gin;
       public      	   emilsedgh    false    2    2    6    6    245            �           1259    127068    mls_data_matrix_unique_id_idx    INDEX     ^   CREATE UNIQUE INDEX mls_data_matrix_unique_id_idx ON mls_data USING btree (matrix_unique_id);
 1   DROP INDEX public.mls_data_matrix_unique_id_idx;
       public      	   emilsedgh    false    246            �           1259    127069    notification_tokens_user_idx    INDEX     X   CREATE INDEX notification_tokens_user_idx ON notifications_tokens USING btree ("user");
 0   DROP INDEX public.notification_tokens_user_idx;
       public      	   emilsedgh    false    248            �           1259    127070 "   notifications_auxiliary_object_idx    INDEX     a   CREATE INDEX notifications_auxiliary_object_idx ON notifications USING btree (auxiliary_object);
 6   DROP INDEX public.notifications_auxiliary_object_idx;
       public      	   emilsedgh    false    249            �           1259    127071 #   notifications_auxiliary_subject_idx    INDEX     c   CREATE INDEX notifications_auxiliary_subject_idx ON notifications USING btree (auxiliary_subject);
 7   DROP INDEX public.notifications_auxiliary_subject_idx;
       public      	   emilsedgh    false    249            �           1259    127072    notifications_object_idx    INDEX     M   CREATE INDEX notifications_object_idx ON notifications USING btree (object);
 ,   DROP INDEX public.notifications_object_idx;
       public      	   emilsedgh    false    249            �           1259    127073     notifications_recommendation_idx    INDEX     ]   CREATE INDEX notifications_recommendation_idx ON notifications USING btree (recommendation);
 4   DROP INDEX public.notifications_recommendation_idx;
       public      	   emilsedgh    false    249            �           1259    127074    notifications_room_idx    INDEX     I   CREATE INDEX notifications_room_idx ON notifications USING btree (room);
 *   DROP INDEX public.notifications_room_idx;
       public      	   emilsedgh    false    249            �           1259    127075    notifications_subject_idx    INDEX     Y   CREATE INDEX notifications_subject_idx ON notifications USING btree (auxiliary_subject);
 -   DROP INDEX public.notifications_subject_idx;
       public      	   emilsedgh    false    249            �           1259    127076    offices_mui_idx    INDEX     O   CREATE UNIQUE INDEX offices_mui_idx ON offices USING btree (matrix_unique_id);
 #   DROP INDEX public.offices_mui_idx;
       public      	   emilsedgh    false    252            �           1259    127077    open_houses_listing_mui_idx    INDEX     S   CREATE INDEX open_houses_listing_mui_idx ON open_houses USING btree (listing_mui);
 /   DROP INDEX public.open_houses_listing_mui_idx;
       public      	   emilsedgh    false    253            �           1259    127078     phone_verifications_phone_number    INDEX     h   CREATE UNIQUE INDEX phone_verifications_phone_number ON phone_verifications USING btree (phone_number);
 4   DROP INDEX public.phone_verifications_phone_number;
       public      	   emilsedgh    false    255            �           1259    127079    photos_last_processed    INDEX     I   CREATE INDEX photos_last_processed ON photos USING btree (processed_at);
 )   DROP INDEX public.photos_last_processed;
       public      	   emilsedgh    false    256            �           1259    127080    photos_listing_mui_idx    INDEX     I   CREATE INDEX photos_listing_mui_idx ON photos USING btree (listing_mui);
 *   DROP INDEX public.photos_listing_mui_idx;
       public      	   emilsedgh    false    256            �           1259    157782    photos_to_be_processed_at    INDEX     S   CREATE INDEX photos_to_be_processed_at ON photos USING btree (to_be_processed_at);
 -   DROP INDEX public.photos_to_be_processed_at;
       public      	   emilsedgh    false    256            �           1259    127081    properties_address_id_idx    INDEX     O   CREATE INDEX properties_address_id_idx ON properties USING btree (address_id);
 -   DROP INDEX public.properties_address_id_idx;
       public      	   emilsedgh    false    241            �           1259    127082    properties_bedroom_count_idx    INDEX     U   CREATE INDEX properties_bedroom_count_idx ON properties USING btree (bedroom_count);
 0   DROP INDEX public.properties_bedroom_count_idx;
       public      	   emilsedgh    false    241            �           1259    127083 "   properties_full_bathroom_count_idx    INDEX     a   CREATE INDEX properties_full_bathroom_count_idx ON properties USING btree (full_bathroom_count);
 6   DROP INDEX public.properties_full_bathroom_count_idx;
       public      	   emilsedgh    false    241            �           1259    127084 "   properties_half_bathroom_count_idx    INDEX     a   CREATE INDEX properties_half_bathroom_count_idx ON properties USING btree (half_bathroom_count);
 6   DROP INDEX public.properties_half_bathroom_count_idx;
       public      	   emilsedgh    false    241            �           1259    127085     properties_lot_square_meters_idx    INDEX     ]   CREATE INDEX properties_lot_square_meters_idx ON properties USING btree (lot_square_meters);
 4   DROP INDEX public.properties_lot_square_meters_idx;
       public      	   emilsedgh    false    241            �           1259    127086    properties_matrix_unique_id_idx    INDEX     b   CREATE UNIQUE INDEX properties_matrix_unique_id_idx ON properties USING btree (matrix_unique_id);
 3   DROP INDEX public.properties_matrix_unique_id_idx;
       public      	   emilsedgh    false    241            �           1259    127099    properties_pool_yn_idx    INDEX     I   CREATE INDEX properties_pool_yn_idx ON properties USING btree (pool_yn);
 *   DROP INDEX public.properties_pool_yn_idx;
       public      	   emilsedgh    false    241            �           1259    127100    properties_property_subtype_idx    INDEX     [   CREATE INDEX properties_property_subtype_idx ON properties USING btree (property_subtype);
 3   DROP INDEX public.properties_property_subtype_idx;
       public      	   emilsedgh    false    241            �           1259    127101    properties_property_type_idx    INDEX     U   CREATE INDEX properties_property_type_idx ON properties USING btree (property_type);
 0   DROP INDEX public.properties_property_type_idx;
       public      	   emilsedgh    false    241            �           1259    127102    properties_square_meters_idx    INDEX     U   CREATE INDEX properties_square_meters_idx ON properties USING btree (square_meters);
 0   DROP INDEX public.properties_square_meters_idx;
       public      	   emilsedgh    false    241            �           1259    127103    properties_year_built_idx    INDEX     O   CREATE INDEX properties_year_built_idx ON properties USING btree (year_built);
 -   DROP INDEX public.properties_year_built_idx;
       public      	   emilsedgh    false    241            �           1259    127104    property_rooms_mui_idx    INDEX     ]   CREATE UNIQUE INDEX property_rooms_mui_idx ON property_rooms USING btree (matrix_unique_id);
 *   DROP INDEX public.property_rooms_mui_idx;
       public      	   emilsedgh    false    257            �           1259    127105    recommendations_object_idx    INDEX     R   CREATE INDEX recommendations_object_idx ON recommendations USING btree (listing);
 .   DROP INDEX public.recommendations_object_idx;
       public      	   emilsedgh    false    259            �           1259    127106    recommendations_room_idx    INDEX     M   CREATE INDEX recommendations_room_idx ON recommendations USING btree (room);
 ,   DROP INDEX public.recommendations_room_idx;
       public      	   emilsedgh    false    259            �           1259    127107    rooms_owner_idx    INDEX     ;   CREATE INDEX rooms_owner_idx ON rooms USING btree (owner);
 #   DROP INDEX public.rooms_owner_idx;
       public      	   emilsedgh    false    261            �           1259    127108    rooms_users_room_idx    INDEX     E   CREATE INDEX rooms_users_room_idx ON rooms_users USING btree (room);
 (   DROP INDEX public.rooms_users_room_idx;
       public      	   emilsedgh    false    263            �           1259    127109    rooms_users_user_idx    INDEX     G   CREATE INDEX rooms_users_user_idx ON rooms_users USING btree ("user");
 (   DROP INDEX public.rooms_users_user_idx;
       public      	   emilsedgh    false    263            �           1259    127110    school_district_gin    INDEX     O   CREATE INDEX school_district_gin ON schools USING gin (district gin_trgm_ops);
 '   DROP INDEX public.school_district_gin;
       public      	   emilsedgh    false    2    2    6    6    264            �           1259    127111    school_name_gin    INDEX     G   CREATE INDEX school_name_gin ON schools USING gin (name gin_trgm_ops);
 #   DROP INDEX public.school_name_gin;
       public      	   emilsedgh    false    2    2    6    6    264            �           1259    127112    subdivision_title_gin    INDEX     S   CREATE INDEX subdivision_title_gin ON subdivisions USING gin (title gin_trgm_ops);
 )   DROP INDEX public.subdivision_title_gin;
       public      	   emilsedgh    false    2    2    6    6    269            �           1259    127115    units_mui_idx    INDEX     T   CREATE UNIQUE INDEX units_mui_idx ON property_units USING btree (matrix_unique_id);
 !   DROP INDEX public.units_mui_idx;
       public      	   emilsedgh    false    258            �           1259    127116    users_address_id_idx    INDEX     E   CREATE INDEX users_address_id_idx ON users USING btree (address_id);
 (   DROP INDEX public.users_address_id_idx;
       public      	   emilsedgh    false    270            �           1259    127117 	   words_idx    INDEX     ?   CREATE INDEX words_idx ON words USING gin (word gin_trgm_ops);
    DROP INDEX public.words_idx;
       public      	   emilsedgh    false    275    2    2    6    6            `           2620    127193    users falsify_email_confirmed    TRIGGER     �   CREATE TRIGGER falsify_email_confirmed AFTER UPDATE ON users FOR EACH ROW WHEN ((old.email IS DISTINCT FROM new.email)) EXECUTE PROCEDURE falsify_email_confirmed();
 6   DROP TRIGGER falsify_email_confirmed ON public.users;
       public    	   emilsedgh    false    1488    270    270            a           2620    127194    users falsify_phone_confirmed    TRIGGER     �   CREATE TRIGGER falsify_phone_confirmed AFTER UPDATE ON users FOR EACH ROW WHEN ((old.phone_number IS DISTINCT FROM new.phone_number)) EXECUTE PROCEDURE falsify_phone_confirmed();
 6   DROP TRIGGER falsify_phone_confirmed ON public.users;
       public    	   emilsedgh    false    1489    270    270            b           2620    127195    users toggle_phone_confirmed    TRIGGER     �   CREATE TRIGGER toggle_phone_confirmed AFTER UPDATE ON users FOR EACH ROW WHEN ((old.phone_number IS DISTINCT FROM new.phone_number)) EXECUTE PROCEDURE toggle_phone_confirmed();
 5   DROP TRIGGER toggle_phone_confirmed ON public.users;
       public    	   emilsedgh    false    1491    270    270            
           2606    127196    alerts alerts_room_fkey    FK CONSTRAINT     e   ALTER TABLE ONLY alerts
    ADD CONSTRAINT alerts_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);
 A   ALTER TABLE ONLY public.alerts DROP CONSTRAINT alerts_room_fkey;
       public    	   emilsedgh    false    261    212    4305                       2606    127201 /   attachments_eav attachments_eav_attachment_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY attachments_eav
    ADD CONSTRAINT attachments_eav_attachment_fkey FOREIGN KEY (attachment) REFERENCES attachments(id);
 Y   ALTER TABLE ONLY public.attachments_eav DROP CONSTRAINT attachments_eav_attachment_fkey;
       public    	   emilsedgh    false    213    214    4186                       2606    127206 !   attachments attachments_user_fkey    FK CONSTRAINT     q   ALTER TABLE ONLY attachments
    ADD CONSTRAINT attachments_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 K   ALTER TABLE ONLY public.attachments DROP CONSTRAINT attachments_user_fkey;
       public    	   emilsedgh    false    270    213    4327                       2606    127211 &   brands_agents brands_agents_agent_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY brands_agents
    ADD CONSTRAINT brands_agents_agent_fkey FOREIGN KEY (agent) REFERENCES agents(id);
 P   ALTER TABLE ONLY public.brands_agents DROP CONSTRAINT brands_agents_agent_fkey;
       public    	   emilsedgh    false    4150    207    216                       2606    127216 &   brands_agents brands_agents_brand_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY brands_agents
    ADD CONSTRAINT brands_agents_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);
 P   ALTER TABLE ONLY public.brands_agents DROP CONSTRAINT brands_agents_brand_fkey;
       public    	   emilsedgh    false    216    215    4190                       2606    127221 ,   brands_hostnames brands_hostnames_brand_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY brands_hostnames
    ADD CONSTRAINT brands_hostnames_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);
 V   ALTER TABLE ONLY public.brands_hostnames DROP CONSTRAINT brands_hostnames_brand_fkey;
       public    	   emilsedgh    false    4190    215    217                       2606    127226 (   brands_offices brands_offices_brand_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY brands_offices
    ADD CONSTRAINT brands_offices_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);
 R   ALTER TABLE ONLY public.brands_offices DROP CONSTRAINT brands_offices_brand_fkey;
       public    	   emilsedgh    false    218    4190    215                       2606    127231 )   brands_offices brands_offices_office_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY brands_offices
    ADD CONSTRAINT brands_offices_office_fkey FOREIGN KEY (office) REFERENCES offices(id);
 S   ALTER TABLE ONLY public.brands_offices DROP CONSTRAINT brands_offices_office_fkey;
       public    	   emilsedgh    false    218    4279    252                       2606    127236 (   brands_parents brands_parents_brand_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY brands_parents
    ADD CONSTRAINT brands_parents_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);
 R   ALTER TABLE ONLY public.brands_parents DROP CONSTRAINT brands_parents_brand_fkey;
       public    	   emilsedgh    false    219    4190    215                       2606    127241 )   brands_parents brands_parents_parent_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY brands_parents
    ADD CONSTRAINT brands_parents_parent_fkey FOREIGN KEY (parent) REFERENCES brands(id);
 S   ALTER TABLE ONLY public.brands_parents DROP CONSTRAINT brands_parents_parent_fkey;
       public    	   emilsedgh    false    219    4190    215                       2606    127246 $   brands_users brands_users_brand_fkey    FK CONSTRAINT     t   ALTER TABLE ONLY brands_users
    ADD CONSTRAINT brands_users_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);
 N   ALTER TABLE ONLY public.brands_users DROP CONSTRAINT brands_users_brand_fkey;
       public    	   emilsedgh    false    220    4190    215                       2606    127251 #   brands_users brands_users_user_fkey    FK CONSTRAINT     s   ALTER TABLE ONLY brands_users
    ADD CONSTRAINT brands_users_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 M   ALTER TABLE ONLY public.brands_users DROP CONSTRAINT brands_users_user_fkey;
       public    	   emilsedgh    false    4327    270    220                       2606    127256    cmas cmas_main_listing_fkey    FK CONSTRAINT     t   ALTER TABLE ONLY cmas
    ADD CONSTRAINT cmas_main_listing_fkey FOREIGN KEY (main_listing) REFERENCES listings(id);
 E   ALTER TABLE ONLY public.cmas DROP CONSTRAINT cmas_main_listing_fkey;
       public    	   emilsedgh    false    208    4159    222                       2606    127261    cmas cmas_room_fkey    FK CONSTRAINT     a   ALTER TABLE ONLY cmas
    ADD CONSTRAINT cmas_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);
 =   ALTER TABLE ONLY public.cmas DROP CONSTRAINT cmas_room_fkey;
       public    	   emilsedgh    false    261    4305    222                       2606    127266    cmas cmas_user_fkey    FK CONSTRAINT     c   ALTER TABLE ONLY cmas
    ADD CONSTRAINT cmas_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 =   ALTER TABLE ONLY public.cmas DROP CONSTRAINT cmas_user_fkey;
       public    	   emilsedgh    false    270    4327    222                       2606    127271 4   contacts_attributes contacts_attributes_contact_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY contacts_attributes
    ADD CONSTRAINT contacts_attributes_contact_fkey FOREIGN KEY (contact) REFERENCES contacts(id);
 ^   ALTER TABLE ONLY public.contacts_attributes DROP CONSTRAINT contacts_attributes_contact_fkey;
       public    	   emilsedgh    false    223    4200    224                       2606    127276 ,   contacts_emails contacts_emails_contact_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY contacts_emails
    ADD CONSTRAINT contacts_emails_contact_fkey FOREIGN KEY (contact) REFERENCES contacts(id);
 V   ALTER TABLE ONLY public.contacts_emails DROP CONSTRAINT contacts_emails_contact_fkey;
       public    	   emilsedgh    false    223    4200    225                       2606    127281 :   contacts_phone_numbers contacts_phone_numbers_contact_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY contacts_phone_numbers
    ADD CONSTRAINT contacts_phone_numbers_contact_fkey FOREIGN KEY (contact) REFERENCES contacts(id);
 d   ALTER TABLE ONLY public.contacts_phone_numbers DROP CONSTRAINT contacts_phone_numbers_contact_fkey;
       public    	   emilsedgh    false    223    4200    226                       2606    127286    contacts contacts_user_fkey    FK CONSTRAINT     k   ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 E   ALTER TABLE ONLY public.contacts DROP CONSTRAINT contacts_user_fkey;
       public    	   emilsedgh    false    4327    223    270                       2606    145092    deals deals_brand_fkey    FK CONSTRAINT     f   ALTER TABLE ONLY deals
    ADD CONSTRAINT deals_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);
 @   ALTER TABLE ONLY public.deals DROP CONSTRAINT deals_brand_fkey;
       public    	   emilsedgh    false    4190    228    215                       2606    127291    deals deals_created_by_fkey    FK CONSTRAINT     o   ALTER TABLE ONLY deals
    ADD CONSTRAINT deals_created_by_fkey FOREIGN KEY (created_by) REFERENCES users(id);
 E   ALTER TABLE ONLY public.deals DROP CONSTRAINT deals_created_by_fkey;
       public    	   emilsedgh    false    270    4327    228                       2606    127296    deals deals_listing_fkey    FK CONSTRAINT     l   ALTER TABLE ONLY deals
    ADD CONSTRAINT deals_listing_fkey FOREIGN KEY (listing) REFERENCES listings(id);
 B   ALTER TABLE ONLY public.deals DROP CONSTRAINT deals_listing_fkey;
       public    	   emilsedgh    false    4159    228    208                        2606    127301 '   deals_roles deals_roles_created_by_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY deals_roles
    ADD CONSTRAINT deals_roles_created_by_fkey FOREIGN KEY (created_by) REFERENCES users(id);
 Q   ALTER TABLE ONLY public.deals_roles DROP CONSTRAINT deals_roles_created_by_fkey;
       public    	   emilsedgh    false    270    229    4327            !           2606    127306 !   deals_roles deals_roles_deal_fkey    FK CONSTRAINT     o   ALTER TABLE ONLY deals_roles
    ADD CONSTRAINT deals_roles_deal_fkey FOREIGN KEY (deal) REFERENCES deals(id);
 K   ALTER TABLE ONLY public.deals_roles DROP CONSTRAINT deals_roles_deal_fkey;
       public    	   emilsedgh    false    4205    229    228            "           2606    127311 !   deals_roles deals_roles_user_fkey    FK CONSTRAINT     q   ALTER TABLE ONLY deals_roles
    ADD CONSTRAINT deals_roles_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 K   ALTER TABLE ONLY public.deals_roles DROP CONSTRAINT deals_roles_user_fkey;
       public    	   emilsedgh    false    229    270    4327            X           2606    128417 '   docusign_users docusign_users_user_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY docusign_users
    ADD CONSTRAINT docusign_users_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 Q   ALTER TABLE ONLY public.docusign_users DROP CONSTRAINT docusign_users_user_fkey;
       public    	   emilsedgh    false    4327    270    277            #           2606    127316 #   envelopes envelopes_created_by_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY envelopes
    ADD CONSTRAINT envelopes_created_by_fkey FOREIGN KEY (created_by) REFERENCES users(id);
 M   ALTER TABLE ONLY public.envelopes DROP CONSTRAINT envelopes_created_by_fkey;
       public    	   emilsedgh    false    270    4327    231            $           2606    127321    envelopes envelopes_deal_fkey    FK CONSTRAINT     k   ALTER TABLE ONLY envelopes
    ADD CONSTRAINT envelopes_deal_fkey FOREIGN KEY (deal) REFERENCES deals(id);
 G   ALTER TABLE ONLY public.envelopes DROP CONSTRAINT envelopes_deal_fkey;
       public    	   emilsedgh    false    228    4205    231            %           2606    127326 5   envelopes_documents envelopes_documents_envelope_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY envelopes_documents
    ADD CONSTRAINT envelopes_documents_envelope_fkey FOREIGN KEY (envelope) REFERENCES envelopes(id);
 _   ALTER TABLE ONLY public.envelopes_documents DROP CONSTRAINT envelopes_documents_envelope_fkey;
       public    	   emilsedgh    false    231    4211    232            &           2606    127331 @   envelopes_documents envelopes_documents_submission_revision_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY envelopes_documents
    ADD CONSTRAINT envelopes_documents_submission_revision_fkey FOREIGN KEY (submission_revision) REFERENCES forms_data(id);
 j   ALTER TABLE ONLY public.envelopes_documents DROP CONSTRAINT envelopes_documents_submission_revision_fkey;
       public    	   emilsedgh    false    236    4221    232            '           2606    127336 7   envelopes_recipients envelopes_recipients_envelope_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY envelopes_recipients
    ADD CONSTRAINT envelopes_recipients_envelope_fkey FOREIGN KEY (envelope) REFERENCES envelopes(id);
 a   ALTER TABLE ONLY public.envelopes_recipients DROP CONSTRAINT envelopes_recipients_envelope_fkey;
       public    	   emilsedgh    false    231    4211    233            (           2606    127341 3   envelopes_recipients envelopes_recipients_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY envelopes_recipients
    ADD CONSTRAINT envelopes_recipients_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 ]   ALTER TABLE ONLY public.envelopes_recipients DROP CONSTRAINT envelopes_recipients_user_fkey;
       public    	   emilsedgh    false    270    233    4327            Y           2606    136742    files files_created_by_fkey    FK CONSTRAINT     o   ALTER TABLE ONLY files
    ADD CONSTRAINT files_created_by_fkey FOREIGN KEY (created_by) REFERENCES users(id);
 E   ALTER TABLE ONLY public.files DROP CONSTRAINT files_created_by_fkey;
       public    	   emilsedgh    false    4327    278    270            Z           2606    136758 )   files_relations files_relations_file_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY files_relations
    ADD CONSTRAINT files_relations_file_fkey FOREIGN KEY (file) REFERENCES files(id);
 S   ALTER TABLE ONLY public.files_relations DROP CONSTRAINT files_relations_file_fkey;
       public    	   emilsedgh    false    279    4340    278            )           2606    127346 !   forms_data forms_data_author_fkey    FK CONSTRAINT     q   ALTER TABLE ONLY forms_data
    ADD CONSTRAINT forms_data_author_fkey FOREIGN KEY (author) REFERENCES users(id);
 K   ALTER TABLE ONLY public.forms_data DROP CONSTRAINT forms_data_author_fkey;
       public    	   emilsedgh    false    270    236    4327            *           2606    127351    forms_data forms_data_form_fkey    FK CONSTRAINT     m   ALTER TABLE ONLY forms_data
    ADD CONSTRAINT forms_data_form_fkey FOREIGN KEY (form) REFERENCES forms(id);
 I   ALTER TABLE ONLY public.forms_data DROP CONSTRAINT forms_data_form_fkey;
       public    	   emilsedgh    false    235    4219    236            +           2606    127356 %   forms_data forms_data_submission_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY forms_data
    ADD CONSTRAINT forms_data_submission_fkey FOREIGN KEY (submission) REFERENCES forms_submissions(id);
 O   ALTER TABLE ONLY public.forms_data DROP CONSTRAINT forms_data_submission_fkey;
       public    	   emilsedgh    false    237    4223    236            ,           2606    127361 -   forms_submissions forms_submissions_deal_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY forms_submissions
    ADD CONSTRAINT forms_submissions_deal_fkey FOREIGN KEY (deal) REFERENCES deals(id);
 W   ALTER TABLE ONLY public.forms_submissions DROP CONSTRAINT forms_submissions_deal_fkey;
       public    	   emilsedgh    false    228    4205    237            -           2606    127366 -   forms_submissions forms_submissions_form_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY forms_submissions
    ADD CONSTRAINT forms_submissions_form_fkey FOREIGN KEY (form) REFERENCES forms(id);
 W   ALTER TABLE ONLY public.forms_submissions DROP CONSTRAINT forms_submissions_form_fkey;
       public    	   emilsedgh    false    235    4219    237            .           2606    127371 *   godaddy_domains godaddy_domains_owner_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY godaddy_domains
    ADD CONSTRAINT godaddy_domains_owner_fkey FOREIGN KEY (owner) REFERENCES users(id);
 T   ALTER TABLE ONLY public.godaddy_domains DROP CONSTRAINT godaddy_domains_owner_fkey;
       public    	   emilsedgh    false    270    4327    238            /           2606    127376 +   godaddy_shoppers godaddy_shoppers_user_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY godaddy_shoppers
    ADD CONSTRAINT godaddy_shoppers_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 U   ALTER TABLE ONLY public.godaddy_shoppers DROP CONSTRAINT godaddy_shoppers_user_fkey;
       public    	   emilsedgh    false    270    4327    239            	           2606    127386 "   listings listings_property_id_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_property_id_fkey FOREIGN KEY (property_id) REFERENCES properties(id);
 L   ALTER TABLE ONLY public.listings DROP CONSTRAINT listings_property_id_fkey;
       public    	   emilsedgh    false    208    241    4239            J           2606    127391 )   rooms_users message_rooms_users_user_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY rooms_users
    ADD CONSTRAINT message_rooms_users_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 S   ALTER TABLE ONLY public.rooms_users DROP CONSTRAINT message_rooms_users_user_fkey;
       public    	   emilsedgh    false    4327    263    270            :           2606    127396 (   messages_acks messages_acks_message_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY messages_acks
    ADD CONSTRAINT messages_acks_message_fkey FOREIGN KEY (message) REFERENCES messages(id);
 R   ALTER TABLE ONLY public.messages_acks DROP CONSTRAINT messages_acks_message_fkey;
       public    	   emilsedgh    false    243    242    4248            ;           2606    127401 %   messages_acks messages_acks_room_fkey    FK CONSTRAINT     s   ALTER TABLE ONLY messages_acks
    ADD CONSTRAINT messages_acks_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);
 O   ALTER TABLE ONLY public.messages_acks DROP CONSTRAINT messages_acks_room_fkey;
       public    	   emilsedgh    false    4305    243    261            <           2606    127406 %   messages_acks messages_acks_user_fkey    FK CONSTRAINT     u   ALTER TABLE ONLY messages_acks
    ADD CONSTRAINT messages_acks_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 O   ALTER TABLE ONLY public.messages_acks DROP CONSTRAINT messages_acks_user_fkey;
       public    	   emilsedgh    false    270    243    4327            5           2606    127411    messages messages_author_fkey    FK CONSTRAINT     m   ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_author_fkey FOREIGN KEY (author) REFERENCES users(id);
 G   ALTER TABLE ONLY public.messages DROP CONSTRAINT messages_author_fkey;
       public    	   emilsedgh    false    270    242    4327            6           2606    127416 #   messages messages_notification_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_notification_fkey FOREIGN KEY (notification) REFERENCES notifications(id);
 M   ALTER TABLE ONLY public.messages DROP CONSTRAINT messages_notification_fkey;
       public    	   emilsedgh    false    249    242    4269            7           2606    127421 %   messages messages_recommendation_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_recommendation_fkey FOREIGN KEY (recommendation) REFERENCES recommendations(id);
 O   ALTER TABLE ONLY public.messages DROP CONSTRAINT messages_recommendation_fkey;
       public    	   emilsedgh    false    4297    259    242            8           2606    127426     messages messages_reference_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_reference_fkey FOREIGN KEY (reference) REFERENCES messages(id);
 J   ALTER TABLE ONLY public.messages DROP CONSTRAINT messages_reference_fkey;
       public    	   emilsedgh    false    242    242    4248            9           2606    127431    messages messages_room_fkey    FK CONSTRAINT     i   ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);
 E   ALTER TABLE ONLY public.messages DROP CONSTRAINT messages_room_fkey;
       public    	   emilsedgh    false    4305    242    261            =           2606    127441 2   notifications_tokens notification_tokens_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY notifications_tokens
    ADD CONSTRAINT notification_tokens_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 \   ALTER TABLE ONLY public.notifications_tokens DROP CONSTRAINT notification_tokens_user_fkey;
       public    	   emilsedgh    false    270    248    4327            @           2606    127456 C   notifications_deliveries notifications_deliveries_notification_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY notifications_deliveries
    ADD CONSTRAINT notifications_deliveries_notification_fkey FOREIGN KEY (notification) REFERENCES notifications(id);
 m   ALTER TABLE ONLY public.notifications_deliveries DROP CONSTRAINT notifications_deliveries_notification_fkey;
       public    	   emilsedgh    false    249    4269    250            A           2606    127461 ;   notifications_deliveries notifications_deliveries_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY notifications_deliveries
    ADD CONSTRAINT notifications_deliveries_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 e   ALTER TABLE ONLY public.notifications_deliveries DROP CONSTRAINT notifications_deliveries_user_fkey;
       public    	   emilsedgh    false    250    4327    270            >           2606    127466 /   notifications notifications_recommendation_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_recommendation_fkey FOREIGN KEY (recommendation) REFERENCES recommendations(id);
 Y   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_recommendation_fkey;
       public    	   emilsedgh    false    4297    249    259            ?           2606    127471 %   notifications notifications_room_fkey    FK CONSTRAINT     s   ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);
 O   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_room_fkey;
       public    	   emilsedgh    false    4305    249    261            B           2606    127476 9   notifications_users notifications_users_notification_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY notifications_users
    ADD CONSTRAINT notifications_users_notification_fkey FOREIGN KEY (notification) REFERENCES notifications(id);
 c   ALTER TABLE ONLY public.notifications_users DROP CONSTRAINT notifications_users_notification_fkey;
       public    	   emilsedgh    false    251    249    4269            C           2606    127481 1   notifications_users notifications_users_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY notifications_users
    ADD CONSTRAINT notifications_users_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 [   ALTER TABLE ONLY public.notifications_users DROP CONSTRAINT notifications_users_user_fkey;
       public    	   emilsedgh    false    4327    251    270            D           2606    127486 =   password_recovery_records password_recovery_records_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY password_recovery_records
    ADD CONSTRAINT password_recovery_records_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 g   ALTER TABLE ONLY public.password_recovery_records DROP CONSTRAINT password_recovery_records_user_fkey;
       public    	   emilsedgh    false    270    254    4327            3           2606    127491 %   properties properties_address_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY properties
    ADD CONSTRAINT properties_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(id);
 O   ALTER TABLE ONLY public.properties DROP CONSTRAINT properties_address_id_fkey;
       public    	   emilsedgh    false    206    241    4144            4           2606    127496 &   properties properties_address_id_fkey1    FK CONSTRAINT     ~   ALTER TABLE ONLY properties
    ADD CONSTRAINT properties_address_id_fkey1 FOREIGN KEY (address_id) REFERENCES addresses(id);
 P   ALTER TABLE ONLY public.properties DROP CONSTRAINT properties_address_id_fkey1;
       public    	   emilsedgh    false    206    241    4144            G           2606    127501 ;   recommendations_eav recommendations_eav_recommendation_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY recommendations_eav
    ADD CONSTRAINT recommendations_eav_recommendation_fkey FOREIGN KEY (recommendation) REFERENCES recommendations(id);
 e   ALTER TABLE ONLY public.recommendations_eav DROP CONSTRAINT recommendations_eav_recommendation_fkey;
       public    	   emilsedgh    false    259    260    4297            H           2606    127506 1   recommendations_eav recommendations_eav_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY recommendations_eav
    ADD CONSTRAINT recommendations_eav_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 [   ALTER TABLE ONLY public.recommendations_eav DROP CONSTRAINT recommendations_eav_user_fkey;
       public    	   emilsedgh    false    4327    270    260            E           2606    127511 +   recommendations recommendations_object_fkey    FK CONSTRAINT        ALTER TABLE ONLY recommendations
    ADD CONSTRAINT recommendations_object_fkey FOREIGN KEY (listing) REFERENCES listings(id);
 U   ALTER TABLE ONLY public.recommendations DROP CONSTRAINT recommendations_object_fkey;
       public    	   emilsedgh    false    259    208    4159            F           2606    127516 )   recommendations recommendations_room_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY recommendations
    ADD CONSTRAINT recommendations_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);
 S   ALTER TABLE ONLY public.recommendations DROP CONSTRAINT recommendations_room_fkey;
       public    	   emilsedgh    false    4305    259    261            [           2606    153396    reviews reviews_deal_fkey    FK CONSTRAINT     g   ALTER TABLE ONLY reviews
    ADD CONSTRAINT reviews_deal_fkey FOREIGN KEY (deal) REFERENCES deals(id);
 C   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_deal_fkey;
       public    	   emilsedgh    false    281    228    4205            ]           2606    153456 &   reviews reviews_envelope_document_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY reviews
    ADD CONSTRAINT reviews_envelope_document_fkey FOREIGN KEY (envelope_document) REFERENCES envelopes_documents(id);
 P   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_envelope_document_fkey;
       public    	   emilsedgh    false    232    281    4213            \           2606    153401    reviews reviews_file_fkey    FK CONSTRAINT     g   ALTER TABLE ONLY reviews
    ADD CONSTRAINT reviews_file_fkey FOREIGN KEY (file) REFERENCES files(id);
 C   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_file_fkey;
       public    	   emilsedgh    false    4340    281    278            ^           2606    153421 /   reviews_history reviews_history_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY reviews_history
    ADD CONSTRAINT reviews_history_created_by_fkey FOREIGN KEY (created_by) REFERENCES users(id);
 Y   ALTER TABLE ONLY public.reviews_history DROP CONSTRAINT reviews_history_created_by_fkey;
       public    	   emilsedgh    false    4327    270    282            _           2606    153426 +   reviews_history reviews_history_review_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY reviews_history
    ADD CONSTRAINT reviews_history_review_fkey FOREIGN KEY (review) REFERENCES reviews(id);
 U   ALTER TABLE ONLY public.reviews_history DROP CONSTRAINT reviews_history_review_fkey;
       public    	   emilsedgh    false    4344    282    281            0           2606    127521 =   invitation_records rooms_invitation_records_invited_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY invitation_records
    ADD CONSTRAINT rooms_invitation_records_invited_user_fkey FOREIGN KEY (invited_user) REFERENCES users(id);
 g   ALTER TABLE ONLY public.invitation_records DROP CONSTRAINT rooms_invitation_records_invited_user_fkey;
       public    	   emilsedgh    false    270    4327    240            1           2606    127526 >   invitation_records rooms_invitation_records_inviting_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY invitation_records
    ADD CONSTRAINT rooms_invitation_records_inviting_user_fkey FOREIGN KEY (inviting_user) REFERENCES users(id);
 h   ALTER TABLE ONLY public.invitation_records DROP CONSTRAINT rooms_invitation_records_inviting_user_fkey;
       public    	   emilsedgh    false    4327    240    270            2           2606    127531 5   invitation_records rooms_invitation_records_room_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY invitation_records
    ADD CONSTRAINT rooms_invitation_records_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);
 _   ALTER TABLE ONLY public.invitation_records DROP CONSTRAINT rooms_invitation_records_room_fkey;
       public    	   emilsedgh    false    261    4305    240            K           2606    127536 *   rooms_users rooms_users_phone_handler_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY rooms_users
    ADD CONSTRAINT rooms_users_phone_handler_fkey FOREIGN KEY (phone_handler) REFERENCES seamless_phone_pool(id);
 T   ALTER TABLE ONLY public.rooms_users DROP CONSTRAINT rooms_users_phone_handler_fkey;
       public    	   emilsedgh    false    265    4315    263            L           2606    127541 !   rooms_users rooms_users_room_fkey    FK CONSTRAINT     o   ALTER TABLE ONLY rooms_users
    ADD CONSTRAINT rooms_users_room_fkey FOREIGN KEY (room) REFERENCES rooms(id);
 K   ALTER TABLE ONLY public.rooms_users DROP CONSTRAINT rooms_users_room_fkey;
       public    	   emilsedgh    false    261    263    4305            I           2606    127546    rooms shortlists_owner_fkey    FK CONSTRAINT     j   ALTER TABLE ONLY rooms
    ADD CONSTRAINT shortlists_owner_fkey FOREIGN KEY (owner) REFERENCES users(id);
 E   ALTER TABLE ONLY public.rooms DROP CONSTRAINT shortlists_owner_fkey;
       public    	   emilsedgh    false    270    261    4327            M           2606    127551 +   stripe_charges stripe_charges_customer_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY stripe_charges
    ADD CONSTRAINT stripe_charges_customer_fkey FOREIGN KEY (customer) REFERENCES stripe_customers(id);
 U   ALTER TABLE ONLY public.stripe_charges DROP CONSTRAINT stripe_charges_customer_fkey;
       public    	   emilsedgh    false    268    4319    267            N           2606    127556 '   stripe_charges stripe_charges_user_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY stripe_charges
    ADD CONSTRAINT stripe_charges_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 Q   ALTER TABLE ONLY public.stripe_charges DROP CONSTRAINT stripe_charges_user_fkey;
       public    	   emilsedgh    false    270    4327    267            O           2606    127561 ,   stripe_customers stripe_customers_owner_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY stripe_customers
    ADD CONSTRAINT stripe_customers_owner_fkey FOREIGN KEY (owner) REFERENCES users(id);
 V   ALTER TABLE ONLY public.stripe_customers DROP CONSTRAINT stripe_customers_owner_fkey;
       public    	   emilsedgh    false    268    4327    270            P           2606    127621    users users_address_id_fkey    FK CONSTRAINT     s   ALTER TABLE ONLY users
    ADD CONSTRAINT users_address_id_fkey FOREIGN KEY (address_id) REFERENCES addresses(id);
 E   ALTER TABLE ONLY public.users DROP CONSTRAINT users_address_id_fkey;
       public    	   emilsedgh    false    270    206    4144            Q           2606    127626    users users_agents_agent_fkey    FK CONSTRAINT     m   ALTER TABLE ONLY users
    ADD CONSTRAINT users_agents_agent_fkey FOREIGN KEY (agent) REFERENCES agents(id);
 G   ALTER TABLE ONLY public.users DROP CONSTRAINT users_agents_agent_fkey;
       public    	   emilsedgh    false    270    4150    207            R           2606    127631    users users_brand_fkey    FK CONSTRAINT     f   ALTER TABLE ONLY users
    ADD CONSTRAINT users_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT users_brand_fkey;
       public    	   emilsedgh    false    4190    215    270            S           2606    127636    users users_personal_room_fkey    FK CONSTRAINT     u   ALTER TABLE ONLY users
    ADD CONSTRAINT users_personal_room_fkey FOREIGN KEY (personal_room) REFERENCES rooms(id);
 H   ALTER TABLE ONLY public.users DROP CONSTRAINT users_personal_room_fkey;
       public    	   emilsedgh    false    261    270    4305            U           2606    127641 2   websites_hostnames websites_hostnames_website_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY websites_hostnames
    ADD CONSTRAINT websites_hostnames_website_fkey FOREIGN KEY (website) REFERENCES websites(id);
 \   ALTER TABLE ONLY public.websites_hostnames DROP CONSTRAINT websites_hostnames_website_fkey;
       public    	   emilsedgh    false    272    4329    273            V           2606    127646 0   websites_snapshots websites_snapshots_brand_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY websites_snapshots
    ADD CONSTRAINT websites_snapshots_brand_fkey FOREIGN KEY (brand) REFERENCES brands(id);
 Z   ALTER TABLE ONLY public.websites_snapshots DROP CONSTRAINT websites_snapshots_brand_fkey;
       public    	   emilsedgh    false    215    4190    274            W           2606    127651 2   websites_snapshots websites_snapshots_website_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY websites_snapshots
    ADD CONSTRAINT websites_snapshots_website_fkey FOREIGN KEY (website) REFERENCES websites(id);
 \   ALTER TABLE ONLY public.websites_snapshots DROP CONSTRAINT websites_snapshots_website_fkey;
       public    	   emilsedgh    false    4329    272    274            T           2606    127656    websites websites_user_fkey    FK CONSTRAINT     k   ALTER TABLE ONLY websites
    ADD CONSTRAINT websites_user_fkey FOREIGN KEY ("user") REFERENCES users(id);
 E   ALTER TABLE ONLY public.websites DROP CONSTRAINT websites_user_fkey;
       public    	   emilsedgh    false    4327    270    272            �           0    21559    agents_emails    MATERIALIZED VIEW DATA     )   REFRESH MATERIALIZED VIEW agents_emails;
            public    	   emilsedgh    false    209    4662            �           0    21574    agents_phones    MATERIALIZED VIEW DATA     )   REFRESH MATERIALIZED VIEW agents_phones;
            public    	   emilsedgh    false    211    4662            �           0    21700    counties    MATERIALIZED VIEW DATA     $   REFRESH MATERIALIZED VIEW counties;
            public    	   emilsedgh    false    227    4662            4           0    157809    listings_filters    MATERIALIZED VIEW DATA     ,   REFRESH MATERIALIZED VIEW listings_filters;
            public    	   emilsedgh    false    283    4662                       0    21860 	   mls_areas    MATERIALIZED VIEW DATA     %   REFRESH MATERIALIZED VIEW mls_areas;
            public    	   emilsedgh    false    245    4662            !           0    22023    schools    MATERIALIZED VIEW DATA     #   REFRESH MATERIALIZED VIEW schools;
            public    	   emilsedgh    false    264    4662            &           0    22065    subdivisions    MATERIALIZED VIEW DATA     (   REFRESH MATERIALIZED VIEW subdivisions;
            public    	   emilsedgh    false    269    4662            ,           0    22160    words    MATERIALIZED VIEW DATA     !   REFRESH MATERIALIZED VIEW words;
            public    	   emilsedgh    false    275    4662            1      x������ � �      �      x��}ko�ƒ�g�_���Ѡ�����k�c�79,���pb!��@����UMr���C���9��Q2�LUuw�SW&��
��w�/����lnn�/���_��#��I��7[��}s!e�/ڮ3;����)�n�$K�����ߦ���K���4B^ ��^
u	z��5��?!���S	�R]J��FJ�
I���ʄo�W�UY�B�]!�3�ε��8%��7T�L���_o�����M��Y^҉�4���{:���ӏ�H�O��{����ջw��w���gP���w�[�(%e������-�[�$��Aߚ�Un�74ۙ�A�&��ťo��P�R�R�~��h���E)��J�D歴e��,+�țv^��>&��-/������~�DB���D��	��~ؾW׿~z�����iɫ=}��6����SL�y�:����$Zo��	�܉m$֤�T�R�F�R��.��Jڍ�W.o#f�u�*j=p����B*�mt@?�mi������%Y����7�"��~m'W�<{'�Hѹ�w�v��f���@o���Z]*�!!���$�)�];i���N:pe���D��H��2�?�I+�Le��o���[�Md�v�o�E8�K�#={��o��>9e�T*�R�-S��({���U-�-���}����\��`4�����Z[���x|!�������e^�|�on��p�5[%lf̀�����K��_�|����VZ�h|'F�;��m�,z}!�a�p�%�Fh�<���B8�aH��k:�vY��0�K�t=�-�|];	�p�,J%O�!暗tb�y�PW��:�������-Z���I�Ȑ�pN��˗���:�kaG2G�v�n��h�׭�D�Nʻ��c�H_{:�Ԍ�6D��tS`|�_H�m6l�4����9Mh��|�^�Eik[IS[��Qd�y���o���sX�o���������7)�y��H�<��o�t���X=�u�m�i�E��n�V�u��<qѤasĠ\oP�U/���oH��fHɠ�7�h�y.���������o���'���)�o����]�WNE�G�N�Yo
��F:��m'�vJd�E`ڹ�3 s��L�� +��F�۩����ng`���!�Vk}G��y��%p�B�FB��k����Ѧ�L~�o���od��vT�z��=!�-��P���~�'c~��A@\���1ű;\?�p��m̹�\VZ�$f��/O����Brb��ng`����7�H��L�F�� ���M��E��n�;:�b�f;J��vQ/ƽ1`��m�f�'	��#�AJS�׃7f\G�J�(�s�!֨j���T��κ#��g^ґ��zc߈��*=�իo�vV���V�������E�a���}�^���&w��ϼ>Bp8
��G�Ǧ��t��!I�.b޲RjS��`� �]��5�q�~�-�`N�z_^҉��g��V�:�>O�E[�Fc.�JNA)r��l�SwH���t�;�C-��K-��g�"o����[�"i�@��`�VdOp��iu�vr�E~��b�p�� �GH]^*�qBK}�-d*�%�K)6D���â�]V�ғP1{��Z��Ce� E4�O���1/��|-�ywi���dD�K�N��KBGI?c�L�\tr7B:ߺ�����c�WJ�������6��}�I�벨�Z���² S��騄����//�����Fy��W���/����_���1�ӷ}/,���"�b�h4�頺
88�n�"��Hw�T�K�|��KcH�"W��.�<Wua�/8ڑ����ۑm^ҷ����Z�\�kR\͕	�31i���_S[���-�I�W�UVViy����,Q��j��+��躘��V�'@��C��I�@��(+I��9�6ϱ��Y+����&��2�6�����ŧ���K
K���ֈ:�=��M�sC�����Y6$�v�Ď.��>ӥZ�ϧ,�J�U�R�HP�(%�������q��[��*�ɋ������*��f�����.P\��5/�7���_�l&|���f������ǒ����B6��������9�g����ZY?��,���.�~p��4�C�,֥����u�����C �k^�o��Dv����6 �������/�_���u�:魯"���P�ȟP���{�@��R+�7(TD�ؚ��wU6��ʠ΅�����<��	,��^�8��C�J�<_@w��o>7��o>���{%X�˩��t����@��|�	�͵<o�%��Ȉ��Zb�kU��X[ծ�d&��Nh��0/���K��U�f2��G/��mk["�g�M֜�W^�I��:�XÓk-��F2�jY�yi��j;�W�ʚrcFO�ԉ�1s���x-a�3��*Q�y�+�e�UM�BG5i�Y�$Wz�WN9��O���@��b���	�`1�������!&%蠺�U����2J�T��(�o�
H��<�������������twۭ1��>��J4]�/�����J/�ܠg��ǲ�f#��XX��>�
�J�%g(\QT����x}����Fۼ��_ ��J�y-���7��>�ws�-�L���'�))�"��h-�%#K�n��d��O�r6��FE�VK7ph���b=�ε��#������g^���D|<��:12|U�@���X(��"=]����w�Ej�l��Jz�S�E����f[ס�KH+ؠtF�t��)d�]$��-*e�<sCj����Xy�z���#i���\/�j�̲�5�����w�m����%�;�&����8<n�B�Q��WE�EB lt\qFWa��+B�ʓ��E�l]��hB�Wd*C��[�3�J�t?^��//����ݙ2_�j���H>���͛������-qB��d>���Y4�
�Ê�C
��p��8��8!A��"J�hqX.d�lp@���L��f���hK�$V���%�����ե�Ϲ�U��^1������v����pEHC��G���\���ޟv����Tz#��c!�
t:hP�R��w��s�a������ �CCN�	���>-���DQWi�	�q�O�zG�$t�$��ٝ���;�n����io�<f�/ExՑǍaXSTd�����smJ:Nr8��xr��G�9�%�����K�$kq��WI��ڑ��a���������L'{d�4�*�����)Q ���	}�( ��Ց�5
��,W.�pm+RR�@5F�uP'N8��K����v��5Ou�A~J��ے~�$ɾ�❭�R��H9��_�(�3O��rc:�y�����.k:L��l8`��U�T�!�I���Su7(����N2��Ú�J�yUr�O��5m��c�xO�7?�>.F��`߷�k:����6��)NⓅ��C�Z#��%NRN҄-TA�T)U	c������ƒ:�a��5cnyI����Y�i(V	��5Ȍ'?1���;�sk}g=�֬���~����oHl@��W3\��H�Y�N��G��Ҿtb,D��,�C��W+�zf���!�'3nO�*e��8l}�����r\��sɍ���1"uc �!��|/��4�/B��|������+������y]��C��Ȃk��XKvÑ�?��尦㋕�gz_ktͼ/����S�x�!���ٞ�>��}�sg&�����$:ъ,��������$q�0�R��Ґ9D�tY@YTU�-��I����I�./����3O�*M3��J>~������Р����m�۩"gb��_o�ߛ�m��`�Yv|5�kI��G�7z�4.�M �F�5yoY%|E�b�#DUک�E)�6��Ｄ��7�o�W߬�v�\{�����믋� �S{�6�Z\�l2��h9��^O߷ڝ�hB�;�p����D�}���CP�!s�U�ti�����Wѷƹj��!��y�;�e�yI�Ӂ�8P�̓dS�� �I'ū�Ż���ɰQ�ղ綤n���};�{:�iF�����@�RF�<�@ɫL֢�cAY�F�V�c��D`${"�N����;Ɓ�w�^V�:>���pgڛ��ݒ��WId�    �!�@�L�`�|��9�%�:w.�ԡN��(t$r�r]6w`�����|x��f��쉚��3/�7�̤:S_����n0-���ds��wS1���|jR�O5���	=B��:=���5
����S�T鍸w��lRAr�����e�C�Rb�N4ƛ�hT��s.���&��j����o�/64�)r���dC��U�J{�Ɔd�R����//i`zɷ:�h���qB������[��vZp����Hcy<2!�V�3�\���
��3�%-;V�miɘ�𢴎.��#�pe.k��~t_��@O��:3��Ӳ�O�kd=���W�}*��N>��gN�x���!�fŇ��%�����u:�B�ZW)I���/WA�4�?���`/��ӳ0��9m�2��bj��������=G�4q,w�ٳ"S-Ć��5-�A�*�z�������oe�{M<�X���1��\��&d��V�}�P�ryd(�4p	+�G�ё��5����;Oh�g�Xr/#��G8W1f�k�-��M]i4�C���,}����wZ���i^�#Η�	gF&VI�2*�X~xS���*{���b����D�~gyg��7��]w���͆�Q�ѐPp�
BT�ǈ�<BH��CѠ��-�� ��yh�8�P\��=�|jnoI���g��Rv,}O4��o>��4�	K�tX|+̎�H�}�0��ܙf,�����9N�0�ǱEaXn"���t	��LAh9$+▐=j;�A8G89^A����Ǐ�F��x�I3q�J�d?V?�{�1�!@#ٶ�j����r�	q.�o�Dk�9�R{�=�u�.�)�Ǥ�_^�7�o����R�.���\��l�����,����M��^[��h![�g�Yh��x�O��O$˾�B_N�G��J�_Yh�J6������s����[��\?؉�gs���;��Vș3�c�$ekڇX8���9(���!LYdE�E��)u݉���1/�텛sn���Y��
��_�����ŋz�t�q�����ş��O���J-8��r�Ul�#Bע�����UW��]VB9�lIK�����E旗t`z����iD�4�샀�������E�LD�uk .���-��=��}�2��rg�G܃)C�C&y�h"	aI~i��Y5*c�Y�|��8�Dƥ�qG�y����8_�18��6^X��?^n�C���bY"�`�T�0�N�¹�+1D/��踔p��ayg��!p�^�q�K�]��*|]�J��pK��90�K���%=s&*Z%l��ae�������;Ӵ�ы�t�B�JE!�S��d�5�!W�&Ҋ�H���\�A�1v!�v��u�S���p�� 0�K<\wnW�M�\��!ɐ�ߗ˸l�@���"�߶0ƍZ����]�Q��u�C��{��h��f'����tV�u:��C%f^�Ҷ�Cې"���ǡ�L�o|�@!�*Y��V6����}*�������k8�Mz�OU?<���� <T�ہ�C5/�&��%\���X��yQTh*:Z%�>׈�0e�5�9aO2�W��yI�~2�G��@ǄLt<�#V'���{��텢w�~��S�=�^������߸ݝ@�C�(\��,��Y~�{s��4��JWJ�9���Y�u]i�Mh����5��z׼�G����U�f0�7״׋�#��D��:��G���Z1��R���<��uH�Ҏ�[ě�zD��(�
e��f�E�\�MP3����/P�J��^�iO���_#�J��n�=���K�ɀ��1��Y<�6����X��&�E��<�̓N��[�3�3"9��톳
OdyǼ��/�m�Jգ�cH^�'F���Ga��-�[������n�c��<�����ЎM���k�X�%qS@Mgj�� ��RS��D�U��#���w���@rg��y��Rɇ�U��}�Jk��]�BW�X��Z�����B� K3.�Ӽ$�2-����)a5\�Ji���SL���<�"��5��K��3�ѫD�2�Zʤ�I�����RE�`b�t��9=p�ݹ�hJC�-�
��3!(��>�F�c�p����RC!&֮��W�OG�s�b���y�%������5�L+��~�˻we,(���~�?=��j�l��&��3歚�u�C>8�B�E�h�+@����
<������>nC����o����գ��s�ҫ4ͼ FO^����dW?Ƽ/饑�r�ENU�r>��IM�\���-'��3�&��.B��C�d_��LMN1(��(kK�ǔ#a��u�e^���w��W|���J�̌>af>
��#�:��:.��sD���|�4�����ǒ03�!E�=3�I��S��xAz�j�������+���;����OIsn��GT�K=�����ơ���3*�r�-RmT�̖Vk=&��ɴP���1hD��T�^������$�V��K�	W��_��D�.�zG���ک*��뢷i��P�뜚ϔ��`(�cpTl�S��ҁt��N/�C/;���/����
L�>��R2��=����3m��,�R��	�n.m���x<fsO���+�݈
{J x���������䇯�7�O���P�lp�IwS�����=%;�2!=�T�`U&�7M�\j�,�#�5�<��-8m��l�N@j�*#�yI�/]�s���5Se���wW_�b�#�%_�X�ד6�VY�]�?s�_����֥�A�χ���l5Wq�!�RIq-���������c�VIz�f�v�b�p�tr�j��œϟ
�ҡ��4Z�8X���A�hW���bP�@�)�u���':�O��|Hs
P$����˗~yJ9��]ON^���v4J���G��w͕�Υ;��0G[�Ȣ��
�u^ Q�̓��%�=�W�
�d\��i^��K �:�5b"c�R�@�S>`��zd6�����������(ƪ��Rd#  ,�ko3R�	.��b4�3̡�M�� �*q㍖<u���@#�Jd~샲��j�یݫ`5��k�yߖ��Ǽ�#۱��
[�o{2��&+�\��q
�uK�2���Sȍ�C�ə m���C�7�ehK��ڲ�0Ȑ�>w:P=M%=�L`�d%?��v�8��=	�t�NBw~���y3�Z�iH����d(g�.�{�D(��`$�,�"��cO�ʼ��0�E��	��</����!Viz��ɛ��}����*
>{8��J#�-��}w�U�g��䭍<1a�s�B�$S�x)�xt����x����`l8T��"'wI�!�VY�� Z��xFAAX��K�U�����b��	����@���	x�����^������z��S���u\�:z�s6���ӵԹ�׭7t��TU�@�\�'U��SN�_��UsE�ϯ���nk.�2��;��ɡ��&<e���w��;#W�K�RJ6�W�r&'�>���K�KU��`g�5^���-�o=Y��Q�C��5�Lx�h����]4D@?��t��{�x�&�k���_O�1�03���H��4� }ilU�<��]��'Q`��t�z��>�tc��熳�5p4�m�g���R8c��'p���6<Ix����qޕ�H$w=��,?���s��L����Ea�0�PE;:׸Y�����[��Eޭ�u�9�K^%���xLH�s�\^ADh�Ν���(���B�]^��s���{s��$=�q)�vGF��S��/G��]�	х`��t~,2;�:=喰4��6 �p�4W���Z�[D��_��n��G���*CW��hvj
�8������	,�Iy�iJᏟ
$���T@E���"p�,�<�xfli����@>�Cj=�x*1s�K:��\<�����;<p��W���]D��_��f�J�͢ �ѭ�O�<!�<4������x^f0o�jE��5�e��F�2��*/I�N�����.p�K����H�J�,���]��l�s*"I<���!����Y�%�(�Y}�:�e� �Oq�+\(5�J#y���YZW��x$�Y=�%�DW���4�����$�{ h  9�X\�|�X�0�ʮ��.�'MWN��d�x*��6~�:^.vڡP����G=V@�b>�ـ�tv�a�yI���SRV�z&
@:ୂ�b+��P/C��BQ�-�GR��� G�a��0<G����l�Y���)�WF^
��W��ay2煡��!?�S��A���:�a>,gd�Qᣱ��B�l��X�9���e��0�m��t6�C�8y����R��n���_,�87'�F�L�!]�7���G� �E�޵۞'��T��tg�`Bx^
?��n�-q�!�Z��w"�
 ��HO����4����
Y�s��4���
�Y�%��^L_�Y��J֣ �K~nH�/�$�+��N\�����Z���W��B.�GGqp�$9��h������s��(|6D:ʬШJ�K}����'���\/M)=7�Fլĝ�N������>�{��#��s	awZr�R;5z��G<r6B1��x:��OP_u��p���%�ٳj��"��2+A{Y��A�>�8*���s��^mQ�޿�z���?e�H�q���㴋"e�!{�1KI��g�Q�yfV�P}����R�
~�B1�+M�PL��#ND�쐭�
��
�������ұ|3�K���%��7wms�e<��d��y��!*�����J�V4�qo�V7�d3��ӡ�Crŉ4�����=���~#Q��䬨K_Ve9���E�\�<�I5�M���L�5����0�s��V)�	�J�do�V���a�3<��m�ۥ-^����[s#����|�7�2�XƆ���uԙ�3��,�Y]����MCx%�;Qpx�%�no�-:G>{�C��_��X]����Nq��蛥{��f��ocY(��l����a�7H�{�2��H�s�
q�Q^z����=|ɨ\Uޠ����Wb��ι=����O���X�U�fƕtvr��I?~���Ff3rV�W�5Vr���;�=C���R�g;�aw�zA!܉f�2�3�J?��-r�dN�'I�}�ad���Cz�I�l����Fm��ZZ#o&}~PW���+fhM�v��/�,��g�+�s}��l�dRF�`Y#�l����#�U���M��+���{��L/9�g��U����7�������g      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   �  x���MK�0���)JϦ�I�4�ͣe���˳�0��v��i(�!zp������fN�i͹� (h�*C���`���
V��[>�v�ϳ�Ǿo��*�u׮��qu���h;]?����G��Cas!��ݵ�V'���U?��؏���k���rl=��}֣�8������2�Mbb�� �<.��	p�x�H�+�U�*�+��xn� �&��J�V�Z�m$]��6`� �&�J���<�����K��d��^�&&C<��51⹗���˅F-�dAũ��9s�Z}����^�t��f�?�y���"�Q+�P3r%U��4���1Vn�nК��}������pβ��Z��l,��Q���Ho�������C
�,!���      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      .      x������ � �      �      x������ � �             x������ � �            x������ � �            x������ � �      /      x������ � �      0      x������ � �         *   x��VJT�R0�QPJ���@Z�����X����D��+F��� ���            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �      	      x������ � �      �      x��ys�X�'�7ާ@DwUg�1��/����dkqKr�j"#:�J�)RCRv�&滿s. �\���N��K�8�{��I�aR�h�T(M��*�)㑥�4�����$����7#T0�S�K�$Cń%���Y���7Ge�B�%��p�<*��CT�������RB�Q�{�w9�$c\X�0�߿;�N�'��h:	ư�$�X�\�ov|���l�����g�p��L��_�%S���.���b���Px���{�WWa�_G���d��o������۫�|e����?̔e�|20\/�����x��,��A�zM�;�̎xDPF����fT�+jMDY�}~���?�d<N��g����>����_�������=��_���?�s��/��L����;�??߿�/��oO�_(����3?�epd:[������ܿN��<_��?���|Bx ���|�<�=o��c����}�w�%����>��AX���{�w�\����c���O�d<�����Ց�i���|s�{|�y�3�&������r�0x���(�N�<�f����?���ފ�.~��.���� F�P!j�:��P���AK�R3�Bs����ZV�Y�Z�*Gj�����Z��P ��#�;�g�4�Gq����
A۱�u�������	m�O�)J�^0g��Φ��g� ��k���������E Y.)�f���~/�'��l��0���[�����$p9Θ֢�W�(��:d�� ��8M�_��¿������/��>&�Mǻ�!�^���qcp�*nl7l�����u������ e�"�!"���#���o:/Z���ŭ��!��:lZ�I�4�Z��)h��8�m�@{U`�D����|���v���C2�s��d2��$�̽_�f����5 ���~�*\8-쀂q�%�l��@!O�I��1��ϟ'�+����TN/+���hgkh9޿�|�1�e��h�x"T譓M�=DY��$�IХJ������r�+J
����O�NN��/�n����w�ᆡL��:p�g��m
�r���t�$ea�W����hГ���v� 7�)�K�$lf�	[5�% ùR��t��?{�g��o ��E �W2A�z��i<�?����h4-F���E0	��ýO��M=�F�g�wk�~�=��\cj����˧C���	n� (�E�������7�нQ�FJ�v�ƌ�����Ԡ<��X�?&�`��d>���3�Z�[|�
Z�6&���=���$y�>M����C0�t���?��ox
�f��5��ן��)<xn��-xN�w�h����0N��>�Q��E��wf�Wp[bu	J�RG)��]�sC���Į��u�B�;9?����?�����_�o�oϮ.W�"��\��6B��!�\�)���[�E��E�a\ʣ:p����hݠ��+�`'��#���ֳ9�la9��J�e`7v�Ec�ZԋN-fn��ф �h�]_\^��\�\�����1ǉ�g���9O� g;�2y[�ƼOן�`��4{�q��٧��
��A��
<��)�A�i��n?��~��Q.�o%�_��(��Wf��	�i��9��M��=�#f�Q���K���5,O��ע���s� �_���u���t��RgZ1��;НL+���@�x�ݭ�[v������`u�����G��u�(��(6����pw�����+�����l�0`a3�	a�輨�؄/�'Ɔ�-y��l9��J�UT_( E5�Q�Ҕ��x�D��(zw�;�]#�>ks+E
�)�}G�8M��&�D���U����M�p�ԭ�%6������(B7���<j��.��Ϩ3�Ѭ_,C���������o%\�ţ�[4v��|/�3�����a�oxR�q)�y,�pG�u�--�k|ė �8�a�C�*9'�m��.+��!�Lz�s0���.wƜW���>����ǣ�Ho`Yk��W(����([udϸl�% \4�*ظ�F��[��
%g�&����>p(Z��j��l�g.ʘ��]9RS�\+Ju�<*�p�F�z�W7�����x<p>�F#x��Z�M�?a:@�$����pK=<<M�Tv��̦O���
h���
����
��2�� �L@�ew5Å��L�}q���{Pr�� ���U�ĝ;]���.��u�.��^�����=���Am)�Q�㭢*@��%�&(����"�G������18����;hS��W��3�@r�w���(+'g�0����CX)�0�b_1e�m�]�qњH�ԟ`���Փ9�/�0�k�u�P1�\;V�0MU��� #����%>�M�����|E	q��1�T���[���i�p�N
Q�2��k�F�n�\2�܍��(���{����x^Bcd�����*�)�������M�9ܜ�^�K�p���4@y5���kF�nF_��?�[��P�������:�2�&�\�9^�A��#w&�(J��W�ND�3�/�(��%YHojE2 J�$�*y4҄&i�,�Մa����p�+ؐ���Z"�ͳ9T���Kr�<R�: U�)��~���&�`�!��N`<y���["$��(6P�n��5Tb������!�`�\��oX�Zt�� ��(�aS�߇�ce���|�x�o:�V��o�!����0�T�!���7��<�`���������������{��k��}�Y�x~~���[�F:L���slc����c�}v�4ǘ*܉v�I<|����N�`�Z[.ػ�p���fc.��u
�V��<�Qp�]* Σ����JUB�h�5�.�ܨf��lф��r��������2�>����$x��A�}��fXK�cv8\^M l��K�(n����>$8��}������tQZU��6I��rg:�H���Z�m� Xc�m������U�M���Aݘ������M͆c;TZ��p�������C���le��#���US�*)	�D��n�#�����ەk9-J�q�u�J��8�XGy������`�V�����w�~+�<�]=�O�n��0�)��~�kV[��eFZ��{_���2(�a����>VX�R�+�:)/3����
wjoFw�idU��݁���"�G	շ�+���+��rvytsu�o v>��A����kaI-Q���t��q�L�֩"�lL��*
�L�`�0J�`�:0It��Q�EkTw�� ԫ��y�PE�PE����U�-�4T�!`ޜ�\�z7��I�x�%>����g�K+vzI��ȪJ�V`�����S�� �D8t�ߦ^��u�%���p�`��{�ߞ��޼��qvGN�?���8��c�kϸqG���j�*oM����\2-����'ф�6����!�H#ن��~O��/s�R+�䍴�Zy��b�+��p���-+�8���y��w`��q��j�G;�V�T���z�q��44zS�Ěr��Ͱ�e�v����0�b��UA<f���F-A���"��2�g��#5Me4lL�@�C0��n����a+;<���|�7�Q��S|2r�N��Wـ�׾���5+-!J^�g�2�	4o��y<�
�<���#������,����c��u�xX���]	�ua;�.?��8�8�w�����K鰰�51i[�&QQUz�Lq"R����FyD.%q��4q�yњ���XY���q����k��F
Vb�@dqb	!K�UN@yy�t�������d4���f9�J�+1��Kǉ��) ��g�v����C�{2����r ���7��ث��.�wx~��}fҕ�c��cI ����K���Tw��3�r�3���0����iP�Q��ʕ&T']��^��_
E�Bn��$7�,X�u��B:�E�E�0��滒�
>�S>��-`    ����g9'�W��!�BgYo!�i�ξ�5O�
4⮾�Ax0��l�S?����,���d�v�g�]j�XR`�y��b{#���f���=�ө�+��=��1Y����V�Uo�sv8�S�W�Y ���i��o}����vL[Յq
J7M<4��!˸����L��JC�h juИ�ʰ1��6d��J[�!UL��Z���2e <K��@W�~�L���]� ��?��/�(h:0T��E�º���e]�~8}Z���U�� ��j-���5r+�t���<��ϋ��q���C�-C��j�5eABVp�K"x�A���'�de?$�d�����ѝ��T�4����z� ưv5+k[q���~���u��Yp˺$�B|����@	J��<m�gF��ˣ΋�@��]N���,�[=Y��H����c�������o`�h���
���-�����l)��Q<(k�r��\M"U�l������'W�P/��L~�E���jյ�H�JU�/�2J�^�-�`�L�d4���ax@���f�$VD���$ʋ�����P�+�8�����U,�=����u���u�dR͝��&.ʢZW��R�
8�m0�3ƣ�'�s?���2�b��:J~�*���<(�7 U�G��f�:m9A"6��R��Q��۱�kG�(e5��u^���]
7!��(��R�r��,� ���^%5[��Q0j���#�Ӭ���_w׸����Bu˪٤ׯQ	u+c��\���� ��ܟA�Δ����5��z�U5���K ʤ�����!{3��3�J SNu�qcTI�>��a4==d����]��i�����eMGe�ي��\G��U)������'4�js�$<i�E��r9#������|��E�N
W�����v˞⊦2~5��k��7,�-JK��H7�m�0}��G�Տ����AP*��!�
J5'�@Se���Mg�F��(+һ��PӁV|��F=��5آW�4k\��|��ӻ�}�e%+��/�TOYL���@�m\�*UL#`I<�2���ZC��ſ�_Ԧ��&�	�Ck�Z��U��0�%��#�`7㏂��l�Z�7k��q������s0;�@�V��,_(Kb`
A+>���+J�g�)��C ���,�����`�Q8a��Z��4�LiI܅�����o�O5[p<z�o�(z\ʒ�m�m�[j0�]ZI�bÕ`jw���U*"u��|�ް/��f+mvˌ�6aKөd��!��U��`a7�\֢�gs��K[ �B�ǳ�/CKM�8��65�+�*�k"Ƥ�nN�]��iL��*��0^	�1�T��87 �q4d%3Ak�>��f�<�,���0̹���Ns����.�0��!:^��mQ/wLl����M��LR�#��������<�9f�a�(�y�~G
nӢ=�J�ՠ��K�H�r�̀�D�(F�$O�QԤ���  ���)��RK#WL�ճ���m���fX^)@��R���`���<���̵?��J����	f��N��D� 4M�ˊ�A�@����
�S�}�؇�8J����qN�5w ڕ���\c6V��*t03�	UrY�{P�0F�\6>fB�F'��&!�p:���0xJfK����𨫚����b۫�F�s1i��b�N�5V:Sd�֪�ly[ζ�3��#,ְ!b�EJ�<Rj����k�yQ[�� �Y�P2Ѭ o=��Lɢ�a������ѿ��G�"V���X��a�&^��b���~4�/�<�d��E�����=Gg���[ �e��]��꟨����T.l��a؝�gX~�b�}4�V̯��!���
��k��
)����L�&��U��N2���TE�|9v�r��^��!שW��02Wi�u���2~}I�9Vd�̦�Χ�R�h
v��?�U��4����+�q�nb�]�Ò@���)��v��S�EK-w�l.���sZ�n��b�Ӆr´l���F�������7��R����]�^/��-wvW_��6cn9��Ip��?�G��*YL��{��;��;%�Z}��B/�9w����V} \p-�e�]&�t=i�u���U��e����d������>�=��l=O����*��%<�f�����"(PHHWwl��q��F6�������6���^��p24�pZ������K�	��呚S�	���۟L��n��n�Z�r��ܐ59��XS� �����+��eH���
M<4��?F��tR�M���z�jI�����R��������:��UoH�69V�����(K�ƿ�T��o�O��FX�x�0ɔ���%��9Xf֘d�����Hj���Hr���2�G"����V�Y
[��,�M譞-�'�,�'1�̤&�����ƾ���e�DrPH{'x)]anlV��:A��zz�,XV����j���G��DUD/�����!�q ��h�,7���;��Ny}G����#Z}��9�0|��%�E�,<���c�Ϡ�|m`!4S�� Y-�]�1R��MڒN���~4�ny�U1�`w��뚍�4.U@���˃qB�q���,�
�ܴ`U�qÛQ`ǋ4R����jW "�j9[��YY�O���5�LB׍԰_�Q�U�?]^�Xr�&������E8
��)�Ė��s ��g�`���]-w�� �8����N]����N�l4����*��1�o�"��T̻'J{���=�@ؚ��ڬo��p�)�w �5����߇���NL�+�2U��I�����Nت"��^vR�Ӧ�<H$..^�Ƃ�h�ŹL�8k\{Q��X8%�Pq�lV�w�g+؝s�ŭٞ�?�(\�.M
N��~����c���5bd������pXıZh�UmBL�\#R�AMh�au�JAxUQ	��P�&b��T�t�p�'�{��$r0;AN���kW�
��(5��պ6ڽ�k8K��{"������S�{����nʟ�lP�M�:d�1b�}1�����o$nĤ*8�����JS�[�S�(ɀ4����XTZ�(	_�m�9�/����J�	��A�Pq��5Q��Fg�J��Q�:/ZcJ��8��bZ=[@I��3������|p��P��A��?>Y����3��8f��ޤ���-+�ҕY1��q/~LZ٘�����$����ϩ2�vq��Rbm�7K%��G0�VP;��wՙU�'�Ӿ.[���RaFq6!�$($��#���K#�4��tW�(CM�m���\���ћ�"5��	�u^Ԋ�+,���W��
jV�F/�<Ù����QHx��8:���˛#�t�?g����4���B�p�����Y�V��bz��h�!�}��,#r�=̓��Ӧ�O�5�*���\!m��5�C��i���0r�
w���,���@����;�F򬻯ծM�;'_U)�~��(aŷ(g	�E�-~<�,�?���~hN=h!�m�-��2-K�ՒV������4c��m�6W��� 9�Iص���_����<�2O����a�H|�ݡ@,[?<�E�|�q�,����z_��2�J��G���xzL�ܟ?�R#��k?�K�;�T�8#��,
!�Dj|A�O�̦�\YV�\�F1R�ۜB�5��oi�-(a�� �`�b���.�x�0�ͱ���Y��-uK5��+{o�,%���9���T�G�3��4�G�:g�u|Ca`gi�E���h�R-sb���[�6��Xr�^;���RR0���� �{�<R��,�e`�H��㙍@�gI[o4Z<�!�+�A��{���ӻd�E������=��׹T�>��.U� h0���m��|�Z��=L�!��L���1�Tz�+�SWjN�n!�[+��FIl$I-�z�$1I�4�h�认C��-�j�-�Z	,k$�Y�`T���9�zH���P�>�ȭ�����_��團�2�rMq��dD�d���uT-���:���Ug\��� ��F�
�0B��rZ	i���\�8a`C"]���~
f�    ��ſd͸���9y0~J����lu$f�s��,�р �r��_�n⮥1l�
�5���jY�]KMj@:/Z� �qLa��@+���Z��M�-ۍ�қ{�5{ 
dEǚ?�t���z��5��y;<,d�w}q��H�:ٹ~����x��kQ��`[#"+eJ����z`����dK�=�������r �1����ڲ2)�R���.i�=n��QG[��z��d6J���w�����1Kg��|�1<���/D��F(Z7 �P)��2�Xo���ɛ�[44iDp$U�'eoH<�$��u^�� D�F��ifoD1ZΖ�VY^��T���~H)'K�$��k����<���'˶�:1x>�F2?up�p���5�/g��g� w���d]��_��^�Qpd{�*.azK��0cf(�+�߃|N'{������%��N�Qdg�V~���j�9�7y`��V0��Ow����wſO'n�8�eg��_)��
�ϗ�����?�q�@GU�����5���^�Z������8��u�<Z��y�}��O��]L�j L�C����`"N�}��I����>?b�z���D;XX��}�W�o�4�*�g+5�Hc��e
vc�Z+(�yAq����P�H�΋��I�o,"�Cj�M���9j�a��1��l�N�/
jq�!@�(al)��Y�bF�A ;��@�WMY�����j����� [�	�.�h>͞���/�?���i2��*;��l��nקJ���DS3К+$<�=��\��`�p`F���?p' ����V���6���L�����%��w��\�����`-|�|wYmҺ�>�]\�櫭�l��U���@���}m�S�F*���BQ��11 Mr�%�����L�J6+�[�F�(����󢩓��:���S���ƿ�L���~���Q���*����9�{H���t<~.������<W��ވ�m��W��SWk.0�\�B��H~���9�;Y).��B����_��/h�6u�b�4K����Q��LK��d�ئ��!֋pR�1�݅��[�\�0K��TQ��P�}\��Rn�и�M8��-��J~��*�#���hq�0s{��C�]�*Θ�"��14wx~�%��(��F|�k��z_A��f��)�͐�ě�3,��ߣ6��Ɲ���„%ߛ4Ⱥ��[�0�7�2���2��g!��
�7_�9���|���h�!�i;�,�A��^�Ywd�����]F	H3ʩ�E-�� �]�};.jf�b'B���4c�-gK��t��aZzY�A�V�*��HYb����F����]M_?����m�F�����XE҆Y��=��Oږ������xaU5���J�ՌH9AK6�����y.N�9{�:��1��W�p��;�f�s̂$|�M��q2qf�᎑�f��k����zg��*��T���j`u�ΐ���11�5qIq�����f�F���rID�4#�ce��bi�	k������iڬ1x��'����[zXL����D����J
Q��.`r���-
j��y�x��c��X�5:�{+p�$������:�C�$�,7v{?�-���/�W�T�VG}|_ѠG�8#���ƍ͓fx�x�,E��M�EK�,w��3ׁ�LV�$�hf�)Ι6���S!�Z�!��H�Z�<[���M��jS9Rӭ�XVe�h�#X���ʃ��ᑀ��?�IQ�8,3�����/ۧT�Ц�,�<K��}0~z gmq���&��~:�����h�~��4����2�}<9T�p�"�x�Z+y�g�k�W���@�����To_9�z��B��Z�2�Ǘ�ןo���Gs�ā�x���`������)#Y�� �øs#ѐڼ���T�#��\���E�̂b�,�ԅ�kL�>,ap�pc�E�Z��h��V�MS���a�UY�Ź�8�4mr�&^�KU��Fqot7�& )�H0
�y �Q4Ǧ��*g��+�f#�8?��!pg�������F��U����K��&(�^��O�*+���I�����ZUM�n��3tc~ �&�i���P�R'�+�4-�UM��*-gs)���c"KW��I8�/(�U��V��Y�|֊"��m�����?KTV7S�e?��]��%�Xc�I���r���HT�C�6o����콲� ҟ'��x�Trk�ϴ���nر����������|���?=;?��)��������%�����&R�6�o�$�4�`�-1�+��^�9F0$UF��即��� �~�V��M0�Ѽ2����Ή`Y�WWت��hv�q ���J�NYn��%��N/n�`1�n�D+��;Wc��l`��5@t9�]HPFs��c	�Σ`��A�E�
����̰�IR�����j]zI ����	C���X�P%�sǑg�f "�xu�to
֫7(_q�1u��xvq ����͎�2���:���¯e�%o��vM���`tc�	�8]qZ�+	[G� y[�t^�9�q��b�x3��r�0��N�t)���I���2�gF/���Ķ�`$�u�A;��o�	���,�*�^�%խρ��HÕ�1k
�}�ʔ���/t�6v`Ҷ,�L��J&nUD
�]Ed5֩��%��2H<Ž��n�&x�2�����i2��k!���B��\�TNܜ��uFf�!��˵1��^��������r w28�;����UM��T<.�+�^%8�"!�6�q�Lń�4a�0������g���΋V6��T>���u�j��l�9ȥ>��Z)����^F���O� 	ĚPdg��SȢ�U;��G￴�4r����b�1g��F�X�A�� )�,K��*�������؋� /��#��d�< �!8V(O�[��m��h:�Lg��Z���:����:�C�='"�R�%\��b���֮��z|yx��뱿�9=�=���?��Nq����ΜB�N�����:O5n\�og4�R�ݞM�?q#�:.j��.�����C^�C�z�0�-=c��byd��@��Y��[5m7ܲ� �8|����X@����4�o����DT#1i���}�0/0���YgO��,/� �gW�Gx	*%�W�e�J�F4�9d�"�<��m�OǪ�>� �/����[���E� 1�%)B��{

v������Ϗ�۫/��W�7��˳�f�/��,�`�D.�k�k}EThc�4҆��9��	`�n��2�$��V��c�C*8�M����&u1_�	���ʑ�[j�:߸=3��6�q�׭�@���8�CM��b˂--@�gk��>ţ%��)��ϧ�L|��>dm�C����lQ�,��g��:5/����2ݤ}��sO��b�,�a1���I���qJ:/Z5���b����x��-���`�upY,�.c��XmIIa�)k�0W�9Z�h�n�B�y[`�t����(PvE'63�E=4� e���Q�}<�9;��jAxu~cp;%�=X
j6��%��|̃0�"8��5]���W�z��lo!� H�P��e�qX(��WHz+����on�.���,��{����BݴA�(�`��?G�3��i��!��Q�?Ft�oG�c#�Pe�Q1O���a�F4�e�}Q+�r�:��zj���\�Z0�y�Hh�=��C䋃W0���.��a��{4�6�?�jD�l�	�-��	���&Ya�B��Boi0D���a������1v���d�Z�9�� ��F�K�d���x�i��{� ��h�d��1�:x�?M�Yv6%�>��a�20q�/�VS)*4/��ӻ|��ם/��e���P����/�`����i�6u��|β�)�� P�.:���R	���i������Q:���zz���oű\�Nb���H�:��Tv�1.�a��Y(�3��ޔ� �v/�D�1�Ϛ���/� �.e��,M%����g�VH1ϲ��X��,à��P�4�6k�a�;��S��N��'�����7��Ux�/��    ��ǞÞ=����ZF��n��$���&ԃ�lՖV
>����!������/�O�lN3�#i@��)lظ�L�
�d��5
������#���
qI3$$��e�I��i�e����Q�v�j��PRg������������w}xM�Ɂw�H���S�]�Fcrf�([u$Ye�p�I0-�n��o� z�\�*E��#eo�� �f_�%������c<�y�L��)�4��NF�5CX�N��`i�J�n7,0��,���;�sTr"_P��7��4D�h�1 \5gF�40!e���U9�d�+�k�������e`��NaAk�ʑ�j���,̻n�h�x+����$btM�[����L�~M��+�?�����%�X�9cG�suT�ٴKOS��S�V�+��}ΒgX������#��� ���ו߬��٭������ƹ�|qqv�ڿ>�s?��Eg�>]�� 6c�ħm�`�G�1����Y�A��MAk"�f�e�ĦA�E�ʎ���Zõ]Qv�g˨N>��jZ���F>�XteB�`��&����� ��o���`�l��)��O,��ԥ�W��:z ��a8Jji�ꊄb�_5���Z��񌡪�^�'�,޺��2�@�1xYq�K���y�K=T.Hy�q	�B���W�n��?�T��6g�8STE���'�a�P����6U��z���[����l����!�����������qb'R�6�\gŚ|�bM��;I)���v�w�.��0!x�T�s�Hϲ��Z��b���*APL��Т����H��Z˞2�J����O�;K2�,�+�DǱ�!xH��R�t�z.a{C 4��Ȯ4K�O�H�F��Ƈ�����w�yy�W�������N�ߟw&!�����$ĺ�4����em�$a���,�K}:"T
�2�y�k@��PpP骵�<[�MLN�O	q����J(c�cש�Bx_�v��i?L���i���\�h��ǳ?on��ϳG�U����^Ʊ�(R9Иq�
�0����w7�r0�w����j��P/��� �Y�̓Yp���gq͊Su��J�qŔ[������8����DTR�w;A^��臡�e��N�������/7>w���R:��0��|ݘ%�j٬g��v����8":�d��o�&APjÓ�hg�P��]���IZ�dm'��-�E�Z���3/2v^j��`N�# �c�������X+g�s��'��?�4kGh��"� �G5��T����d��0��ˀ�wп��X����͡׮�i��DA=/�Z1c�bʐ˗�2�j+x|���̄���|v�o�3��v�@op?#� ��&ۿ��A�w��r�k�G�u��++�.*F݊�L.uhR�t\Ԇ:46�b�ص�-p�t	�ic���Y��k$=hX�{�.�oOO���2p�WOܐ��D�CR�ai�����q�6Gk��ة%Ş����,f�f�p4ً@����k<�,G��y����^j�S(Z��5�^<K~ç�l�tw_�GpG�e'\�s�o�*;K�_GA�[Q���Gf�����~S>�;��x�_��9Yfϱ����7#�TK8�&�{$��gK��u����()�w٧±|�M�S�$q�b2=�
���L,a$f���M�+4�F��,�MŹz�pY�"�1i�Q�H��(�hɕN1�Y!�J �w�h �K�����r���qܬ�A>K"D%-'�^�б����XL'�{�\ #z��ʡ����O8�Qg
Y��TB�mx���8��`R����'����*��ͺ��a�
`��T�*��V>��|V4��j_�(�]��
�鈳\�[�'k lݯ�`H�V��ug5�u}=���R��Xxs�i1�>L$��ʔ$�4�
Hh"l:-/
yj�U�-ݎDr�2O�"rSG��1�H�=�Z�z�~�x������+���ߧ_�a���S�j��ƔQ�z�`UDjc�SJ�/~}��)��?���=�����JAn9f{�-��f�;�����o�IQkW2YdP����)�:6�f{0����J�WV��`���SQ�%Y�Ѱ��}���X	'$a�4�'�w�%��%`ߒ��8�d��<������D�|�M����?��r~vy�U��We����U怶Q�U ��ؠS�KoQ��B��T;�3��i���8H�:/j՜��]���dܮh�ճ��$:�� �"sY�C�ŬY��y��
������$�)8��E�Q�_�~�8���p8�Y9���|t�[,�
g�9�`.��ꥳWp�`k�-��o��]��=;����ytE1E\t��l:�_�������]ӈ������JIw����GF�@�[�R����E`�� ��;.Z�t�:��.�CbA���z6�������`7<(]k�jl�ç�nJ\m�v�C�'�v�&���8�s�xzq�i��`��2Yt�w�Wf�����o�F$)|2�~��帩�읢|>p��S�ð2uJQMY?�C�	^���i�%��XR�gA��^������˳�7�����i��N��:�jG����	�X>�5t��h��2r�q�j�*9 �7�QҘ�&,I( ��6��0�l(2k��l!�/%	�yd��y�g
�p**\�;�m�[���Y.��_�l/�tSU�yS�n�͜��Dk�}�p�U��C�y�����d�iU5��9��0�'��w�m4��k��RF�3��3�f&�nƙ�E��,fe;����ٻ�c�k���t���#���~����`��;D7Y��m�y"��و�"���`��F��� 1����8RR;��4�[����ʡ,53��d�Ǌ}�,`[����}��鰥�j��<e��%���F]��Nb,x��@ Zt�4�����C|�?���J�N�k��ʮ�Z�d���r��0�e���ǲ�FNw�ڗ{Nk��+��7�` ~:�?<�X2E��j�΢ڬ{GG}�č�},�S�W�{9�[T�n2&.ԑH*C�3�U�LB� �:/Z�σ����������F#)T������@��F���EeI�P7��V�Lvx��d���w�����>5�0���p�~�I���*	�Ƹ�x�7���(��������G�u��f�T�+C�����bT�A6�ɻ����e�e��c��u��T%�7��6���P���l�yei������՗��*�&���������U[��N#V��we�(��7�
�!��#l>���ư�T�Q: ���U�X��A���!���HV��@0��J
�R2�<�[%�αdQ����q#�QFfeVjm�UY`E.�"��k^�!�-f| �Q�7�o�{�$x�q?Z8s�i$������!�� �b�x��(c����JÓ��O�d2�"T�;w���e��K�=��Z�/�)jT\	�kޗ��.�]�Xn�C�ZO��aVg!"s�p�	� V��Nf���|vV�b9��Z��Y�&S"|���:"�� 5�͍��iUǘ��"�y� J�+Ր��~6�(Iѝ>a��E�'�
D����F%���rEC�
G�.�A2�6���b��G�|z��Y��k�Y��H+Ő`#.��b@����d��r�#=�Q8p�ߠ��s��
�S$�0�3���`6���C��h�Z#3B�s`�&����#6�7��KL0�$���(��΀]|�<# �#�w���M&�	���?:��w�n\�]��Mp�2b��),���0�ȵ"1��p��\tr�E����{$���U+�ճ�5ې�G�+�*v$�Q+��S�������0�f�,k��V���q�t��x�G_+	��������7�6ױ���UV�`P�+��IW��j��D,�Rx�KCw]��8f%ޟ��f��Q`�D`�*�y(?��1�;
X�Tu^�
;�Gfh`疢	�ճ��,�$X��+��'cT�Z��
G$8yk��ۭV��j�1A�c����G��    �������	���J�z4�{R�o��vx��J���9r�AW�K�˭�᳢�^�7Y=��ݖ����T'Δ��~,���V$ƤA�jqj:0�E�Ş�dpH�5��O/qL?�X��ٸ C�,�,
��@D����X��G�IY�!�ټcӕ�m��ZX.�ȕ��X�}�I��`�W�x��TD�0H܌&�����	��%�h��j�ʀ"yv��Á�`��1|�$�̀C��j�i
~� J�'#݊>sdT�$ �Tn�Z���VB�cX�Ń��r���(#�X��F	��O`s���83a��x
R�!Y8H�>)����3 ("�^�`��-�X������ukS���0�`&V�[�[JM	g���i��8��m��o!����B@���IZ1��� ��a%�*��j�&'��Ahx::L�.��V�Ԋ��-�7	fw0�X�&��^�uD�0l���BᓲAd�I"�H!�DD	%��l�H�.p��*8ܛ�?H�M�X(،��jA�D��P��D�D2Hb
�t��o��)� �@	����L��h�,���r�{8sO2$px�VJAv�L�n�Z*p�Az��S�ޔ��f���i`x[A��S04�m��Ab�JE�ЂT�"�с�|5,��1|o!6u	�R�p�Ј��ACt�{�}<��R�m	e��'!x��l�4�B�l`�t0�<AL &@~3�*��H��{3"f�H�4�`1c�S*���,���;6n�)��Ui�(��,���2iLDHA��I�Q	ց���`PY�$҂)$ːلIW�r9%Ɂ^�Te�f\k������-�S7ߞǘw\�`g�~J2+�7)#S 	�����'X%�I���V,y+�¯��(�̖�L,{��vj#f�����-��(c9�1���,Ek��(\��O�fC��23Vdtڦ䛰`�Y�4����L��r���G�,N��J�HA`���_���z���k�
��L�&��efvɂ�o(�>Ŧ��?�&>Zݎ�0�1HU)������~���w�6'���'2�	�|��"b�)Z�V�X|D�����QxQ���szT$�CP�L����)�qs���nl�#>Ӕ��=`�ؘ�  oy�K3�3�Ƹ�����n���.d{\Yu{[4@D{��W������l�Y�����1l������[�ϔ��ǧ� i�O��{�\��"����{���3����G�gگ���e���z�C@B^\�|0W������;��%v�U�W�o%C��Z�	��ྼÃ�O���S�?&�Ӟ �d���0��^��岒rV81�I�{�χ(���g_��C�$�y2O&��;�?Φ�~���f,7����Z闳e1��9ס]uʨ���ɩ��M��؇;�9<��˻�L��Ż���!V5o�TJ!I��jM��K�\��xI&6�A4��d
�p�kހ2��6V�����Yj�L�К��`���2浑��o�P6Pk3����D2���,�fe�Yg��͙��a��Z����b���VSIl�[�V��'�M���A��f�{���V��)�����ji���L{\�ب�O
��wo��W����{�Y��o/��ƪGE�B�4B�T�+'�@F���IJ8����/�v�<�C3�W.���B
T�64M���;��t]D�A���0G.�[s�cŏ	ʐ�ەxA��fI�DQ�G��sQ�"�:;�>E�����BX���U��e�L$���1{�ظ�yݍ�a����I$(�Ɓ!I��oЙ��ª�w�ٕ�p��Mc���2�2���������K������e��#�c;ffk%}�}��żDZ�u�eA	R�]��(=ad���q��16	m1��5�ù �!Zu^T70���bq	%X�F�a��:�U�v	�)�*�&��o����BP���������]�CeFake_}��&{�2m�+w�]Uݔ���ؘ\��r��BU.���i��wK�7ˊ�G�=�{�_�<RF�Ƨ������ӊxa1=
�W%�v�9�w�p4�`7m�1��\�ü=�����5lئzy��=|��Fd������j�j<Pxk{�F����;H�6�����L"�U�n67�����&	nQ9H�6xILRh��Ɂ֦I3��rV��E����q���ZYZnL��!�4š���A2��Hk����5�CF������k�.�����\~>��6$(�� ��uTd�bk�A�d��b�%s���g�$��^�����}�H�A=�Wgꕻ��ɷ	�|y��������p��ǝ2������//\�ݞ�eY@Z<�lb:���v��ɴ9N��U�=w�g�~�3d՗|�Ԧ<�n�@�1Z�	Tm�MH�I@vR��V$m��ڄ�w]ԶM`ď`A�!Z*SV�YW�*���`�r��wn�MH?����⯊�@�ݗd����Y�7R�O8�*h[��K*�Uh3�i����G����{;��^C�w u�$���l��S�t�)R�|V����bWh�<��'GH��s@�80�X�d-�x��Y�H)��M
�ȹ�"�|����|��yiQ�=������E�q�ӡ��|��}!�jK�u�%�n�H���9):AL��[�����M���24�p�k&�q4'�Oxv��`�LJj�l$��M�0M�([F�5ۂjV�qH^\y�*f���{\-����B�����Q���q��jQD{|
1�%�o� ����0��SH�L�[-�ǧ���� �O��S�Da���iX�.:��j:b=��J���R��j����Ք�o����=J/����3����J�e��kQ��h�Ѷa����BGwu��{��K�v�QF���V$<%���d:����a�l���#�ҝȸO�|c��g�(c�I�Ǝ��B��"~����ү?�^5�)w�i+;�)�63�'yOs���+���������4��tc�剴Lǰ�v^�j�k�F�|���V���c�ܧb�P$�1�+A7�ߥM�Ҹӗ��t�Ҙ��.���Ee�>U��Y��+o���i��Z���V�H{\Mq��j����Z-Me�E�{[�:����ۣ��\�(o��=�[Ĥ��R���k�Dؗw��W��S�k�D�����=���-���m����������R����������-�:�oKi��������-eJ�,o�SQ�G5����BF_�yr��I�_�ҤZ������q��EF���"�����V�b��f`���c���X��~
�q�̞"pT�h_�GvTJK� ���`d�6�J�Oq4��gnHYF�w:>����;���s*(��znuqk����jBo���Ā=�� 0�`�Kh�$vL9��hŁA�!�yHp`r����|��C���;0:�2Ĕ��v�P�����\K��-��ae�"������j{\-I��V�X ��jq��[��x��V�q��y2�[�r����Ɓ�VKc��j�{�� "���B�d{\-5=>�H�q%\��Z�������2���2	M�O!eq�XHu��n�FV��� <�o����[
��z[�����j��h"��5�Lj�E��R�5��O����]�6�[�Z������	�����%��
���?�eSF�ZI�L6e�*+�-Qyi&W|��e|<p%��eyUVW��G_#��n0�d��^U�Ppn"��R.�Zm����/��2sB.w�7�A��,@� @S(s/��u����(� �h�)j!������"(���U�<Ȳ"�)�/UB\���������6�E�t����Lyrl�������d<3I\)W����T�q����@*XjE%�nT"���d�E+HE� ��5�rM��U�bE��%��a-Uc�V�8Ki��ʡ�j3����Bs��w�p`d�O@�~�Q?Wv������?
��k��=�����So��nm%8wJ���b�M�͙h\������O����O�.�o�/ˆ�gs�A���/��R 	  ��gp�Y_eO�2�u ���vu3��dr�r���7&Q�o��c�:.��h� ��\�|h�[�Ġ��xVP�yu�+��JV��'X"M���:"+�6?�K������gm��p�����|�|7 
���`3�I��et�� ���ZZ6�	�����j,��>r���`0�_�T�ߢ���(̌����[d$�Ym�۠�mЏ7��?���7������Ƙ��`��))b���7c��juvC;�+Ú@mj�F�r�A(l���l��#TŢ�UT+7�݂�?��(�ڸ1��Yq���ZQ7��n�n���j��Vq+�������6P�~lCF�j����\�4�./�o���.�.}�7�����]�ve��(�\��3 �Zz߂����4�,�4|�C�	s#P,'4�Scܧ\���E�#����m�b��4!3���$b�x��V����=c����q�fh	�\�7>� [�|U���"��*osph��	�{���Y�hyל�p 輨
�@��eL6��R�K�JiE�B�IY�<���rh��VBL����4O�	SJ���?:/�y��\	���χ����Q�g-b��ɛ?�#|�����G���#�Q�yRHI5҃�����Ѵ��s������S��2{2Z_=ɯ.p���5΁Δ�11�b�z9b��W�1'���*/ڧ�moր��kCdL����hI@SPd!�h�8?�`�:UC-���%�+p�ʈ�f�C���8'MV��5���n<ݪ4�ȍ�y��_4�c�c�N���-X�ȃ`�d�Y|�L�6��3�ru�~��'�����L"���;�v'�׫s�����Xu2�Y(� ǆU6u"��.Uژ�gc��t^��83v7�m[�P�p
{=�YC��Cm����c��L�6Ą��1��KK>������@����:%���S���Du^�
a�7��PaBM��0�ѣ5%�d�ʡs���g��u�����X���`�pDQ���yQ�(l���p�U*Y�E�Xul轂���U�X���M`l�c�MW�r�R�Z"1�rh	U�f)��K�#t� 9[�� BbS~�'KR/����0�Q��.�N���5��������1dT$�m�Xk��i�����l�#y7O������h���w���>�������Ƀ&ϽӫsG�������c����gyv)d��a>N�9}#LsA�z�au�,#Q1�pY�PR$e��%*䑊D�E�X5�W�7�Zf�1�45�W�*�LU5�"�\��J�T�PC�r�u5�+eY%����)��DN�3ao��+mR|���@o��ǣ�$�����p#VLl���mܡ_� �WK��ƣI<O������ #)�b�^���-?hS64l��2f�� A'QEr��1�rLh"����j�B������F84��H�4B��bA�:3!A��p�.Z��, �M#�[�!�����B���s����0�Cf��0tr��~��,�a �X.P�up�1�&$��5`��!%�j��BkZ�`�I�ZV9�An����TH0�� oI��Fq���F�(�EVS�}�d�c$V��ـHtߥ�bHpNe���Z�$'�����Om�uo)AV�-�h�5E*@�~f����?�f�����G4*M�%�ͷ�����5�����l���1�y�]{��KU;]��o�d&`m��U@��s�*AHS�1D��y,��Yu'1ME�E�8T��h�2Vg�w���01D߷Bʗ9M+�U�W��ViMϢ8B�+[ӻ;эn���X�8������&�d�{�4�8��IȨl�@�P󛅇8�P����3׼��=��<���㴵����`���@�X�WhTI>4�í����]�����;�ܩ6M���Q�������>�(#����'�<�%g��ZLVb��D�1��j�D�%�U��PΌhg]k������,��Z��PN���x|~_���Y�� �L���ѧ�b�#gY��%��ɒ,[q���1�����~:�Y�L�s<��F���y.\'���1���c�p n��9�K6�l/)j._�����4�*�1�1WqA��4"Jij�X1�y�� ܄G�x4xs����ʫ$Rr�$�Z�J,s5
���ʡ��m����&���S0�m�1�w~�&��:c{���)Y�-w�"��h�����������=�'���8L���8���RH�.%CKu���*7p�ߊ�L�N��	�n�|K�bm�{Ă�kJ�k�Ht^�
8�=���A�l��+K�j4�@���F�4_N�S��*�XH�!��.Eܧ��ԬLQ��w�kr�X�bQq2�y�k&K��(b-M�Zock8&Jˀ�}׼N�4Hb�4J���)�w�`���i#m5��~�poU�QF�A�p$+[i��WͿ������� ���y/Ln�5�Bw&�5akL��\��К� 	>VQ$`��ߍ��Y�������t ������VS��5w��	A��_a����2TKS�I�jtFt4����!$&E=E���;����Y�43����Lr4�d���y}*W���g΅�̪��7�'�����@b��&���L����do�BC�HїOor��۸Q��J�4B�&(���Q��"�y�����LQ�MA�ђ ��i.� �A�[�4�F�6A7u:���,�>n'��q�Z��M�t���"��Dg��d�4�����1�	k<*\j8c�;=�2KV�d;9%�!� �;4���[5�f�G���v�Z�+!Hv�|&��<Y�YV��^��p�K5(1��I�?@IB���$
�z7M/o@�G�� 	� �]d @s���=���-c)�M$�r�K�Z�� �}F�t ���sx����sd����\.���4�^��8���8UR�h��[�9>Z��||<�m���]T4~��}��=����>�w���rr�k��#�r~���0���w�M����ilFс���M�1�Q���Pp�'���� �L            x������ � �            x������ � �            x��[ے�8�}����yه�tA���}Z�y�]�Ȁ��+�h 2+����$@Dfִ�u]pwI~=�R
�M��L�	������Lʜ��`�����<W�:!l���e(�:�����������HeeUe�Pvcy���+��[�P�C�l*_�+Y����Y�U����O���ꢭ�zSZ'�R�$��� ��r�}��n��~��Y�=����ꢻ�/�@lM��L%���(�T�sއ�W\����3xʺκ����Lq����G�]���eC���jC�e.8醾o��]W)���ոa��8�uV�-�w͟�� Eݖ�u+`<�`���2��y��>B�_
��t�XPn�C�q'�Iw\*��<py�>�r�Jx��t��u��Fxh�M_��F*�ї�������/zm�nچ ȥv��Ldm�Vg#��#�W%�7��m�[#I4Y����E�V�+�}�ERh����g�ײ�iU���u��������������3��8����XIE}"�~��#KM�L�N��P4-��L���l�1ag��П�k�-Ɯ�(0��\N�|�e{+��Oȑ���P�m���+��3�K3L�U�T�Q�1��A]͹9��uB۰����0�3-��\�e�{�r�@�A�un�6�;���Ęϛ����#�y��-3��Y!�C�'g
{�'O@��A�,�����UJsg�b�5�K<���"&;���W��}�8Cj�������V;:E�f��!ɯ�~>�|��E�F�r��2����X��}#��s�C��zަp�+�m@�:�dV�Y3����Sv�Z]]WDUH��|'����h&8�
vBr�.�H��C�H��-������؜?��u�,���O�1���l�P�/Q��Y�G:~)�;=hn���6r����e�y��mM�6����V.&���-`�΢0E���3��GW���`IN��('�� ���6�r��˕t���~K�I��TVPu��xԮ�q��WV^���7w�� �Q�D{��a<��(A�eȞ&��������!X0�����Bf���Ó��ۢ�c"b˝�k9�� �1�9f�9M�MC݌��K��A�Z��:���ڌ�)�@�d3�.¯!և*�$ܿ�Q#N�a*К�/�����>k�<����[yyB��vǢ����X�7�����ߏ,���[<�a���9��EH��l"P��7E��[v�Уʤ�Y�b����x��H������ ��q?M��ސ�\z���5�io�,���������l��|ĸc�5�7Ef����J�p��=��E�š!p�#���sˀ�OX@�|l�Ra���&�o-šL,�^����Q��!�/�xp�(�� s��RΑr�x��@M��6��3r@��9Uθ������ɓ)��<I�i�v�<�<�UxV3},�Ƕfi��Z"��+b���f��@�F�s�M�m��1v�8O�#G<;���T��6H-'|m�b��\h�Y��|o��un�B�Md)���Luoۏ�d!|�ou�����xq9�����ai}�6��8l!�"����a?�h���ߤ��3�p��k�?�o�yв��q��帰�JS<�ӊi82�۟��*tM.�>c3���~��n*�0�:�v�v�qV�T����쬙c��/���>�,��"��q#�K�Q(Q���_^� Z��	���t�ue!���K�/����#ܸV\��:�_^�aC�n9����Y��B)��.7��R���{�h�kPڃwx�9����"���4I)�5���L��е�Ysы���l[�1(f~�Z�Bp���7����ER��,�,@��lk�&�Mb.���A*��Y���A#o)}矶���D[4��/��㦐2�!,;�ρ=@�>�O�����#[?+�[2��і^�Ce�v�z�-���E�&��?r�}h�w��+֘9U��2\.�ei�i�u-�E���7���w�mC�k��|FB�x��983k��B�Fn_sK;ߑr��]��K���|Ǣ_mԢ֖����Ah���e��6]���b쯕���)�Y4A"N��uŹ�sR�_�ye�HC�<g���A�m3n=��b����ڴM(Qձ6�"-2ڹ"f������a�%��R��FXYP#-�c%�D3f��) ���)f�����9C����<�/Be�FO�[�-�aݮ�`�ou��j�,t�v�Xl4���f�K�9�Hc��۠�Q���m��Ĥ���vWr�Hc ��B��r��rWF�S&���2c(�}���s�͋$���"��5ڃՄ���2+�0�+b����i����q��U�<�Q�]^���b7�L���pHgg�ٹ~_lH�lR	�WJ�n�/�6A�w�]
r��t푳}����i?��@�EWF�]� �j��
	�Z�>Zr�8G����Թ���|^�j!᪌[�o7�Q9�Il��A�X���5�̹�VR��0����ʠr�9SJEU��,ve$�p�,c7D}���Q�,Y�"ˊ+�Ok)�ʑ(��K���yJk�+!w�^}p��o��r�V(;�l�PmՔ]A������XX�����(���e�J��uI ]Aw��Ǌ�� ,�V8�u�~GP�i R[T�E���x���tRf�
��Q�⃈ݍ�@ #k�a�T��x�U���,g\�b홷i�Fl�)�g$��~��Wu<�
���; 2��=:�.�pi��&�R�T�^�G��ɖ M��#�?MJ �A��Q�ʪ�PiF;1�(&�糱��T��Q����P8N1��U��p��s#Y���Bz3�ь�������)�s�騭:H6d���P$��q��Un��_�jY��Ӵ�d�#�Zg �("xI���^���yK��s9����eo.�D(B����A���i#��;��|�7�j��{3�F���k�^>�m]Z�j�z"���ۤ���Q'I[��5ٍ����YvPs4LG�'�b��l=AYJ�t���̂Tc�3���u��,C�%y��{������/}O��!]M�r��)C��-��9?F_3s��%���y�<�@�)�������Mix���Z�c�X�r}Yُ7�6��W(򐿃	�o�xp��U��=2�J�:�YDp�1%�74>���?hJ	���?ںOw� �݈�4�$M����-o��%J�l-������_U�N�� g�T�t��1����<��C:�Y�\oe��hc!]��C4����S[b��Ɔ�Ol��447�rVB��I�ٜ�"��Uy���DW-o��!?�NED���熀,ds� #B��GNu�����d��̡ͬ�a]Qʔ-���S�V	� ��.v�+�Lo׈0�Q[��=_�>٘"��\�п���V��w��Op�xz��X6�uS^�p�WB>c�E���q����=Y���є�Z6�_��m�m���!�i����#�E��L5]�P��Gx�UC��0HE�Z�by�0;�? ���/�.׬���.f|�	i��D z.�T$���aU���ǡ9]D��B����nb�Md#���(��>h�[Isw�ӯ��&LVJ��g۬�	;$��K"C� �������r�驞�h��B�^�P�A:  D�S��������r�@�g����p�WK��o�F"\n��%��Thd�w"�� ��J;��k#h@�򢢱2�?�?T�&4�ø{wc#ć�^��l�r��V0�:�����|��Yy:�'�(�+��g�
Y��~�t�ï�&��<H�)Z���2R�8]����q�I�p���B'B)a��yδ�������x�X/�7�S�ֈ�$D ��.� ��y�] ��R(��5�Э�C���F�r�%�X"�!D(��י5�#d�`���g#��/cOn��R~��L"̮��Q��WاH_���J#�8���5rQ(kC������V ���/c��c�s�/
;̶���g'�C��Pd͸��jx3�'M�f�-9`.N h  ��|�K��i$�Y E@,�0�k��*�6}l���g�sj�I~� �7���X�={in���+u"0𥯰��l|�iֲY���hn���K9��C
��	Zn�'e�"����Р �4��7s��Sߒ�o�!(%m��c�����s��nJOo�UH����Ka�$!�m�����i�`;��2����j�dEݽ��>-��J �	�cF�>k< ]�&6G)�Z,r���};ͶP��cs��,n 㜄{-r�������JʋЊ��d��=>��Q�U��v36�n�r���Έ�OV����$��1c݇��2�������3I�q��/��kBB/��"<s|�f���}�BxzH/�iUW�S!a��s:=��ڨ���$+"e��	�y�Ph)$w���"�)'�����k�G[�/ F�(�Ļ��y��%Ԁ��3�]�q����6�_l��K/4�D�^�)i���᧥��a���p�m�� �d��fPt Ƚ9��Ϥ����?mi?u �(�gOh�Gh	���Q�G��p���l��fV�o0i��d����d�u�[^���� Yn�Lg����^j����ǐ�x�fGs��t�A��0�0�]�3�	�9�R�|#��~��v$V�C�qE�y�3�m�^M;jYȺ��-MJ"�� �"0�$}�Zá����o�-~�gO��V��"����[�|c4���
p�|v\_.�CjΟ�+�Dto�iuBW��9�AĂ����j�g�,��Iw �ch��U,�_BLo������g����C��h(��yy��p�l��8*Ny�u�O��y4��r�u뺣������H|zM{t��@�����������            x������ � �           x����N�@Eם��ĸU�~I�fˬ�D��K3$H��ӎ2L&a]U��S��VP5��f
�V��UWt�u�:V�!@W �k��.���1D��U'�5p"NB&11Ww���s74}׷�����O���@q����?��\�����S�?����``Eܔ5�u�x�i�
�pj*0�1�'
ց��i��*�������:#zr����<n-��ao��x�kE�V���%cD���`9�(�+#'�j�}�T��l��bh����۾]���N�-@#�|	�,E/'e"Z�Q���\��K�|����%��1���nf$��1
�[	�N�e��1�@t�\��K�������Ȋ�4G�:_�w�C�h]����8��5=�Zv� �SD��u�|ݾ���o��ons���d�y��V�*���]Y�� �� V:�Xr�z��a�g8f{���C��\7�R��8��7�\UXzk������#��>�5�Kꬆ1�Q0<��Y�L��f�o�ޮV����;�            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x��[�7r.�,��2��u�2.�[�Q���-�Zl����쇼�e5���բ��?$��*T"�i5�gجΪ���"*aZ�y�e�����F|Y���e�2��@��F����/)l����
�V�������_�%
W�]��L*�����_P!%�����_|��x������������m������?�~��|������~�����Do�gK�����_����D(���t��pA~WLo��`ĩ��^	�_ )���R�P�c���w���O�T���*�ʆ�H~����
y�㗝��\�5V9ȯ��8�������$�%���_�F�h��E'�i	�$� �#�V��S����2�
����~A%!L\~��e���-�$̍?�-)�����7��(?N��j�ى��+@�@p\*z��q��K_��Ʃm�B�l$~Y�꣮��lk8�S�A��~%�z�����o�<.�{lQ}�=5�[�5E,-u�_�EuQ~q��Vr%�>��3k�T��|����ܣ!���c)�
n���m�����U���G�.�83��ȭF���^|Mp~ʕ�4*~�X��Dp�z۶�q��x��ʋ�C5�p����+|@��%a�^�)1�>J ��w�%��F���7�F!��m����>�\	�����O -`˅j���D�� mÅ�w��ȏ�K��,l�?�z��~I~ ��q�)��Ϯj��"���� 1~-�Wƭ�{,E|�9w�Sȸ��֫�~U_P;�u^�Jz*?s�E˖�gI<:_4PŢ����G'A:��ju�{�-��#�K��}lxC8ș����[��0 ���ϐ�������0���a_��6/;6���pTx�M�;"8��G�0imZ��
t|R�J�)FDĈ9(jY�P��$���FDFkCD|R�c	B��o�R�u�3�� ͉G � =2�����8Ԡ�Bj}����o7�_m�~������R4��u��*�n�����%�3��it��L��/���h�
�o0c4>��$ �+:�c�s����+?����0v.?�(cs�& �	�-e԰��'Jٹ @S�c��Q�Sp�b�����F
��ve%E�qJ_�0�<������zg�(#b&�=��'�0���#�PnF�Pb�����l1.CG�F�l��Q�U���o�3�oP��#9~|�a	�P}a��c)Ï1 s��(�s(��]M�;v���0MaS��!�C��r/�O�1�[~��	ck���m����r&s���Gbk�A�/5��Jv!��%h�d���kҚ�v�Y㵿���$>`��
�z��\|T,rő0�"�Ќ��(Rp����9�v�S1��w�j�s�N��z�G��[��8?�9�Wse���ă#�X���(��mYR2ǝ�GMˌ����G��f���Ǝ?*��>�D�1+CG��]����%�a)q�;�eP�N�E��U{Q�U�.O�����%S0����9F_�:�o��_w͇͇����~W7�j�p8~,����7w�q��F�}^
͂�8�-ʲd�-�;ו�8Q�d��yB���`�����ɤ�ř�Ш��g���A�Hc��6��LHkǩ�5Q7�0P'�(��F)�┒~Ʌ
������w�m,��v0�r��Pwi�Q����0��CG�����a����n޼���_���_��LS�(��E����z6#���]q�	�櫦>,�霡XF���U6h�L�����)ѣ�v�k���?��G88l�	pX	��`*u�B�N0v29���E(�A��P$P��VC1.��~�(	w������Y���(�Ll�Y�ڬ�~m�P�Y�܏�����%&��&��!g'�բ)��P�o�	5�0��ɜ�1 `�
�n�G+jRJ� ��i��������lq��F7ⳓ��Az��Tx�&�Z$�N��{HV)�⯖^`n��k����T~�&�n�e���GS�}����`@z*�L�_.zo/P~�5ː_+B��ɽ�� Wb*?���^��������(2�7��w�z�)�#��i��!�[��s+��of������cP`����i��E��� ~�W�V�O)D��"�@�����V^���v��V}��Zj≄�]vI@�g���bn��-]⯴��G�@�ecp�o�f|����%v��j8��ӊ��/њ/��)�v�	r�^C�N#zF-�B`"�1`e��|�㱩7o����"]@���9��u��F��P�]�Šؕ�Cz(�v����GFϚCq	��C�j�sD �$����C$����czD�wŗ?��7��[�Q#�����-�z J��\z rkW��03ow7�c�n���������" ��3�x��nl��`�m�V����x�z��7��n^4��l~�����.��sD�2��"��V��~9�&��.��n7˩�g�wb�L%M&#e���N�X )l��7�M���:xq���"��J��JK�cʧ0e�N.ك��%n������x�p�(ɢ�'�2:�Ѷ̠q� �СR��h������?�ݻ����/e(sD�Zgh!7j�'�)�0N�la#H��ͫ����������i%�����f`�ZF0![-4��\ӏ�����]�l~*n~����\�CO�l2\~[ԨPƧZg�	�]^R����D��nA®��UEs�pA��h-�dn���8��$�B��Ki��������h,�q�1fJj�(i}տՁ2阘�*��b�D���y�1&1�����EH_z�[�*-./h�zjhTVJA��{�`�ho0�W����f�����xy��G$\�W3-k���+���.�-'���� ��Kck��[ʥ�K���������K���c)�]�)RG��Ī�_ _���g���avSx�%R�&l�r@(��{,Ezat��նEͺp���4EM�%�]q���t�&��#<̰���rQ��Զ��y���K�SU����XC�-�-���k�r f����2�t;�Se������B����U�fJ|awNc�G���]$�R�������s���V���
��I���$�%(f1zPL�҂3�uP����-�
��N,�)}(F/�X*=�p�Q���C!UNOq�GQ�r�b ���,`�RqBf���0�)�C��8?�a�p��!�uܬW'���GQ(���֭{�����	�@(��P��(N@铒� ��f�'F�.N�����e�dLڶ�Q-�R��g~�U��R�z1�r�ݚxY�(i�"���U���o�B�<��տ�-��!���K�S�E����L�n��q�1�Ӯ����86��������~��%��fS5��^�����Ի��aW7��|���baX��	���ɺc_�����Z�аU�^(����<cs��@��0�����2H 6��vꢵ�����.�P�b�ޝ�@ D1Ze i�9 F3
0`�� ���� � ��5� �श������E'�I��G1�Z;�M��^����2&�	���L�VL�) ��/.�{ �y MKe�	���9�� 0�0��H'I@����F���
��iuv����T�t��>��	 ���Z�$c(%*�A-�f d�Ʌ��N~ D�q�3�2��he�:B1��_ܬ�ħT�ײ�  L�Md�m��RN�4���6�� ����&C|��<j���۟i�J��Fo�P�{��̐�#��K�f:�*M~�j}iC��g۲_�(�" �8b�0!TZ���&��zV�2�@�,�?��3�f�
����@MY�9��L�ϩ	���$�kY��.(�2<��|�|0�ᐡgA(M�`~!=��< ���)���}I�Y�Z��	�4�[' Lˤ�	��qF��	�̀��W�O�oh�38��3˱}$a3�62�����X�t��@�(!�;�4�>���� � ����	�FF�0����    <�i *�N�Z^d� �yT\k�����\���!tۈ��J�U'k4^|�E��JM�7m��X؉�������0��pD�uo!f����-F�w�7@�a3Hc@�~l��^�[ܹ'[��B����ʪ�_����¶������/�=/1�lq?s�`���w���o��]
�UMZR9�mB���f�t��7�zin���va[�1�p�W+�k(���D�?�ǖC8����!���7�0���@$��`��̤0)XѬ�*d� Aη�{ h���) ��&���/[	]�J~�#���!4!�	pxY~�/�/'�
���/�V��!�Z�^~�^���_���Na�	 $�Jf �O�X ��!' t��:A��	�MM�zЄR2�+�g@S�az�A��A~%��{b 2L�Q� F)� �ir���Ȇ����� 0���Y�_Z6 T��1T1v�{e��g�ӆ�/��Nůo�z�є������U���"iғ��s'=���1^[O���k1^��%��}Ҕ��.�/@�]^6$����<��VQ5��KS~��̖����� 4�| �Oj-�	����=�.m
�n�]^�(ۢ� '�����P����~7*��GB��d�?D�9����O�6�T��O�}}a|��Z���Պ�0���J%�ɟ�|�A��
� � L� ��mT 3rF�n; [�F=�P&��(c��)�H�_� ?��w
���I��i
�g`�>�`:̓�]Ȩ��� !�bBE�O*�Eoiva�h��e�>x��x<*>�<�2�4�{���C A�V:C~1o�6߄�3�����o"-�o��"������濠�S�i~�R9���w�Dʜ��?*�!��90�~�쿼�t��?|��*⽇|P��g��_Qc;�FD�.�nu(�] 'Aǚ�����`n��wwl���)�z��� �d��{�T���G���W��?Z-~�'"��>H��@O�y�u�4m�!���$��ŷ�)��o҆ߤ���A~j�ͯ�N�x��;�gf�/��_�����NVQj�>I5bd�x�X|?׮E��t�jXA�{dԡ��s������=�X$�TѮs���Y/>�|��e,�B�9����Y�e��S/����õ�Y�� ��
̌�L~H��P9]wH+?��Z~���A~4_Lg��fg	��g�c L�����4<6��s�HS A�V�- 4��i�p>[?�h4���� Ȅ����\�~�q����v	6~�6�j�ڋς��ggH����S"�\���7�+[6�^~NjȐ_�O�߆S����R��I{V�@�� �a�H��c $�Z����𗿬���6�p¢�a��M �4�iB��T~���A�C����\,M|��zn��╖�i�%ņ�	U5�?-���u4�N]��c�%P���T�E ߔ3���(��)��Y "� 2o����"�Ȥ�oV��e`P��ΐ��8��q�N0�&�X^<��ϔ�H�s�X4 �ڮ�L- m�,/�y * �� D����c�#�4��7]ln��ad۰����r��Lc H��@-� � x��BDB$���P3�f .o �{�Њ2�C�]]�}��F���91�>����(i�S���I� BOs �f�	�(s�1���a���-�"M)���0~%�<�r0��)gE�H�.���/-!��w�x��&-�J��9㦹��Q���������W��N�l�2f��׶1܅k�c	142����jM�n`[)��b��C��SLb4���ɟtM�p���9��p�{�i��M�i� �������r��v��?1z�@��i���%'���SYt�+�_*�m���4�uB��σ�̸�k���m�<����xU���z�	ʣ�m|��]�y�!��� �	i�CB<��T9ʃ�������g��_������gϟ}�v���ͳ~���7�?y}K�g‱���m2&Fr8w�N�������L>�����7A��V�pҨh��)��*MS,��J������cM��R�ز�p�u�3!uL]輪�pw���c����;~p�@э��?�/�R��
k�g�Nx�1/�d���KF� �Ů��n+2�_:C~N�I�� ?��[���&i�Y��)�ߏ?#Df�o�jb��M&���4��+ �]�*� p�O�	�'e�^�٦���+�A|�o�� �h,���=@^���w�]� t P�*��9)���VC�/�J��[ &0(w���- ß�c����(M�|^��AA|�ݏ��_@�~��gC�=i������f��@�֋ύ��/eaS��i�O�r����e�5�L�y]V/�t���F��'�m��4 P-��O�NN*�*I# ��,�� ?E
�0_-�I���|��lZ�"�XlA��g�W�r� "����y�f�>-N�� \����3���Д��� #�[K�UJ��KJ3�0��Pܧ̓�i������D|#�2�z������=g쓦�T,l��ғ`��T������1�SМM@ X^T� ��	@E���}!3�Y��l�Ÿ�?Џdğ�&j�Ƙ���畴��/]ڕ�ɯ��ɠ�N���I��t�>��_JP�^���9�㙲��]����i��ԧOE�r�G�ut��)�g�s��E�e���/(�9ދB\� ߅{�ߴ�j�υy ��X�-����@C��������2r������\��hb/���w�(1�4sJ��"�}q��M��=��ͷ�ۗLj��t��E�eeK����g��lA� RN���>��C���6��>���o�������:w��~_oZ{�M䮔���k���PkAE����~v����&��PÝ/�Г���-������i���>my��n����)����)fV0�il��ٔB�S(*7��������p�y��(�sq�l��u������Ng|�Z�	���+T�m��Q�+×f�W�.\����hmd45/ZC� �T+m����!�?���͍���z������YK��Y,'��
���,�����n���|:�4�zw<^��޲Xt|��Q{5�^!1a.��aaK��D$ly��#�YIY�A$��O����I�Űh�с���V�U?�m�iw��"m��-f��	sG��j��q��)ͦm���<���=�V�-ϠL��ӳ\chlG�)��Sh?���F�}�V="����K�cq��ը��jr
軦��c?�|h�8]���C�v?7���5����{��7UQ�n��-
�;K�g�ˮ/�jS��,�w��Yb���7-��5�_�{U�|8ܢ���_��;|����&rG_��ŅF4�iYv;}k��l�h�Trߧ@:���� w�7�����O7���?��HH���݇��]s9&�%��=���:?�4B����R�`��ھ�{~�H�ކ:�څ�ñ���q�)^�9|�a�f*�2W�F�SM4L><�Ǉ[w}��S��������ǐn�:ws9��G�;xݥ�vJ�6i�X���er��,u��?�1��?��3���1�Y�x�H���u���Y�2��(�"�f����x��_O���<�(D�2�͙��n��e�n�ٚ �4�d5lF"�+�E�|Ma���P�Ǒ��͇��ƙli���rw�Aj�A���U��X� �*HN&)��[*gHN�b �?��y���f��������7�S�R��R�m�r��-� R���Y퐑��s�Ѭ�:4�ջ�U���MS��&��~�o7?��,d��rj���c+�69N�ģ�����z��<�H������w���_��;4�[|���?�[ݏ�S���|߇}�ps����`�돛��C��kV�k�~L��"��h�)�(9��è�e����������N���R���'89+s� A��?{]��[�����"��-�~m>bs�T��'    ;��vJ6�.V�У�r�+�va^�Z�8Й�y��XزW�>|�$as(�_P����k�Q\�e�ؖ��u�����pk�֯V�oE���K{�^�Z\qr��VIC�s	{+��b`����c	���6��'U�ۣ�'���Z�a��	f��z����\dm�G���)��nv�m�i�M|�5��R�Y�9��j2�L�S�0����g挥���i� ���S]�9s&����X~"�9�3���
�SLԐW�QX`A���v��ͻ�[�>~�Uhb7?��]�><�����Q3����Y�D�$t��a@3
�t�5�����q�Z�Ǉ��wE���M��C��J����t�x�t���/�P��뀾1���J􂝮<#��Lm�n�MsS�� 5�������8l�_��]D�p�> 32�3�d�#P� �0��Q(����u�2ܪm��ED�bD�d�RV�E��O��OU��jK �rP��ߛ�k�A0Fғtp
\��)�^�g���ay�dR�?ܺ���Mq<�8a�:�t��}�!u�W�e+��@isa��۫G	�����)P0����(���m�`��� �ĮU�-�*�vs�1/�
���'f�_q)5L�MI�MI//� �q !�?��h͜�4 �پ��� 	k�N~& #!�1��k��l�i��t��J�_�`��0 ��Iv��B195 �f &%���k/S�\g��fm��ٖRC��N0�&�H�&s��? �+�]�?�L�K���������:_�~� � ?-���%O��z���|&?���}ł�4pS�,�r�@�P8�3 < O�rp zhj�` �,� {?��R��"�dJ2c�7A~fx�}6��,�a�'X��;&�_A�s�rQ �@bt~�ӌ��7�_�ζ B���řd��_
��L��/`,��\֭19�n��9p��T�4�s�Kw���_W��V|qf��W��l�� ���a&%i2���8 ��W�{UV0��>�/^ ���Z��c�3x Gx��N@���S���̉��f2ꁹ6Ck7?�i�H�*#y��#���Ђ3! �`���cMA�Ii-f��i2rHa=XT~�ǅN0�&�Z>���&��XN&>��{1N����_���Jv�u�=I�a�����%�*��o���{G_AP��Q8SS�ж��o������N~�t�_�:���cUL`�4�1i�Y�Wv�?Џ�%͑(��?ʯ��i�i��!E�3 ���j���_j�0 ����u`�)� �~�-�׆��5`c�l���a{ܼ�i~��緛����>�hm���ŎQ�=gױN�j{g"�ύ����!\_[��5���b�����8��T��ث�������_��~s��럾��O����g��~���4�	�݌�����)��Zh|v��%l�;;�d��ׯ��Bz���go^\o^~���_.�Z<��A	�I7�%\�	�>�2�I_Q�
�T�Ʌ�P�����o�~�f��7/ڼ~�y���o���]�r��\$E[�YQ��ݫg�1:O��B�+�f��d=�����7��gj�ж�-Nyֶ�tݰ@D�x���3@0����:<_�q?zS��k�8b�K�(@4�!��QƠ�ܬx���?\�}�͛��W��~}������XL�U��	AO"��]C�1�cy����S�,7�h���:8L��tv���JgܦGs���y�{�"�� 7LtO��{�%�O�䆁N���g߾Z����=�A&��`��|-��<`�p������go��r�ݳ���_�|�����"�����<���e��QZKi����u�(�
ۼq�kЯ���6�
.�Z�0�é�p28Mѓ ��uL�	P2L�WϞ�[�+�$�]�G��t�f>���� �ث�%���S��&,x�7/�]���F.��l0�q���/}3��P�&l Ιm@Lf�~rC�M5�(�C}�ۘ��h3DE�b�ǖ/�P[���A�P)3 P1[������r'M@��u TwK��u�`�9;�5�#�p �If�� �Z�K-f=�~��M�W��0
 %Ub:�\8�Z���E��3� �e &fX�$i �r�?���(l5 JHԈmW�a5�������(= THW���ֳ�b� ���) ��,�Ǜ�D� �Q&�B���:�X��l�k'>�ҳ��õ4�᷅�C�w'W��z�e
��Y���>��'4Q��fF�iN̟�Z�a#���s��D�Wo	gDM՟���?·��<�0^W4�@�����<�f@���\,����ʉ���-ٍ���������[�$��Ԭ�!������ܞי�m�"?,eAA~��d����ދOcP�����e�5���,��4���F�Y��ȟ��1A~�_V2G}S��ltޫ�,-��'���>��l3Ɵ�#�k�7d�xZ ��N,�Ϣ�4�2��?��f����@���ӂ��+���u���#a'�sa�3�M��	�����K�A��
'?�{Q�ї��x��J ��'�.�=�ŧa/Jc0AqP�k1����^���ؼ��c���	�d7Z�-f�
g!�4d>+��-���������-�:`�nn>^D�\�ƶ�N�dS����T�z��{;#[|IN�V�+����
��ĕ��J���<����aq�E�d<�*�E�����Tz�(�X�y�IOLᚎ���3Cc �!S,[���#���_��i��
9E@��}s�@�)r� 3����(:C@��£A�y�"��Z��D@���9@:�S+�AMB��?�W�CP�#:A�9��K{?��JD���������Z��ΒN�~������/  `"Ð	U"��v���Dr���AE*+�zC7 ����DC��5H�9 �����NIԟ����~lZh���Ќ'Ӳ)Y�c�D��� �G��d�s�qH���h�^KEHx���)�"�����C'�e�ld��ڴ9�L��&�	sCN��B+��. (Z&]-��)���hT��`lj�41��wi,�= ��&� ��L��$:d�U�?V@2�R<ar�AMg 1&�$�D= �9�`<ʤJ����D�oIp�:  `9 8!Q#��(>%R��~�	Q  K+�j ���F/S#&����g���L �j%�: b~ d�P��=������*��ɽ�(D�j[5K���$��;� '�F%�2� 8ZqD�lm,�sH&��2��'��D��������'6�lc	+�b(�p�U�]Q�d~ū�d #W�\	�m؉�_`�
g��Rl�b����+L@xnq!�˭��_k��B�Z�ulw���  �L�B�`���l�`��U���H���+���\E 8�b@�4 ���K[!' D+2t��C����4�%���b9Q@`<-�kN��'�l��>���Dtq3�C ]頵c^�;�=ce��M���8�ت�P wg�j |��~@0�_O�� �R=B  ��u�^��] �/Nfl#����Cz��=� ��-��$m�HwB32�8�����%�"f�� �傸(:סD*�Uu�
K; |���S�iqԊ��b6$q�r�
 А� �H�|uhp�>sf<_�?CPh��@-WQ3�a�,�Ht�.l9BHW0V�w�`6����z:2Q�$Y>�?C *�2�H�.j �=�p��`Ɖ |iڲ�][oˤM�כ����Q+�e_0'�ja֩��V��A5�(���~�2��D�|�����;�*�؀s.M���1��y!���!R���*���A"�
�e"���͈�@+ɣT�m˺�@bD��/ș!��� e���`�4�����%XA�f�㌨Z������L����r_v� |c�+�$�rJ�@��*�+ 
����*�V�8n=�㉾��)'�����a�&#    �̞%�Lm�'Z�/L0�.�ᵨK�NXj@�x�F�řhh����{�e~hê�e�6��? � ��R�������1��K{$%���fC����%"XZ��0�$9s�����R}���$X
I A���\�*s�[ (J��*��R,�t���E`��#0�O�ȮO$!XZ��H�7�̰��3j��'X����,-��02 #O�z��s��/���� �lE��O����^2��`i�w@�.ݡ��S��m�G0�0�N�DK��Xےb�Gv��_? $��Ŵ����W@N�y��
�=�hz����J� pe��:G~{i(:��D_��H�#P��1�]c��������$���=�A�e8\�^��(��P`LO�}�bf�#觀J�~
�1�D�Tٺ��+�,ї-�T�W@��π0Z���-#r8=�KtK�Mg �R� �G��=��|  � R�@pe�쮀\@�iU{ �1/��Pb8��a6 Yi[O��!��c �5����ʖR�@�d�_�@4+C�-�\��li}��?�(����J�:SE�G'!�Ԅy�XZ��@H�ׇB6:Y��({놚H�K+� (�j}R)ק�= �3NF���C(d+�r�_+NgnX$r��.��@RY�@h�O��������-m5 �;7MIe��T8G�H��b �B��7Ư(�blK�e�CF����M��ix.�X�2�k�+L��b���P'^��m�`�� ��2	 ]���/���o�*K~f 2@sҟ��D � xP!NM {��I T�1ڎy�H��p�o�Yݭ�Z�q����#:Ķ�:�8l�������&Èm[t8lH�;�0�*����B��e�
	zzʵ���WS :@���sJ�S�kp�QF��D	W�vd  �k�� S��8 ��@��^0�@&
 m�5d  ��f   � $H� ��a
�9V@��A@����`��L$"IG�,�@w���2��IJ�#PRΝqb4��-�
� L Pj���ʐӅ��BgS��ec �2m 	<M����iS+ �L�5-�
�e�#���*�� ���DW��-���P��Ӓ��u� �FWF�T�D?@�o"��� ��6�F1j9�e
�(6��%�Y�,3 p�4ch�XT�#5�ѱ����c������ly6�\�#7b� � �1jWU�K�#�?8������h����M{��6w7�cqww���ԛ�����~_~�ؗvus�y���ݦjv7�۟��5�7�_������<��eS�l?��Ϭ�c����n���o�Cӌ�n{~,�́���owǛ��������<�P
��D����ۿN��8sI5y���$l�0�����1J����V���o��o:�f��N>:<�2�9�c�o�⇏���M��'�	�����L���<EfX�D��[}������n�\����`������/�����]��Eqt��5pkd�n����؇��Ms��y�wz�SvF�����oޣ���v���7/짵/1\DF1�&��#Z�ֲ5����_��k����w�.iA?>?��/��_7hG�U�a+������a���_P�w����^4��aw�~���~�`�_^?�4�����L_4�7uS��;{��捵Ο����ݼ����Iy�_]����X���{��b
��v�ב�����)���h{�����=��p(v�]7��������~�	���;��|8w����7?�v��¥���{Ӻk����(�U�j6t�s��܍�&WL۞\�޹��mu��Q+��C{��1�_��͏/��d���7��nn��3�%��/�Ԁ�s�������C��@�E!3~��p��[%x�uq��v�zݶ��q��ó��;T)�gOwfʷ��/�)!jd��ń=�^x~hPU=��@54F��]��P^7��'��L~�u��WS�_^���`B�b�(6�\ـ�j(��԰A��ܠz7��Me���J�����>7��q:��]�����!�
��,W`���JA� P9@�l�4 �p�w���a ���c �9no>n�M�|p/��6��N'��?���TGk.O����z�.|����K��t4�l\�5�!�D0����P�p���o_?������}�9�7?��t�/��F(�6���ww�m<�@�9�?�\�秛���7�X�kj���B���ݱ�y������6/���O�$�b9b7x��"�'u�s��Q&jK�)���	4x�rPs.���r��� ��i=/����;�^25�������ꦸ����T����;T�{ϋ[�;�_��m�������כ����q�L����������
g!ܳz_6����=j����滢���>9�ub��] 限��NW�9TA1r_�G�����5�b�F� ӣJ>������������B����%�$�K�vE��5h2h<�Q��3��
�x���gw������yh���}�����ooЧ�>t|��l��Ms[7�ȹؓ��=�9l��������;j~о+~� �jn��ŝ��ۏw�_���?��wV4�?�\J�(��������i��5�uS7�gcT��xn�����p��&A3~��hf3/��F�u�?y�/��گ:4��M���x�Cs�a���1����Y��o-�z�d�Lm�����T��R��j<��_�ưjP>��\��?��E2�˫�s�m�eF�@�&�Q%gdo�/+��!���8I	�	���+]�T>�n� 7/S<����;6��Mqs�?�/�Y޴��{A������e4���n�#F!Dq����V��;�6o������O.�*�6�*|6��~G,oA�	16iJ�k�p�[*�1r:"��=��ad��_��?O��E�tq��0"��L
,a������5/�qbm�pka��ý]��f2�w�뇂,��Ά�qE�/�b~ET$�¡�0�����h�_4Ǣz�ԛ?�Ń{�l���n�!��zSTUsw,�n[*��,�����$���w���.�	7�		���I4����r�� LFD���ga��9��t�v�^�C�<b(p�e]�d�; �1@j6H���i�������o�C���cs�H'��O[�;a�����?��H̕�c��s[���w�����5�^ܶ��6%q�"�؞�֡���y��r���4��#��]q�5L23$��;Q�����!��\�9��YRq���{=uNW�m��Y���C[�n߁��K�|8���2]#�Iac�]��$�0v�j1[��Ӡ
��|薞k�K�Ɛ���]qpgG�r` ����O��jZ��0`X$��BM���j\�Ce���|a���~�}��l��l�[b�5��-/��w��?��	�5��%�1&�ԙ�j?D����Dc��w��{mt�#���5�U����]��5�8�l�W�ه�6"����U6 Ӷæ��_����r�Tr��7�{=��n�g�>>ܺ��~���ۏ�o��\�1&�q�����N��u�\R�����jal�[����1�����O������Ce�n�� ���"P�t4��/�FB%�qE��N׵����}�=b�%4���9]Q���m7�����e+<B�f�>޵�D��ǳ��R%���*!~���\���岇�~ۿbX!�{��a��A�(���=	�㱧���ӔC��F�$��C��ʨu��M�F1�S^�������?�:�f����-ӂ�A0�0D�a����;���R��e@�Ff �!�Kɴ�P� ��l� t�;���;5� WR�-�`Kd)L  m&�	wF:�cYD�a�;��:��z ��m���ciX½��٭)Xue�+���3��;E �`��[����C 5)!c
��9C� 9��(�X��f\�ڝ�Z�
�!io��    �xJ�U� �Pi�,2�@ʓ��M���P)�$ܿ>G Y�A���&:���" ��a	�
\Z�E�7��s��`S.M�f4�
y�@6�����l���C�F/Y�%ӄ+�=�4��{���g�ѡe��,�Ki�-�s��rpq��0B���rM�"�p�|�@���(�ʱ�uD��6Zϴ(1(
���1#��`S�(�p�/�RNٔ&�t�"y ��a5k2 u��JNC
����U��&!.խ�9��9YJ�f1M�t�&y/~�ؔu�a�(�������J3KlLb^�|�� /L�0q{��ԗ�ļ�,������F593��-G ���o
 ������ *����T47v�l� Y������Tgd��ˈ��Lf�qb0�tl( 0"�s%������`y��bf��,�K4�p�zɊ)�n/�BTEQ��R�Zy��% �) D��v_ஹal���ʎGƑ������vq�U�E+ ��z���?|m��7__�����i!$����bWڟ�k�ȹ�0peָ�T��0�3őᣆ��g=j�$���W(��uw�n���=��?��wU*�{��tJ�+��D� �q����їEBw��֡���=J������GJ3���l.���W��"�^��Ut�"��^�3*:��Ʈ�1$c��/Tt�{6Z��*:��Μ�7�îr{V�A�%]ڣ���eW�a0�ac�O��P�����q�@5rR�IU�\(���+����V+��l�QCOR�@��n�l[�n]z���sa]��>|���Y2��sއe޷)��?������D�����}����~��$�3���+e���݆���NF�'�=�����q�Hu���Ȧ�:��r�\���0	�9���c\�u�q���q�N)��G�R��rm4h)R�Y�(RJʧ�)��7�<E�9	S(���T(>sbb����'�]<��?��d 7&��k��Iw���P/�{E��X"��j=��O��L^��|ϟO��>��\g>���EUu��+)��#�=Ej�92L(R�4���/�L[����?'�:����=�#�oB�T���̑+�A7?/)>s�#��11ȑ�ˑ��H�bw��ST�;I����z�X%b����r��Vk��*N��s�}�84w~��l�����ܽkn7op�ӻ0�:�(�V�5�m����~S���R��Q�W�\q�D�8&v�ha���w{����~ ��Z���{��-G�%�uWش�RIN�+;_H�h5ӒL�J"�s}q���T~���K�[��筱O~k�l��
����F>���Os��u\Fgl�	CHdi�rP��q�N��u_��������������|2��%�O0�����'���\<��~-�n���b��ɉݞ�$�N�?��WS���kp�)��v�^]e{�&��~������*~�"���{���a�"��H]�]ߒ�a� '}Kz��(����Y�����!9�d�Ʈ��ڨ���d|^-�S����w{�����k�3��bA�*�蔫>��-�Ƃ2�.JG�=�I�d��>a���@v���X���n�?9���͹�Հ���1��[�ۤ������|k���*C')\���I�t��kd���M�G?��wmo�p~��n�j���'Π�T[���>-�u1J ����>rŁ��`�0������r~C����+1=B!�D$�.>��vzJ8��1�T��'����-,����	��?1?h�N�6gO����@����=1�X'Lh-�V-�7�ӣ	\�5F�����uK1?�4�F|�9�����]{�K��:Z�$cr��f�X�)'c�s��n�:��ru�М��C�����ܓ��\��SX7�/[Xb��g�������$ca)�EڟЭ��^�t�_$n�W���W�Se>f���V��f�*A��u���O�'�}^םQ��J�ֳ��듛<=ձ-
F�\�v��:?��Я?���))�����歧7?�/��\�9eE��^�;+�rNk<���q%�n��ĭ>�x>�VN�����[)rR����Ʀ�!�pi�c!,8���%�����M,t���q�o\J1�{n��������^�ے�+��,���7�Pt�����U�5����c��!�Y�>��J�/�����1�q�r��=������~'��LJc�U��LjR��3�}��oKIӒ�H���^=�iN��l�r��=7ܜ�I���*'RcW��!5�{V,�'�����
�y�j��
���&��f{U���ztQ��Y@'�@�����7p��xX����aah*�_���VjL`��ȡ�N��
B+�K�\�\�b�.-���q�D\�V#��˄�0�n�5\��jhq)`�Lq%^�a`���%I�u͊���.g7�.� D
3�Eq��z�,\��/*Ǿ�]�>����ȳ��D\��4�w⢲ȱ/"i�Bt�V0��,����x
�u�*��n���$�"�[
2`1`)I2��8x��E��	.m�pi3j-��+�!oe�C�Å����R��ԨMD.a��, ��Ũ��҉��_O�Yц��?�Ș.��pi�gцN�6�uu��%z5I��4��FQ9ub��Ũs���E�6�����H�f�*1����47���YC�e��X9��@��eb:�'�-�\���uօ9?�".�<�l�T"ɫљ�X:Lmx�t�mECCI� �PC'�d=�s�`e�lqP*������҉�f�S��q��$�b&g���b�1.̔g�N����b�0]���L9��Z�KV���RC��IRF`ȸ�"�,e��Ŋ�Y�����T͈���q����`%:d_Y��	�5�69�PT��1��3%L�\���ٰ��eɻ����0���C�F+)gg�ib9§�*�	PR�:����@tFM�����lt���@�
�,�ʜs��^�Pl��9D,9r��A.��Fk�9�"M��V�ɱ��&�0�������	۽������?9�ڷkc8�r!]��Ҿ]��������};�	���H��0�aB�餚*Hby �~��q�k
#�*j���
5#�3�%���Q�c!�_@	��0y�'z�Z��:D�tHY�=r�4�hy�4��#�[��z@����p2ⱀ��N+�3���Pom�K�y��C��#!W}�'0����T�v����>En��a摠k��atX1��
��N�n0���!�� 7$���R��NOϹ�C�'3ng���̰�7lm�#$�P��f��d<`�}��X@�n0=l�=:��R9�)��?���Y6�����ǂ.t��3�_X�;����e�2���
n��&'$�D�~i�_ �@��S=,�>t|�(��*}z�G����j����~�������߮mG���,�KTw*����Λ�Z��:�/�V=p��K3ew�����O>=
r���@0��}�ud�U��3s����>{k��W�\���B�N9:P"
�{n�62a�Lp�u8ޡj�r�W��QY/��c�u��D �_�Z@ڴ9�O��!
�O�D��t��Mk ����B: |��x��
&�@��N�2 C�3BZUr= a/t�!0v�[L�D���[@ L@P6�d @��B�J$!��wd @e ��+> ��Q���&�}|�
@��ʇ� �9�7wfL��1n
 ь%�S�% ��tCH��Λ�G@��+�����q��X+:=Ӆ7 @3+:�Ju_J���wǼ�v^V:sv�#В���@��eL�EEAs���g2C3�S&��s�TR�&��>��w0䒳��	a�E ��ɺ̊���w� |�2��D.��ݒ\f��݅���~9~ ��D��lI~���d�c.��ʏ�35cH$"�aq@��DU�83ε�F��8�!HL@�������Y�.��� #8��p�%�(��M� @B693`�@9@l�    �n�w 1�[/� tY� `<Ƣ�Fb�A�I��g� KF�?��-�1�Q��s�� ;@ �@S����!�G, �7j|s��+1�4��
%39 �*��@E�, ы�1�0!Bb/@5nN�I��[��5�a��#x_=tI~��5������0�@�Pn�*H@_�uimK��.)n+E)w�y& (u��8q,�K���+�C�e���Ԟ����@Q1��sq(����l���'u�|�Z����g���P'�LD ��3
�B~�� �bfXH�� �B2���@Ps�!?z� `�� �D z!#>@� *D�9	�:�%�RΦ��D����� ?� ȶ,!Ä���Be��MD@X����&���~�G�����Dl�F=���
�E ���H@���!��$#�����m2� =��5 @WI�� ��)|yC<!p������(7�"~�j�?ї��eW֋�R�s�g&nƂ*`�	H$R_=����_��b ��9M �Q)���%�b_	�� �Vk���D(�T�OY�%:b&.g�g��Ƭ�cVz)tt�꿞�D py=b  <������ȯ0��`NL�Otľ�j��^���[/�V��� �O����D�U��*�Z�fY�'���-���d(�iP��G��"��e�3�EB9�E"��	`�N8FY��� H�c�ϛ 0��\@b$�-r������s����)*}�皾��2F�
 �oq�2����U2t�c�m��l�DD~��r���'��� M]��`4�d� l?���	]Z� � @j� d � ��3͆V�����)��[K���#�M�4�@�cc�)��+��IF����(@�J��!�J)1�)�l�3��8f�֣C��@�X��fN�#0�{�+	�X.4��p��ل�D$��*��(�J�8�X-aVC�a�o��'@c:3�"��D��rɓG��!3�۬5d��s��fJD�!��c3�yS�2c�`2J�����ZM��\g`h��`l��Xgfۭ� ��c���L%:3��=3�P��ф�!���œ	��x�ݍn`!q`���D�h���ך�Tq_&��D$��M� Ze ��y��X��Sur�D����L~at��E�
�",�*�r��/։*��k�:=�
#�#քG#R�ô�q�!��7�=  ����6����(g!u�+��w�;  P�2hTSͣI����� ��u3 ��l�#�F`O�D���E�41��g.�]vD0`r̘5cC�d��&�����E�3d��3�����h(�������D��T<�����/H�&����A  Dk�Q�D�D_f̀B�J���Y�X���.m8Qt�X�N�:�Qw{N$�eD,-ʭg��*#'P@�!cHJ)ƫ3o�� |_� ��㬫��%�Hm[�@��Q�SPjC�"#[����ߪ+dC��F�L$�q�m�+�.�w��?������p�a��[��g��<9��_\uŘ�o쟿��a���&@~T�8��Q��+U�g��h9nI՞[̣�`�7��i?��l�*�jee�D�Um�f���k�����y$e�8�2P@��A�����;͇5�N	E�����PY�c�YEY�0+�4�62*����u��H�*sT!�jQ�Mɵ�������R0,�v������>���z�QU~T��Eƨ�OO�G2�βY"�z�=����Z��w%%�<J�TK�0�[pMV���/����������2GY���a��)�jk��5�x�*�ck�W-7�`n��*B#1���F�u�NI��I��#�G���amD��F��O9 c/>�V����v2��J����28�� B�1�Q��Q]���� 	�֚U9��� �IlE�&C�u3%�Wf��������jl�գ*$@�X�d��$�ꨥ�.���y�(E�r>�L��m�`fK,i����)�x<w%�+Z��*$�X�0]8Yb!ZPS0�0j�G�~���*#f�-�"���0t:�i�����n�U����B�,�
� �rDj=�,2jT��V��,����V��l�̚�z��H��xi�xTk^g8, ��{`�T3fM������*T�e��a�|& ��s�،X�20Co�?�z��<,�45�9[�It- �7c��X� ���ǣ�G
��V�.F��@ۊ�L��1
��6��*kڶ`(`|�]AЏ1���B0֝q��ZK��@����rJ���+����8<�
�#��rG;
hA�P�`��k!9��������G�WnX��W�� y�X�/��ć�_@G�%H��[-�Yb�C3j4�R2{���l|X�s�W�~�U�}�1��j�=��
��O��*tNA�DP���|�.FP\�,P��(�9p=�*��J��KC%z4�$
8��t����t"*}~�?	��a�hS�f=*�t�2��K�3T��R
*���{���k���T�ҁ+n��������ꦸg)Dt���G^|����}���ḻ?�ž����es����O�I��Cឲ_4��Ön�fc�w��8��6�������������Ծph� =IR��06D��Sl�D�yE\u]��J���Uq�ms���b�N�?�['��B�|�X�z�ppr@2���n�ph��//�ݽw/��>���on��a��m��f�1n��k�������쌼n���x]�k��+~z�;6_7�m��ݷ���?�o^����g�
�US4�P XY����@]����/k����������7
vhj?)/۵�~��n5!g���ٯ�����mr$7�E?��
�|���)�	 �a١]��^I;�u�E��{�{�L��=���ƪb�
D�lV7GR{ܬ�L �|�'hh��˷�������+<����ǟ����&������O����>�0�
�r�~�?���f��]+���~�C������?��TR�ro���ŗ��������/�_~�����;�����{�mOlPZ>j����:b~���'[w+�o}r[��~����ŧo���<l�ߧ_ߣ�����>��#�v�|'���jm��S&�T����. B�a����������N@����5Ȋ<m��"T���":(TXU�{�}c�� \�]��}?���L� 1{�.ǧ+�1��+[I��>U�D
� ���l|=�����M��
);J�|1��5F ��K���`����K �ޢqdf�u+�/�� �1��2���Y�		�Ձ�SR	?0����l�C%�=TS	�O�F%��T����2�JP����Jlvfm6dh��B��f�^iY�-�JT[�*A�P.�J MS	�������ף��h:��A(�J�m3��H������ �"@He�J@hWX��1Vȝ��fKj-`X[tw�BA��
ǀ�vd�͂A�$9�d&�;?$0!�k�b?�� �� ԶîAH���τDݘP�	i!79�|���3l|���|W�p�N�j+ܘP�����AH�J�������J�}�e	E��k�DIDg�AR�cL$B�8� qZp	�1�����؜�%��>M@�l��9���0��9Xel{�K(��9l�4�A��������t@-��B� �_Z��\n���0����ir�ۂ�\,��p3��T:�Z���8!cX��!\b?�D�� ��w��h�F���GK�i��ٕ@�ݷ���LDJ3ѭ�Y��b�ϳ^FB?F��<����`#���p��� 0<X)A�\�R��!k9!��΀���t�Q�8]� 3����R�
�ͺ�	�u��ш*�zX�^ � f(`)@� �|]C aP ��y�U5ⶔ��	o�[L	�vf�F$��	0R��A�=	��� �����4���Ș*���+hr� �N�f�aP��HT���~Ι��9ko���B�o��C��qǗ7�    5�^S���p��q{K��R	5���P�m�!��$D3�X�������%ҕ{B}:8�b|�pgtPȩn��ns���A�N�hk�oOC!}
�)�ts-�Q���q-�F�	��
���Vhc�����7���879�5��8��.�L���,�m�.�4Fl�]�1�r���Y(����:{�1�-���PǙpԡ̀��q`����֝Δ��25�)�a�I�s ki� ��<�D��6W�l��?lU��*~���3��VnAo7;]l���*SX�r��X(�V[�V�3�Ab#MJ��&XuȆt߭���DA���_�[�
rߒt����5�-nD��e�kcw��Uv��q�V���z�DYsEJ�2�ҡw?<F����&ud��j1Y�C8:8�"#��/Ǿ�"�34?��x�V�)�d����{C�`���?�~�F���P	��Ӑ0��@��:!��ِ�l�N�$�Pr]��D�fyO	`l���s[
�u�����e�W:��)?u�u� :c�XU�X�����^�^}���|xx���<����Z�6�?�V->?�~����G�������ՙ@J��\$HlG�t+�kc��+�|1�i��`����տ�t7դ�D�����Ь�zW�	2�=��v"zڐ9�s�ݳz-���7���/�v�L����xr�~�Y������I���>�%���{��v:���� �4I,��.*�-�@���{X4N�'����6��*v�ɷ����*��Av��z�t��
7���N��GhlB*Bi� D�#a�W�6-�xK�(_a�~��)A&�����ȯ#@�|n����i#�h|��S�(���J�a9^�}�"��`O��F���w_���"}�������{����/��:���d��}���W�[�Y�$ġ��+��j�P2��<�4��sxU�?6?I\#X�ӟF�d�c��rv�3�����1�G(7H� D�F�~���/ǯ�ϛO��u�f�F���%q��0���~\�w�y���L^����nu� `����I�ɆRH{t ΄'��>$��бIZ��Bf����LS;���������P�G�D��0po_%�������VZ��Y�����^�z09t�g�d�M���c�m$h/��:�Y섿$�V�6H"Gw��<L�Q`�����y�����˪Y7j�[��B�qO�Β��6��6G��M��ₚ&aE$�g�<�s�֚�]�W��T�:�?��oi�hـ�Y� ���t^���� �#5]O�<bʕ��S54���F��ojk!tJ�ڨ��֑�Z9�7��E��Ҵ%:6b�7��,M;��s�;r����Y4	{Z^V��hz��)���7��\ZF��<rV�si�`l���n�c
� S�E?�4("5-��r՚f�����ר��E+��bm-�Sd���H�G��j����Sԛ�Vuo����[#�49+�z�G?.�p�^+����X��[�WW�-M� ~d
�Y\3�I� �	Xid���4@�"i�,����9	�B{�=Ak�	�/S�#�e�EҴI-�]�)I8��*iaA�U@d�l�O���*����P�vV�~e*�����Y�M�Ɍ��T'P�>�ȏ���aӳ��T��&�>�}��dݮ�C��T"+�� �g+�� �h{���r��%�)�8��X�F�����u[�V�>m������O?Mfc�l/|��A�R���IEK88�MV���YȾ(r/ʿrO|�ɪ�??�����t2��(��s�ʩ��gie�J,���5U_�J�6s�W����զ�a�b[�Y'NM�I�\j�ߎҷf��P�H؎�����f;j��h��)'�i?�z"�`LHnԶ�:A��Wc#�Ӆ����^�/���W}�l~\(V����}�����/����u+��]=����j����߻��Mꠝ�6�)M���ap�
�1������3�z�Nzߗ�ۇշ&E��wT#K�� 7� *�����^z��Xݲ�,���?�C��?�ޗ�r����I��!����J��sƎ����_�����G��(��;O���iı�γ��LG�Pb��Lw7D�)��iY���e��B,�N���N���-�( ��!��L:�f��f/�?�v�=��//�Ϗ^�?�Z?�u�D�-'�4�P�)����Zȍ�SB���]t�Fv,�;��ЙٲsB=0FK��Y�������<YeK�`%  ��I�\� R��� "R c�u�і���|䎮�B�� �urV��Z �n9E �-�3�lg�M�b2R �t{�v����H��^��"R�?~"`� <_ERK ��V�	K����kV����C�K�c�K��xXo�*�#�_h
�����Q� U0���!c+ȑ{�X�~�����}	��̨=�f{=��0��{=)@` �ȁ �{���:]ғ ,l6�ъ�j;���C~ZC�&��s�RE�c�+��1 ��w�c=�$ѿ
d$�Co�j�n�f�vy�e��{ �@j#�����H,��*6a�����*	Lf��v�=��{����Ē�H9󨽍y�S�T�Cgxs
�[��/���kP������Q��p��������C����HBW�J�1� � u��`1 �.>qp���s�uC<wI9θ	cmY���$tuE�T��F����������ڻ�-k�r�[#r�qܳ� ��)�q�cLB<�	"a�.m��Hkl���X��@2��1R�6$#ِ��Y�Ŗ.�)��j�XwVӿt7��&�H6T����[	�*�6J$� )�0j���ӻ�|�HF]u�:_74�*r��%�b֕7 ��r�B�{�n�;���T�9�Zֽ����Q��H&��D$�㐧f�64t����1��T�dB�#�jH�!r��p3��	P�O7wpx[��m%��w���}�����7^���;g�e�)��������>������7�����������Wx������O_>l�_��1*xS}���������O��}���{�>�������7��~�����╣�3v������w֬�փ��0����w����{z�l�`�e� �@fFP&v�zP����Pe:��;�=�T_�МSC�pj ����#����8�^�	d�0�E�����0�P`�Q�	�AZa5�#��G���5���4�.�P�"c�T-�����np}N�������]a�5UՅ�
`��QCU7Wݙ[���
�(� �8�y�;s���vp�Ks��r�I�h,��y-Ⱦ�|o�f38�,Sh
�.T�j�W��7:�f�ػ)������sj0ܪA;JP��CI�jp��r=^X8��y54V���"A���z��g8U0�sa��{�Q�v&Y��5��B)��7�+�=U���V;�)�+��:}5�@�����/i��T�Y$#Z��b�0C��jp�|�¦��A�d��.��7&LWF�aӠ��T�G�J�,�V����
�]/==���������i��A��i"Y��E-�	lڝ,v�(#�9�ÀO�i&��*�I��ۍ	���ϱĀI��K��'G��]�a���o�9��!���5K=�^$L Q �}Pn?�sX.9ml{54Z���E�a�e��tJpD��m�C
�d��t��H�贾��`;�*�	T��Ƭ@0y��E��ڄ�^�DX1�rv7�h���B�[V�� 2�4{y�������Oe���9s�E�>i)�w(���8�@�ic��A�f�n�Ul�y�bW�r5��+i� ˮ�@��#[}����j�;���oSG�_J���V��m@o�Ư������_��n�K��/�������V�Է��/M&;^~S���~�;����a�p�L�נ!�(��wzX��Z�*���Rgb���j��u?t�mf���dk0����m5^�C:�V73=2mR?̧�U���#=.��}q���{TF�Dm���|�'�    ��j�b4�RgeK��^����}�Lo��_��֖��w�|����Na�~(���͜��
��\��[�����)��hLI�|�f���eY�@qP�VŮ8��O#�"�Hk���XBLY<E��W���a,��(�-f��.�F�G��
FH��k�D�f��h��� q� -t;(C\��(� ��6��<G���!�=���=*K�#@�.�)�������L� !~Z � �]�	@�ҍN4�G M�N�"��I��(��L9H
h�fF�N�e	,	@�z��@20{@�V"�$>	~^B��x��y�@`��GcP�zcTN�9�ܻ#ӧ������E���2�
��"��4�2�#�:�FJh��l��!Ȳ�� uG���J9P��Z���Z���B������^�S0"�1)�/���
�<!��	p��f%���2+L}u�2.�d[����HO�d��R��{8Z��s�D��'3�,je�^��M�>v]n:}H@��� ��c�>M���G���cWR�����!3��⒰Oʅ�u<E�3�p���)�ic,6h��ɤ�f�q�9��	�R�l$ٶ �u����4�
g�p�g��A�����$@�4v"<jV�x��΁�
	�H,�.���R=B���e�����!ӎ�y�x��9�̏���Q�����Eg���OH�ꥼL�\��UU��ީ��y]�.�H��}��|G�<d��F[l����%�[4�=p�ZW?4\`��������>8;�G�	y'�@��-!��c�|o5_��(�nrJP,�	*Yh3P��T����KTp�b�dR�/�B�+�"��u>Ūs*V7��(l1$
$��LX]����8z���Շѵ,�����ss�Ʉ]���$b�����z��'H,ԙ�r2�=/�č���	Y� `9=�S���>Ef���_}R�ϯ�#?��c���P.�E��*4���4��^�Sd��ټ��1��I�c�"/�+�۝o~�R4���I�a���4��2���s}�ƅ�������ϗ��SO{ʏW_���J��A�[�q��~���>T_��eOd1S�������ᯟa�_;��@�տ�+ѱ�)$��2Z-���b]	����x<�#g���F����7@ ���)3Ga���������ˉs:\�`fA��/�,�Cg�Yҙ�q�1�0s�O��L���r��N8ZjXN�dD�[6uzٖg&.W��*�\�ْ0z_���Ukफ़-�UUͰrg��ΠO8[\�(K�RD���X�{�:[�e�-%G��g����l\�Wt�j��l������k<m�W�iNm7����H�;�Bn�8��{�:m�P��m������������2zꩳ�`sUT~p��{��Y�pG\W����I�-
[1r��N]WG�:g��+6��������_������u�C������&�+h?Q
b���6��;�LFK+ʯO9��f�Y�B�A�v�`�!
����24 ���݁��`��]	ớH�)?�e?��X��/�Z
���f S�a�g�W_���?���w_}��7����}߷ă�Y̕�����Çg���=;��H�Ȍ����S�7���H���>8}�o9o^�~��G����#x�<�5���9�yO��}�FYb�(��n&�h2���P�[ �'\��[I��"D�d};ѩ[��P�������ǋXЎ�9�(��d�}׿��oL= r,�e������,Ԫ�Ծ�:-mHA�JM&{��{Fx�b\�t���zO�y��Lh�ט
�� �&#u�:#g���J	Ge�ͤ�W� FFܛ)���;鉲���smp��d*��V%��O�p����b��m=u����)Y�J�DֵP��a"c뮋~yV9!;&������s��:؁�Ĝeg��&aЭ�4i�M���&�P�l ���U�uF�B��]�BY�3�D\-�3�%A����_������w.\�����Z��H�Rg��fdi���=���ڱ�fm/Y�u��fl� �I:Y���FaY<ZT{R)�ԯ�&T\��`�_�F q�~#�Wpߴy��+N�� �BcH��Xf�+"{6y6��9��������U>��J�ˑ��}�ͳ)����D��R�m�M)�`r�8:�qP�ٿ*ž���Z�������;�)rx
�,r��S�n'a WZ��� LϷL	�p2$](��JQq����c]�}s+1	Gu'��k��̟�6���f�� Z�p�eN�YR��.2��T�Gv9���zpGLe�T��2���9Z����A+�jh��aԕ6�D8�X�/�S�A�E�װI@#򹙡^�Z��Р�a~X7�M�r��E5A���~�p�4rw~,���vf�@ۋ���6���?�}�/=�< ���X;*o�-åu�d_��B>C��$ءp�_ROd�JԿ稞ȳ���=3e���5m���j�@�B%��`ߣo"=�f?�o�}nbP"��Ҭ]���\�
����������)��R�t�n�F'(��h3�Xά//��Xq�e�f��K�x�[D)"n3��	��P�
pwチ~DvG��;��o�����@�b���Y֜:���f�Na�Ћ��i7Ix,t��>��"��LKv���OdTIx�<��y�N��D���X�Ƅ��'5?Ǔ�@�yz�yB�s�P�����F$�"c�v<�"c-5P~��y�n%��gj�D��>�q�Q,��8�i�Q�;a�F��s6n� |�H^�oKW��[�;(��M�av�\oske�~%���aC?m�?N���;k��r[�pJC��GI�_d��J�\���@8㨚$�@�V/�Pf���J`3ߚ��0*N ��MF���؄�1���Q���_�D
�����`+%��Z���l���1)@k��
�P�������g(�c�F�y�5's�Z�LY�2��ܹ�� &���+�d�g����kNy�g���`���#f��;_/y�ad���3H����h?Z3R ś@bh����V��@����{���Q 	�ǡ]p�v'l A��*ƈ�Ps �0ۄpB��1*)uO ���~4�Q.sN8
-�pZ!����}�F� >��I�Bz0ؠ��@h�`Z�����BY�a�=
9���W���A�M����A�U:��dL��c����x��<e�:����) �4�9�5Kگ G�@[62)��V6�6*�Kb�>�����e,'f�&l��U�m7��� )� D�f9��"�(�gʆ$P��v-�0��)� YZc���K`#�PӺv�	54k`�:O8��ڀ1�$ 36��6��'��R�oO$�#�	T� �Zh�>��SP���Ǡ�@r���H��$��0q�.��ޑ�����b%Pk�)�� X���uOX9���jjKk�,�nj����H��U�αR���
��*�u��u��'n]mO�ՖK��hg@�-���� ��a�s�ͫݏ ���{e�u��?U��%�m�.��e�mI�@�� �!���,�/?=�/æo�P�U|��p��0����?}���(�pTG3��d�~���we+�C��0�|n�(1��{w0~�ڝ���W�ΖY�#�����s��n�}�1o�� Xⷬ1n����Ǹª8�Q�)q|�� �����y��S�a �/n `�����O�>��p������Q��S� �T&��2����e3G�}ov��]���K|���)�c���_�m�r�~rg9KSP����k�$��ҠB�d��D�a�"a�Zoe�K4MN�p�J�8.��f�J.�Fp	�s���\RK��jq��K�x�pj�N���N\rg9��"��K��	�V,;I�%�`$.�`���K֌U]��įzX�ѥc`�Z�s�%1Kby����$,9��
��@��hXez%}Xr�b��`	m,�$Þ�-�AI��^�]����"}�>(��    X-}EK��j���O:l��)S�.��(�SkE��η ��I��r�	Ҽ�U�Ñ�ă�g�&g7������(��:=e�W������=�*��I\��v[����F���#������-��s��S��L�t<!�e��9ƫO��-���|����<c�(-Oc��/���`a��b`>��XO�h��P, ���B��D"ҩ#����[O3�����z���zJ��N�VnL�a*��U����@��Ԅ�ư	H5��H��4Y�Kw8Wk8�N�G�	�ŷs��b�����SNX�Sg��܁�\���`�<�S&�u?>_�@��%�TC-�29J9O�F��eZe���F�NJ�Z�3�H	�$��L
��CS'u�$��?m>���Vx�����ϓ�E�dg���Xr�.�Nh��I�B�B$��lrp�t"����Q��>�������)n`��Sb�H���cC�T$�RMA��)����M$R��Dv�E��tv]|��3�Q����m�S~n���f�Tu��A1ܬS�bD�Y}ݨZVh�Q1ùNg���[�iQ1au r:Q1�G8-<*v��Dd�^��F�h���"#c�����$�y� �y�we�}��*�%##cr0er�ncf}�v��l��ͳ 7O���t�T" >Շ/���te#u�P��.�^����@�_�n"��� ��,��UB��ׁ�z��u���&�'��\5٫��dҠyi�;�2�Z�8(
U����Xl�[��>h�� ��iHך�'���Ʈ���y\��<�zny|O�e������@YFi���%h*T�#����`Mx����e�����@5p�FQXg����L4��@Gn��];(1J��������2�|�O����]�&��6X��!9��hӶ��v4�P�G�~���80�F�@(XY,��k���=�������ە��c�}�T��;I�_(ܓk���y8���;x��oV_}(6����o>w�Av����1�������iG?�ęB���R�����4��z�у��Jq��-��N��7�x�[ybG�VmM��E���(FکV���߿`l�c����>7�E��N�Ģ����[a�	��5$(�5� 	�-{�sJw�5�3j"-�z`Ó�^�Μg����/�
�e������4!:� ��i4bM�g� �� �2���$v���n��HR�1ǃ� �z0�^�Kb�1�P}�0L��d��tn9�RAPpk Ā"�HP��<�k�nI��	���@5V���V����c���`?����Ʈ��^����
��v�9�p�f5��j���f5<t )O�R���;&s��0���tc�7��"R����:��W��ؑ���y��n����_Y=7�$H]U�\8x%�'�����%)�&3U�{��U%�i�W��C�Xo�F�[�y]m��@�RR�$� 	nsK%uwK՟�;�����P+|U��^Yg�+����>c�[��ۇu����~X}�u����ou���o���{���zF~v�ӧ,`��q�⨣���E�oo�Ls|��Z��$4O���0�{G���:���E�� �v6	͎&��^��}U7w����YO��ՇK��u(��9������&r����l8Ҷ��4�8?h�3h�'q�!��4ų�\}�hP/�%� �� B���E�&? lB�(;��|~��.����+�9�^yu��|��zn~�'��i"�ۭ\'Գ[%Ո���^S~��*�p���w�ͳ���nx�����e�q�����\�S����!8@mX�ف�t�������;�W���-��kr������^E���EO���%�A[۾����(��ޓdZ���	�ȑUz8x�,�n�	ȁ��$�W�颌/�}m����O�-<_�������Jhq�J��0M�V���a|�/;�!V�o�[\�����p��U��߭h���J4j`թ,�e	2�O����*�hK��$�E�S�a�5bs|S(��5Z��(���"�ֽ}�(�:g�)X������b)�`&��AQE�N2n��)@j�v]Q�����ե �[��)��i��['�P ��ť3gѯ6���B�K	(	b�z�.	����`�W�H���pР�/
N)4����U(њ��M2�d�u�\�1�,�Q~�K�+�*0���IFS5��ĚBEؠ��&�pg7�S;���~$�D:	_�b�p f�-���p n�'���1Ѻ�����w66��r`������ �TP��`���#�>�3������:3)�u����?�d�st_{ኩ�r-�j�����:����^���:��Ҝ�ւ��o�w�EB��o�B~�~�{�5"2}������^~��[H>���9e����J|�B!�� A(-�v�՚���"�ȫ��)�`�~�̩0��J�N���ԥɐ;������u܆��
!����L���A�$b��(%b����A_K�N��R���PM��x�3C�%��`ejwD�N��猃���`��g���n�vC	zu\��j����*E��z���e��0 	�_�
�9#4NA��UP쟻�0-S҃'�"1ڙ�3L��3�]8V�x�pB��@]WDq��K�©�D\\y"i%��q ;��F�(HG��[�D5��ϝd����A q��?Q/����A�)I�W� ��o	�OF � ���� �D*� �J+�� �
��J8s��i��N�`$r@�C��J3����(@S(@�F�5�6t}�Q@fJ�_ }��'���H�r�Ts���0"� �fX�p�\��~cO� #kؠ��� �0A���6��Ft&���L�S�+�b�Q�;)A�K�Vr]�`���%�SU�rqU� ���Si(���}:s"�u�A8��)
�aZ��%0-l�G:3���3*쟫�y�������lS�dYZ=Y��d�����"�k)�v1���7N�,q7ĵ磭/2�m��ķ']V����XJP�� �U֘�3+*U�?�FaQ�Y��[��ژ�� 9�dd�W�XA�ˊ#Ҋ��-�\5�5�W3ڐ���t��pק�+kS'1dB
���ct՝�TK9�A����=S��sph��X	sږ�U�;���E	;Hk5�tR� �֤�;HD� ��eQ� ]6\��*��/3������^(xM��m�S�������2:q��w���P�D��A��OAL��t�\���W��e'�R��^����t���	w>����Έ��s-�[�:AZS��!A�� �O�����6�Ѯ~���/��3�&��&�u�՘#�/@�f�9���#�~��X\����MBC	{dpk�����O������ۛZ5�@��L�c�9�g0���}��yd�\僄emM��kH�E�Iw<s�r����q�;ռ�Q?�OFX�>m�=s�N����X9��'e�98���s�r�U�4��{h��l�)�q@'H�Wg$I"Z��4���y�6���t�����l����(V�����'6�3��N���mh:/}_پ>#y��G�-�()ҭ>9�S���03�O��y��F)�O���i4?Yp�zJ@��lIE��3�`I�TM|�K�����
��s�W�~�9O^_f��)j8DD����en^Y���p<14Sa@������< ���V��E��z��E�F�L� �\-�� ��\\��h��~���B�m��C�����m8�Ŗ��~{��q|0!�ji����Vʹ`0�L�R�R0�ۻ��P�]�4�gp�)P7�@yޮ%�~r�(Tq��������a����&�M+؝�E� m %�2�h0c6����[%��[%��� �s�FEH��-`@9�9�ӡz�
�_�`YVz��m�c�$�T�yU�P/�E��OM��eM�lР�(�H�`R��n��؇��YR|��������������)օp���^�J���c�dy�AY����^�������&�s6Ӥ���*t    �D�8�&�ڒ�\�
�H�R��{�&��z-܁�	�6Օn7#��j#�j��Ag۰pNŶ�f�IIXE=�$�2ӭ/4���v��ݜWG	nN���$`iZВR���X��N�;	��*��V�}sܪ�/�M��]�Ih����D�7Z��A�����*8��N:�YU_������O�3�g`]h
h�p ��ҶZA��������U��j��}���5��^{���/+�ncx!�,��Aӫ~�������`P����ۇ���u�{��WƊ����s��<��N`�� F�=�"η,������8���j���>��q�!��K��;���O,����4P���R���_����ݙ��y����hhZ�]����vL��,���t��P�����̂%-���	�pK�	 �q�����T|�\l�x�����ӷ��V�y��P:��'���X�o��yy �PD{: �4@we�S��Ja�s�|�	U�E�0���5(r�g¡��F�<Wy� �!�]����um����r���H������W$y�tGΌ�
uo�OUٽSH�b��b�i���dpQ9���l�-��@X �&]��1� �%sp-�{�"E �d��C�� 2R �T��	`$�>^ 6�9$�2�9動�����4+@����ZNxm��ߖ�l������Ah��#n�"���C���Ԧ�D��M�������7 )A �9x���S�[*�D.@�g���[;��gT �(;v��Jh�����+�y}+� �eHN)eP�QL����G�J�>"��4ݢsQ��AjG����+�E�l�t��)�D�S7�|Q?}N���T(�yB4Տ5�+�L�M��ײ�%&��L�eFS�����Hد䌗 �bR�Q�*R����u6��Z��U���:�W���8P	z��� �T,4�����ێ]�*�x� L�Z;��2�U��a�NU���W��-#���[����ֵ��ס����y��5^�A��-w�?B�֔C�7�3U��SWҏg�!.�W�h��ld����M~�	�Z���H��*i+�*I���f)�z�H�b��ϧ�3�׽^����6a���#�J�M�t�FC)���[4�H�����k	�U��uƞ�RSO�R�)V�}���{>$P�U�Xg�o�� �S��BA_��Xا�/Q���v���"�G*X�����W��T��w:�bχ�Jb���)P �Xc�b�+T}���k�][�X��Rav�3��T�P�*�D*���2�]N��5eJ��;�1#)V�>`�X�w�?�b�"���MP,ޱ��@�:R�z�Z�؆����	�UG\�b�w�5}ŪHŪE�tk�6���IM2�o@ڧ["Πu�-��H�Э\��+�hڱ��ՠ�b#y��E��b�Q,�<�U� ������+6��r��o�W[���M����6��VzU
;�*}E�b?�b���8`�F��	�	� �1}6�8p�-9�תtzMp3��܅B�ƁV��{�m�6���*�K��������4}�ƱW�\;��lZ5��zk\ZZ�[�ȑz��^�qv�{��m��ݪ[��]R� 1�W�Y��g��ډ��h���b
�	Ɩ ��d�g�A,&��6��_NTq��6���q��kW֡�m����Di�I�wy:�=���Z�����kʜ��J�4H���;2�%���5�uF�b՟t���.Qȷ��T���u?�@��p狟��]i�@/��R,�лP�`��a�^7��y"��4ك+��+f���e�!5���R�]�;��X��HP,�befc/U�)LD*V,�k����
H�+!D�+�o�R㍙ի\����صU�Œ�x`������Q���#��DX�dw+]���D�x�j���J�6c+����IF�@_h��^�k�[��]�5��� ���n���j��aM�ٯ"W	DK�{�S�+eݿ�+G�+/:��M���͑�U �̰��Xyq�	\��3�M(�0K�n׹Hٱ�p���w{���#w�^f��^���D��0���X�%���Wl�R�����Ƙ���5�s����(D��m��J7D��۱X����=���X�`�:.u��j�.J�}$�|��l,-�u�T����BeRV��j�
t�;i�>�q�5��KK�l�j�-vk�9^�FH�LdL?Ɉd���.�[�~��B?��x�"#��@)���8��Z�Q8����<�?k�a�gc�%F��x�ـu�|ii{�r���Hqw���~�*�$z9�`����z�C��[T	�Kp�|� � ����_)r��"C�{�6^�b+�)̊����s
�WZ�~m�i� �+v+�)L�q�pX�q���٥%$��m�cJ ̱����lW��8�u!��
lժ6��;p����ZY2��� �9K��ݫ�LA�7�ݸ+��:Gl��	U�o�	�k�Am��V���7$2kw]��_]�E��|�����?}�{����b�����SqV�{�-����[2�%�����^�^��]��j���Meu_��v޷8~�˳�$�c���v��vI!�K�Q_��v:A��i��,I!�ڕm�N��MP� �vi���c�������,�Z�Ui�W��x��jז0�u`�n��M��:� ��4��%.�h]�Z�8�o�n��MhG�}�W��T�8A��ij?K�j�v���z���h׬�{j���]F�]� �t���7x�վ6r��1�I��1cd�K}���ݮ��COOкKs>�s��i=g�$\�~o�ǐG P�U�8�+u���~��R�Z���fM��k=�Z؁�4����������A�y���ȝAnl��P*b�M�:���N}dW&r���{T���ϓSPi�6�}M�m�Q�T�Ƹ_ ,vIzmFnv���~.����5Ժ�u�2x�Z�G۾�#���Fx����+��kl���z������{]dl�w�$�D"�1'��?��������>��	j�a7��`h)E��N��xu�ǽ�[U�]��5��@��S���G�۵9A����~��P�vlh̆��Yu�ڱ,��va�,���i�������<q���A�wX
�v̈Y���	2Z����ij?���U;5<f��ף����ӺEA�����v��s�s^���ֻ�H�1�	��+���G�74=�F���z����SF���}�����xmF��5<=U�i{��,�\_[C	ש��u������t��v���;�JW�Vw�M	[��R8e@,J��N5� g�J`N뺹L��v���u�Ժ�L��H���s_���^f) K�B��8p���F%�g��P�*gS��׵����2kt��)�����bi�Z��ka}0�W�h��/���[U-;��/�b욈}�=��}�E������D�Ͳ!%�n����Fٗ]Fʾ�X�,;k�҅�Blkٷ��r��$;�M�X6a��O��%3F#��%��<Vig��d��k��������~��?y h&-�zr5i��o����m��O��?�c͗�����C_��Mq�������������.N���U$ک̬~�G���9��/l_��_9)ޢ��q�kZ��/W�W��~�}������7�ރ�����N��ߌU=����Oݡ��ۿ{��S5kZ�+��n��7�]����r���`�ý��E�=/~3��d,���@�|l<�(\΂~|����?�s���ټW_��f?�80�90@�-f��B3�K{�XHp�s~���y�@�X�v������y�f&�;XעO��x��������ȶa3Ö��&#LgVR�@" F�Wx� �DH�k	��С��+Ew�&ѡ�W��!�"��6��g����>:p$:�>�pC�Yt �t�/0�R��T�Q�$�A�V9�$��az���q$��I}3CG����73c��PFD��B�?1�t�h�!�"�e[+C�P)��2`    e��-���z+�~$�����7���BP���b<���t,���+eѰ��� ¨A�Aʏz��U�M��!��D�Bq��/�ҀrP�	����n�����Ǳ�2��9Fs�"��r���rp��~�XN�dg�	��^G!��(�2�H��A��nv��eW��Xܕ�fh���E)��b�|�sこ�e���W���=p,�f�_�*�ZTm��7뀓QƵ}ע3�Nu�z{���等�;"�����+��-��cFb�)-7l���"���/ �
�8%e��wV��%C�l�ö,r>:�'y�Cމ�K����Fb���x���Y��k����*ͽR
1oRW}#=���S�ae��Й�.�><@$<@�y����"(�y� 3O꙯�w���"�ϦL��;��q���DwE��du������:"���{�Q���"F!B�6OP�rLI��;Ȭ�n����H!�
�F�b��&#^F�Nf��w��	1�R�#&1B�M��}�FQ��.l0��w�o�p��e���f���R��������/ŧ�����-��?��~�����?�[}W���/ݶ����$�M��?{�ś�=���]lW���ٛt�����s�1!��E�
����_�1���d-�nÎ@-��6$:ZĪ��E���躒|+H$H�h̨�(��=�.#��}�#o�n��������n����چ7�z��&��q��̜�1_+�^�sV�L�c^J����V�ɴC[3�̑Y���)n@��Rx�9�	=��n 1R��i�h��O����G�S��f����l��~�.@��(�Ɖ���[��I���rE���3�޿�Mm@p�[���h��Ɛ!e��LH�i��>`D 9�R0"���"RO��tְI��Z(=S���V����ՔO#��7L=�FMA���ӈH���H/"��:�-W�k~4�V�{I�����)r�{�h!x,zWW�$K��I#� �x)�L,�L�H��]����sU֊{�	@�������:!|�u(���uT����;���\U9���{W*�%Y�Y�0.�;g �9�6�̆z=C�O�2k�qo_�����T�G[=w�4��r��N��G	�~��G������J�oܿ
�7���"�Դ����F�$)}AV�̌�Ӛ���nfk��i��(l��[))m+'6d��طZu�ժ�t�<�3'" "�e̕C�� ɞ�cL��D �[��P���'�4�*GeH��#�,m$F�A��#&i��,�#Sӯ
#DfO[�Z�����oz���v� hF:S��|��~K	j�]瞉Dh;��^Dbkʫ��ry��HD��B�"��#+_�����1�cq,�^BkM?�d�/Buo1I"Nַ� ߷���fF����;��	�o4o��VJkȎ��/�f�V�K�}ӱ8aژ�BJ�/��c�NjgTʻ�� F@Ѱȅ��[�q�n��"��ܖ����
���j����O�14xW���(r8PT>�ԿN�d�Z���y� ���[��ʭB�����[/ŧ�:�~J�&83'���v%r}|�N�z��a��-�ѝV�>W|�����⧡������'���m����)� �ٕ�������Ƒ� /����|mb�\�E���jqҐ]���%��LF���:�M�^�Oa����� #��H��ڮ)mݍYb�!�	���9$��$��ir�쮕��F�^"�{��\o����P��ܙ�$*7�*7G��>���LW�����T�B"A�,G|�~��LY�����2N�V�k.�E��:�f�[��m�`������s����f�� hq:�*��ӹ�YH��Սot��l���9E���gѹ8�Υ����1��k#i�m�׹��p�<\Xފ5n��n��ͲD`C?$�����BT�*+ۇ�����߆���¯#Z��n(����W6��� ��H���z@�����&�,��9��X��j��u�"u�� ���\>�R��Xq���&z��;�z9�N�:R��I�,�GO�۵M��9�Q�un3��ϭ��~��t�YtN��y;�,�����AP7�՛z�;#<ʱf9��[C���τ��)�rBx��ڝ��e�ݡ�P�U��5��'��e�fGp��ZjV㲻;ŝ���C�8�	[��d�f�m��q�ڱĠ�luJK�(Rvjq�<#��O+�y��IH�dX�e�������;l����̏/6��m_�N���Fagӣ{;U�!�����]������k�ڮy[~�����V�W����g���_�O��Ǐ��{�����>T_��/�����3V��uc���2�ƽ��_���͈}�CB���E�Swk�i��������`+��6kR�Xv���@o��p�����}#��*�T �%������X�C3Q�,ݯ��~�������oK1���ۇ�����D��(��}�K�w(���)7뒍���6��}��S��b۪�[���>��ń�,����鏏5����_��M�%;g��%�X�� Kk�E:��G�s��m\`����R&�ݖ�T@r'
��CQc�P����JPT�+u_�-ٳ��Z"��{SP�Z�K���� +�T5�`�Ǎ,QfdZH�fОE�_�ۿ����,�e����mp&N=��AQf��t�}~�-�1[}��/���m�\�W+�4h�Vd�F��gCV��S�WF6%�d�s#+D"�;y�,�F`U\V1�� �]�'ã���,�?�ݏ�w�f���pY�� ��d3���3��nR@�����"��iT�2c/��$`ƙ���%hu:h��|ּ�|�(M�L�#ol:��Q�?W�PO�����6�AEJ``a�GR�%R�0VI�굹�!{�l"�[�IU^��D��Ѭ�|M��C��Ag��:e�J���	�e4!�n�=M��M굹����Ik�XA	�bV4qf���-�7k8�9��w��'M�I?�,Ά�������2��B��WZ���2V���!=��Mq^�e=��.�}�]��=�8� Ղ�?+�����R��j]�	��E!֜0{ѽBp�����"��A.��O�Ւ"���4ڙD�I�ȯr�@��j���"Ck'�����x�A���= 7Շi�c�uL�M�9G:�O:P˄���
O:4��t�Q_���7?��yڕZ������?�Y5���G��Ȕ����N���Hf���Qga.G"ӆE�0�dU:��ޙ�XC�f�8�R��~ �D=qv����'.��=W��&��3 �&5@�N�Ú�`B>D�2˹�(xKj�	<��"A��d����'# �T��9������I��~��ɣGx%��^��x�����X|X��]��Ň��?�>��O�A����M�`�̣�1-�;�����'��1'���\�w�d��Z��74M�ݖ7:�Z�r��F���>҈�U�>NbK=0h?��_j����R��\��B���[����:KsK_�Y���\6�$8pɩ:HcӪ���$^k�xm�j&���2�h�͖N��6[.&R�,ZN����,&����$h!Au�ԭ��#�m5�W[�HŌ�37�=RUd��'W���H=W�n�#��օI���@L��~Li�U$^w��^����
k�t�W�g
d^k�Z~+����\S����[�@��	Z~��Yd���|�u�X�6Rjər�l�\�s[z�;!�^�[B�L�UK�&�_M��ظ���>��%��*,�ׂ%4���D�q���K��{�p��@x���@�y��Y�
RDF�}�ё0�����^��BE��Գ���2'k�Q/�%@��"�$��m����#�T������n�N�������+�� �97_Y$�t��ӺKT+s+m��$��4�uJ^0��=<�8$aه�� W=�O�NạD�9R⠤�z���6}ꕹ�Q�lPK    �:�U��H�g,��ZZH �E��E��]��k9,<���D��g��EB#B�\�!49����Fvd�U����{imEh�u�r����4��t:�����4[{NMJӺ�"�/!��/�c��R�AԌ"��j�+Cô_� gaw�D>K��+ǒzinX�%M���P�R0=җ���	�%�|�}#>�����\�-�SL��t|�������x�m9��ރ	��l-�VA4�!tM M�8�\�X٩�����7br��X�47b2�ӆ����n�g�=��Ua��~���:���l� �.�63�D���1�<1���FL"x	6�uR�)���D[Vr0'2˘�,c��[�T�\C3Pt���c珴�j�z��r�.�,�Y
��*W�,�mq�I[~\) ���eVH�AV��D˴����j�<��E����h6�ϮN�#���~,Q����,����Q�+ILۑ�SJ��Fݸߙ�Z������&_{�
�0e��f���C�l�K�����ԓJ�s�O�L��I��04�/��
#E����	�o,�����;���84� à8#�gTֆ�R<.Y�eB*yG�M
�n�]�a?�AaG�䰫򰻟�Z�ۭ����A���(ߡ�5Һ�ҳ���kw�d��0{��{YBY�E��O{��p�˩O����;]�8��M?����~�o����ʳ���?}���/����VnU�ϏŪْՏr�����D	�M)������
)��-U�fb@�t� c�kb?��;�"M�ig����� �!ెC��)�N�'`8�#�m��2WhMLw`G4�d�9���x�A���{�QΪ�n{�K s�nN� ̑Sţ-�M�97�{%/t�dQ�)A'<�Z+��1GQ�9;Xo���k<�2b"-{�C��Cp0��9!��*K`sh$'O�cs�b_�B�J��=����IXSC �㪮
��T����5����vq�Dk���h���2R~��x��2�@b�c�－w��U��l-���rZu������	���A�}t�Ht�2��|���a�tpg�9B�}�c�����	��P���%P\�T�S(�׍�-�,�fȵglq��H�ё�S�0��.}�|���@�H�F8�7}r^���=Շ�������q��qH� � �X��8���y�_Ǒ㓆��z�����#'���r]&�QȬw�:=d���%�;s[裌�D�*k��A���x^3Ro�`�yN6J�����X$��ڥc�ޤ�tH=� T��~�D6����{�5u��?��#�{w��d~K���w���+��"ʤ;���a�����.Dq����4o�Z��Ym�ŧ���urT�������=c�X#E���ZI�t'G
R*Y�̿������*�ef��W[=�M�>��fC����+v���˛QsG俋��/�%�ktߕ��G��}��J�;1�wb w��zE�{�?��G�7���n�}kuƂ�i�T�������p�ڧ5��G���v���w�y�� # �6�QB�: �n1�H����?l[�fiQ�$���պ�Z����E�_�/�4� E��<�x���{��/�;������!�^�}M���k�%���-!�>�_��޻��l���ha�բkU���L\�i	 ���\����<���9PY�{��&p%`f�J��]�ա8��1zoP5e=��V:�����>����>��`�p����@'�G�����ݼ�ԏ��4�+�+q�\�@P.���z}��.�MB��ق�I@��*&�T>��4|�+8�R��JbAꝖ��x���
ƕ������Ve"�<�}���<�s���'A�ؠV�@~�g~V����H�Ww�M4zm��N<j��i`~�a!�;R	�:@���c_�(T�'L�,����L[rP�c,��t�'2����_y�VؚSp?S��cU���F���r���1�	�Wz&��ǭ�@�7��`�� V}��H௦9 �ռ2��3�;�_��h����E�oAI�h��Q��$	��}����J��'~d~�Kl��?���)�ҋ�{I��ʲS���K���Ȳu�B����5�?�|S��\��4k�:(%~����������;~`$��o��,�D��I�w�|I�1�qh��q7�{7C�i�� �nݔ��R$��(��}�~�HdX
�\0,U��8�.��q) �m���~7�"��j���ݿ<�B��bSB�Ĭ�Z�hJ���i�Qfnb!Mլ]wֶ��6�<!�F9c�P?�#3���0���Eԏ GԬ�X��:3��̒�J��['k�2k�<�4	���B���YI��>�D��n#!7ș�woL����֯g�jx�l��{���)!�� ��{�4�-,#0G�Т	�,�����lU�#��[���-n�\a�{��Ḗ��A��ȸVq-���T@���"8���̀9�vQh�}�F+"L ����xk�XS�Hjz���D�>�D�� �������m�����s3ȗi�M�P���
S��W�9�Ѻ+(����+�25�� ��P��>��9s�V0�QFcV뭹SZk|��N���;�e����j�R+��у� �H̩[����cN��4�9���2�Q��0�R�%0G�6�J*[
��MR`�MЧcP�0.���U��z�GMe27Ѓ#qA<w\P���K�J���ٷ��
S9LWD����9ɻl9����(�#Qd�,V��`nHA��Rk[$�.���$��R��Y$SyW�DM��Q)���"��-ɨ~k4�s�9y� i�y�x4M��y/��~��du����\�M��&W),Hjm�!/�J�kG!����7�sD�"�gA<�&�f������Pͱ�){��F�c	ش]SB>�d�1�MV��}l����n�4G�8�B#U���FJ�_6��H�l�&g\9M��Y�E�0E�	������G�!���z����m���C��2��C��Źq�=�T����\���)��Ġ���7	�2),��heU?"+蠪��y�"3vtpd ��x�%�?��ٙ�	�T��1hԸ��CB��u��E��uP��܆��`���"5�/tv�{52���$��l2������H���4,I�:�-��
A��F&�A�J��Tސi�4;�=�w0b���%���Y�𫈝�\l�/4�k�l�r}z�4B���!�r�ʍ�T��R4Z�zK�N����ĝO�^�h3��A���.!2&��2=�j0�"8@�3qo�3=r���v�AO�H�T������,9�����S���(ǩ���%���^�����c+L�Nw�ܩ�,$!��5=z���M��(�����㬛{= |���Q�HIL�L�S<��z�_�^�~CtaO�:���r�]<�	gu�nV�Q$�C������ڨ��u��Aw1��,�hWwшfa���@g�}��}83>���qh�!a5���� ��IG�S��	>b�Ǘ����T����|�c�&'���m�ic��a��-cǳ����.z��:m�W$~�������v[��^�qo�lK�`ڱ2�L�����B{��AЗ�h�%�V	,����+Z�D���D�L��%-�����7�(ᥓ�'
��y�@�%��AB��������y8\�?O ������@j�^����[�����XL;���P��[�@�]k��@/y�4Я�b��H����x@�� ���+�	���'����� l��AHzy�;7(JĬ$����Y�WG��N��l{���n�[���\���1W����i��p��v�"���������W�']�Ni�+cڧ��n�������D��P�`2  -��z T����� "qR �Um�DA�u �������s��P��U ^66O �I
� �� ��0��^��z1�f� �^� u�w������=n�p�mc�#0x�n��`��b`�L��~�   S�pWQ�p���R��_���~�l���wK�� �:0{OsBcԫ���jj3>�X�܉�
�HY?G �F��8�#�{�*��s�V�i ��X��C��6o��(�猏I�nt��~K
�������w ���^Ϗ�m=����à�M8�]Y��6&:K)-Һ)E�N5���D"
���k^HJ��=�R�q#�g�d�U�T�4��-*��Vs���i��V��k�QZ]ݓ��PM�g��!�p��(Ī~�W�1���N�T�%��JBR�>��T�TPn8�p����l$��1h�*!���R_�V(I��im|˘Akߝ�5܇��ݑ.t2Zэ��J���y��Y�4�cWq�ۜ���ŜU/dՏ�ՅX咬r�j�:��[Eg=I��vLܸzV�c�V!N�S8�\���4�DҬz�Y:Vh�1m�X-� �?y�f|��A*�%��
��ю�=�H-(�>�Z�������2�Г��
>�Z�����`��%����8̣�p�T�[U��o*+d�껠Y�
J C�KM*#p�w��<��*��[�ՙ
FV%�*�+W��Z���i��1i�X�~��J��Ҵ�U�^ ' JeW\��j\�ӊ|��|���Ɯ 7\s��Y���ꛖ����F�����.�V�Il�(w"wB���sV��k`�!� u���K�B��aO��j@��kK���S�~���O�U����O4�߆Opk��g������|ۭ?Dc�׏U, ��壪��W��˩��g��w#�Uooo��;>      
      x���v�H�5x��)�^=��jF&��+J�$�)RMRV�W߀ (��j,����5���I&"2q$R�kf.�*WY"�2#wD��M�|[V;�3��yl�}�p�3a�>=�O��h�V4S����oo�;��9��w���e�u��d�Ά�I���3�tƓ��Л����a�w�Ʒ���Y��L����&�~��~���Wڨ{Ӈ���s�t'�O���u���/F�������h�:77�^gp���:�;�Q��7药���]����Qw|���n:=����I����7���;<B^L?�vn'���>�N��|8�~�cop��7x�w�ϻg��?��p�ߎ����1��=�b���;����7�~������[����]�²l%��&��	�O��;�0\��?��[����5���(^l�A҂����I�.��y��2Z���׷����`��M�bW1��V~>�<�+��x�]Dl���ď�n��S�-8�+<F{{�\F�t�Z�=���a�\��r�t6� |��o���
�}��nWA�:�U���!�/�o���S�5��g����ta��p�U�7��"H���w?����jpI�j�'�r[���<��j���Q�c�q��:[>>-�t������v�0O��:V/-�gg�þ����c��vk�>��%���*^>/���w��?~ȣ���4]5˸5-�2�kZ��;^������r��.�i�a�E̦q�Z.�g����6K������)�,�)��>�c+9��x���S�P�<%��=�a�{�ؗy��ƣ"�fp�`l����v��m��0f쮳ۧ�_�>�7�ԙ����j�>l����t��,��8	X����y#t�%�y��_����<��f�1�a��7��A�Gu��w;�w����	�,��Zc��f��,L�S���E���ʗPc_�$ް�`���7����{\�b�2���|�7��`
�Z��"~�O7�c3x�p��b�ZnYO�	!{YnWp�d�Z���t�]Kx�c�k���2�:1���=��y�J��jY͎�8[�Ck9����1=׷}�q����[���0a�~	6K�~�	�*zr���6XE���8�����v����\�5��_>3���e�V�<��`3�����a��D{�M�ޘ�|r��8��Ƌ�K��+8���b�<����Η`��$~[�<Ҽ>�ǚ"����o�C&�����F�˯���"�Ѵ"�z��������� �&+ؖ��K�q�E/��f���1�l�sɠ�pWx*�����.��X�+�~��vm�`�Z�A��1��[c�����l�g���;�����o�Y�[�^�fM'��ʷ���U�VfK��(�㷬 4���͗�ɨsޛ�N�]!D�X�]wp�g�n���t8�����z��[X�������vq��+��>���v>IP�vu{	K����&W�;�m#����Y���;�;���'��`����\� d�����cc6�t��@��`������ή��&�!� l�&�]��p����I�CB�ó�Sgt.o�3�/޾���{:���p������O�`ûAw# �Ygtӝ�����9?���:���PB��������b��� �F=�=8?��J�7��%<W�}�.��pߴr��0!�b��n�K5���v+��v	��~��V�m�p���]S�]��m����KVm�4IK�%^��Y���뿽��4}��ހqZ2����y��:r�~���sH�&:�i�Y:�	h���c�8i{,�w�9�&X��m���O���~�	����]��Q�A
�v\u�������r��1 6����t����>���q%F`��18�}��;���t\/˯���M�5��UA�qnWh*����|�?.?�:��n?�O��$�c-8<C*7�ǧ�5�W��C6��sL�{'I����Fq�[�O�m���7|�ϯ@��0�}�+PJ7�81(�U4�K�A/`����lǯ� �a��Ϡ���d�}�պΌ7\��ޡ''�E{�3i��Sa�M�<S�FQl�^�7��bXc�mGoX�Ia������f|����& �pz5��X �b���`�\y�pGg�/ �^`�a��>�p4��������> �G q����5� ĕ+��8OV��l����w�s���+�B&�<��b� �]���y!��h�f0�&4�q6��ńv�� �p�\=�l���/)��;`�&��]��<��'B���N�k��Q�3�C�gR>=���r�"@�/�9��MA�OC��@YxZ����l�V_���Y�����f�|��[�'�|�B���M�d�k��Hp-�-��Iu����h���"
u|Gw� {�-O���e+]�Sv15p���9�����R���g��t]��)�����	:���Ry��q�~�f��n�Z�L�ϟ�0��r~�����.��K�چ�J�D+����[b�M簈���C�OS���j�5LD�,�`ߦC�i�¬�&�؅s����"0v�ܾ����1߰�8Ir��;���H`�lh�$��Z��{�ooɞ����$�,��x��m��p�՚�p1����{}^�[;�6���g����0�`�f�,�z�ꋀ��~a�s�p��o��_��Xo�L�!������~�W0Xa�������xp�).���fn@4p���5�h;K�2�`h���<���>݀�],�yb��x�zK���&�I�4-��,34�̰Ou���(E�j7r��� 7`�;��;���A�-�����22���i��C4�bR��s��
��R�
���{�e�����.<l O��-�Y�j��#�� nV1�XGȼ�Kw�>��s��ha )�e#�}xk�w�ҭ���M�����Ō+�̼:�`pw깱h��c���w���=�p���D���"?z_�Y�f̛��)X,�	0*|¼���q�������C��U>#���9-��<)�~8�a��[���[��[� �?�����[�'|X)-���k\�������>��퐮rǭc<_����e��Zw`�a���V��p���d/�<�+�ky���[���j��Y���F;�3o�U�u�О�3m>�z�ްu�a�`a�k���`1�H#����zk� S �\:����)�y����`:���2�Ci˕Gh¶at+3���F8��1,)�wW��p����C���2[<�(����G�qi�#����(|[���-�,�k��U���X�_Fd���*�����J�Fv��E�sS}�0���w׹���p{�#!�êS�c˷��I!�����M�,B���6��s ��E��0�a^���s��lXb��s�ns���pq"`���~>�E��0�b�'p�3�ĭ��p�3�=�Sp�����X6,��m�pB�"�Ho�D�Y]� �����N`4���E�>y� ~��V���"����:�b�B�{u���8G���	L2�y��Q�tW�8ӓI� W���i���Cz�+xחl��'�..�G��a�P�4T| �����Ȗu��sqZ�SP� ���c��������Y��÷���^�
�U� ����fd�(K�Ez��xu�։���Bǣ����MدM0ј�g�mh�H�Ԧ����;{A`���C�Kq8�y�O!:8�m00�<��t�e�$��>͓��4��[+���e��B�����ڼ��>��:�� z��m��Q���]��Ze���G�4��恒I��1��m
ȑ�K��v��J��?�F4�Hg�nֈ���p��(�σs6�v�?a�r��N�φ�ј����SL�0�;�v����u���Z��@�o
��\ǫd�-�Ķu��S����j���ʼu%�t.W*}SJ����u5l��ʒM��a����U���c8���U��:���߆�Jc�)�;΄��y}X�?/��ǄB�MR1��Cx|0LY���:s    �WpjL�Ndekr�Zmk���n
���M�1��.��JF�u���j����ڱ|�ԓ	�N�P��T�kjX���U�-�a4�x���Y�gs4�Q2^�6�u�nF�uk .�h��\�I�`
��cN�(��,��*g6� #�7ބ�}�U����W�Q2�EQuvJ(��ϑZ��wx��LѮE��� S&`�c�9���sF4�Y��2�q�v{^����~¤
|ax]���<�g�ad(�m���C`����K�h�GVU[�]��1\�-�8�\�˅�y%�T���p�v�ED)
8����k�Y8�୳%�9����� �̎��
��'Or|D�uI�<�M!��L�4u��#�<�FpGVe1>c�{6c��"�Z~�r���͖m|�`�i�����+�8��X ������f�.�Gİ��Fܸ#��\����]�t��U�	���ѕq8��KKn�Vn�0!�=I��-���0�-�"�
V��������U�K�>�^0u�}/�y�m�|W���TB����mc��,Yn�5���p&���;�������m�~Wߔb�/y6�m�s�)�ij������Sk�B�l�8�Y�4�!L@��� ��aF+Q|-p')U5V�W��|0�8�I�{�폀l2���0��u�B��j��YVB�%�/�X7 ��E��Y����#$�Y�����G��V�"A w�ݡ�*�,��QEa0��n��Ck:�7����oxq=G�Ǟ�Հa�m�Ax^_d",[�2ܯ�����3�4�hQ�d�Y��ӓ�p��yI1��Ѓ\gװ� �-�w��9��B�K�B~b'����wC��^��L��;���&n�a��0%�A����sa����㔂�;��r����U��w�� �W�{X%�[�\o��? b�@Y��rc-RO�LV�V{��y�i�1�`���\��)B �L����Ay�>�����.�8�h�,eo���>�Қ\I^f�I�H=���@�@/zU���;P��QI��I��M32ʁKwS���:���ԋ=�*1�x�#Z�4����~gLj�^Z缲�;r�r��}w��p�_�9/e�M�]���SÙyV�O�/�f��Ye�
f�	0mf��-�ċ9�94-�� ��6=|0��%��p���]a���	�6u�挅	<_�I!LCXf�:d��`���Ŀ�۳�$�����? f��o��mڞcL�2�:1���m��W�!5[��y��Dm��w=�kPF!�,�l��&�^���\�8_�$�c�
�ͳ�CO�BJ�8�_~��S�K���h���q�rn�>dodЏ�@L����B�N�����Eq���F#�������sJ�=�A$���~�������`��Lz��&���"Lh̖� 1̳�f��!	u:��]�x��?0u�<_���4��ɓgI�2�s�C����<^v<&��F�Mʯ(,��3�9<W��R�I(�*�����uu����=S,�yp"�S�30�6>�%B�<�g6_��@t�Ao��x�D���� Ol���aT��Ao��OGp�� ��˽�qѯ���w�]�@�m:H0��O�aA�:��n��-���1��8 W�b|O��'���� O}ƥ
j���޿�J�)Uc� mpM��\�hLN-ٰCz�����M��H_�zR��1�&�!�k Fsp����W!��2��X"T���h��/H�Aah��4ʌs�T{;\�y����}Itq�C2���Z��ڿ�`5�D_U�©��E�V2���iq���:r%�:)uT����Y�](�SJx݈]��!g �*�D�|�ž��7�a ��P���;�u�2{3�|h�u�B�0���:�7kv�O$����y�%Ih�q� f킦L����z�G��O�C:� |�&Z���L+b'���;�٥r�?�U��U2�
isMf����ܧ[�:�X�y[J6S�"C���<~θk�=K+���*��sV�ZV��f�,֚'��Pc�L%���b�R�n�S| �P�d�ӐU���n��&����C��{�i�7��"�d�]X��M�ۆ皶���]&�n��n:�J)%�D�	���gY�ES�ޱ��w�M@$Mz�oI����S.`�W��Z��c	�î��}'_��+W���!X�y|	�w�V9m�]YY����q=ފ�Q���2'� S�:��JK�J��we�ˁ�挼�P(j̬0��6�VQ�g&�n^jfL#�w�,�{��e��G��5Zҿ��|�x������p��<@n�C�ls̉��k�>����	.<�<�<���i�)��.(�>�0&���3��w`z{Sd��/Bӻ����"N9�	�*8��N������n�$�X�rIH��_�i3��>�y� �հ�2��*a���F%�F�/<����l�I�����������!o��]õ-�v���/ׅ;Ĺ�u��b�j~�n�c��P~�s�"8��[��yռ�1@= �k��u`��	��9���ܚ�s@
��tl!�[<m��?�o񶹼�F�:\n��=VX�
���]�A����a�P�]��J��b��i���X�.MX��}߉��Xk=����ܼ�B�+���fM��,	^JVM)�x�Y꩞tp���p��O���7�ڴ[�E�A�z�9�a�?4��|��lp?�rW4J��b�Q�&k�S*+�cB�;+���GMq0�O��v��N�
��`!�
�c�MJ��V����?=���*N"]pE%<	�9��H���KX�%����]?<k̩+�[�PFc0W���K�UB7xz=7�ez�q�hˊb����20-a�������8�Y��Hb�LX�a��^5�{{Wa��Za�� AX�i�`�r�+��ذ �j`rõj8����=ӱ�quMn�}q������R�Qc������pR�=h�bLa7��jxM!jct�	�lwC�Rs��`���d�`Ř?��V���ɦ�n�f�MCN`L�Ѕ�
FK��͙�)r�IOm/V����Q�5�Qޕ*6}��\��*)�*,�
�0�D�T�+�:��8Y>���.Y�`@���&��3�:��K �kE�h�^ ��S.�(��b��l@�R����U�&~�ІJ;m��Y���Q��Yb��3��������[-�s s���T,��jc:���ul_4rB���l,X�YʨY׋0٘�l�`%�e�*eK�)쒝.�	�UX"���Fو=X��΢8Bq�0t̬Nrv̚��l/��xh��u3Y�H�\2�͙��#+ߥkm���9�x(B���߰A�#0e٩�Y�!���aݯa��8ϙ���
9�O���sWa"�Ld�(��8���� En�wRVG�㯖 �1?��/���>ƪ�d��k�V�
�kYѩ���D�.����"�7}��g�Q}����8XoW1�@c�â-E�LOwm���m�r-�ɗU��l��(��]�W]���q�o
ߦ��o���k�BwQ���Q�KPv�ת�(D�.~J�����->ٻ��Y�%��yA/��_�������>y _2�0�/�drO�;�{�(��/�d}�I��~9[\���~B4@M?r�ю�(���6��E��9�Dи��ayFC	ݲ̯�!+���Oq-�U���&c�hƐ:��K��>��i��S郋9
��3f�bi�P����w!i��^�{Q��R���92#��cX�a�.��N�Sm��%�`�R�S����?�N�v~˓�Z6sGպ��T֙c��&��k�rir���L��he��^H�l F���UZmdԭ�	�[��u�Z��.�%�"�x��uO��=��K�v�f�sb���-�=I'�w���B��l�H�G�ܯv��<ȋ��f��JU���Ԡ|>���&x�_��%��LAE�fsz��Hf~T7谯F?�����m!��
�Cd �N~�    '���./�1N�UB.5i�#/F�%;K�$X��D�Hr��sW'&���S�˖ �ip�	z��yy&��m"U��c_(�'μ�O����y�.�����p��"�D[�ԯo��-�ɔ�%)pW���j�{yn�1r�1N7���Uh-�F*�4�ZϿȩ���hu8.���ץ�!�U����9����;<+���<Db<x�4��)�^UϨ�=����-��ʙG������Y���x�4�����o��nn<F;�͌�'i��R*P�*ֺ)�ҴL����sX�įQ!�2�����tl��T�36�n��4N`p���7K��b�\+F���/񋬡M��ce>���`4\�5�3-���AT1p�<p��ʼ��N���<�F��[�W�~�H�+/OoHfm7?����h��Y&h�a���If���s���jhtKMv=��d���U�� ��hu��c�LdpojX�i̕x��EZ�КͬYظc�l��juCp�|E�Iz	)ET����&���H�y�bY�2�B�b�X#�(��2b�,A!����I��`��ɔ"[[�A�tB�H�\��!/ H>��dv��j���a�1�»��ݯ�!���IɌ<	j�u[�*�x�KW���{0�O,�۞������3�Éd�v��UÀ9�햦H�2��e���+����~��5Gf����}_iGSvgE�v���S�(����]C�lE��i�%����^`yjUB��Y.�p����	c�İVb1$�x9�n�(L���pBװw�|�-�"c~�$��$�$��'�m�4��9�.�\�`��U��HB� )�&͗��zM�6��0S�ɛQ�Y;u�����j�xFQ�B��Z{J��S�v�\N�����s&�3�-��뭵L>��k�����@d����(P��-<��A���L�'%�w`N�w3�<���J6RKm�
K��i5��#Ң�Ym��8�+��z𠮇Q���W7�r�~|���Nn{5Ůխh�`D4*WV�|Q�q�푡��J��I�(�na����8Ru\��f+�<nԔ+�"�9�8R��vл�+�Ԟ��Z����is��M3��v}ÛzN;�.O5�<�y�5caV�q\ $-��L6��e��g��<I="�0�Mx��*��ڶ�+�-��&kM��Q�?-�	n�&N[%HzAY�kEA���X�P,S�]I.a�H�f$��qG�^i/�#`y��5���"|Ә]fʘt���Cgy��vі{�}����3IX�$�n��1�����La�@����l�]��a���hm0�M���/��
�n�is�`3�4�P��4���[6o��A�q�;b�3���ՋԵUiz�^2[�h��g�Rh�j�_�1~���(S�Ɋ��O�S����
���v�Y��F�渺�W*؜�W������(/;�I+�,�)��n���&�-���}�.��U�N�RP�*�cY�k=�bj������^15�G�ܰ�F)�U�F$P�4q@��ʢ�F6,�wq��l��r��H�^(��Kܵ��3+ S��E���qC� Ε�������rk�v�F�]���Y���A�r�#9��!��-�^��;�;�ģ:��x������_wFق?�Y�-Cv9�dD`O�������в<� �IŒ1�		�ز��;��o��Int/nG���V�����{��3�zO��(6��pp>d���	��e��������(������k��a�1���:���&L6���i�78k�R�cW�}Řa�7l��������㆝��D����ōή��x����-*��}�ۑ�;�zg:�_N޳�>�C��{��{�j�������`2���t��bL�ItF=��^Fz�K�]��<_�m��0|߆�ֶJ!2Km�,l��Th�[�����](N����j��x@Y5?�M��~7q��,��D�Y�0M��@�R�rDAxi�*�{27��?�oy����ߡ���Xhf�������z}��v���Ir��]�5. ����V`�^���(�̈ꖛز���A㮹��6ђ$� xO��;��
���,�Rt<o������K�[d+�fi��?U�L"����$�H+�R�zeAmHC��1���P,���^WV3��'�E3ۮ�j�r[����3�U{$q�J�iy�e���زө	X����o���nJ�|�Y�$���^$��U��u�^S�T&7ir������8� �(�L�?��C�k�l�P|1܍LV�:��j}��n��/�]_����\׏��i�3��T��Z�NŌ7�8���w����E���U�T�ד>z]��(L9��~Ø��L';�I_'ƙ��$�ɞ�5UR-W�Q��U��--�Z}��s��V���k���*4�d�6��W��E��u�y"Y,�n��E
��ɳHO�W�,�i����ub�Ċ$D��hS��m�������IxX�X�䓧��c�9E�]�-
:	��҅ﺆ�:�SwNL;�Ԓ�N�xy��T�օW�o�w���y�	r�z����Zۣ���z���2����,}E��pU�>� wA"Fª�*o3S�@�bJ^��H�eְ�ʒJx�t�XH�.ai+
(	X(*�x����r��IQ~aD����Z��V(ʋ��ra��Q�Vq�y󡦑5*s�qR���<N)��M�$�IV����HJ#Ԩb��&X{� T><�S=���o�t/6�����9������RO�B��GB,�Il��S)j�J�q�~j��+^`�lO���M�����O���}���4%"����RKV.���z�w7�0��F����G�@��a��6�c�Tl�f�ʼ1�F��*`	��%).CJEVaa`�_�e��_<�50f��xn�M�3l��2a�v�u��۷���i���N����
�<v %jT��d�&s꿒��1X�i7i?�>v�R��U������03]����9୪%�o�vX��L�����*߯��gBs��OYɠ�佒�����M��P�o��A.��1�8����E����23�a���k*
�v�4�Ha��m��p<fg�n�G�+@q��'�H}�����'6��T�������>�ܟu{���r��n2�����w���˘b2����̴�{�����u�]wƓ�j�zڻdc8G��:��pؗ;�o:�M��&p�c��N��p�]�\�:��'y�l���i�/�	� 7	����?u:v���zgCS�s6�GCmk�:��P/X8�7�j�l[���L���ɘ�稫�3��������p�˄�����pp��S��N��L�՛�M�����x�W�v�r�6��ű*��pM��ʼ�F��$^�:Z������[�R*�F��l���a�@�$���Z��`�tI��RA+ð?%s�9?�Q��( �	k��m�\��i�_UD���!z�&�C��Rնʵ��8!w"���I�`��Ʊ�ih��4�8^>=���o%�0%Y�6R�����L��9�(�*�M�n�Ɇ}�reDf��B4�yU�"e��ӥcl�I��u���QF��X�`Pݩ��)��������ձm����F
�RQEac�1��{����r
_k�ٱڰ$�~��:QI�\��aY#����RH��),5��
{��'-h,�!�+��qD#��pI`M���r�w��t=�{�d9��.Th�¬&�k��⻻�ƲG���R�œ*�5��^[�r��i��n��hsS��T|I#��t��{�L�:K=�nh�\�A��7(��}����(��C��3jg~L��@�m��\�=�)����5/�[�R���pS�rf�Ѩ��}0b57�`c-+�F�d�wu+(��e?�<̑׫�:]����C^�#��j]5&72�h�16��Dl�`7�YC]�,C�f�4�i�v�&�J=rK�OK���z�2c�'��_���v�����%�>��9X1{&����U<���;_��6�m����B�b�tA������|����B�    Y'����N���L�L��_�t�o2B2F:C]�U��l��¢ՋjXjf��Y�&A��ꡅ��5{��;�'�����c�NӔݮ������qbb�A�tTe�l��v���-GU��ᦾ�=�Qъ#Zh��
e�?���譵��
��T_�"���б�� ��B,-�h���R��T ��ʦH��2;ɝҶnZܯi^�Wwۑ�5���wL�9o�p� ���C�|N���5��8����i�[���򉎭�.�(y��Jy�]�ż���7�E��yg�P�ZIo�n~�����F��J�n��=�n�m�e��}4e���s��k����݂z�)�uR�����[���w7������a��6�6,i6n�w�5�6r �8��x(��5��4�&�����į
=zY�O��KD:w\��);o��w&,;O̥�?�2�*���UV�Fx�����S�B�Zw��3kk�}�>�D�v��U�� �� :e[(���5�h��+!���$��}����AE(P�I;n�����<Ȋ�hJ��Q@��[fdxl~����0z�_C�:HI�"��]Owlnؾ���2�n=�ݜ8��m�uDI��c�<���cKF%�ֶwj��]6�n���&����u��U8�Y�z��4$���l4_�s��8�T��{3FM�Av�|����=o�NО�1��V{jr�,�W�7/Ʈ�m�MwW鏦28e������zα��9,Y |�g�l�k������a-SUS��4v�{|�Ð���k�(D*p����U0۬U�Q��~!�0�J��f�ɮQ�l��;�]O ƪ{�cx5���"�l���MK�Xk�K�V��]l׸=aC��[R�^$��j��RN��ڃ�u��K�cQ�g�t�]���#´ q��񓌘�6��>@&B^X%U�heUIZ�|��V���*L_O���a[��� 6�L���IZ�L��.� �S����*$�
9V�ai�,͝����.���mmht/��GR�*[+������V���YGh��w��k��T5e�_�ں�?�Q��[��2�����ʺ��=^��2e~������E��Eq�� �/���"��%ͱ��p$���Y�6����\�B�<_�<X��5�2���v��4���MY�*W�$" s9C&
�̘ٖ��c�GK�n֊�q5�S�3�	��P���YH��� �YCj���'���j�fp݂*+��U��J���G� ʓOc����3��K�P�����+wF����R��K�v���^#�L�	,4n��b�y Î"!�x;�����7-ns]X���k���3�K���M0�XR�+*�[���V�Zd����mx�N��uT9I%�Y(��]�[��	6�Pq��鮆X��Z�C^|�*_�ʅ-ͪ�4��N.p=3�t���ϖ��a��b�#��T�Å�u�/(��G����0�L�����|��ڄ'5E�j�o�d�:	�����Z�
Qb�^f�6�:t�E��}R�?��lt؞)]�s�֗�Wx���s3���)\��T.�u�Ʌ_�/���õgh�#´+`X�D�W�tf�^!'�=�[Hv.w��c Z��]^o�z]�G��{ S��[�DA�)�F�-|; 4o��5�j֒���}"A����[aű����t��v����/��h�>��/QveC��K��=�W3�Wfg�֩^?�
�5�����G�C>k��1.0kX�
�g��g	��z�����5ʘ�,a���y>,�'fD)�Xػ#ÖeWd�[Qn�{�q л�v�/ಎa��V6Ge�^MN�\�S�F��'��fwq9�7�N��C�v�c]�̴7���6���*�,&���&��5D��Uh�:T<a�p�)� �L.SRA�܋�����v6ej��[.r�ܖ��p�0I�$Jjb�@D�9Cr�=K�����`臆c�;^�!�������T]�N��\��c$vB %SR�*4J�,+AC]�B�qE�P�#���'�ـ}�S��w��/irn���C�)φ�KEn:cW�<ޚ�j��~���9|����`?�(m}��Yd**�L��T.N՘��K=�[���d��Y�˅�	�3d�Z�X��kBYZ!E� ҇���G�6�����o��@�6����t��tw��-��n��!��77���G)��U�e�1���J$�=�F:�U�|X,�)*(�^_6�I���j0�.�9��q��_��n?XT�F���2�M��@!�"�0<�t~*� ��
��:FT	�h�c٢�c�Z���`��3��>K ��T�K��$Ȇ˭
���6���6)U��p�̦�dV������
5>-�Q�Z��n��"��nKo��n8�o� ��,;��"�����O	��m���;��&zڶ%Sb%϶�6jOV�[`I�=L*�f�-�������i����.�����-X�]��Ii�+�����	����WO�5a�"�p����l'Q�:a-�U@)�(O(�Pn���(}�ּ;]?M��.�]�P�$��W�6Ѩ��?��PP�aƉ\�A��n/�mq�z���Z�w-���T��"��
E�-s�a��6�����rKv �rE��sG��]�܋�Rarr�L�tN?�QQx5'�h����	�Na�j�I�b��W�����Y>$T�u����aA6o�#���Un�&ϗP��o�bц��F��.��{�+�m��s��/���~����p딏V7����s��s|˩��Xމ���z��[���մ��u�FЉ�r��6Ȳ�^WMn�gU�.zt��n`0U�(�8Q���=ŷ��?	{�k }�i�lv�y^]����{0����U\����v5C/ǡ���t���aS�A]��0�>���֛��9Y$ʞ/���N�eU�P-�����{��g?�5��dОZ^JiAt�qy`�S�������\&��ͷ�dQ0r5ǀ��`S0H$���;l)�ubs?�#�aT��f1�ԧNv�#nͰ�%�p(���DVm��L��5�B�-�t��:CR�@
B�	���l`��w�&O9��e�a�`����DAT���O 7�U3je���:�?��Ԕk�9�`�����,��;�;���P�=�B&:-ćϢ(-��SSW��m�[eO���P�5�	�'�t:�����n9��.`7���3�t?�j��3�q.�n(J��&�+~$7�5�#�Z�lo���{g֒c*M�3{�'��E��)i��A�0F{�M��0��h2"���\�ۧ#��wF�^��_����TGAlX`4�B�0 v��E`����w��3`9Z���YYT����(�N5)نr�����j�!��Re|�q�T&�k�Jљ����"(����nYP���72���Z~��A^�B�"���*9A�k5=u|F%XԂ�	i�%��y��p�ULa��c�V�����8ɟ3���I���K-�i_���jd4ʡ�,�˯�3[KjP9�e������J�[��͚��/�^��-��%�J*����=#�ld#x����Y��Ͷ	�3Ѹ�,��������ԕ�ĺ�%���EqFX$�N�gcT��0�dLJ}���A�����D�w�SW�� 	ba��5 x�@���;���M ,��\�R�κ�J�t� �Χ��|I���}ju�_�����6NEǄj�!�<m����������&S[#7�0o$�Z��gE�/*�8c�]Z�JEu-���,yf$ʝ֜I#�=}�7-!�s\ӴmG�`/�*��q,m�,�v-�Te�
��neC�Tp�	����8;ƃ�����ax�o���I0K�IF* 0�;��v����`�Fjo�ի�@G�	��ҙ�	I��ϐ��}�j�,���t�#}�Y%��g�c��Ό�4�ݴ˅�ˮj9�cƮ7�({U����]f�$Q�{5S
$l�ey/�� �W�a��_�������~R��v��h�[�($6g]��J�+[���&s��U�S�A���N�A <n{�2��� �"C0@I��u��+�e����`J�A ��B    O��!�?�*��H�C�{���j���z2� ����Ew4�u�U�ۖ�hI �[<w���l�s���)����jY��W�s�|��o�����N��~�]D�����c��O�_Vjd��=��K��ɛ6�:e �SE��?͠B	9�tQ�}�Y�B��ͥn^�d7̩9�����N+'g�N�[t	.�;�2����,"��v�����(��r�k,ބ��:��i�*�Ȥ�+R���{�'���w ����,H�P03LA�3�JN��MU�S���I��;�F���(��×Tb$�誌���F/z���ږ�&�mf���F���N,�*۱f+�߷�S>*9́L
C�J�6�C�U�`S.U��(�R��@1�]�$��;5ʅs6N���X<,��Hbx{yu�����W|wnʎ6�ڮ=�\/ƶ4j^z��ֵp��DV�Y�sd��'ư��@��M�,$1#�ѝh)������x��T�L>���{�<�=ɴh�;�~A�w	�I�b�{�q�"7s���ᥙUk��Є�װJ����������I�-��)c��,�$�>���>�k�B�5���t�b�!��ܸ�̎1=\t��xH��B�B3��^ΐ6_�Vc��E��<啚8�����Wmq��K��i�`aܢZ���(n)�n{(oY��
 ���^sqˡ��	������5��ir5����P%KI�.�.���H"�F,�u_j흺˒ZSe�8���x�E�w���@��������?����vg������B$��KZnǆ�E�q�@��W����)ٮ��3A����3,�óΤ7�ԑ��5�2?>M�hq��

��������ɒ����`EA��|2�&��g�#�A]�~W��������>(U���Q	��Te�ԑT�B�1�`�Tb�2�Le���Cj^w��,b�
���0�4�~�
�-�4���1JD�s%��$��K
pd�3t�6�/�c��+BP�>S�<W�Uc����a��k�������E���3�_�'a	Q��Y�8�/��ث,`	�ҿ̓������&����ć��U�/u���,Yʟ�ޔ�.>/{H�Yl)_�~4ӽ��qh�Nۏ�~�FP�$ya(̈́c�h�1�_�)��<�U�AO�G K��] q���ڍ`�
�1i�(,��T��?S&�f;
���R�n����?�/U��L2XmR�<�)���=�wT0u��c%��i|=��;�U.�K&�#�P���
�K���l����)�-�|���2:P݆D�(N^>��~Q[��䓧����z��7?g�>�+������c͕!�D�ݰ�%���,n�)�'q��:FP����[p�����dn�GFb(�����n䁪��o�J��R:?Z.�=ʌ��u�v�z������J+֊�������H��BY���Y;NI"��(�0淴[�VjJQ6�CUk(K�?��'�h M� �g�/�w�Z�$,��Ѣ�Pٮ�f����pxM����U#�TV�;BY���\�}��LH��7��M���{��I��P7�z8�t&c��=�1j��:�u����t�!c����Ncw�Op/��;���S]��f��;}N�Ófv7�wG�}��>��L�5:�s����v�?��D��c{ݻ1^ཱ�^�?�k]��t=m�,�졪��}��<��U�EU��OG��hUߚ����E`���}�y��@Tc�IVL�Qzh
�o�қO��K�e_p;q���T ���U�?�-Fj
���S�C�<���(�-��k�J�o�ꚬ�Q�D�[􇾍�K���kբ�'��吷�M<�8�&��v.�l�*˥8�R-���0I��3Z�곲��/Z��;7������ś�;�fV؞NC�u�-����& ���D㡹jlFC*��۶�|�\�5����4Ĳ;X�"�o���-���H��L�e��c)����üB�L�Kr��0!�N $/y��(%��s3�J�`*�y��?�~�J%JKd�(E֔��F6�Z��s��]�M�QM�Z��:�W̮�8�an��$��8�nHڮ��j�Z�-�s���e�n���Q`3��P$*�t�0R�%#^�߫��3�l��&��h;�גf���|��X}�<d�?�A=>0�yn3L�jO��ڴB/R8�Ԛ�ڛtw�W�޼l�̖k�pwy��n"]���e�.�b┮�N5ic����Dn臍���d�a�X8|�F��pVI���E��Mt�+�&�+�� ,gQ����Q�%�#y�2w:��S��/��_��4�GUo��l��(;�Y�l)E� {��r���I��ɖ��κ�"� �Rϱ.�W���3,���������R~V��b�w�j�f��
g�☾�G�[jz���Su=l���H����9�a~�t�u��굙�u���v-����}#m{R���gq�S3�E�����g:5�(qG3#�Ō/�o9�j���I���T\Z�"�e��i%٘���]�o�J�4�;.��"�Ä�d!��H�3YU�z#/q�:��Gaד6��Dl�(^,��U������@�0�N�_����T�2�������)k��
�!�sK���Wv���_��s��(�y}��+��^:���W�<�j�g�?^�+��.���c��Fɚ�8?(8x*m�x;m�8,X���(�6�K5�~e���~�O�`��o`��B���_h��M��L0ز2C�v�m8�)��%�Z�EaD��<�[&�L�nFc����������zۤ������Pݞ��o�]��y���V�w�D�l?�q�-bU�q/w��u��t���M*�Y��oǪ���6Rͨ�D��x����������&�q-���m���.��,���J��� Ylҥ$b�ϗ���b���Ҧ
]���q�-K�(��׃7X���jOcn��*{v�5��b�xh�՚�`��..�K$H�\-��H8y�8���J�͍lQ���s�4�2�(�h-�����>)�M�s���S�	�Q�$^�oz��C�9����'�0U��Qd�[X6$���L��Y5x莫��}ldx��fn�=L���m��v�C����ub�׶��6|xu���U�z�Z�'3=K��բ6���?���9�TB��\��N�;1�wpx�S�T~�ݿ���4�*!@�,�L��/AS��N�1�\Y�m�n����~�����ˏ'��!�4���u��J��O����t�cf�u>vz��i_�vo��,���G��
؈���n������Q��/?'y��~|���Ψ���w�ч���6ތz�����v4�.����g�~�;v�QV�Z���7�������P�D��U������fg2���îo��<�.fY:װӤ��P���f_d�Q9GoPw�֎n�>7˴\�T����8���T*�j�h��sd�*��ӕz�i�.��v���)o|��~�R�8��ԔI�r �!�?8�:Q����a���<�Χa�|�I"U���D�L��S��Z���E7-o�D>2�3x[��.�T�1�q�.pl۵����Z����J�t�$�d9�bВ��*J�;ٚֻM��������M���S�>�JΑ*��r���u�����d�K���w�ȣ#>�V�g�;R�mT��J�ɫ�9&�6��T*8ՁG�����&.�u�QN*PS������%��Q�i}T~��EO��7p��c��Rͳ�l���X��\5[��1R�`���l�o�5T&A]7,ࣤ��������ב�����9�p�RW�Lx���̷إ��k����K~�U7��{�0��Z]��st�����j��.����j����ХE:U�r��=Ï�S/������cvq;��W�sZ��e΋�n�q;�$����y������=���>ve���L�	���`4��?|��]��|ݝ������NO�1l�v�H}��:\(�:�k���]w��~鸲O�l��]��.z��JL����-    ���ް����C�R=�=� ��ƽa���pܝ�
�b<t�p�!
����>��\~�_�E@G8�����	,�W�m��N��;�g�.܈v��!Ou�����F�cm�Q�4��g�kӇ +>��D�H7%l�i`��� ϳQf�)���n�OaX�R�z�݊,[�,ߏ	vb��N��\ˍImԧ�ܔ���9v��*UO?C��H�W�oq��� e��2W�I�N�
'Y������E�B��7���ى��m��(L�P[�L@���p�}�x��r��Ze۴�8���)�<_gr@䴾�[*�d�5�W�$�G
U8�Ď%��ZA������>�Χ(E�n��Oy:��@�8��!���~��&9pI+������Q�w�]�x���� ` x��D�!�׷:�{@1c�������re%ԃ�36e��-ߵ=��>�¯�P*��M�N���f+@{S���2� ��z�@ ������~4P�^��?)?~V�x��!�]�Z��ZE]N,��a�ޗX�G
֖���TX���~��*����C!p��n�A�y�1ιpy`���xh;1��rN��{n�_7�b�A�8
_���\K��yu���XH3�͈4��=oB��T�z�u4IM��ta��^v{��4���#��%/$O��R�v_����U��H#�8z��H;S5��#�2��,�9�*��Y�-����z�u�m%���\��D�L�$������ō$[�
�쳥���[�0E��{,�^n�H��I����0m�	�/���C[ b.���2L�۞���8�%V��}�nw��𺭦	~Ů��G����J�\�W��+s��tMw��Ip�}�*�)�&SQS�$r�w�fe�MQì!�X'p�q?V����F�`�v��SeN��v����j�Sf`5�X��]eY�
]�	�*�s� ���R�!f*�*��S�LQs�C�e(���XQ���h$�JF�J�d�-��J�>�M� �L��T�-�)WJh�d�K�=�9��MUr3	�+97�����Ķ]��*UмѴL�<${�x��bRN��"����{n�U���5�!<@�p���a��I#�Զ�;J��0v �6���_o�G��[^�9@k�+��֠q���Ak�g�`fMӉ�zǤ-<'�{��^�Z�y�*u/#xً�$��0Ռ^�s��t�ɔeS�?�3��X��+<��se��x��vDy�r�~V��
�q��DYv��}�Y(�L��1�]%�RLWykv]s�#	� >B��	�����u�
�	�X�Ơ�ނ٫���>w\۷ݴ	&m��<wP��1<��2�Ɇt�4��D=���n�l�v�&�=���!�9���hu����+4��l���O.�'s�ҿ��p|�z�59�T�{	��lV�ӆW��WOw�XH��1�X�16�jj�q�>�"�Am��Iu]���Y]�b^2&q��(<��pG�����O0#j�Ȉ�����m��Gz�)���Ŏ߰�A�U�a����Uډ��=�(_��2ݒY�-ٿPf00�0}!�m�V@�f���������!���'	��L�8�Pw��dz�!�I+U�>�S]8x���gm�J]��;��	i4�ٍ�B�3�M���1�Kv%̺�CuM��aS���Z#=2t�f�6l0'�]�
�O��F�Tf~�g��V8��b�aO����+pd�ƚ��]�Z	���۾�\h��Ϋ����H������:֬}y�G=�+���rF]^��O�b���R&���6��u�ר�¿�k�gzY�?�k���\����Ά,�l���@�@�����ro0�/�n̆RVv�ς�4�*�Ϛ�	wfs��Д��处v��U�pƒ�@���^"P�ۂR���z��c8�e��q�`�*r*��n���YA��κ��u��"C�`;Ho��NzX�z���;gث�S�*�hPrI�g:�c:ܷ\a��ŉa�X�n�(S�r�7|w_��.����2@�!����W�o���V�.k�����Z��h�~wQ�N�>��+�H�$���+���B�E������d�9�0ëf8N3�7��_�͛�fl����X�1;��5jED�H4z7�C�e�@�T�?`��6~�T����%U
R*ʋ@u��/t4�g ��G�9R1`Ύ$a�6����5��̋�+1.�����%s�r�w>��~Av2L�q�� ���qOE�����S�\�Q<k_�������B�؈&�� |j��4Jp�:Sj��N��M�B�l0O�R�BvYc^%�!�)E$���(�S@���z�f�Q�o����/:c�j8��ٸ;����������7�0F��	�����a���X�kq�%ߓB�i�.�P�=���Xi'>���b�Ήi.�S}�2jd��A��,��^i����WQ�w�M.�=�����2�Z����>�S� �)c߇m��~D,����hZ^�K"��$rfg��HAd��M��Ykjb�dF��`���U)���	�z��8~�a�O��[�d��\�y@�ìa�f]Q�="��*���U]l�e�Tcy�)b��-+o�Oё�jIZK9�<u��Da"�&�d�t󨿆t���+�9F�ܛ7���\Y�[{��2��fDW�4�JW~��Ժl�*�_����s�K��dq��e2��ɨ��T>:�$(�ȪN�ͫ�dy���4Z=�eP�mUgg�wo�-��,r�n�nW�K�j
���N��j(�Tv���ig4F��x��[�Z��A��J}lt�L�V�[�/tG�����=�{%h��J�
k�Z�}X��;��S�R(��2l<�W��n���a�^�U�i&�{��'�QeZ2ѩd��r*v��~�
�]��J����{�v��G�q��]���Wn�PIe�E[�+:�)S>/˯�f�VSUF@������	��5�V�2ɓ��P� ͐�� ��lP�R����dc�RS.�$;��|����s\.w�m�ۻ�9�2f�MG5v��YTM��gG`���yǼ���^p�5u��H�Z��w�>��96�IGI�Bݨ!��.��X��!}���༇>;�;2��;��}���s��D����;��S-�u�#$�.Ǭ3��xһ�L���t$��0U���o�LD+e���}`�N����ݎ;w�e�O�:ag<����u��S�_��dT�6��ʮ���݁������k��f�q4���<W��[ ��z�)hB�������:ϲK��r��yH��5�[M��q�m���${�����
���^E�.G>�/	�7I����R����H��QTSn�8d������v�U�k��1w[�y.I3�-8/�n�Wg�·���&T��Ed�fy|a���4���j~���'yʪ/1���F�M5�,�hD�bI�*�3
-v��dE��+�)����e;�=/�T!�X�*
�.��ZJ� =�1�UA�_��2Β�)&��T��^s����oR�<ؾJ]Eg�Z���^]/�HrY�)%>6��lT2��h+	���{,IH���|�HG�. Ց&�W8����!W�`\R�e�/���0���1;�.t�59�*tBx�c�F���m�p
W��J�~'lT���K���뿩�&
	�2��/�z?a�����v��8|��Z�^�wo_ýץ��7eSF��MNS���:_��/p����:�5q=Sd�K�·Kv9'��-���(^�o�R֍���-o*,bF�wû7�ZZEK֓!�7J��,��[���f��H��,u�MT��4*)ZR�Yy�[�l��<H��qWlE���նM�/�n[T�١E�<`w@iDsv���?SW��LD�t�T5�P�~v,��]P-4�����K�ڽoZ�5u����p˶�BS*��wb{�g~��Ğ���z��}����3�d�3�l����HAF��M��w����������|#��u��ҏ���h�ռNY��[���ȕ=�����8o��������9Yo�s��#��^�<�a��>��#�e�����R���    V}�N9g��m���i|Ɲh
���i�e��v�t�ùa5
~>�9$�@�6�H���c�&����Tݒ��:�-�@6k���ɑ88KV)Ý���4��L#3C]8�	�N%��*;^w�V�? ���gl�L���,�?`&���N�L�*�H����މR��X4Md���i�ښG��3�+��	�������	.Ӆ��\51/B�il<`�UQ�}�9���؞�؈���!���|x0�e������5Or���N���&`<��,k�G�&��@� �8@[Q|1M3.��`+�p�A[�΂���	øZ���&d���������e��<�X�2���F���C�9�;�o8��`UY�����AW���Q3Vc���@�Mc���SE5�t���*�}&��w�t*m�k��~�j��y���9AhS��v�n�ʘoQr�m*~�z�T�����|o����o�Oɠ��`1kES��^s��	���|^i���:�7'"a��I���
�J���l�x��'v�[��h�ʦ�OBR�ς'�a��������=��٩���ݝ0z���Dk?��� ��nP|��Qt'I���d�	όV����d@Ll!��E�t3N�e���Z!�>��VW����Y�	�>�y�'��-���_�lU>�?�$&lH�=G�9�l*wHN��������gsp���fk̻׏�/�<�~CY��	�*�*�S�tA�ඣ;��;&g����c���L�b�ĺ����/��G��)Ķy��k����u)��}��t�c��r��z�c�q��F�{���ly��Թrl���<��1c��S�	�ۛj�� A��<�[����N����g���Юrf���)Oq*a<�(W�D�sT��qg�D��jiS��4(GD�t�Q��r���m��໭�^1�{$9w�\
~�2��:�T�m�!�~BvlrD�"	��4���u�vaMz�Oݸ���p0��>,x�g/�韋:K����;��IL�o��/�~���<ݪ�a�G�� �t��ʫ��{��I���cZ�7sU+�o���.XB�Q���
���&��}�`���&⏊����h1#�pC	��{ d�7#�s����qFn��,s9��$��b#a6������l.h�7�n4҇f�kOt-�����q�Ao�O�p]���4U����[p����v�X��Po0��M۰�+ϒ���ڵ��۾���,A��y�"a�U��m)ߘ�!���h)�Wo#�4�L6�T\&+D�o����J*R�w8?�Sdm5�f>N)^e��X1�4�F�)��j����9�O��݃���'l�P?�i�θ����O�`4mڿL���kS���&�E�\���6��br��^���p ��pp2m����dB�I�l�Ix�{۝��y0���b������1~r=�O��La�Ko��O��OK�܃�	����ϰj�>&J'd6n0�,���\�13�;�5�3-1���AFX\/���2,G�P_�Iȣ��o"�,(@��|�}S���Js��q�l����
�~�S�:��J��b��e����0i�����X �Vc≎{�a|1��8�=�s�e��ckߔ��Y8?d�t���5/M�<;<��)� �I�N�	�6����X�9�iA!<(����=�ͅ�~���3�~�i ����Z��fL�PJD��Z�4Ȗ�A�.��$�b���w�|˅�Z�Ip90=��2��X��ˋ}�ePКv��|n�*����8��Z�zM�����帿�voO��ӼE����Q�w�Fa��-��m�'���!�"\8��y/'ܵ�U�R�V4�pҋS�T�6i]x"����KL��#�����Φ��@��cL0g�t{�Ѹ=��T��U�lC]��^�/E!�8OІ����T��8�?tǘq��`�~�Nt�QV�_��Z�p�;�9�0�^&-��Ƌ�uE�8���'�[g4�Y�D?S] �3��B	s �ey��e�C��@,�@ �x;��Ax=z��UK� J�����i���ʈȝ3^�����eŶ�q�|�.��8�[��$Z#��ѹ�� r�P�z�ث-�j_`��3K8���J�E��s�[]��5A���kEV�Kϱit�,D{W�3
q/�S��`�ˇ�&��+������ǎ�Lk�G�p҈`�[�BF���N�����D�ˎI6��B]Y�d�r��	���)�+_nB��mp'�3,����Ύ��!=�I�������0[g>�цg�gyϯS��tp��{eEF�(s�[� ���c�J�3�y�z�-���5t�{���d�Ygg5�Y�yi��uReG��?��
��.�_� ����h)�?e�r��/p��3r9�2�#o�}l��K�4�,���݄NWX$Yp-��C����^�!�>И���7ѴI��{D�����8�l�C�?�{d6�P(��WPza�^�����KR81������Q�:��`�B�)��,X�q)Bt�tQ�,�wx�����Z� !�0}�;�廾��`��G��M��[Vţ�F�V����9dV���7\�G��!RYƛ����8`�NɎ��"-���@�d7g��r[��p�/�^��+���'��`Q�Meþp�¨�̗s�8�pԼT��Vk��:05�V���ɍg�1�����*�\D&����_�-��扉f�d�%8��&�~���3z&���,A�ƮJ�l.<�.EK��Z�n�kB�%y���?��6�J�MM�I���L��!��҅z�r_PJbu�S������u%��������`L��M+C��3n�
�E�z�(�l��;,�=�J;�fv}�(ʺ�f�Q{�^��*Z_�Myl{�]Ƀ�E����;R!1���M��L\uh@҈�_#AJGtx|�+fL/_̤��T@bQ�𸏍K��0���{a�Qh��'-�s3����6�أ���M0�omrI@����'�J�����Υ����ӯ'�q�.o�ڿh_�_�Z�?���7(px>�?] �������WM�&H������݌�F7��8йl��ڸ���έjU�/`��hO8����]��D\�m{�(�&PތE���$1�3������Wmܻu{(�v;�_�'�:�w�i�M�?i�t�81t��-�|�Z�}��5vc@#���V��K2�*3��J&ץy��q�v�4r��3N����:���u�e��E��z�����وN.WR�Ԣ�|�C�?���1��b�w����d��aо�l���4R��-��Ci���*f��)�X��/S�j�5�	�x�bm�;_�[��Z�-�궂1�����&��|\UJ]:fCP�l�1l��/�����˿! *;��?Y�zO�����_�_Z�s8��>��hu�Ď$í�}�����K��V}.&G˭6��5���D #�VB�a�F	%i�<酜'9s��;j���A~6�/�R;e�L����4`�h�5�ߩ��N�G��0�*�l���b�K�yQ��R��

�	[���;yi�|���zC�Mxi$ᡘY��Z� ���H�\�����m S�GV�����`���N��<Ú��m�[<_N�5m���rR*_r�vuԶ)HOn��$��4��c+�E;7xR��7�U��dU�	�2yޅ�"��Q ��} ���v�GO�`��gk�؂��%�>EV�����6�)�z��U�##�_}o� }���b{sk6_��/���w��u]�b�	�os����`KH�/��X��<v�u�3��w̭H$�n���(�N��3�Yذ�S�oZ~tP����
fQ�K�sy+!_�K�TĔD��.��[��G�YB�r�ĬGtq_���=}����������6�aRS2�C��T�"2���*mSj�
&3n���pUPn��j����*�X�Cxo��$��C���	YGI�|��M��8�	����*j�m��6e�M���g���Rw/�U(�Tȭ6���y�|W���uˀ����    Y*�X B���n�<M��L���:���lnxF�&;�O��x����+ڇ8�J��($�q�X/�:ܕ������ry4�p]�T9V)7O}��1Q�A�h�.71m��0�VZ^Y�V�	j���D'?48>$_�WԻkC0��O%�'1R�9d�O�k�m�i�fܓ�y�D�$σ��ZfT�ҫ��q�V[������~����S���)b���q��Uz S�_�+���gr�~�>��mO2��P�t�R��Q�+�.���D�C`��A��$��q`|�$m�A#4�vJM�������t@��>����m��<������D�R�<rǛ������:=��
��m%�� J��ρ�ж�ʟI���$s�cA�;�5�bߥGM�g���-�<[O2Bf���ʘ�=#��؅w�U��%Vb���J��,޾����Y���1�2x���bBܬ��3 �2�7t!*�K�˲Be�ۘ�wSjH�v�a~hq�6Z�ɔ�3�"=���a�k�>�:��
�S����T^b���Uk��A�k�X��Ш��M�rqWLĺ�tN��� �
�Cƴa�ft�3��P�)�Ԡ�\{|?!).Ӳ}�C�$78O5� ��g4�=��q��2ǂLn��l��@5?��=���9K�b�I���ճfi2�D:�c��~��ݬ��{�P�;�"8)Meb6�W�=��R��[s����Z�7�U�  t��"�b�KuL�Txeu��0��a@������AL
c��mԾ?�	^D:��ި�@n<�>�x:��̒推���>F��Sd#~���s9!��3ګ����h�_�s���wo�����	�:���O�|�/Q/t�ЩFÉ24��6�N'Z�?����i������ד��Z���KM`���<M:���������}�zܻ��\i�F�%�����Χݓ��z3�O'�����d~*��g�S{mDU�&?Zgtu��� �]i��k�{�?�D�l��*�!ƚr*9i�g����a;o����&����4�K��tG����_�n�ܴ9�lӷ]7S���}f�h�d��sVغ��͘�z%t�r��'�
9�����j��op��� 3x�iK�R?�x���Iu�-�Pz
jU�n�ъ��Fy�L{�aF�E�B��JI�ni���L��Ӣ?��N�u�i_Ú���N�����~��,� �f+E�ơX�:7;2(�Z(�)�N�4g@�`3BX��%�[EhZQl�Pf0����X�T�
��'AkQS<U��S;���Yk��U�Z�a��(��l���R/�Lȸ���5&Vmw�yb!+�k��ŚPuʮ"��ܐ5A�������Ǟ�����gE�������K 4W�o���|P�{��zu�z�������jX�����/��HkPi� Kz8æ�G��#
��֛{����t�n���,��'u/-_r
�GM�B?:���������K��t�@��v%ݽ���_����_����8-�G(���yniEI`�<���F��fn�;�`sym��_!�>�@_�j�>s�����}���<���n��o[�/�����o��`Ph� 2ގ� �Gj��4s�,{��=�&wf�Y�eX�(���뻾����2ưqu����%@�X��n�7�z��s�42����gf��j*�����}�-�:��3SNJ[/Q�g���@C��\�G&9C7���Lސo�L���{*��h"�<�x���nD��"��扷�!Dd@(��1�'m(3�p�X���DU;)^�U���X���:!]��k�N%nSO�t��76@��.8y��|�!JZ�T ��M� �'G����K,{�3a������ĂO5���D�  ��#E<��@�iw��\_�7��-��
�KW\w[�5*	�ĳ`Y�k��Ÿ��7nOѨ�����2�
����MW�c�l����=��i�zMV��Y2̬�`�չ�0öM�wmf����`X�0
��B-9ʸ��̮]��I;:7�;s�v�+z7�v^��yp8+�����p/j��x��8^�!�n���K�f�����oT�q�>N�J�q<����w�����q��?���D5��Yp��!��#��
F;�N���rj���E�o1�A��M��Q�Y ��Š����t 3Ñ|�y�
l�,tc�Q����s��N�Z���� �sf�H�0<�e,���L�yw�?j�~Ԋm�+$����?�p�d��{z3�$�$�"f���*������J�ܲ+ڠ�i�����W����t�]E��y�$�;�ƣƯ��h�Z���@L�o�۶�^���Uo<n{�!�e_ҕ�}~3�Nl<����nj��A{��B(M6!�֔Čq�ӛL���l�������
6m����l 
��_cI���f����S�#x����Z���)f�.�sI&�d�D�W��l�B�B]r�����_�2�z���@�����w!��>*V��p(�P�T�*s�Y7ݽ����TW-#�`T�UE0(]�V�?�q�E������:p�x`J�Z��_��(-��5$�7O	&e������j3�pmT���M/�j�w6�����f�/�dqE��;sg�p��'�����%&+K�7��A<BF��4T�DB�j'ėW���P����I�/��6&A�F�\r�%S�����!}=2�R	/F`H�!U���ʞh߾H|l�os@HD��0-ݳ��6l�g��e:���m�ٶ�q(9Y��_<���іH��4$�r�Vf)�ZJ��b.���{��6��c��Q�;C��_�&q%{s���gi�*3iI,&�?��a�U�B���RȂ�r���U��\b�����}���lsG���Oڅ��t���E��!����r��&�o`�ܬ��/����aVE�ڡ�1�Â2;�'��`�`�l3��!}���N`�m}C��2�|�`6"�EV��O�Ĉ����P�x.]�PS�t��W�3�S�I?�w&��F+�1̉���O�@���rt@��<'s�C ,�^���G;�f��j3x�o� ��z����cfO*8i����-�
�D�B�	)���?�j����b��"1���9��Gq��J���#�G.{���W�ə�n��MU��p�4%�3&
����A�b�h���d�`�np?+�	f�}�3�Y��ۦkd�G-�F�F�S���Ǳl˳|��L���cd5��H3ze�rDp�� �74��&��f���3_���C�|=i�fR��GΠ�Jg�6p(�W�M��_އ�o.F��&��w`k���%e����}N�q���o�}盗v΄�U� �m�a�����ݣYA��7k��,�j���I=n5s�0�w��.�R펨�^D�q��o�+�'��>��F� YX�E�U��x�Sb���Z����D�����G�@�|����B�h��d<�?�����Ñv݃�s4�&W�O�8@�?�ښ�kB*軹�*r|�[��b�5���@����H�������QQ���l�0�~��w64<��C��u�C���ʢP���W�w��
`�0�v��)�W�6�i����7�0�^`-�V�l���ͅ��\���ܲ��rM�[ޢ���ݷ�����T��)��$�/��[q�+����߻�������Uڟ�������q��.���^BTC�	��	��	ǬHV$�y٥2b�h;���	�8�j,�$��a9���b��������%m�D��d�"��I\�<����%%�)�m�C���v�@VDA|��3¶�L�����S���jw�b��fɗ�@y��V�;�%A(���CC��&�E����U�! p�z�e����v\�y$=i�?0�O�-�`P<�z.�_5z�c����CĘ�2nq!(�D�Utx�4q����o��ej�O<m�&_mu{�Hm'[͝��'f�R��8�aҁ)�_��u��KZ���C8�mv��l�aBA�k2T.J���7��n6�Le��b��I�
B����/��3��l% �  ����r��j�A!a�Y)3Y{�d�,�yD"OFB;Y����e�Δ�)����R1(E9�5�Ū/���")��i�h��� �?��w@�-��L)�1RU�6	(_���~��^B���(�Du�=���_?��'<�Ы�x��l������%��h����׹i@���*�S(0F�~�E���p�HA*�,(,-w����,���o�.��s����ό��Jq?JG�v8'c`ҝ;>;�;���2o3%d��1��ktm�ɦL�r�t����q�s�u����#],��n������������\X�g�>Q�}Sē=f52&���u6�-�*�ZP������g�Eʡ �B����j�M�uL�sc�V�V�z����es�q��A�~��QF�V�3x#���K�y��m�3�~B� �(.�/	Ul�Ǫ>��WF��گ��c���.�Wnes?��f9Ǿ"��`"x�m�F�Ғ|��/�!�=�Z�AE��`�0�F����w�ƌ�caB��x��8�v=�q|����8L��MC>�e��f(�f�g�{2t�9s�����E�kŽ,�%\����JB���L��D���_�I}��ӫ�u< �+Ŗ�v��*��xh,��:���g�:`@a)�*���,A��f;,p<�bW��x9��ݰJd�m{��U�R��5��h�Jimhi5���A���؆w�]��{��X����aqv��5����!-�e�v��$��O�2�-b�����<��Y��=D�K�.��PS~q
Ϟ�	B����EǪ�|c�� Ţ�Î����[�bJ����qAJ
.�*�Xۖ����ޤ��_"��4S#U|����li	K�%-%��0��;̀��4�u-��!L��S�h��T�BM'���G7Uhm���S��R��G�ϝI5���^&,���
�*�5YH8Lt�MQFcB�斿��tƷ���<����͑�l�N��%���|{a��OL�!(�N�+��F�	z+�.�;�پay��F!;�Q��(_���J�BA`��;�c�.�#P�@���=SA�K2�Ԧ�H90ݺz�JC(K�L��	��U�]��A�}^��	^mhB{��̘��쨃7�����0SBO���4Տ��c��w.5(����U�7�f�(�}��L�P8���6uS��)�&�؆�	�T�f���Bl�;������@���=������/�2K���as�X�4((_D��ݖZ�R\��ۈ~Y/\�����"���݄͘�9�d���t�6�X�ҧ�D��F=x��,u�F�rv��Ô�v�B�ţP�[���y�6!.���5	V�1����X�M$Xn�|��Sv��C�s�0{L�;����+�&����a���ۦ�Q�i�`խ�e)-*a�v�$�d���X�t�3;I�.D_�Θoǟ�����O��N�            x������ � �            x������ � �            x������ � �            x������ � �      2      x������ � �      3      x������ � �            x������ � �             x������ � �      "   ?   x�ȱ�0�:^�;6�Є���/9]oOW��Z�F瘀�E;PQy�Uٖ<��lqp�      #      x������ � �      g      x������ � �      $      x������ � �      %      x������ � �      '   �   x�u�=o�0Eg�WT(rx~vlө)Z	"���4̋�$%P�[�� �X��.���9[m��^�!�0���S�BB�����V �N-� �1�x-���ǀ̂C4k�8u��������+gX/�J�]i\<M�O�������J%���<��7݁���SC�+�`�yV��G�(u�(�?:������d���cYշ��T��48��z��4ZN���"m��<S�mt���0z��$��_&uS�      )      x������ � �      *      x������ � �      +      x������ � �      -      x������ � �     