require('../lib/models/index.js')();
require('./connection.js');

var db      = require('../lib/utils/db.js');
var sql     = require('../lib/utils/require_sql.js');
var async   = require('async');
var request = require('request').defaults({ encoding: null });
var options = {limit:100};

var isMore = true;
var isMoreImageToProcess = function() { return isMore; };

var processPhoto = function(photo, cb) {
  request.get(photo.url, function (err, res, body) {
    if(err)
      return cb(err);

    Photo.setExif(body, photo.matrix_unique_id, (err) => {
      if(err)
        console.log(err);
      cb(); //Dont exit for all if it fails for a pic.
    });
  });
};

var processPhotos = function (callback) {
  console.log('Fetching new ' + options.limit + ' records');
  Photo.getPhotosWithoutExif(options, function (err, res) {
    if (err)
      return callback(err);

    if (res.length < 1) {
      isMore = false;
      console.log('No more record to process. Done!');
      return ;
    }

    async.forEach(res, processPhoto, callback);
  });
};

async.whilst(isMoreImageToProcess, processPhotos, (err) => {
  if(err)
    console.log(err);
  process.exit();
});
