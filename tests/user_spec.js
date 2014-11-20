var frisby = require('frisby');
var config = require('../lib/config.js');

var URL = 'http://localhost:'+config.http.port;

frisby.globalSetup({
  request: {
    json:true
  }
});

var user = {
  username:'phubar',
  first_name:'foo',
  last_name:'bar',
  email:'foo.bar@provider.tld',
  phone_number:'989124834198',
};

var address = {
  title:'title',
  subtitle:'subtitle',
  street_number:'#333',
  street_name:'phu street',
  city:'los majones',
  state:'texas',
  state_code:'TX',
  zip_code:'12345',
  neighborhood:'disastrous place'
}

var createUser = frisby.create('create user')
  .post(URL+'/user', user)
  .expectStatus(201)
  .afterJSON(function(json) {
    user.id = json.id;

    getUser = frisby.create('get user')
      .get(URL+'/user/'+user.id)
      .expectJSON(user)
      .expectStatus(200);

    updatedUser = JSON.parse(JSON.stringify(user));
    updatedUser.first_name = 'updated first name';
    updateUser = frisby.create('update user')
      .put(URL+'/user/'+user.id, updatedUser)
      .expectStatus(200);

    getUpdatedUser = frisby.create('get updated user')
      .get(URL+'/user/'+user.id)
      .expectJSON(updatedUser)
      .expectStatus(200);

    deleteUser = frisby.create('delete user')
      .delete(URL+'/user/'+user.id)
      .expectStatus(204);

    setAddress = frisby.create('set address')
      .put(URL+'/user/'+user.id+'/address', address)
      .expectStatus(200);

    deleteAddress = frisby.create('delete address')
      .delete(URL+'/user/'+user.id+'/address')
      .expectStatus(204);

    getAddress = frisby.create('get address')
      .get(URL+'/user/'+user.id+'/address')
      .expectJSON(address)
      .expectStatus(200);
  });


describe("/user", function() {
  it("creates, gets and deletes a user", function() {
    createUser.after(function() {
      getUser.after(function() {
        updateUser.after(function() {
          getUpdatedUser.after(function() {
            setAddress.after(function() {
              getAddress.after(function() {
                deleteAddress.after(function() {
                  deleteUser.toss();
                }).toss();
              }).toss();
            }).toss();
          }).toss();
        }).toss();
      }).toss();
    }).toss();
  });
});