const fs = require('fs')
const path = require('path')
const brand = require('./data/brand.js')
const contexts = require('./data/context.js')

registerSuite('office', ['add'])
registerSuite('form', ['create'])
registerSuite('billing_plan', ['create'])

const hostname = 'testhost'
let brand_id

const createParent = (cb) => {
  brand.name = 'Parent Brand'
  brand.roles = [
    {
      role: 'Admin',
      members: [
        {
          user: results.authorize.token.data.id
        }
      ],
      acl: ['Admin']
    }
  ]

  return frisby.create('create a brand')
    .post('/brands', brand)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      //       data: brand
    })
}

const create = (cb) => {
  brand.parent = results.brand.createParent.data.id

  brand.roles = [
    {
      role: 'Owner',
      members: [
        {
          user: results.authorize.token.data.id
        }
      ],
      acl: ['Admin', 'Marketing', 'Deals', 'CRM']
    }
  ]

  delete brand.role // We don't have a role in this one. But we should have access as we have access to the parent.

  return frisby.create('create a child brand')
    .post('/brands', brand)
    .after((err, res, body) => {
      brand_id = body.data.id
      cb(err, res, body)
    })
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
    })
}

const get = (cb) => {
  return frisby.create('get brand')
    .get(`/brands/${results.brand.create.data.id}`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      data: results.brand.create.data
    })
}

const byParent = (cb) => {
  return frisby.create('get brands by their parent')
    .get(`/brands/${results.brand.createParent.data.id}/children`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      data: [results.brand.create.data]
    })
}

const update = cb => {
  const updated = {...results.brand.create.data, name: 'Updated Brand'}

  return frisby.create('update brand')
    .put(`/brands/${results.brand.create.data.id}`, updated)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      data: updated
    })
}

const addHostname = cb => {
  return frisby.create('add hostname to a brand')
    .post(`/brands/${brand_id}/hostnames`, {
      hostname: hostname,
      is_default: true
    })
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      //       data: brand
    })
}

const removeHostname = cb => {
  return frisby.create('delete hostname of a brand')
    .delete(`/brands/${brand_id}/hostnames?hostname=${hostname}`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      //       data: brand
    })
}

const addDateContext = cb => {
  const { list_date } = contexts
  return frisby.create('add a context definition to a brand')
    .post(`/brands/${brand_id}/contexts`, list_date)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: list_date
    })
}

const addTextContext = cb => {
  const { contract_status }  = contexts
  return frisby.create('add a context definition to a brand')
    .post(`/brands/${brand_id}/contexts`, contract_status)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: contract_status
    })
}

const getContexts = cb => {
  return frisby.create('get brand context definitions')
    .get(`/brands/${brand_id}/contexts`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: Array.from(contexts)
    })
}

const updateContext = cb => {
  const data = results.brand.addDateContext.data
  data.label = 'Updated Context'

  return frisby.create('update a context')
    .put(`/brands/${brand_id}/contexts/${data.id}`, data)
    .after(cb)
    .expectStatus(200)
}

const deleteContext = cb => {
  return frisby.create('delete a context')
    .delete(`/brands/${brand_id}/contexts/${results.brand.addDateContext.data.id}`)
    .after(cb)
    .expectStatus(204)
}

const getByHostname = (cb) => {
  return frisby.create('search for a hostname')
    .get(`/brands/search?hostname=${hostname}`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      //       data: brand
    })
}

const addChecklist = cb => {
  return frisby.create('add a checklist to a brand')
    .post(`/brands/${brand_id}/checklists`, {
      title: 'Checklist 1',
      deal_type: 'Buying',
      property_type: 'Resale',
      order: 2,
      is_terminatable: true,
      is_deactivatable: true,
      tab_name: 'Contract'
    })
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      //       data: brand
    })
}

const updateChecklist = cb => {
  const data = results.brand.addChecklist.data
  data.title = 'Updated Checklist'

  return frisby.create('update a checklist')
    .put(`/brands/${brand_id}/checklists/${results.brand.addChecklist.data.id}`, data)
    .after(cb)
    .expectStatus(200)
}

const deleteChecklist = cb => {
  return frisby.create('delete a checklist to a brand')
    .delete(`/brands/${brand_id}/checklists/${results.brand.addChecklist.data.id}`)
    .after(cb)
    .expectStatus(204)
}

const getChecklists = cb => {
  return frisby.create('get a brands checklists')
    .get(`/brands/${brand_id}/checklists`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      //       data: brand
    })
}

const addTask = cb => {
  const task = {
    title: 'Task 1',
    task_type: 'Form',
    form: results.form.create.data.id,
    order: 1,
    required: true
  }

  return frisby.create('add a task to a brand checklist')
    .post(`/brands/${brand_id}/checklists/${results.brand.addChecklist.data.id}/tasks`, task)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
    })
}

const updateTask = cb => {
  const d = results.brand.addTask.data
  d.title = 'Updated Task'
  d.required = false

  return frisby.create('update a task')
    .put(`/brands/${brand_id}/checklists/${results.brand.addChecklist.data.id}/tasks/${results.brand.addTask.data.id}`, d)
    .after(cb)
    .expectStatus(200)
}

const sortChecklist = cb => {
  const task = results.brand.addTask.data.tasks[0]

  const data = [
    {
      id: task.id,
      order: 3
    }
  ]

  return frisby.create('sort a checklist')
    .put(`/brands/${brand_id}/checklists/${results.brand.addChecklist.data.id}/sort`, data)
    .after(cb)
    .expectStatus(200)
}

const deleteTask = cb => {
  return frisby.create('delete a task from a brand checklist')
    .delete(`/brands/${brand_id}/checklists/${results.brand.addChecklist.data.id}/tasks/${results.brand.addTask.data.id}`)
    .after(cb)
    .expectStatus(204)
}

const addRole = cb => {
  return frisby.create('add a role to a brand')
    .post(`/brands/${brand_id}/roles`, {
      role: 'Admin',
      acl: [
        'Deals'
      ]
    })
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
    })
}

const updateRole = cb => {
  return frisby.create('update a role')
    .post(`/brands/${brand_id}/roles`, {
      role: 'Updated Role Name',
      acl: [
        'Deals',
        'admin'
      ]
    })
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
    })
}

const getRoles = cb => {
  return frisby.create('get all roles for a brand')
    .get(`/brands/${brand_id}/roles`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK'
    })
}

const deleteRole = cb => {
  return frisby.create('delete a brand role')
    .delete(`/brands/${brand_id}/roles/${results.brand.addRole.data.id}`)
    .after(cb)
    .expectStatus(204)
}

const addMember = cb => {
  return frisby.create('add a user to a brand role')
    .post(`/brands/${brand_id}/roles/${results.brand.addRole.data.id}/members`, {
      emails: ['invited-member@boer.rechat.com']
    })
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: [{
        email: 'invited-member@boer.rechat.com',
        type: 'user'
      }]
    })
}

const getMembers = cb => {
  return frisby.create('get all members of a brand role')
    .get(`/brands/${brand_id}/roles/${results.brand.addRole.data.id}/members`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: [{
        type: 'user'
      }]
    })
    .expectJSONLength('data', 1)
}

const deleteMember = cb => {
  return frisby.create('delete a member from a role')
    .delete(`/brands/${brand_id}/roles/${results.brand.addRole.data.id}/members/${results.authorize.token.data.id}`)
    .after(cb)
    .expectStatus(204)
}

const getAgents = cb => {
  return frisby.create('get all agents of a brand')
    .get(`/brands/${brand_id}/agents?q=User`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
    })
}

const addTemplate = cb => {
  const form = results.form.create.data.id
  const field = 51821682
  const value = 'Template Value'

  return frisby.create('add a form template')
    .post(`/brands/${brand_id}/forms/templates/${form}/${field}`, {value})
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
    })
}

const getTemplates = cb => {
  return frisby.create('get all templates for a brand (and its parents)')
    .get(`/brands/${brand_id}/forms/templates/${results.form.create.data.id}`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: [
        {
          form: results.brand.addTemplate.data.form,
          field: results.brand.addTemplate.data.field,
          value: results.brand.addTemplate.data.value,
        }
      ],
      info: {
        count: 1
      }
    })
}

const updateBrandSettings = cb => {
  return frisby.create('update a brand setting')
    .put(`/brands/${brand_id}/settings/palette`, {
      palette: {
        'body-bg-color': '#eee'
      }
    })
    .addHeader('X-Rechat-Brand', brand_id)
    .after(cb)
    .expectStatus(204)
}

const updateUserSettings = cb => {
  return frisby.create('update a user setting')
    .put('/users/self/settings/user_filter', {
      value: [
        '4926132e-9e1d-11e7-8fd6-0242ac110003',
        '5d66ae5e-f82c-11e5-b4b4-f23c91b0d077'
      ]
    })
    .addHeader('X-Rechat-Brand', brand_id)
    .after(cb)
    .expectStatus(200)
}

const getUserRoles = cb => {
  return frisby.create('get all user roles')
    .get('/users/self/roles')
    .after(cb)
    .expectStatus(200)
}


const createSubscription = cb => {
  const { plan } = results.billing_plan.create

  const subscription = {
    plan: plan.id
  }

  return frisby.create('create a subscription')
    .post(`/brands/${brand_id}/subscriptions`, subscription)
    .after(cb)
    .expectStatus(200)
}


const updateSubscription = cb => {
  const created = results.brand.createSubscription.data

  const data = {
    content: {
      subscription: {
        id: created.chargebee_id
      }
    }
  }

  return frisby.create('update a subscription (webhook)')
    .post('/chargebee/webhook', data)
    .after(cb)
    .expectStatus(200)
}

const checkoutSubscription = cb => {
  const { id } = results.brand.createSubscription.data

  return frisby.create('get checkout page')
    .get(`/brands/${brand_id}/subscriptions/${id}/checkout`, {
      followRedirect: false
    })
    .after(cb)
    .expectStatus(302)
}

const cancelSubscription = cb => {
  const { id } = results.brand.createSubscription.data

  return frisby.create('cancel a subscription')
    .post(`/brands/${brand_id}/subscriptions/${id}/cancel`)
    .after(cb)
    .expectStatus(204)
}

const removeBrand = cb => {
  return frisby.create('delete a brand')
    .delete(`/brands/${brand_id}`)
    .after(cb)
    .expectStatus(204)
}

const addEmail = cb => {
  const email = {
    name: 'Email Name',
    goal: 'Email Goal',
    subject: 'Email Subject',
    body: 'Email Body',
    include_signature: true
  }

  return frisby.create('add an email template to a brand')
    .post(`/brands/${brand_id}/emails/templates`, email)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: email
    })
}

const updateEmail = cb => {
  const email = {
    name: 'Updated Email Name',
    goal: 'Updated Email Goal',
    subject: 'Updated Email Subject',
    body: 'Updated Email Body',
    include_signature: false
  }

  return frisby.create('update an email template')
    .put(`/brands/${brand_id}/emails/templates/${results.brand.addEmail.data.id}`, email)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: email
    })
}

const getEmails = cb => {
  return frisby.create('get email templates')
    .get(`/brands/${brand_id}/emails/templates`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: [results.brand.updateEmail.data]
    })
}

const deleteEmail = cb => {
  return frisby.create('delete an email')
    .delete(`/brands/${brand_id}/emails/templates/${results.brand.addEmail.data.id}`)
    .after(cb)
    .expectStatus(204)
}

const addStatus = cb => {
  const status = {
    label: 'Active',
    deal_types: [
      'Buying'
    ],
    property_types: [
      'Resale'
    ],
    admin_only: false,
    is_archived: true
  }

  return frisby.create('add a deal status')
    .post(`/brands/${brand_id}/deals/statuses`, status)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: status
    })
}

const updateStatus = cb => {
  const status = {
    label: 'Active Contingent',
    deal_types: [
      'Buying',
      'Selling'
    ],
    property_types: [
      'Resale',
      'New Home'
    ],
    admin_only: true,
    is_archived: false,
    is_active: true,
    is_pending: false
  }

  return frisby.create('update a deal status')
    .put(`/brands/${brand_id}/deals/statuses/${results.brand.addStatus.data.id}`, status)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: status
    })
}

const getStatuses = cb => {
  return frisby.create('get deal statuses')
    .get(`/brands/${brand_id}/deals/statuses`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: [results.brand.updateStatus.data]
    })
}

const deleteStatus = cb => {
  return frisby.create('delete a deal status')
    .delete(`/brands/${brand_id}/deals/statuses/${results.brand.addStatus.data.id}`)
    .after(cb)
    .expectStatus(204)
}

function createAsset(cb) {
  const logo = fs.createReadStream(path.resolve(__dirname, 'data/logo.png'))

  return frisby
    .create('create an asset')
    .post(
      `/brands/${results.brand.create.data.id}/assets`,
      {
        file: logo
      },
      {
        json: false,
        form: true
      }
    )
    .addHeader('content-type', 'multipart/form-data')
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK'
    })
}

const getAssets = cb => {
  return frisby.create('get brand assets')
    .get(`/brands/${brand_id}/assets`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: [results.brand.createAsset.data]
    })
}

const deleteAsset = cb => {
  return frisby.create('delete a brand asset')
    .delete(`/brands/${brand_id}/assets/${results.brand.getAssets.data[0].id}`)
    .after(cb)
    .expectStatus(204)
}

module.exports = {
  createParent,
  create,

  get,
  byParent,
  update,

  addRole,
  updateRole,
  getRoles,

  addMember,
  getMembers,

  getAgents,

  deleteMember,

  deleteRole,

  addHostname,
  addChecklist,
  updateChecklist,
  addTask,
  updateTask,
  sortChecklist,
  getChecklists,
  deleteTask,
  deleteChecklist,
  getByHostname,
  removeHostname,

  addDateContext,
  addTextContext,
  getContexts,
  updateContext,
  deleteContext,

  addTemplate,
  getTemplates,

  addEmail,
  updateEmail,
  getEmails,
  deleteEmail,

  updateBrandSettings,
  updateUserSettings,

  createSubscription,
  updateSubscription,
  checkoutSubscription,
  cancelSubscription,

  getUserRoles,

  addStatus,
  updateStatus,
  getStatuses,
  deleteStatus,

  createAsset,
  getAssets,
  deleteAsset,

  removeBrand
}
