const { aggregate } = require('../../lib/utils/worker')

const config = require('../../lib/config')

const {
  contacts,
  contact_import,
  contact_lists,
  contact_duplicates,
} = require('../../lib/models/Contact/worker')

const touches_handler = require('../../lib/models/CRM/Touch/worker')
const tasks_handler = require('../../lib/models/CRM/Task/worker')
const calendar_handlers = require('../../lib/models/Calendar/worker')

const Agent = require('../../lib/models/Agent')
const Email = require('../../lib/models/Email')
const { Listing } = require('../../lib/models/Listing')
const Notification = require('../../lib/models/Notification')
const User = require('../../lib/models/User')
const ShowingsCrawler = require('../../lib/models/Showings/crawler')
const GoogleWorkers = require('../../lib/models/Google/workers/')


const airship = (job, done) => {
  const {
    notification_user,
    notification,
    user_id,
    token
  } = job.data

  Notification.sendToDevice(notification_user, notification, token, user_id, done)
}

const notification = (job, done) => {
  Notification.create(job.data.notification, done)
}

const email = (job, done) => {
  Email.send(job.data).nodeify(done)
}

const sms = (job, done) => {
  SMS.callTwilio(job.data, done)
}

const saveLastSeen = (job, done) => {
  User.saveLastSeen(job.data, done)
}

const mls_unit = (job, done) => {
  PropertyUnit.create(job.data.processed).nodeify(done)
}

const mls_openhouse = (job, done) => {
  OpenHouse.create(job.data.processed).nodeify(done)
}

const mls_room = (job, done) => {
  PropertyRoom.create(job.data.processed).nodeify(done)
}

const mls_agent = (job, done) => {
  Agent.create(job.data.processed).nodeify(done)
}

const mls_office = (job, done) => {
  Office.create(job.data.processed).nodeify(done)
}

const mls_photo = (job, done) => {
  Photo.create({
    ...job.data.processed,
    revision: job.data.revision
  }).nodeify(done)
}

const mls_listing = (job, done) => {
  Listing.create({
    ...job.data.processed,
    revision: job.data.revision
  }, done)
}

const mls_validate_listing_photos = (job, done) => {
  Photo.deleteMissing(job.data.listing, job.data.present).nodeify(done)
}

const sync_brokerwolf = (job, done) => {
  Deal.get(job.data.id, (err, deal) => {
    if (err)
      return done(err)

    Deal.BrokerWolf.sync(deal).nodeify(done)
  })
}

const deal_email = (job, done) => {
  Deal.Email.accept(job.data.incoming).nodeify(done)
}

const showings_crawler = (job, done) => {
  ShowingsCrawler.startCrawler(job.data).nodeify(done)
}

const google_sync = (job, done) => {
  GoogleWorkers.syncGoogle(job.data).nodeify(done)
}


module.exports = {
  airship_transport_send_device: {
    handler: airship,
    parallel: config.airship.parallel
  },

  create_notification: {
    handler: notification,
    parallel: 50
  },

  email: {
    handler: email,
    parallel: 50
  },

  sms: {
    handler: sms,
    parallel: config.twilio.parallel
  },

  save_last_seen: {
    handler: saveLastSeen,
    parallel: 5
  },

  'MLS.Unit': {
    handler: mls_unit,
    parallel: 50
  },

  'MLS.Room': {
    handler: mls_room,
    parallel: 50
  },

  'MLS.OpenHouse': {
    handler: mls_openhouse,
    parallel: 50
  },

  'MLS.Agent': {
    handler: mls_agent,
    parallel: 50
  },

  'MLS.Office': {
    handler: mls_office,
    parallel: 50
  },

  'MLS.Photo': {
    handler: mls_photo,
    parallel: 50
  },

  'MLS.Listing': {
    handler: mls_listing,
    parallel: 50
  },

  'MLS.Listing.Photos.Validate': {
    handler: mls_validate_listing_photos,
    parallel: 50
  },

  'sync_brokerwolf': {
    handler: sync_brokerwolf,
    parallel: 1
  },

  'deal_email': {
    handler: deal_email,
    parallel: 5
  },

  contact_import: {
    handler: contact_import,
    parallel: 4
  },

  contacts: {
    handler: contacts,
    parallel: 8
  },

  contact_lists: {
    handler: contact_lists,
    parallel: 8
  },

  contact_duplicates: {
    handler: contact_duplicates,
    parallel: 8
  },

  touches: {
    handler: touches_handler,
    parallel: 8
  },

  tasks: {
    handler: tasks_handler,
    parallel: 8
  },

  calendar: {
    handler: aggregate(calendar_handlers),
    parallel: 2
  },

  showings_crawler: {
    handler: showings_crawler,
    parallel: 1
  },

  google_sync: {
    handler: google_sync,
    parallel: 1
  }
}
