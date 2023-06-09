const schools_response = require('./expected_objects/schools.js')

const searchWithInvalidQuery = (cb) => {
  return frisby.create('expect 400 with invalid (small) q')
    .get('/schools/search?q=a')
    .after(cb)
    .expectStatus(400)
}

const searchWithValidQuery = (cb) => {
  return frisby.create('expect 200 with valid query')
    .get('/schools/search?q=Wylie')
    .after(cb)
    .expectStatus(200)
}

const invalidDistrictsSearch = (cb) => {
  return frisby.create('expect 400 with invalid districts, districts should be an array')
    .get('/schools/search?districts=a')
    .after(cb)
    .expectStatus(400)
}

const searchByDistricts = (cb) => {
  return frisby.create('search for schools by districts')
    .get('/schools/search?districts[]=Dallas ISD')
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: []
    })
    .expectJSONTypes({
      code: String,
      data: [schools_response.schools]
    })
}

const searchDistrictsWithInvalidQuery = (cb) => {
  return frisby.create('expect 400 with invalid query, query should be an array')
    .get('/schools/districts/search?q=a')
    .after(cb)
    .expectStatus(400)
}

const searchDistricts = (cb) => {
  return frisby.create('search for districts')
    .get('/schools/districts/search?q[]=Dallas')
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: []
    })
    .expectJSONTypes({
      code: String,
      data: [schools_response.districts]
    })
}

module.exports = {
  searchWithInvalidQuery,
  searchWithValidQuery,
  invalidDistrictsSearch,
  searchByDistricts,
  searchDistrictsWithInvalidQuery,
  searchDistricts
}
