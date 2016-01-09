'use strict';

var async = require('async');
var db = require('../lib/utils/db');

var up = [
  'ALTER TABLE alerts ADD listing_statuses listing_status[] NOT NULL DEFAULT \'{"Active"}\';',
  'UPDATE alerts SET listing_statuses = \'{"Active"}\';'
];

var down = [
  'ALTER TABLE alerts DROP COLUMN listing_statuses;',
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
