const listing = require('./listing.js')
const v = require('./validation.js')

module.exports = {
  'type': 'recommendation',
  'id': String,
  'source': String,
  'source_url': String,
  'referring_objects': [String],
  'listing': listing,
  'recommendation_type': 'Listing',
  'hidden': Boolean,
  'created_at': Number,
  'updated_at': Number,
  'deleted_at': v.optionalNumber,
  'comment_count': Number,
  'document_count': Number,
  'video_count': Number,
  'image_count': Number,
  'room': String,
  'users': Array
}
