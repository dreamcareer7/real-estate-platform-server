registerSuite('contact', [
  'getAttributeDefs',
  'create'
])

const HOUR = 3600
const DAY = 24 * HOUR

const addEmail = cb => {
  const email = {
    name: 'Email Name',
    goal: 'Email Goal',
    subject: 'Email Subject',
    body: 'Email Body',
    include_signature: true
  }

  return frisby.create('add an email template to a brand')
    .post(`/brands/${results.brand.createParent.data.id}/emails/templates`, email)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      code: 'OK',
      data: email
    })
}

const addFlow = cb => {
  const flow = {
    name: 'Rechat Team Onboarding',
    description: 'The process of on-boarding a new team member',
    steps: [{
      title: 'Create Rechat email',
      description: 'Create a Rechat email address for the new guy to use in other services',
      due_in: 10 * HOUR,
      event: {
        title: 'Create Rechat email',
        task_type: 'Other',
      }
    }, {
      title: 'Send them a test email',
      description: 'Automatically send them a test email to make sure it\'s working',
      due_in: 8 * HOUR + DAY,
      email: results.flow.addEmail.data.id
    }, {
      title: 'Demo of Rechat',
      description: 'Dan gives a quick demo of the Rechat system and explains how it works',
      due_in: 3 * DAY + 14 * HOUR,
      event: {
        title: 'Demo of Rechat',
        task_type: 'Call',
      }
    }]
  }

  return frisby.create('add a brand flow')
    .post(`/brands/${results.brand.createParent.data.id}/flows?associations[]=brand_flow.steps&associations[]=brand_flow_step.event&associations[]=brand_flow_step.email`, flow)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      data: {
        ...flow,
        steps: [
          flow.steps[0],
          {
            ...flow.steps[1],
            email: {
              id: flow.steps[1].email
            }
          },
          flow.steps[2],
        ]
      }
    })
}

const getBrandFlows = cb => {
  return frisby.create('get brand flows')
    .get(`/brands/${results.brand.create.data.id}/flows?associations[]=brand_flow.steps&associations[]=brand_flow_step.event&associations[]=brand_flow_step.email`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      data: [{
        name: 'Rechat Team Onboarding',
        description: 'The process of on-boarding a new team member',
        steps: [{}, {}, {}]
      }]
    })
}

const updateFlow = cb => {
  const brand = results.brand.createParent.data.id
  const flow = results.flow.getBrandFlows.data[0].id

  return frisby.create('update a brand flow')
    .put(`/brands/${brand}/flows/${flow}`, {
      name: '8 in 8',
      description: '8 in 8 Ninja Selling Flow',
    })
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      data: {
        id: flow,
        name: '8 in 8',
        description: '8 in 8 Ninja Selling Flow'
      }
    })
}

const addStepToFlow = cb => {
  const brand = results.brand.createParent.data.id
  const flow = results.flow.getBrandFlows.data[0].id

  const step = {
    title: 'Call to check on them',
    description: 'Call to check on them',
    due_in: 7 * DAY + 10 * HOUR,
    event: {
      title: 'Call to check on them',
      task_type: 'Call',
    }
  }

  return frisby.create('add a step to a brand flow')
    .post(`/brands/${brand}/flows/${flow}/steps?associations[]=brand_flow_step.event&associations[]=brand_flow_step.email`, {
      steps: [step]
    })
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      data: [step]
    })
}

const editBrandFlowStep = cb => {
  const brand = results.brand.createParent.data.id
  const flow = results.flow.getBrandFlows.data[0].id
  const step_id = results.flow.addStepToFlow.data[0].id

  const step = {
    title: 'Meet with them to catch up',
    description: 'Meet with them to catch up',
    due_in: 10 * DAY + 11 * HOUR,
    event: {
      title: 'Meet with them to catch up',
      task_type: 'In-Person Meeting',
    }
  }

  return frisby.create('update a step in a brand flow')
    .put(`/brands/${brand}/flows/${flow}/steps/${step_id}?associations[]=brand_flow_step.event&associations[]=brand_flow_step.email`, step)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      data: step
    })
}

const getBrandFlowById = cb => {
  const brand = results.brand.create.data.id
  const flow = results.flow.getBrandFlows.data[0].id
  const steps = [
    ...results.flow.getBrandFlows.data[0].steps,
    results.flow.editBrandFlowStep.data
  ]

  return frisby.create('get brand flows')
    .get(`/brands/${brand}/flows/${flow}?associations[]=brand_flow.steps&associations[]=brand_flow_step.event&associations[]=brand_flow_step.email`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      data: {
        id: flow,
        name: '8 in 8',
        description: '8 in 8 Ninja Selling Flow',
        steps
      }
    })
}

const deleteFlowStep = cb => {
  const brand = results.brand.createParent.data.id
  const flow = results.flow.getBrandFlows.data[0].id
  const step = results.flow.addStepToFlow.data[0].id

  return frisby.create('delete a brand flow step')
    .delete(`/brands/${brand}/flows/${flow}/steps/${step}`)
    .after(cb)
    .expectStatus(204)
}

const enroll = cb => {
  return frisby.create('enroll a contact to a flow')
    .post('/crm/flows?associations[]=contact.flows&associations[]=flow_step.crm_task&associations[]=flow_step.email', {
      origin: results.flow.getBrandFlows.data[0].id,
      starts_at: Date.now() / 1000,
      steps: results.flow.getBrandFlows.data[0].steps.map(s => s.id),
      contacts: {
        ids: [results.contact.create.data[0].id]
      }
    })
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      data: [{
        steps: [{}, {}, {}],
        contact: results.contact.create.data[0].id
      }]
    })
}

const deleteFlowWithActiveFlows = cb => {
  const brand = results.brand.createParent.data.id
  const flow = results.flow.getBrandFlows.data[0].id

  return frisby.create('delete a brand flow with active flows')
    .delete(`/brands/${brand}/flows/${flow}`)
    .after(cb)
    .expectStatus(409)
}

const checkFlowAssociation = cb => {
  return frisby.create('check flow association on contact')
    .get(`/contacts/${results.contact.create.data[0].id}?associations[]=contact.flows&associations[]=flow_step.crm_task&associations[]=flow_step.email`)
    .after(cb)
    .expectJSON({
      data: {
        flows: [{
          steps: [{}, {}, {}]
        }]
      }
    })
}

const stop = cb => {
  return frisby.create('stop a flow')
    .delete(`/crm/flows/${results.flow.enroll.data[0].id}`)
    .after(cb)
    .expectStatus(204)
}

const checkStoppedFlowAssociation = cb => {
  return frisby.create('check flow association on contact')
    .get(`/contacts/${results.contact.create.data[0].id}?associations[]=contact.flows&associations[]=flow_step.crm_task&associations[]=flow_step.email`)
    .after(cb)
    .expectJSON({
      data: {
        flows: null
      }
    })
}

const deleteFlow = cb => {
  const brand = results.brand.createParent.data.id
  const flow = results.flow.getBrandFlows.data[0].id

  return frisby.create('delete a brand flow')
    .delete(`/brands/${brand}/flows/${flow}`)
    .after(cb)
    .expectStatus(204)
}


module.exports = {
  addEmail,
  addFlow,
  getBrandFlows,
  updateFlow,
  addStepToFlow,
  editBrandFlowStep,
  getBrandFlowById,
  deleteFlowStep,
  enroll,
  deleteFlowWithActiveFlows,
  checkFlowAssociation,
  stop,
  checkStoppedFlowAssociation,
  deleteFlow
}
