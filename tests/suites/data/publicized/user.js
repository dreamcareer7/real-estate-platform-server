module.exports = {
    "type": String,
    "username": function(val) { expect(val).toBeTypeOrNull(String); },
    "first_name": String,
    "last_name": String,
    "email": String,
    "phone_number": String,
    "created_at": Number,
    "id": String,
    "cover_image_url": null,
    "profile_image_url": String,
    "updated_at": Number,
    "user_status": String,
    "profile_image_thumbnail_url": null,
    "cover_image_thumbnail_url": null,
    "email_confirmed": Boolean,
    "timezone": String,
    "user_code": Number,
    "user_type": String,
    "deleted_at": null,
    "phone_confirmed": false,
    "current_time": String,
    "push_allowed": false,
    "address": null,
    "invitation_url": String
  };