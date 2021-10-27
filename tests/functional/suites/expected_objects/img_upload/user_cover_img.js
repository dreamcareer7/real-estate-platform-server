const v = require('../validation.js')

module.exports = {
  'type': 'user',
  'id': String,
  'username': v.optionalString,
  'first_name': String,
  'last_name': String,
  'email': String,
  'phone_number': v.optionalString,
  'created_at': Number,
  'cover_image_url': v.optionalString,
  'profile_image_url': v.optionalString,
  'updated_at': Number,
  'user_status': String,
  'profile_image_thumbnail_url': v.optionalString,
  'cover_image_thumbnail_url': v.optionalString,
  'email_confirmed': Boolean,
  'timezone': String,
  'user_type': String,
  'deleted_at': v.optionalString,
  'phone_confirmed': Boolean,
  'current_time': String,
  'push_allowed': Boolean,
  'email_signature': v.optionalString,
  'address_id': v.optionalString,
  'is_shadow': Boolean,
  'personal_room': v.optionalString,
  'brand': v.optionalString,
  'fake_email': Boolean,
  'features': v.optionalArray,
  'last_seen_at': v.optionalString,
  'last_seen_type': v.optionalString,
  'has_docusign': Number,
  'active_brand': v.optionalString,
  'display_name': String,
  'abbreviated_display_name': String,
  'online_state': String
}