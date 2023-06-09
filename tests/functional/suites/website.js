const website = require('./data/website.js')
const website_response = require('./expected_objects/website.js')

const hostname = 'localsite'

registerSuite('template', ['create', 'instantiate'])

const create = (cb) => {
  return frisby.create('create a website')
    .post('/websites', {
      ...website,
      template_instance: results.template.instantiate.data.id
    })
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: website
    })
    .expectJSONTypes({
      code: String,
      data: website_response
    })
}

const getAll = (cb) => {
  return frisby.create('get user\'s websites')
    .get('/websites')
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: [results.website.create.data]
    })
}

const get = (cb) => {
  return frisby.create('get website')
    .get('/websites/' + results.website.create.data.id)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: results.website.create.data
    })
    .expectJSONTypes({
      code: String,
      data: website_response
    })
}

const addHostname = (cb) => {
  results.website.create.data.hostnames = [hostname]

  return frisby.create('add hostname to a website')
    .post('/websites/' + results.website.create.data.id + '/hostnames', {
      hostname,
      is_default: true
    })
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: results.website.create.data
    })
    .expectJSONTypes({
      code: String,
      data: website_response
    })
}

const getByHostname = (cb) => {
  return frisby.create('get website by hostname')
    .get('/websites/search?hostname=' + hostname)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: results.website.create.data
    })
    .expectJSONTypes({
      code: String,
      data: website_response
    })
}

const deleteHostname = cb => {
  delete results.website.create.data.hostnames[0]

  return frisby.create('delete a hostname from a website')
    .delete(`/websites/${results.website.create.data.id}/hostnames?hostname=${hostname}`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: results.website.create.data
    })
    .expectJSONTypes({
      code: String,
      data: website_response
    })
}

const update = cb => {
  const updated = JSON.parse(JSON.stringify(website))
  updated.template = 'light2'
  updated.attributes.facebook_url = 'https://updated_facebook_url'
  updated.attributes.new_attribute = 'value'

  return frisby.create('update a website')
    .put('/websites/' + results.website.create.data.id, updated)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: updated
    })
    .expectJSONTypes({
      code: String,
      data: website_response
    })
}

const deleteWebsite = cb => {
  return frisby.create('delete a website')
    .delete(`/websites/${results.website.create.data.id}`)
    .after(cb)
    .expectStatus(204)
}

module.exports = {
  create,
  get,
  getAll,
  addHostname,
  getByHostname,
  deleteHostname,
  update,
  deleteWebsite
}
