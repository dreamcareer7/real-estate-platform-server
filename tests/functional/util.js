const config = require('../../lib/config.js')
const dataUser = require('./suites/data/user.js')

const users = new Map()

function createUser({ email }) {
  return cb => frisby.create(`create user with email ${email}`)
    .post('/users', {
      ...dataUser,
      email,
      client_id: config.tests.client_id,
      client_secret: config.tests.client_secret,
    })
    .after((err, res, body) => {
      users.set(email, { ...res, password: dataUser.password })
      cb(err, res, body)
    })
    .expectStatus(201)
}

/**
 * @param {string} description 
 * @param {unknown[]} brands 
 * @param {(response: unknown) => UUID} getActiveBrand
 */
function createBrands(description, brands, getActiveBrand) {
  return cb => frisby.create(description)
    .post('/_/brands?associations[]=brand.children', brands)
    .after((err, res, json) => {
      if (getActiveBrand) {
        const activeBrand = getActiveBrand(json)
        if (activeBrand) {
          const setup = frisby.globalSetup()
          setup.request.headers['X-Rechat-Brand'] = activeBrand
          frisby.globalSetup(setup)      
        }
      }
      cb(err, res, json)
    })
    .expectStatus(200)
}

function beforeFrisby(fn, doBefore) {
  return cb => {
    doBefore()
    return fn(cb)
  }
}

/**
 * @template F
 * @param {F} fns 
 * @returns {F}
 */
function beforeFirstFrisby(fns, doBefore) {
  const [k, fn] = Object.entries(fns)[0]
  fns[k] = beforeFrisby(fn, doBefore)

  return fns
}

function afterFrisby(fn, doAfter) {
  return cb => {
    const F = fn(cb)
    F.current.after.unshift(doAfter)
    return F
  }
}

/**
 * @template F
 * @param {F} fns 
 * @returns {F}
 */
function afterLastFrisby(fns, doAfter) {
  const entries = Object.entries(fns)
  const [k, fn] = entries[entries.length - 1]
  fns[k] = afterFrisby(fn, doAfter)

  return fns
}

/**
 * @template F
 * @param {() => UUID} brandFn 
 * @param {F} fns 
 * @returns {F}
 */
function switchBrand(brandFn, fns) {
  return beforeFirstFrisby(fns, () => {
    const setup = frisby.globalSetup()
    setup.request.headers['X-Rechat-Brand'] = brandFn()
    frisby.globalSetup(setup)

    return fns
  })
}

function getTokenFor(email) {
  return cb => {
    const user = users.get(email) ?? dataUser
  
    const auth_params = {
      client_id: config.tests.client_id,
      client_secret: config.tests.client_secret,
      username: email,
      password: user.password,
      grant_type: 'password'
    }
  
    return frisby.create(`login as ${email}`)
      .post('/oauth2/token', auth_params)
      .afterJSON(body => {
        user.access_token = body.access_token
      })
      .after(cb)
      .expectStatus(200)
  }
}

function runAsUser(email, fns) {
  let originalAuthorizationHeader

  const revertAuthorizationHeader = () => {
    const setup = frisby.globalSetup()
    setup.request.headers['Authorization'] = originalAuthorizationHeader
    frisby.globalSetup(setup)  
  }

  function setToken(token) {
    const setup = frisby.globalSetup()
    originalAuthorizationHeader = setup.request.headers['Authorization']
    setup.request.headers['Authorization'] = 'Bearer ' + token
    frisby.globalSetup(setup)
  }

  beforeFirstFrisby(fns, () => {
    const user = users.get(email) ?? dataUser
  
    setToken(user.access_token)
  })

  afterLastFrisby(fns, () => revertAuthorizationHeader())

  return fns
}

module.exports = {
  createBrands,
  createUser,
  getTokenFor,
  runAsUser,
  switchBrand,
}