const Context = require('../models/Context')

const am = require('../utils/async_middleware.js')
const expect = require('../utils/validator.js').expect

const Brand = require('../models/Brand')
const ShowingsCredential = require('../models/Showings.com/credential')
const ShowingsCrawler = require('../models/Showings.com/crawler')



function brandAccess(req, res, next) {
  const brand = getCurrentBrand()
  const user = req.user.id

  return Brand.limitAccess({ user, brand }).nodeify(err => {
    if (err) {
      return res.error(err)
    }

    next()
  })
}

function getCurrentBrand() {
  const brand = Brand.getCurrent()

  if (!brand || !brand.id)
    throw Error.BadRequest('Brand is not specified.')
  
  return brand.id
}

const createCredential = async function (req, res) {
  const user = req.user.id
  const brand = getCurrentBrand()

  const isLoginSuccess = await ShowingsCrawler.loginTest({ username: req.body.username, password: req.body.password })

  if(isLoginSuccess) {

    let alreadyCreatedRecord = null
    try {
      alreadyCreatedRecord = await ShowingsCredential.getByUser(user, brand)
    } catch(ex) {
      // do nothing
      Context.log('Showings createCredential-Failed', ex)
    }

    if(alreadyCreatedRecord) {
      res.status(409)
      return res.end()
    }
  
    const body = {
      username: req.body.username,
      password: req.body.password,
      selected_location: req.body.selected_location,
      selected_location_string: req.body.selected_location_string,
      loginStatus: true
    }

    const id = await ShowingsCredential.create(user, brand, body)
    const credentialRecord = await ShowingsCredential.get(id)
  
    return res.model(credentialRecord)
  }

  res.status(403)  
  return res.end()
}

const getCredential = async function (req, res) {
  const user = req.user.id
  const brand = getCurrentBrand()

  const credentialRecord = await ShowingsCredential.getByUser(user, brand)

  return res.model(credentialRecord)
}

const updateCredential = async function (req, res) {
  const user = req.user.id
  const brand = getCurrentBrand()
  const body = req.body

  expect(body.username).to.be.a('string')
  expect(body.password).to.be.a('string')

  await ShowingsCredential.updateCredential(user, brand, body)

  const credentialRecord = await ShowingsCredential.getByUser(user, brand)

  return res.model(credentialRecord)
}

const updateMarket = async function (req, res) {
  const user = req.user.id
  const brand = getCurrentBrand()
  const body = req.body

  await ShowingsCredential.updateMarket(user, brand, body)

  const credentialRecord = await ShowingsCredential.getByUser(user, brand)

  return res.model(credentialRecord)
}

const deleteCredential = async function (req, res) {
  const user = req.user.id
  const brand = getCurrentBrand()

  await ShowingsCredential.delete(user, brand)

  res.status(204)
  return res.end()
}


const router = function (app) {
  const auth = app.auth.bearer.middleware

  app.post('/users/self/showings/credentials', auth, brandAccess, am(createCredential))

  app.get('/users/self/showings/credentials', auth, brandAccess, am(getCredential))

  app.put('/users/self/showings/credentials', auth, brandAccess, am(updateCredential))
  app.put('/users/self/showings/credentials/market', auth, brandAccess, am(updateMarket))

  app.delete('/users/self/showings/credentials', auth, brandAccess, am(deleteCredential))
}

module.exports = router
