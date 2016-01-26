var user = require('./user.js');
var v = require('../../../lib/utils/response_validation.js');

module.exports = {
  "id": String,
  "contact_user": user,
  "created_at": Number,
  "updated_at": Number,
  "deleted_at": v.optionalNumber,
  "first_name": v.optionalString,
  "last_name": v.optionalString,
  "phone_number": String,
  "email": String,
  "profile_image_url": v.optionalString,
  "invitation_url": v.optionalString,
  "company": v.optionalString,
  "address": v.optionalString,
  "birthday": v.optionalNumber,
  "cover_image_url": v.optionalString,
  "type": "contact",
  "tags": v.optionalArray
};
