registerSuite('brand', [
  'createParent',
  'create'
])

const email = {
  to: [
    {
      email: 'recipient@rechat.com'
    },
  ],
  due_at: new Date(),
  html: '<div>Hi</div>',
  subject: 'Email Subject'
}

const individual = {
  ...email,
  subject: 'Individual Email'
}

const mailgun_id = 'example-mailgun-id-email-1'

const schedule = cb => {
  email.from = results.authorize.token.data.id

  return frisby
    .create('Schedule an email campaign')
    .addHeader('X-RECHAT-BRAND', results.brand.create.data.id)
    .post('/emails', email)
    .after(cb)
    .expectStatus(200)
}

const sendDue = cb => {
  return frisby
    .create('Send Due Email Campaigns')
    .post('/jobs', {
      name: 'EmailCampaign.sendDue',
    })
    .addHeader('x-handle-jobs', 'yes')
    .after(cb)
    .expectStatus(200)
}

const addEvent = cb => {
  const data = {
    'event-data': {
      timestamp: 1531818450.203548,
      recipient: email.to[0].email,
      event: 'delivered',
      message: {
        headers: {
          'message-id': mailgun_id
        }
      }
    }
  }

  return frisby
    .create('Add an event to the email')
    .post('/emails/events', data)
    .after(cb)
    .expectStatus(200)
}

const updateStats = cb => {
  return frisby
    .create('Update campaign stats')
    .post('/jobs', {
      name: 'EmailCampaign.updateStats',
    })
    .after(cb)
    .expectStatus(200)
}

const get = cb => {
  return frisby
    .create('Get the campaign')
    .get(`/emails/${results.email.schedule.data[0]}?associations[]=email_campaign.emails&associations[]=email_campaign.recipients`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      data: {
        subject: email.subject,
        html: email.html,
        delivered: 1,
        recipients: email.to
      }
    })
}

const getByBrand = cb => {
  const updated = results.email.update.data

  return frisby
    .create('Get campaigns by brand')
    .get(`/brands/${results.brand.create.data.id}/emails/campaigns?associations[]=email_campaign.recipients`)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      data: [
        {
          subject: updated.subject,
          html: updated.html,
          delivered: 0,
          recipients: [
            {
              email: updated.recipients[0].email
            }
          ]
        },

        {
          subject: email.subject,
          html: email.html,
          delivered: 1,
          recipients: individual.to
        }
      ]
    })
}

const scheduleIndividual = cb => {
  individual.from = results.authorize.token.data.id

  return frisby
    .create('Schedule an individual email campaign')
    .addHeader('X-RECHAT-BRAND', results.brand.create.data.id)
    .post('/emails/individual', individual)
    .after(cb)
    .expectStatus(200)
}

const update = cb => {
  const html = `<div>
  From: {{sender.display_name or "me"}}
  </div>
  <div>
  To: {{recipient.display_name or "there"}}
  </div>`

  const subject = 'Individual Email From {{sender.display_name}}'

  const campaign = {
    id: results.email.scheduleIndividual.data[0],
    ...individual,
    subject,
    html,
    to: [
      {
        email: 'foo@bar.com'
      }
    ]
  }

  return frisby
    .create('Update a campaign')
    .addHeader('X-RECHAT-BRAND', results.brand.create.data.id)
    .put(`/emails/${results.email.scheduleIndividual.data[0]}?associations[]=email_campaign.recipients`, campaign)
    .after(cb)
    .expectStatus(200)
    .expectJSON({
      data: {
        subject: campaign.subject,
        html: campaign.html,
        recipients: [
          {
            email: campaign.to[0].email
          }
        ]
      }
    })
}

const remove = cb => {
  return frisby
    .create('delete a campaign')
    .delete(`/emails/${results.email.scheduleIndividual.data[0]}`)
    .after(cb)
    .expectStatus(204)
}

module.exports = {
  schedule,
  scheduleIndividual,
  update,
  sendDue,
  addEvent,
  updateStats,
  get,
  getByBrand,
  remove
}
