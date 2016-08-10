'use strict';

var async = require('async');
var db = require('../lib/utils/db');
var fs = require('fs');

var listings_filters = fs.readFileSync('./lib/sql/alert/listings_filters.mv.sql').toString();

var up = [
  'ALTER TABLE alerts ADD COLUMN selling_offices text[]',
  'ALTER TABLE alerts ADD COLUMN selling_agents  text[]',
  'DROP MATERIALIZED VIEW listings_filters',
  listings_filters
];

var down = [
  'ALTER TABLE alerts DROP COLUMN selling_offices',
  'ALTER TABLE alerts DROP COLUMN selling_agents'
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
