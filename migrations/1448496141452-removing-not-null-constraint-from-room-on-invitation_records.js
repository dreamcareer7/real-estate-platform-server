'use strict';

var db = require('../lib/utils/db');

var sql_up   = 'ALTER TABLE invitation_records ALTER COLUMN room DROP NOT NULL;';
var sql_down = 'ALTER TABLE invitation_records ALTER COLUMN room SET NOT NULL;';

var runSql = (sql) => {
  return (next) => {
    db.conn( (err, client) => {
      if(err)
        return next(err);

      return client.query(sql, next);
    });
  };
};

exports.up = runSql(sql_up);
exports.down = runSql(sql_down);
