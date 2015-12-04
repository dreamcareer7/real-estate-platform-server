'use strict';

var db = require('../lib/utils/db');

var sql_up   = 'ALTER TYPE notification_object_class ADD VALUE \'Invitation\';';
var sql_down = 'SELECT NOW();';

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
