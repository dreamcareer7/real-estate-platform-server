var user = require('./user.js');
var recommendation = require('./recommendation.js');

module.exports = {
  "type": String,
  "id": String,
  "message": String,
  "created_at": Number,
  "updated_at": Number,
  "room": String,
  "action": String,
  "object_class": null,
  "auxiliary_object_class": null,
  "auxiliary_object": null,
  "recommendation": function(val) { expect(val).toBeTypeOrNull(String); },
  "auxiliary_subject": null,
  "subject_class": String,
  "auxiliary_subject_class": null,
  "extra_subject_class": null,
  "extra_object_class": null,
  "deleted_at": function(val) { expect(val).toBeTypeOrNull(Number); },
  "specific": null,
  "notification_type": String,
  "objects": null,
  "subjects": [user],
  "recommendations": function(val) { expect(val).toBeTypeOrNull([recommendation]); },
};