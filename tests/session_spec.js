var frisby = require('frisby');
var config = require('../lib/config.js');

var URL = 'http://localhost:'+config.http.port;

frisby.globalSetup({
  request: {
    json:true
  }
});

var session = {
  device_name:'iPhone Emulator',
  device_uuid:'AC285B9D-6C5A-48F7-A704-7D6F12D70BFE',
  client_version:'0.1'
};


var createSession = frisby.create('create session')
  .post(URL+'/session', session)
  .expectStatus(201)
  .expectJSON({
    code:'OK',
    data:{
      type: "session",
      api_base_url: "https://api.shortlisted.com:443",
      client_version_status: "UPGRADE_AVAILABLE",
    }
  });


describe("/session", function() {
  it("creates a session", function() {
    createSession.toss();
  });
});