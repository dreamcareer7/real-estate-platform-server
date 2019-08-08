const expect = require('../utils/validator').expect
const am = require('../utils/async_middleware')
const _u = require('lodash')
const promisify = require('../utils/promisify')

const Context = require('../models/Context/index')
const User = require('../models/User/index')
const Brand = require('../models/Brand/index')
const BrandEmail = require('../models/Brand/email')
const BrandList = require('../models/Brand/list')
const BrandSettings = require('../models/Brand/settings')
const BrandRole = require('../models/Brand/role')
const BrandChecklist = require('../models/Brand/checklist')

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

const addHostname = async (req, res) => {
  const hostname = req.body
  hostname.brand = req.params.id

  const brand = await Brand.addHostname(hostname)
  res.model(brand)
}

const removeHostname = async (req, res) => {
  const brand = await Brand.removeHostname(req.params.id, req.query.hostname)
  res.model(brand)
}

const addOffice = async (req, res) => {
  const office = req.body.office
  expect(office).to.be.a('string')

  const brand = await Brand.addOffice({
    brand: req.params.id,
    office: office
  })

  res.model(brand)
}

const addChecklist = async (req, res) => {
  const checklist = req.body
  checklist.brand = req.params.id

  const saved = await BrandChecklist.create(checklist)

  res.model(saved)
}

const getChecklists = async (req, res) => {
  const checklists = await BrandChecklist.getByBrand(req.params.id)

  res.model(checklists)
}

const deleteChecklist = async (req, res) => {
  await BrandChecklist.delete(req.params.cid)

  res.status(204)
  res.end()
}

const updateChecklist = async (req, res) => {
  const checklist = req.body
  checklist.id = req.params.cid

  const saved = await BrandChecklist.update(checklist)

  res.model(saved)
}

const addTask = async (req, res) => {
  const task = req.body
  task.checklist = req.params.cid

  const checklist = await BrandChecklist.addTask(task)

  res.model(checklist)
}

const updateTask = async (req, res) => {
  const task = req.body
  task.id = req.params.tid

  await BrandChecklist.updateTask(task)

  res.end()
}

const deleteTask = async (req, res) => {
  await BrandChecklist.deleteTask(req.params.tid)

  res.status(204)
  res.end()
}

const addContext = async (req, res) => {
  const context = req.body
  context.brand = req.params.id

  const saved = await BrandContext.create(context)

  res.model(saved)
}

const getContexts = async (req, res) => {
  const contexts = await BrandContext.getByBrand(req.params.id)
  res.collection(contexts)
}

const removeOffice = async (req, res) => {
  const brand = await Brand.removeOffice(req.params.id, req.params.office)
  res.model(brand)
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

const addRole = async (req, res) => {
  const role = req.body.role
  const acl = req.body.acl

  expect(role).to.be.a('string')
  expect(acl).to.be.an('array')

  const saved = await BrandRole.create({
    brand: req.params.id,
    role,
    acl
  })

  res.model(saved)
}

const updateRole = async (req, res) => {
  const id = req.params.rid
  const role = req.body.role
  const acl = req.body.acl

  expect(id).to.be.uuid
  expect(role).to.be.a('string')
  expect(acl).to.be.an('array')

  const saved = await BrandRole.update({
    id,
    role,
    acl
  })

  res.model(saved)
}

const getRoles = async (req, res) => {
  const roles = await BrandRole.getByBrand(req.params.id)

  res.model(roles)
}

const deleteRole = async (req, res) => {
  await BrandRole.delete(req.params.role)

  res.status(204)
  return res.end()
}

const addMember = async (req, res) => {
  const users = req.body.users || []
  const emails = req.body.emails || []
  const phone_numbers = req.body.phone_numbers || []

  if (_u.isEmpty(users) && _u.isEmpty(emails) && _u.isEmpty(phone_numbers))
    return res.error(Error.Validation('You must supply either an array of user ids, emails or phone numbers'))

  if (!Array.isArray(users))
    return res.error(Error.Validation('`user` property must be an array of user ids'))

  if (!Array.isArray(emails))
    return res.error(Error.Validation('`emails` property must be an array of email addresses'))

  if (!Array.isArray(phone_numbers))
    return res.error(Error.Validation('`phone_numbers` property must be an array of phone numbers'))


  const saved = await promisify(User.getOrCreateBulk)(req.user.id, users, emails, phone_numbers)

  for(const user of saved) {
    await BrandRole.addMember({
      role: req.params.role,
      user
    })
  }

  const ids = await BrandRole.getMembers(req.params.role)
  const members = await User.getAll(ids)
  res.collection(members)
}

const getMembers = async (req, res) => {
  const ids = await BrandRole.getMembers(req.params.role)
  const members = await User.getAll(ids)
  res.collection(members)
}

const getAgents = async (req, res) => {
  /*
   * Access control on this endpoint is a bit different and handled here.
   * Basically, you have access to this endpoint if you normally have access to this brand.
   * The only difference is, if you are a member on this brand OR it's sub brands
   * you still should have access to this endpoint.
   * That's because you have to be able to choose another collueage of your's from a list
   * as a co-agent
   */

  const hasAccess = await Brand.isSubMember(req.params.id, req.user.id)

  if (!hasAccess)
    await Brand.limitAccess({
      user: req.user.id,
      brand: req.params.id
    })

  const agents = await Brand.getAgents(req.params.id)

  Orm.setAssociationConditions({
    'brand_role.members': agents.map(agent => agent.user)
  })

  const brand_ids = new Set(agents.map(a => a.brand))
  const brands = await Brand.getAll(Array.from(brand_ids))

  res.collection(brands)
}

const deleteMember = async (req, res) => {
  await BrandRole.removeMember(req.params.role, req.params.user)
  res.status(204)
  return res.end()
}

const createTemplate = async (req, res) => {
  const template = req.body

  const saved = await FormTemplate.create({
    ...template,
    brand: req.params.id,
    created_by: req.user.id
  })

  res.model(saved)
}

const updateTemplate = async (req, res) => {
  const template = req.body

  const updated = await FormTemplate.update({
    ...template,
    id: req.params.template,
    updated_by: req.user.id
  })

  res.model(updated)
}

const getTemplates = async (req, res) => {
  expect(req.query.form).to.be.uuid

  const templates = await FormTemplate.getByForm({
    brand: req.params.id,
    form: req.query.form
  })

  res.collection(templates)
}


const addEmail = async (req, res) => {
  const email = req.body
  email.brand = req.params.id
  email.created_by = req.user.id

  const saved = await BrandEmail.create(email)

  res.model(saved)
}

const getEmails = async (req, res) => {
  const emails = await BrandEmail.getByBrand(req.params.id)

  res.model(emails)
}

const deleteEmail = async (req, res) => {
  await BrandEmail.delete(req.params.cid)

  res.status(204)
  res.end()
}

const updateEmail = async (req, res) => {
  const email = req.body
  email.id = req.params.eid

  const saved = await BrandEmail.update(email)

  res.model(saved)
}

const addList = async (req, res) => {
  expect(req.body).to.be.an('array')

  const ids = await BrandList.createAll(req.params.id, req.body)
  const saved = await BrandList.getAll(ids)

  return res.collection(saved)
}

const getLists = async (req, res) => {
  const lists = await BrandList.getForBrand(req.params.id)

  res.collection(lists)
}

const getBrandSettings = async(req, res) => {
  const settings = await BrandSettings.get(req.params.id)

  res.collection(settings)
}

const setBrandSettings = async (req, res) => {
  const user_id = req.user.id
  const brand_id = req.params.id
  const key = req.params.key
  const value = req.body.value

  await BrandSettings.set(brand_id, key, value, user_id)

  res.status(204)
  res.end()
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

  app.post('/brands/:id/roles', b, access, am(addRole))
  app.put('/brands/:id/roles/:rid', b, access, am(updateRole))
  app.get('/brands/:id/roles', b, access, am(getRoles))
  app.delete('/brands/:id/roles/:role', b, access, am(deleteRole))

  app.get('/brands/:id/children', b, access, am(getChildren))

  app.post('/brands/:id/roles/:role/members', b, access, am(addMember))
  app.get('/brands/:id/roles/:role/members', b, access, am(getMembers))
  app.delete('/brands/:id/roles/:role/members/:user', b, access, am(deleteMember))

  app.post('/brands/:id/hostnames', b, access, am(addHostname))
  app.delete('/brands/:id/hostnames', b, access, am(removeHostname))

  app.post('/brands/:id/checklists', b, access, am(addChecklist))
  app.get('/brands/:id/checklists', b, access, am(getChecklists))
  app.delete('/brands/:id/checklists/:cid', b, access, am(deleteChecklist))
  app.put('/brands/:id/checklists/:cid', b, access, am(updateChecklist))

  app.post('/brands/:id/contexts', b, access, am(addContext))
  app.get('/brands/:id/contexts', b, access, am(getContexts))

  app.post('/brands/:id/checklists/:cid/tasks', b, access, am(addTask))
  app.delete('/brands/:id/checklists/:cid/tasks/:tid', b, access, am(deleteTask))
  app.put('/brands/:id/checklists/:cid/tasks/:tid', b, access, am(updateTask))

  app.post('/brands/:id/offices', b, access, am(addOffice))
  app.delete('/brands/:id/offices/:office', b, access, am(removeOffice))

  app.get('/brands/:id/agents', b, am(getAgents))

  app.post('/brands/:id/forms/templates', b, access, am(createTemplate))
  app.get('/brands/:id/forms/templates', b, access, am(getTemplates))
  app.put('/brands/:id/forms/templates/:template', b, access, am(updateTemplate))

  app.post('/brands/:id/emails/templates', b, access, am(addEmail))
  app.get('/brands/:id/emails/templates', b, access, am(getEmails))
  app.delete('/brands/:id/emails/templates/:eid', b, access, am(deleteEmail))
  app.put('/brands/:id/emails/templates/:eid', b, access, am(updateEmail))

  app.post('/brands/:id/lists', b, access, am(addList))
  app.get('/brands/:id/lists', b, access, am(getLists))

  app.get('/brands/:id/settings', b, access, am(getBrandSettings))
  app.put('/brands/:id/settings/:key', b, access, am(setBrandSettings))

  app.get('/brands/search', am(search))
  app.get('/brands/:id', am(get))
  app.put('/brands/:id', b, access, am(update))
  app.delete('/brands/:id', b, access, am(remove))
}

module.exports = router
