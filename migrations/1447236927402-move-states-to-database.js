'use strict';

var db = require('../lib/utils/db');

var createDb   = 'CREATE TABLE migrations ( created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(), state jsonb );';
var insert = 'INSERT INTO migrations (state) VALUES (\'{"state":{"pos":14}}\');';
var dropDb = 'DROP TABLE migrations';

function up(next) => {
  db.conn( (err, client) => {
    if(err)
      return next(err);

    client.query(dropDb, (err) => {
      if(err)
        return next(err);

      client.query(insert, next);
    })
  });
}

function down(next) => {
  db.conn( (err, client) => {
    if(err)
      return next(err);

    client.query(dropDb, next);
  });
}

exports.up = up;
exports.down = down;
