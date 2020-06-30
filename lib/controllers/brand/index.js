const expect = require('../../utils/validator').expect
const am = require('../../utils/async_middleware')

const Context   = require('../../models/Context')
const Brand     = require('../../models/Brand/index')
const BrandRole = require('../../models/Brand/role')

const get = async (req, res) => {
  const brand_id = req.params.id

  expect(brand_id).to.be.uuid

  const brand = await Brand.get(brand_id)
  res.model(brand)
}

const create = async (req, res) => {
  const created = await Brand.create(req.body)

  const { roles = [] } = req.body

  expect(roles).to.be.an('array')

  if (roles.length < 1)
    return res.model(created)

  for(const role of roles) {
    const createdRole = await BrandRole.create({
      ...role,
      brand: created.id
    })

    const { members = [] } = role

    for(const member of members) {
      await BrandRole.addMember({
        ...member,
        role: createdRole.id
      })
    }
  }

  const brand = await Brand.get(created.id)
  res.model(brand)
}

const update = async (req, res) => {
  const brand = req.body
  brand.id = req.params.id

  const saved = await Brand.update(req.body)
  res.model(saved)
}

const remove = async (req, res) => {
  expect(req.params.id).to.be.uuid

  await Brand.delete(req.params.id)
  res.status(204)
  res.end()
}

const search = async (req, res) => {
  const hostname = req.query.hostname

  expect(hostname).to.be.a('string').and.to.have.length.above(4)

  const brand = await Brand.getByHostname(hostname)

  res.model(brand)
}

const getChildren = async (req, res) => {
  expect(req.params.id).to.be.uuid

  const children = await Brand.getByParent(req.params.id)

  res.collection(children)
}

const setBrand = async (req, res, next) => {
  let brand_id

  if (req.headers['x-rechat-brand'])
    brand_id = req.headers['x-rechat-brand']
  else if(req.user)
    brand_id = req.user.brand

  if(!brand_id)
    return next()

  expect(brand_id).to.be.uuid

  const brand = await Brand.get(brand_id)
  Context.set({brand})
  next()
}

const _access = async (req, res, next) => {
  await Brand.limitAccess({
    user: req.user.id,
    brand: req.params.id
  })

  next()
}

const router = function (app) {
  const b = app.auth.bearer.middleware
  const access = am(_access)

  app.use(am(setBrand))
  app.post('/brands', b, am(create))
  app.get('/brands/:id/children', b, access, am(getChildren))
  app.get('/brands/search', am(search))
  app.get('/brands/:id', am(get))
  app.put('/brands/:id', b, access, am(update))
  app.delete('/brands/:id', b, access, am(remove))

  const modules = [
    'deal/checklist',
    'deal/form-template',
    'deal/context',
    'deal/status',
    'flow',
    'role',
    'hostname',
    'task',
    'email-template',
    'list',
    'member',
    'setting',
    'asset'
  ]

  modules.forEach(name => {
    require(`./${name}.js`)({
      app,
      b,
      access,
      am
    })
  })
}

module.exports = router
