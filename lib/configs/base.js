const domain_contact = {
  nameFirst: 'Shayan',
  nameLast: 'Hamidi',
  organization: 'Rechat inc' ,
  email: 'support@rechat.com' ,
  phone: '+1.9729711191' ,
  addressMailing: {
    address1: 'Address' ,
    city: 'Dallas',
    state: 'Texas' ,
    postalCode: '55555' ,
    country: 'US'
  }
}

module.exports = {
  pg: {
    connection: {
      user: null,
      database: null,
      password: null
    },
    connection_timeout: 10000,
    pool_size: 3000
  },

  url: {
    protocol: 'http',
    hostname: 'localhost',
    port: 3078
  },

  allowed_upload_types: ['png', 'gif', 'jpg', 'jpeg', 'docx', 'doc', 'pdf', 'xls', 'xlsx', 'mp4', 'mov', 'webm', 'txt', 'csv', 'heic', 'mp4', 'html', 'pages', 'svg'],

  assets: 'http://assets.rechat.com',

  redis: {
    url: process.env.NODE_ENV === 'tests' ? 'redis://127.0.0.1:6379/1' : 'redis://127.0.0.1:6379'
  },

  http: {
    port: 3078,
    sport: 3079
  },

  auth: {
    access_token_lifetime: 86400 * 31
  },

  salt: {
    string: null,
    iterations: 1000,
    length: 5
  },

  buckets: {
    private: {
      name: null,
      region: null,
      cdn: {
        url: null,
        keypair: {
          id: null,
          private: null
        }
      }
    },
    public: {
      name: null,
      region: null,
      cdn: {
        url: null
      }
    }
  },

  airship: {
    key: null,
    secret: null,
    masterSecret: null,
    parallel: 10
  },

  mls: {},

  ntreis: {
    login_url: 'http://matrixrets.ntreis.net/rets/login.ashx',
    user: null,
    password: null,
    parallel: 100,
    gallery: 'Photo',
    pause: 20000,
    default_photo_ext: '.jpg',
    default_limit: 3000,
    version: '0.2',
    photo_update_batch_size: 50,
    concurrency: 5,
    timeout: 300000
  },

  slack: {
    enabled: false,
    webhook: null,
    name: 'Development',
    support: {
      enabled: false,
      signing_secret: null
    }
  },

  geo: {
    enabled: false,
  },

  google: {
    address_batch_size: 320,
    concurrency: 1,
    pause: 200,
    api_key: null,
    url: 'https://maps.googleapis.com/maps/api/geocode/json',
    use_key: false,
    client_id: null,
    project_id: null,
    auth_uri: 'https://accounts.google.com/o/oauth2/auth',
    token_uri: 'https://accounts.google.com/o/oauth2/token',
    auth_provider_x509_cert_url: 'https://www.googleapis.com/oauth2/v1/certs',
    client_secret: null,
    redirect_uri: 'http://localhost:3078/calendar/callback?user=',
    scopes: ['https://www.googleapis.com/auth/calendar'],
    access_type: 'offline',
    web_hook: 'https://localhost:3078/calendar/notifications'
  },

  bing: {
    url: 'http://dev.virtualearth.net/REST/v1/Locations',
    api_key: null,
    address_batch_size: 30,
    concurrency: 5,
    pause: 200,
    staging: 1000000
  },

  email: {
    from: 'Rechat Support <support@rechat.com>',
    parallel: 10,
    seamless_address: null,
    seamless_delay: '2 minute', // Postgres interval
    seamless_timeout: '30 minute', // Postgres interval
    stat_update_delay: 1000 * 3
  },

  crypto: {
    key: null,
    iv: null,
    sign: {
      alghoritm: 'RSA-SHA256',
      private: null,
      public: null
    }
  },

  tests: {
    client_id: 'bf0da47e-7226-11e4-905b-0024d71b10fc',
    client_secret: 'secret',
    username: 'test@rechat.com',
    password: 'aaaaaa',
    port: 3079
  },

  twilio: {
    sid: null,
    auth_token: null,
    parallel: 10,
    from: '+17205732428'
  },

  app: {
    name: 'rechat'
  },

  webapp: {
    hostname: 'localhost',
    protocol: 'http',
    port: 8080
  },

  branch: {
    base_url: 'https://api.branch.io'
  },

  datadog: {
    api_key: null
  },

  mailgun: {
    api_key: null,
    domain: null,
  },

  intercom: {
    enabled: false,
    app: null,
    token: null
  },

  webserver: {
    host: 'rechat.site'
  },

  stripe: {
    key: null
  },

  godaddy: {
    key: null,
    secret: null,

    registrant: domain_contact,
    admin: domain_contact,
    tech: domain_contact,
    billing: domain_contact,

    nameservers: [
      'dns.rechat.site',
      'ssl.rechat.site'
    ]
  },

  forms: {
    url: null,
    cdn: null
  },

  screenshots: {
    host: 'https://screenshots.rechat.com'
  },

  docusign: {
    baseurl: 'https://account-d.docusign.com',
    integrator_key: null,
    secret_key: null
  },

  scheduler: {
    queues: {
      refresh: {
        refresh_agents: {
          command: ['refresh/agents.js'],
          interval: 60000 * 60 * 24,
          priority: 2
        },

        refresh_schools: {
          command: ['refresh/schools.js'],
          interval: 86400 * 1000 * 7,
          priority: 2
        },

        refresh_mls_areas: {
          command: ['refresh/areas.js'],
          interval: 86400 * 1000 * 7,
          priority: 2
        },

        refresh_counties: {
          command: ['refresh/counties.js'],
          interval: 86400 * 1000 * 7,
          priority: 2
        },

        refresh_subdivisions: {
          command: ['refresh/subdivisions.js'],
          interval: 86400 * 1000 * 7,
          priority: 2
        },

        refresh_deals_buyers: {
          command: ['refresh/deals_buyers.js'],
          interval: 60 * 60 * 1000,
          priority: 1
        },

        refresh_deals: {
          command: ['refresh/deals.js'],
          interval: 1000 * 30,
          priority: 1
        }
      },

      geocode: {
        fix_geocode: {
          command: [ 'geocode/fix.js' ],
          interval: 1 * 3600 * 1000,
          priority: 3
        }
      },

      calendar: {
        calendar_notification: {
          command: [ 'calendar/notification.js' ],
          interval: 0.5 * 3600 * 1000,
          priority: 1
        }
      },

      docusign: {
        update_tokens: {
          command: [ '../docusign/update-tokens.js' ],
          interval: 86400 * 1000,
          priority: 1
        }
      },

      brokerwolf: {
        sync_all: {
          command: [ '../brokerwolf/sync-all.js' ],
          interval: 86400 * 1000,
          priority: 1
        }
      }
    }
  },
  amqp: {
    connection: process.env.CLOUDAMQP_URL || 'amqp://guest@localhost/',
  },

  task_notification_delay: 1000 * 60 * 5,

  calendar: {
    notification_hour: 8, // Time of the day at which users will receive calendar notifications
  },

  showings: {
    crawling_gap_hour: '1 hours',
    first_crawl_time_window: 90,
    recurring_crawl_days_back: 60
  },


  email_composer: {
    attachment_upload_limit: {
      mailgun: 15728640, // In bytes, 15MB
      gmail: 27262976, // In bytes, 26MB
      outlook: 27262976, // In bytes, 26MB
    },
    signature_upload_limit: 5242880 // 5 MB
  },

  google_scopes: {
    basic: ['profile', 'email'],

    contacts: {
      full: ['https://www.googleapis.com/auth/contacts'],

      readonly: ['https://www.googleapis.com/auth/contacts.readonly'],

      other: {
        readonly: ['https://www.googleapis.com/auth/contacts.other.readonly']
      } 
    },

    gmail: {
      readonly: ['https://www.googleapis.com/auth/gmail.readonly'],

      send: [
        'https://www.googleapis.com/auth/gmail.send'
      ],

      modify: [
        'https://www.googleapis.com/auth/gmail.modify'
      ],
    },

    calendar: [
      'https://www.googleapis.com/auth/calendar'
    ]
  },

  google_integration: {
    max_sync_emails_num: 5000,
    backward_month_num: 24,

    credential: {},
    subscription: {
      topic: null
    },

    crm_task_update_reason: 'gcal_google_to_rechat',
    contact_update_reason: 'google_integration',

    slack_channel: 'google_integration'
  },


  microsoft_scopes: {
    basic: ['openid', 'offline_access', 'profile', 'email', 'User.Read'],

    contacts: {
      read: ['Contacts.Read'],
      full: ['Contacts.ReadWrite']
    },
      
    mail: {
      read: ['Mail.Read'],

      send: ['Mail.Send'],

      draft: ['Mail.ReadWrite']
    },

    calendar: ['Calendars.ReadWrite']
  },

  microsoft_integration: {
    max_sync_emails_num: 5000,
    backward_month_num: 24,

    credential: {},
    subscription_secret: 'xc78tt14zl772fm8xr0gyqqd',
    subscription_secret_calendar: 'c5l3prx8mh0evaiqeolf0von',
    subscription_secret_contacts: 't0OtW4Inbka5rB2yKbK1lAmT',

    openExtension: {
      outlook: {
        id: 'Microsoft.OutlookServices.OpenTypeExtension.Rechat_Outlook_Ext',
        name: 'Rechat_Outlook_Ext'
      },
      calendar: {
        id: 'Microsoft.OutlookServices.OpenTypeExtension.Rechat_Outlook_Cal_Ext',
        name: 'Rechat_Outlook_Cal_Ext'
      },
      contact: {
        id: 'Microsoft.OutlookServices.OpenTypeExtension.Rechat_Outlook_Contact_Ext',
        name: 'Rechat_Outlook_Contact_Ext'
      }
    },

    crm_task_update_reason: 'mcal_google_to_rechat',
    contact_update_reason: 'microsoft_integration',

    slack_channel: 'microsoft_integration'
  },


  emails_integration: {
    time_gap: '2 hour',
    miliSec: 1 * 60 * 60 * 1000,

    outlook: {
      time_gap: '15 minutes',
      miliSec: 10 * 60 * 1000,
    },

    sync_by_query: {
      time_gap: '1 minute'
    }
  },

  calendar_integration: {
    time_gap: '15 minutes',
    miliSec: 10 * 60 * 1000
  },

  contacts_integration: {
    time_gap: '12 hours',
    miliSec: 24 * 60 * 60 * 1000,

    avatars_time_gap: '1 hour'
  },


  aws: {
    AWS_KMS_KEY_ID: 'xxx-xxx-xxx-xxx-xxx'
  },

  chargebee: {
    api_key: null,
    site: null
  },

  daily: {
    webinars_api_key: null,
    webinars_url: null
  },

  cloudflare: {
    account_id: null,
    api_key: null,
    base_url: 'https://api.cloudflare.com',
    email: null,
    records: [
      {
        type: 'CNAME',
        name: '@',
        content: 'dns.rechat.site',
        ttl: 120
      },
      {
        type: 'CNAME',
        name: 'www',
        content: 'dns.rechat.site',
        ttl: 120
      }
    ]
  }
}
