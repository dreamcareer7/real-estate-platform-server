const expect = require('../utils/validator.js').expect
const fixHeroku = require('../utils/fix-heroku.js')

const bodyParser = require('body-parser')

const fs = require('fs')
const format = require('util').format
const url = require('url')

const config = require('../config.js')

const Envelope = require('../models/Envelope')
const Deal = require('../models/Deal')
const Crypto = require('../models/Crypto')
const Url = require('../models/Url')

function createEnvelope (req, res) {
  fixHeroku(req)

  const envelope = req.body

  Deal.limitAccess({
    user: req.user,
    deal_id: envelope.deal
  }).nodeify(err => {
    if (err)
      res.error(err)

    envelope.created_by = req.user.id
    envelope.owner = envelope.owner || req.user.id

    Envelope.create(req.body, function (err, envelope) {
      if (err) {
        if (err.http === 401) {
          res.statusCode = 428
          res.end()
          return
        }

        return res.error(err)
      }

      Deal.notifyById(envelope.deal).nodeify(err => {
        if (err)
          return res.error(err)

        res.model(envelope)
      })
    })
  })
}

function updateStatus(req, res) {
  expect(req.params.id).to.be.uuid

  expect(req.query.token).to.be.uuid

  Envelope.get(req.params.id, (err, envelope) => {
    if (err)
      return res.error(err)

    if (envelope.webhook_token !== req.query.token)
      return res.error(Error.Forbidden())

    Envelope.updateStatus(req.params.id, req.body).nodeify(err => {
      if (err)
        return res.error(err)

      res.end()
    })
  })
}

function sign(req, res) {
  expect(req.params.id).to.be.uuid
  expect(req.params.recipient).to.be.uuid

  Envelope.get(req.params.id, (err, envelope) => {
    if (err)
      return res.error(err)

    if (envelope.created_by !== req.user.id)
      return res.error(Error.Forbidden())

    Envelope.getSignUrl({
      envelope_id: req.params.id,
      recipient_id: req.params.recipient,
      user: req.user
    }, (err, url) => {
      if (err)
        return res.error(err)

      res.redirect(url)
    })
  })
}

function edit(req, res) {
  expect(req.params.id).to.be.uuid

  Envelope.getEditUrl({
    envelope_id: req.params.id,
    recipient_id: req.params.recipient
  }, (err, url) => {
    if (err)
      return res.error(err)

    res.redirect(url)
  })
}

function getEnvelopes(req, res) {
  expect(req.params.deal).to.be.uuid

  Envelope.getByDeal(req.params.deal, (err, envelopes) => {
    if (err)
      return res.error(err)

    res.collection(envelopes)
  })
}

function getEnvelope(req, res) {
  expect(req.params.id).to.be.uuid

  Envelope.get(req.params.id, (err, envelope) => {
    if (err)
      return res.error(err)

    res.model(envelope)
  })
}

function patchStatus(req, res) {
  const envelope_id = req.params.id
  const status = req.body.status

  expect(envelope_id).to.be.uuid
  expect(status).to.be.a('string')

  if(status !== 'Voided')
    return res.error(Error.Validation('You can only void an envelope'))

  Envelope.void(req.params.id, (err, envelope) => {
    if(err)
      return res.error(err)

    res.model(envelope)
  })
}

function resend(req, res) {
  const envelope_id = req.params.id

  expect(envelope_id).to.be.uuid

  Envelope.get(envelope_id, (err, envelope) => {
    if (err)
      return res.error(err)

    Envelope.resend(req.params.id, err => {
      if(err)
        return res.error(err)

      res.model(envelope)
    })
  })
}

const closeWebviewHtml = fs.readFileSync(__dirname + '/../html/envelope/close_webview.html').toString()
const closeWebview = (res) => {
  res.header('Content-Type', 'text/html')
  res.write(closeWebviewHtml)
  res.end()
}
function signed(req, res) {
  fixHeroku(req)

  expect(req.params.id).to.be.uuid

  expect(req.query.token).to.be.uuid

  Envelope.get(req.params.id, (err, envelope) => {
    if (err)
      return res.error(err)

    if (envelope.webhook_token !== req.query.token)
      return res.error(Error.Forbidden())

    Envelope.update(req.params.id, err => {
      if (err)
        return res.error(err)

      Deal.notifyById(envelope.deal, Deal.UPDATED).nodeify(err => {
        if (err)
          return res.error(err)

        closeWebview(res)
      })
    })
  })
}

const authenticate = (req, res) => {
  const base = url.parse(config.docusign.baseurl)
  base.pathname = '/oauth/auth'
  base.query = {
    response_type: 'code',
    scope: 'signature',
    client_id: config.docusign.integrator_key,
    state: JSON.stringify({
      signature: Crypto.sign(req.user.id).toString('base64'),
      user_id: req.user.id,
    }),
    redirect_uri: Url.api({
      uri: '/docusign/auth/done',
    })
  }

  res.redirect(url.format(base))
}

const disconnect = async (req, res) => {
  await Envelope.deleteUserInfo(req.user)
  res.status(204)
  res.end()
}

const openAppHtml = fs.readFileSync(__dirname + '/../html/envelope/open_app.html').toString()
const openApp = (res, uri) => {
  res.header('Content-Type', 'text/html')
  res.write(format(openAppHtml, config.app.name, uri))
  res.end()
}

const authDone = (req, res) => {
  const code = req.query.code
  const state = JSON.parse(req.query.state)

  if (!state.signature || !state.user_id || !Crypto.verify(state.user_id, Buffer.from(state.signature, 'base64')))
    return res.error(Error.Unauthorized())

  Envelope.saveUserInfo(state.user_id, code, err => {
    if (err)
      return res.error(err)

    openApp(res, 'docusign-authenticated')
  })
}

const access = (req, res, next) => {
  const envelope_id = req.params.id

  expect(envelope_id).to.be.uuid

  Envelope.get(envelope_id, (err, envelope) => {
    if (err)
      return res.error(err)

    Deal.limitAccess({
      user: req.user,
      deal_id: envelope.deal
    }).nodeify(err => {
      if (err)
        res.error(err)

      next()
    })
  })
}

const router = function (app) {
  const auth = app.auth.bearer.middleware

  const textParser = bodyParser.text({
    type: 'text/xml',
    limit: '10mb'
  })

  app.post('/envelopes', auth, createEnvelope)
  app.post('/envelopes/:id/hook', textParser, updateStatus)
  app.get('/envelopes/:id', auth, access, getEnvelope)
  app.get('/envelopes/:id/sign/:recipient', auth, access, sign)
  app.get('/envelopes/:id/edit', auth, access, edit)
  app.patch('/envelopes/:id/status', auth, access, patchStatus)
  app.get('/deals/:deal/envelopes', auth, getEnvelopes)
  app.post('/envelopes/:id/resend', auth, access, resend)
  app.get('/envelopes/:id/signed', signed)
  app.get('/users/self/docusign/auth', auth, authenticate)
  app.delete('/users/self/docusign', auth, disconnect)
  app.get('/docusign/auth/done', authDone)
}

module.exports = router
