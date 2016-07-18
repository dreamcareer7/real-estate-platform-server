'use strict';

var async = require('async');
var db = require('../lib/utils/db');

var up = [
  'DROP INDEX IF EXISTS photos_listing_mui_idx1',
  'CREATE INDEX photos_last_processed ON photos (last_processed)'
];

var down = [];

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
