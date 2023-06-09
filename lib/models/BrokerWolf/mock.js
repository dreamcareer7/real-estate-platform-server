const Nock = require('nock')

const { host } = require('../../../tests/functional/suites/data/brokerwolf/settings')

const options = {}

const nock = Nock(host, options)

const memberSamples = require('./members/samples')

nock
  .get('/wolfconnect/members/v1/')
  .query({
    '$orderby': 'CreatedTimestamp',
    '$top': 300,
    '$skip': 0
  })
  .reply(200, memberSamples)

const propertyTypeSamples = require('./property-types/samples')
nock.get('/wolfconnect/property-types/v1/').reply(200, propertyTypeSamples)

const classificationSamples = require('./classifications/samples')
nock.get('/wolfconnect/classifications/v1/').reply(200, classificationSamples)

const contactTypeSamples = require('./contact-types/samples')
nock.get('/wolfconnect/contact-types/v1/').reply(200, contactTypeSamples)

const transactionSample = require('./transaction/sample')
nock.post('/wolfconnect/transactions/v1/').reply(200, transactionSample)

nock.persist()
