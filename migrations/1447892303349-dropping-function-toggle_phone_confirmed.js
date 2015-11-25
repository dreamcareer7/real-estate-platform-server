'use strict';

var db = require('../lib/utils/db');

var sql_up   = 'DROP FUNCTION IF EXISTS toggle_phone_verification();';

var sql_down = 'CREATE OR REPLACE FUNCTION toggle_phone_confirmed() RETURNS TRIGGER AS $toggle_phone_confirmed$\
                BEGIN\
                UPDATE users\
                SET phone_confirmed = false\
                WHERE id = NEW.id;\
                RETURN NEW;\
                END;\
                $toggle_phone_confirmed$ language plpgsql;';

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
