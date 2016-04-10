'use strict';

var async = require('async');
var db = require('../lib/utils/db');

var up = [
  'ALTER TABLE listings ADD showing_instructions TEXT, ADD appointment_phone TEXT, ADD appointment_phone_ext TEXT, ADD appointment_call TEXT, ADD owner_name TEXT, ADD seller_type TEXT, ADD occupancy TEXT, ADD private_remarks TEXT'
];

var down = [
  'ALTER TABLE listings DROP COLUMN showing_instructions, DROP COLUMN appointment_phone, DROP COLUMN appointment_phone_ext, DROP COLUMN appointment_call, DROP COLUMN owner_name, DROP COLUMN seller_type, DROP COLUMN occupancy, DROP COLUMN private_remarks'
];

var runAll = (sqls, next) => {
  db.conn( (err, client) => {
    if(err)
      return next(err);

    async.eachSeries(sqls, client.query.bind(client), next);
  });
};

var run = (queries) => {
  return (next) => {
    runAll(queries, next);
  };
};

exports.up = run(up);
exports.down = run(down);
