const Nock = require('nock')
const config = require('../../config.js')

const nock = Nock(config.docusign.baseurl)
const demoUrl = 'https://demo.docusign.net'

nock.post('/oauth/token').reply(200, {
  access_token: 'Mock Access Token',
  refresh_token: 'Mock Refresh Token',
  token_type: 'Bearer',
  expires_in: 28800
})

nock.get('/oauth/userinfo').reply(200, {
  sub: '2befd66e-0c51-4d98-b590-82ffa707afbc',
  name: 'Test Rechat',
  given_name: 'Test',
  family_name: 'Rechat',
  created: '2017-04-18T16:56:58.183',
  email: 'test@rechat.com',
  accounts: [
    {
      account_id: '6dc2efb6-908e-46ee-9313-a3b2bbfd4f32',
      is_default: true,
      account_name: 'Rechat',
      base_uri: demoUrl
    }
  ]
})

nock.persist()

const n2 = Nock(demoUrl)

const id = '0bd9ee91-0146-4268-8230-f8f4094935b5'
const base = '/restapi/v2/accounts/6dc2efb6-908e-46ee-9313-a3b2bbfd4f32'

n2.post(`${base}/envelopes`).reply(201, {
  envelopeId: id,
  uri: `/envelopes/${id}`,
  statusDateTime: '2017-06-05T18:00:58.1094608Z',
  status: 'sent'
})

n2.get(`${base}/envelopes/${id}/documents/1`).reply(200, 'PDF')

n2.get(`${base}/envelopes/${id}/documents/combined`).reply(200, 'Combined PDFs')

const signUrl = `${base}/Signing/startinsession.aspx`
n2.post(`${base}/envelopes/${id}/views/recipient`).reply(201, {
  url: demoUrl + signUrl
})

n2.get(signUrl).reply(200)

n2.put(`${base}/envelopes/${id}`).reply(200, {
  envelopeId: id
})

n2.persist()