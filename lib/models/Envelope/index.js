const db = require('../../utils/db.js')
const validator = require('../../utils/validator.js')
const async = require('async')
const config = require('../../config.js')
const parser = new (require('xml2js').Parser)
const EventEmitter = require('events').EventEmitter
const request = require('request')
const promisify = require('../../utils/promisify')
const { peanar } = require('../../utils/peanar')
const _ = require('underscore')
const extractMetadata = require('./extract-metadata')
const RoomActivity = require('../Activity/room')
const DealChecklist = require('../Deal/checklist')
const AttachedFile = require('../AttachedFile')
const Task = require('../Task')
const Context = require('../Context')
const Deal = require('../Deal')
const DealContext = require('../Deal/context/get')
const Form = require('../Form')
const Submission = require('../Form/submission')
const DealRole = require('../Deal/role')
const Notification = require('../Notification/issue')
const Message = require('../Message/post')
const Room = require('../Room/get')
const Url = require('../Url')
const User = require('../User/get')
const setDynamicRoles = require('../Deal/form/set-dynamic-roles')


if (process.env.NODE_ENV === 'tests')
  require('./mock.js')

const Envelope = new EventEmitter

Object.assign(Envelope, {
  ...require('./get')
})

const EnvelopeRecipient = {
  ...require('./recipient/constants'),
  ...require('./recipient/get'),
}

const EnvelopeDocument = require('./document/get')

const schema = {
  type: 'object',

  title: {
    type: 'string',
    required: true
  },

  body: {
    type: ['string', 'null'],
    required: false
  },

  submissions: {
    type: 'array',
    uuid: true,
    required: false
  },

  created_by: {
    type: 'string',
    uuid: true,
    required: true
  }
}

const validate = validator.bind(null, schema)

const headers = {
//   'X-DocuSign-Authentication': JSON.stringify({
//     'IntegratorKey': config.docusign.integrator_key
//   })
}

const fixStatus = status => {
  return (status.charAt(0).toUpperCase() + status.slice(1))
}

const update = (data, cb) => {
  db.query('envelope/update', [
    data.docusign_id,
    fixStatus(data.status),
    data.title,
    data.id
  ], cb)
}

const permissionError = Error.create.bind(null, {
  http: 412,
  message: 'Invalid docusign authorization',
  code: 'DocusignAuthenticationRequired',
  slack: false
})

const getUsersInfo = (user_ids, cb) => {
  db.query('envelope/user/get', [user_ids], (err, res) => {
    if (err)
      return cb(err)

    cb(null, res.rows)
  })
}

const getUserInfo = (user_id, cb) => {
  getUsersInfo([user_id], (err, users) => {
    if (err)
      return cb(err)

    if (users.length < 1)
      return cb(permissionError())

    cb(null, users[0])
  })
}

const fetchTokens = (form, cb) => {
  const auth = config.docusign.integrator_key + ':' + config.docusign.secret_key

  const headers = {
    Authorization: 'Basic ' + (Buffer.from(auth).toString('base64'))
  }

  const params = {
    uri: `${config.docusign.baseurl}/oauth/token`,
    method: 'POST',
    headers,
    form,
    json: true
  }

  request(params, (err, res, body) => {
    if (err || res.statusCode !== 200)
      return cb(Error.Generic(err || body))

    cb(null, body)
  })
}

const getLoginInfo = (user_id, token, cb) => {
  const headers = {
    Authorization: 'Bearer ' + token
  }
  const params = {
    uri: `${config.docusign.baseurl}/oauth/userinfo`,
    headers,
    json: true
  }

  request(params, (err, res, body) => {
    if (err || res.statusCode !== 200)
      return cb(Error.Generic(err || body))

    cb(null, body)
  })
}

const saveUser = ({
  user_id,
  access_token,
  refresh_token,
  account_id,
  base_url,
  first_name,
  last_name,
  email
}, cb) => {
  db.query('envelope/user/insert', [
    user_id,
    access_token,
    refresh_token,
    account_id,
    base_url,
    first_name,
    last_name,
    email
  ], cb)
}

Envelope.saveUserInfo = (user_id, code, cb) => {
  fetchTokens({
    code,
    grant_type: 'authorization_code'
  }, (err, tokens) => {
    if (err)
      return cb(err)

    getLoginInfo(user_id, tokens.access_token, (err, info) => {
      if (err)
        return cb(err)

      saveUser({
        user_id,
        access_token: tokens.access_token,
        refresh_token: tokens.refresh_token,
        account_id: info.accounts[0].account_id,
        base_url: info.accounts[0].base_uri,
        first_name: info.given_name,
        last_name: info.family_name,
        email: info.email
      }, cb)
    })
  })
}

Envelope.deleteUserInfo = user => {
  return db.query.promise('envelope/user/delete', [user.id])
}

Envelope.getExpiringUsers = async () => {
  const { rows } = await db.query.promise('envelope/user/expiring')
  return rows
}

Envelope.refreshToken = async docusign_user => {
  const tokens = await promisify(fetchTokens)({
    grant_type: 'refresh_token',
    refresh_token: docusign_user.refresh_token
  })

  const info = await promisify(getLoginInfo)(docusign_user.user, tokens.access_token)

  await promisify(saveUser)({
    user_id: docusign_user.user,
    access_token: tokens.access_token,
    refresh_token: tokens.refresh_token,
    account_id: docusign_user.account_id,
    base_url: docusign_user.base_url,
    first_name: info.given_name,
    last_name: info.family_name,
    email: info.email
  })
}

const docusignRequest = (user_id, r, cb) => {
  getUserInfo(user_id, (err, info) => {

    const refreshTokenAndRetry = () => {
      fetchTokens({
        grant_type: 'refresh_token',
        refresh_token: info.refresh_token
      }, (err, tokens) => {
        if (err)
          return cb(permissionError())

        saveUser({
          user_id,
          access_token: tokens.access_token,
          refresh_token: tokens.refresh_token,
          account_id: info.account_id,
          base_url: info.base_url,
          first_name: info.first_name,
          last_name: info.last_name,
          email: info.email
        }, err => {
          if (err)
            return cb(err)

          r.headers.Authorization = 'Bearer ' + tokens.access_token

          request(r, (err, res, body) => { //Retry with the newly acquired token.
            if (res.statusCode >= 400 && res.statusCode <= 499) {
              Context.log('Docusign request failed', res.statusCode, body.toString())
              return cb(Error.BadRequest({
                message: body.message
              }))
            }

            cb(err, res, body)
          })
        })
      })
    }

    if (err)
      return cb(err)

    r.uri = r.url || `${info.base_url}/restapi/v2/accounts/${info.account_id}${r.uri}`

    if (!r.headers)
      r.headers = {}

    r.headers.Authorization = 'Bearer ' + info.access_token

    request(r, (err, res, body) => {
      if (err)
        return cb(err)

      // If its a 401, we should refresh the token and try again.
      // Otherwise, none of this wrapper's business
      if (res.statusCode === 401)
        return refreshTokenAndRetry()

      Context.log('Docusign call result', r.uri, res.statusCode, body.message)

      if (res.statusCode >= 400 && res.statusCode <= 499) {
        return cb(Error.BadRequest({
          message: body.message
        }))
      }

      return cb(err, res, body)
    })
  })
}

const addDocument = (document, cb) => {
  db.query('envelope/document/add', [
    document.envelope_id,
    document.title,
    document.document_id,
    document.task,
    document.revision,
    document.file
  ], cb)
}

Envelope.create = function (envelope, cb) {
  const insert = cb => {
    db.query('envelope/insert', [
      envelope.created_by,
      envelope.owner,
      envelope.deal,
      envelope.auto_notify === undefined ? true : envelope.auto_notify
    ], cb)
  }

  const addRecipient = (envelope_id, rec, cb) => {
    db.query('envelope/recipient/add', [
      envelope_id,
      rec.role,
      typeof(rec.order) === 'number' ? rec.order : 1,
      rec.envelope_recipient_type
    ], (err, res) => {
      if (err)
        return cb(err)

      return cb(null, {
        id: res.rows[0].id,
        order: res.rows[0].order,
        role: rec.role,
        envelope_recipient_type: rec.envelope_recipient_type
      })
    })
  }

  const addRecipients = (cb, results) => {
    async.map(envelope.recipients, addRecipient.bind(null, results.insert.rows[0].id), cb)
  }

  const updateTask = ({task, deal, user}, cb) => {
    Deal.updateTaskSubmission({
      user,
      deal,
      task
    }).nodeify(cb)
  }

  const tasks_revisions = {}

  const getRevision = (deal, user, task, cb) => {
    updateTask({deal, user, task}, (err, submission) => {
      if (err)
        return cb(err)

      tasks_revisions[task.id] = submission.last_revision
      Submission.getRevision(submission.last_revision).nodeify(cb)
    })
  }

  const getTasks = (cb, results) => {
    const tasks = envelope.documents
      .filter(doc => Boolean(doc.task)) //Filter the documents that are not tasks.
      .map(doc => doc.task)

    Task.getAll(tasks).nodeify(cb)
  }

  const getRevisions = (cb, results) => {
    async.map(results.tasks, (task, cb) => {
      getRevision(results.deal, results.user, task, cb)
    }, cb)
  }

  const getFiles = (cb, results) => {
    const files = envelope.documents
      .filter(doc => Boolean(doc.file)) //Filter the documents that are not files.
      .map(doc => doc.file)

    AttachedFile.getAll(files).nodeify(cb)
  }

  const pdfs = {}
  const original_pdfs = {}

  const loadOriginalRevisionPdf = (rev, cb) => {
    AttachedFile.download(rev.file, (err, buffer) => {
      if (err)
        return cb(err)

      original_pdfs[rev.id] = buffer
      cb()
    })
  }

  const loadRevisionPdf = (rev, cb) => {
    Submission.flatten(rev).nodeify((err, buffer) => {
      if (err)
        return cb(err)

      pdfs[rev.id] = buffer
      cb()
    })
  }


  const loadPdfs = (cb, results) => {
    async.parallel([
      cb => async.forEach(results.revisions, loadOriginalRevisionPdf, cb),
      cb => async.forEach(results.revisions, loadRevisionPdf, cb),
    ], cb)
  }

  const _loadAssignments = async revisions => {

    const assignments = {}

    for (const revision of revisions) {
      const pdf = original_pdfs[revision.id]
      const document_assignments = await extractMetadata(pdf)

      assignments[revision.id] = document_assignments
    }


    return assignments
  }

  const loadAssignments = (cb, results) => {
    _loadAssignments(results.revisions).nodeify(cb)
  }

  const loadForms = (cb, results) => {
    const forms = results.revisions.map(revision => revision.form)
    Form.getAll(forms).nodeify(cb)
  }

  const addDocuments = (cb, results) => {
    const revisions = _.indexBy(results.revisions, 'id')
    const files = _.indexBy(results.files, 'id')
    const forms = _.indexBy(results.forms, 'id')

    const documents = []

    const prepareRevisionDocument = d => {
      const revision_id = tasks_revisions[d.task]
      const revision = revisions[revision_id]
      const form = forms[revision.form]

      const document = {}
      document.title = `${form.name}.pdf`
      document.task = d.task
      document.revision = revision.id

      return document
    }

    const prepareFileDocument = d => {
      const file = files[d.file]

      const document = {}
      document.title = file.name
      document.file = file.id

      return document
    }

    envelope.documents.forEach((d, i) => {
      let document

      if (d.file)
        document = prepareFileDocument(d)

      if (d.task)
        document = prepareRevisionDocument(d)

      document.document_id = i + 1
      document.envelope_id = results.insert.rows[0].id
      documents.push(document)
    })

    async.map(documents, addDocument, (err, res) => {
      if (err)
        return cb(err)

      cb(null, res.map(r => r.rows[0]))
    })
  }

  const docusign = async (cb, results) => {
    const params = {
      method: 'POST',
      uri: '/envelopes',
      body: {
        emailSubject: envelope.title,
        emailSettings: {
          replyEmailAddressOverride: results.user.email,
          replyEmailNameOverride: results.user.display_name
        },
        documents: [],
        status: 'Created',
        recipients: {
          signers: [],
          carbonCopies: []
        },
        eventNotification: {
          url: Url.api({
            uri: `/envelopes/${results.insert.rows[0].id}/hook`,
            query: {
              token: results.insert.rows[0].webhook_token
            }
          }),
          requireAcknowledgment: true,
          recipientEvents: [
            {recipientEventStatusCode: 'Sent'},
            {recipientEventStatusCode: 'Delivered'},
            {recipientEventStatusCode: 'Completed'},
            {recipientEventStatusCode: 'Declined'},
            {recipientEventStatusCode: 'AuthenticationFailed'},
            {recipientEventStatusCode: 'AutoResponded'}
          ],
          envelopeEvents: [{
            envelopeEventStatusCode: 'Voided',
          }]
        }
      },
      json: true
    }

    if (envelope.body)
      params.body.emailBlurb = envelope.body

    const files = _.indexBy(results.files, 'id')

    results.documents.forEach(document => {
      const documentBase64 = document.task && pdfs[document.submission_revision].toString('base64')
      const remoteUrl = document.file && files[document.file].url

      const doc = {
        documentId: document.document_id,
        name: document.title,
        documentBase64,
        remoteUrl
      }

      params.body.documents.push(doc)
    })


    /* 
     * grouped_roles is used for matching who the assignments should be assigned to.
     * For example an assignment may say { role: [Buyer, BuyerpowerOfAttorney], number: 0 }, 
     * That would mean this assignment should be assigned to the first (number 0) Buyer. If no Buyer
     * is defined within the recipients, BuyerPowerOfAttorney should also be accepted.
     * It's all easy peasy here. Until you get to the filtering part. The question is
     * what does this filtering based on isRecipient doing here?
     * Imagine you have the following assignment: {role: [Seller], number: 0}
     * And in your deal you have 2 sellers: John and Jane (In the mentioned order)
     * So, normally, John would be Seller 0, Jane would be Seller 1.
     * Now, if you docusign something, and only send it to Jane, what you expect is that whatever it is
     * That must be assigned to Seller, to be assigned to Jane. 
     * Bottom line is, if you send the docusign to Jane, Jane _IS_ Seller 0.
     * This causes bug forms#256.
     * Also note that clients may swap the order of Jane and John.
     * So if Jane's order is 0 and John's order is 1, then we should consider them as such.
     * Also note that CC'ed recipients should be excluded (server#1949)
     */
    const isAssignee = role => {
      return role.envelope_recipient_type === 'Signer'
    }
    const recipient_ids = _.chain(envelope.recipients).filter(isAssignee).sortBy('order').map('role').value()
    const isRecipient = role => {
      return recipient_ids.includes(role.id)
    }
    const getOrder = role => {
      return recipient_ids.indexOf(role.id)
    }
    const grouped_roles = _.chain(results.roles).filter(isRecipient).sortBy(getOrder).groupBy('role').value()

    const promises = results.recipients.map(recipient => {
      const r = _.find(results.roles, {id: recipient.role})

      if (!r.email)
        throw new Error.Validation(`Role ${r.id} has no email defined`)

      const signer = {
        email: r.email,
        name: r.legal_full_name,
        recipientId: recipient.id,
        customFields: [recipient.id],
        routingOrder: recipient.order,
        /*
         * If null, docusign will send him an email.
         * Otherwise, signer will be an embedded one.
         *
         * Apparently this feature is not enabled for all their plans.
         * Therefore we're disabling it for now.
         *
         clientUserId: r.user === envelope.created_by ? r.user : null,
         */
        tabs: {
          signHereTabs: [],
          dateSignedTabs: [],
          initialHereTabs: [],
          checkboxTabs: [],
          radioGroupTabs: [],
          textTabs: []
        }
      }

      if (recipient.envelope_recipient_type === EnvelopeRecipient.CARBON_COPY) {
        delete signer.tabs
        params.body.recipients.carbonCopies.push(signer)
        return
      }

      let id = 0

      results.documents.forEach(document => {
        if (!document.submission_revision)
          return

        const assignments = results.assignments[document.submission_revision]

        for(const item of assignments) {
          const { assignment, rect, page } = item

          if (!Array.isArray(assignment.role))
            continue

          const match = _.some(assignment.role, role => {
            const found = grouped_roles[role]?.[assignment.number]
            return found?.id === r.id
          })

          if (!match)
            continue

          const tab = {
            documentId: document.document_id,
            pageNumber: page,
            xPosition: parseInt(rect[0]),
            yPosition: parseInt(rect[1]),
            tabLabel: `tab-${++id}`,
            required: false
          }

          // These magic numbers are offsets specific to SignatureHere and InitialsHere tabs
          // Found them here http://stackoverflow.com/questions/24170573/absolute-coordinate-positioning-of-signhere-tabs

          if (assignment.assignment === 'Signature') {
            tab.yPosition -= 21
            signer.tabs.signHereTabs.push(tab)
          }

          if (assignment.assignment === 'Date')
            signer.tabs.dateSignedTabs.push(tab)

          if (assignment.assignment === 'Initials') {
            tab.yPosition -= 16
            signer.tabs.initialHereTabs.push(tab)
          }

          if (assignment.assignment === 'Checkbox') {
            tab.xPosition -= 10
            tab.yPosition -= 5
            signer.tabs.checkboxTabs.push(tab)
          }


          if (assignment.assignment === 'Textbox') {
            tab.xPosition -= 2
            tab.yPosition -= 3
            tab.width = parseInt(rect[2]) - parseInt(rect[0])
            tab.height = parseInt(rect[3]) - parseInt(rect[1])
            signer.tabs.textTabs.push(tab)
          }
        }
      })

      if (signer.tabs.signHereTabs.length < 1)
        delete signer.tabs.signHereTabs

      if (signer.tabs.dateSignedTabs.length < 1)
        delete signer.tabs.dateSignedTabs

      if (signer.tabs.initialHereTabs.length < 1)
        delete signer.tabs.initialHereTabs

      if (signer.tabs.textTabs.length < 1)
        delete signer.tabs.textTabs

      if (signer.tabs.checkboxTabs.length < 1)
        delete signer.tabs.checkboxTabs

      if (signer.tabs.radioGroupTabs.length < 1)
        delete signer.tabs.radioGroupTabs

      params.body.recipients.signers.push(signer)
    })

    await Promise.all(promises)

    docusignRequest(envelope.owner, params, (err, res, body) => {
      if (err)
        return cb(err)

      if (res.statusCode !== 201) {
        return cb(Error.Generic(body))
      }

      cb(null, body)
    })
  }

  const updateEnvelope = (cb, results) => {
    update({
      id: results.insert.rows[0].id,
      docusign_id: results.docusign.envelopeId,
      status: results.docusign.status,
      title: envelope.title
    }, cb)
  }

  const done = (err, results) => {
    if (err)
      return cb(err)


    Envelope.get(results.insert.rows[0].id, (err, envelope) => {
      if (err)
        return cb(err)

      Envelope.emit('envelope created', envelope)
      cb(null, envelope)
    })
  }

  const addActivity = (cb, results) => {
    const formatter = task => {
      const activity = {
        action: 'UserCreatedEnvelopeForTask',
        object_class: 'envelope_activity',
        object: {
          type: 'envelope_activity',
          task,
          envelope
        }
      }

      return activity
    }

    addEnvelopeActivity({
      envelope_id: results.insert.rows[0].id,
      formatter,
      user_id: envelope.created_by,
      set_author: false
    }).nodeify(cb)
  }

  const saveDocuments = async (cb, results) => {
    Envelope.saveDocuments(results.envelope.id).nodeify(cb)
  }

  const getRoles = (cb, results) => {
    DealRole.getAll(results.deal.roles).nodeify((err, roles) => {
      if (err)
        return cb(err)

      setDynamicRoles({
        deal: results.deal,
        roles
      })

      cb(null, roles)
    })
  }

  async.auto({
    // To make sure that there _is_ an access token, we fetvh the token first.
    // If there isnt, we stop the process right here and ask user to authenticate.
    token: cb => getUserInfo(envelope.owner, cb),

    deal: cb => Deal.get(envelope.deal, cb),
    roles: ['deal', getRoles],
    user: cb => User.get(envelope.created_by).nodeify(cb),
    validate: cb => validate(envelope, cb),
    insert: ['validate', 'token', insert],
    recipients: ['insert', addRecipients],
    tasks: getTasks,
    revisions: ['token', 'tasks', 'user', 'deal', getRevisions],
    files: ['token', getFiles],
    loadPdfs: ['revisions', 'files', loadPdfs],
    assignments: ['loadPdfs', loadAssignments],
    forms: ['revisions', loadForms],
    documents: ['revisions', 'forms', 'insert', 'files', addDocuments],
    activities: ['documents', addActivity],
    docusign: ['loadPdfs', 'insert', 'recipients', 'roles', 'forms', 'assignments', 'documents', 'user', docusign],
    updateEnvelope: ['docusign', updateEnvelope],
    envelope: ['updateEnvelope', (cb, results) => Envelope.get(results.insert.rows[0].id, cb)],
    saveDocuments: ['envelope', saveDocuments],
  }, done)
}

Envelope.saveDocuments = async envelope_id => {
  const envelope = await promisify(Envelope.get)(envelope_id)
  const user = await User.get(envelope.created_by)

  const documents = await promisify(EnvelopeDocument.getAll)(envelope.documents)

  const saveDocument = async document => {
    const pdf = await promisify(Envelope.getDocuments)(envelope.id, document.document_id)

    const saved = await AttachedFile.saveFromBuffer({
      filename: `${document.title}.pdf`,
      relations: [
        {
          role: 'Envelope',
          role_id: envelope.id
        },
        {
          role: 'EnvelopeDocument',
          role_id: document.id
        }
      ],
      path: envelope.deal,
      user,
      public: false,
      buffer: pdf
    })

    await db.query.promise('envelope/document/add-revision', [
      document.id,
      saved.id
    ])
  }

  const promises = documents.map(saveDocument)

  await Promise.all(promises)
}

const getRelevantTasks = async envelope_id => {
  const envelope = await promisify(Envelope.get)(envelope_id)
  const documents = await promisify(EnvelopeDocument.getAll)(envelope.documents)

  const envelope_tasks = new Set(documents.map(d => d.task))
  const envelope_attachments = new Set(documents.map(d => d.file))

  const deal = await promisify(Deal.get)(envelope.deal)

  const checklists = await DealChecklist.getAll(deal.checklists)

  let task_ids = []
  checklists.forEach(c => {
    task_ids = task_ids.concat(c.tasks)
  })

  const tasks = await Task.getAll(task_ids)
  const room_ids = tasks.map(t => t.room)
  const rooms = await promisify(Room.getAll)(room_ids)
  const indexed = _.indexBy(rooms, 'id')

  const relevant = []

  for(const task of tasks) {
    if (envelope_tasks.has(task.id)) {
      relevant.push(task)
      continue
    }

    if (_.intersection(indexed[task.room].attachments, Array.from(envelope_attachments)).length > 0) {
      relevant.push(task)
    }
  }

  return relevant
}

const addEnvelopeActivity = async ({envelope_id, formatter, user_id, deal_role, set_author = true}) => {
  let user

  if (set_author && user)
    user_id = await User.get(user_id)

  const tasks = await getRelevantTasks(envelope_id)

  for(const task of tasks) {
    const activity = formatter(task)

    await promisify(RoomActivity.postToRoom)({
      room_id: task.room,
      activity,
      deal_role,
      user_id,
      set_author: false
    })
  }

  return tasks
}

const updateRecipient = (envelope, deal, recipient, cb) => {
  Context.log('Updating recipient', recipient)
  const issueActivity = (role, cb) => {
    const formatter = task => {
      const activity = {
        action: 'DealRoleReactedToEnvelopeForTask',
        object_class: 'envelope_activity',
        object: {
          type: 'envelope_activity',
          recipient,
          task
        }
      }

      return activity
    }

    addEnvelopeActivity({
      envelope_id: envelope.id,
      formatter,
      deal_role: role.id,
    }).nodeify(cb)
  }

  const issueNotification = (envelope, role, recipient, cb) => {
    if (role.user === envelope.created_by)
      return cb() // Dont send me a notification that I just signed the doc.

    const enabled = [
      'Completed',
      'Declined',
    ]

    if (!enabled.includes(recipient.status))
      return cb()

    Envelope.emit('envelope recipient updated', {
      recipient,
      envelope
    })

    const notification = {}
    notification.action = 'ReactedTo'
    notification.object = envelope.id
    notification.object_class = 'Envelope'
    notification.subject = role.id
    notification.subject_class = 'DealRole'
    notification.auxiliary_subject = recipient.id
    notification.auxiliary_subject_class = 'EnvelopeRecipient'
    notification.auxiliary_object = envelope.deal
    notification.auxiliary_object_class = 'Deal'
    notification.message = `${role.legal_full_name} ${recipient.status} your documents.`
    notification.title = DealContext.getStreetAddress(deal)

    Notification.issueForUser(notification, envelope.created_by, cb)
  }

  EnvelopeRecipient.get(recipient.id, (err, old) => {
    if (err)
      return cb(err)

    if (old.status === fixStatus(recipient.status))
      return cb()

    db.query('envelope/recipient/update', [
      recipient.id,
      fixStatus(recipient.status),
      recipient.signed_at
    ], (err, res) => {
      if (err)
        return cb(err)

      if (res.rows.length < 1)
        return cb(Error.Generic(`Cannot find recipient ${recipient.id} for envelope ${envelope.id}`))

      DealRole.get(res.rows[0].role).nodeify((err, role) => {
        if (err)
          return cb(err)

        issueNotification(envelope, role, recipient, err => {
          if (err)
            return cb(err)

          issueActivity(role, cb)
        })
      })
    })
  })
}

const _updateStatus = (id, xml, cb) => {
  Context.log('Updating envelope', id)
  const cleanup = (cb, results) => {
    const status = results.payload.DocuSignEnvelopeInformation.EnvelopeStatus[0]

    const data = {
      envelope_status: status.Status[0],
      recipients: []
    }

    data.recipients = status.RecipientStatuses[0].RecipientStatus
    /*
     * If the recipient is not sent from Rechat,
     * for exampe when he is a CarbonCopy recipient,
     * then there's gonna be no CustomField.
     *
     * Filter them out.
     */
      .filter(rs => (rs.CustomFields[0] && rs.CustomFields[0].CustomField[0]))
      .map(rs => {
        return {
          status: rs.Status[0],
          id: rs.CustomFields[0].CustomField[0],
          signed_at: rs.Signed ? rs.Signed[0] : null,
        }
      })

    data.documents = status.DocumentStatuses[0].DocumentStatus
      .map(ds => {
        return {
          id: parseInt(ds.ID[0]),
          title: ds.Name[0]
        }
      })

    cb(null, data)
  }

  const updateStatus = (cb, results) => {
    update({
      id: results.envelope.id,
      docusign_id: results.envelope.docusign_id,
      status: results.data.envelope_status,
      title: results.envelope.title
    }, cb)
  }

  const updateRecipients = (cb, results) => {
    async.forEach(results.data.recipients, updateRecipient.bind(null, results.envelope, results.deal), cb)
  }

  const submitTask = (task, cb) => {
    task.attention_requested = true
    Task.update(task).nodeify(cb)
  }

  const submit = (cb, results) => {
    if (results.data.envelope_status !== 'Completed')
      return cb()

    if (!results.envelope.auto_notify)
      return cb()

    getRelevantTasks(results.envelope.id).nodeify((err, tasks) => {
      if (err)
        return cb(err)

      async.forEach(tasks, submitTask, cb)
    })
  }


  const _addNewDocuments = async results => {
    const existing = await promisify(EnvelopeDocument.getAll)(results.envelope.documents)
    const existing_ids = existing.map(d => d.document_id)

    const newDocuments = []

    for(const document of results.data.documents) {
      if (existing_ids.includes(document.id))
        continue

      const d = {
        envelope_id: results.envelope.id,
        title: document.title,
        document_id: document.id,
      }

      const saved = await promisify(addDocument)(d)
      newDocuments.push(saved)
    }

    return newDocuments
  }

  const addNewDocuments = (cb, results) => {
    _addNewDocuments(results).nodeify(cb)
  }

  const saveDocuments = (cb, results) => {
    Envelope.saveDocuments(results.envelope.id).nodeify(cb)
  }

  const _issueActivity = async results => {
    if (results.data.envelope_status === 'Voided')
      await issueVoidActivity(results.envelope)

    const newDocuments = results.newDocuments.map(r => r.rows[0].id)

    for(const newDocument of newDocuments)
      await issueNewDocumentActivity(results.envelope, newDocument)
  }

  const issueActivity = (cb, results) => {
    _issueActivity(results).nodeify(cb)
  }

  const live = (cb, results) => {
    Deal.notifyById(results.envelope.deal, Deal.UPDATED).nodeify(cb)
  }

  async.auto({
    envelope: cb => Envelope.get(id, cb),
    deal: ['envelope', (cb, results) => Deal.get(results.envelope.deal, cb)],
    payload: cb => parser.parseString(xml, cb),
    data: ['envelope', 'payload', cleanup],
    status: ['data', updateStatus],
    recipients: ['data', 'deal', updateRecipients],
    documents: ['envelope', 'newDocuments', saveDocuments],
    newDocuments: ['envelope', 'data', addNewDocuments],
    activity: ['data', 'envelope', 'newDocuments', 'documents', issueActivity],
    submit: ['data', submit],
    live: ['submit', live]
  }, cb)
}

const updateStatus = (id, xml) => {
  return promisify(_updateStatus)(id, xml)
}

Envelope.updateStatus = peanar.job({
  handler: updateStatus,
  exchange: 'envelope_update',
  name: 'envelope_update',
  queue: 'envelope_update',
  error_exchange: 'envelope_update.error',
  max_retries: 10,
  retry_delay: 30000,
  retry_exchange: 'envelope_update.retry',
})

const issueVoidActivity = async envelope => {
  const formatter = task => {
    const activity = {
      action: 'UserVoidedEnvelopeForTask',
      object_class: 'envelope_activity',
      object: {
        type: 'envelope_activity',
        envelope
      },
    }

    return activity
  }

  return addEnvelopeActivity({
    envelope_id: envelope.id,
    formatter,
    user_id: envelope.created_by,
  })
}

const issueNewDocumentActivity = async (envelope, document_id) => {
  const document = await promisify(EnvelopeDocument.get)(document_id)
  const file = await AttachedFile.get(document.pdf)

  const activity = {
    action: 'UserUploadedFile',
    object_class: 'file',
    object: file
  }

  const tasks = await addEnvelopeActivity({
    envelope_id: envelope.id,
    formatter: () => activity,
    user_id: envelope.created_by,
  })

  for(const task of tasks) {
    await promisify(Message.post)(task.room, {
      attachments: [file.id],
      author: envelope.created_by
    }, false)
  }
}

Envelope.update = (id, cb) => {
  const updateRecipients = (cb, results) => {
    const params = {
      uri: `/envelopes/${results.envelope.docusign_id}/recipients`,
      headers,
      json: true
    }

    docusignRequest(results.envelope.owner, params, (err, res, body) => {
      if (err)
        return cb(err)

      if (res.statusCode !== 200)
        return cb(Error.Generic(body))

      const recipients = body.signers
        .filter(signer => signer.customFields && signer.customFields[0])
        .map(signer => {
          return {
            id: signer.customFields[0],
            status: signer.status,
            signed_at: signer.signedDateTime || null
          }
        })

      async.forEach(recipients, updateRecipient.bind(null, results.envelope, results.deal), cb)
    })
  }

  const updateEnvelope = (cb, results) => {
    const params = {
      uri: `/envelopes/${results.envelope.docusign_id}`,
      headers,
      json: true
    }

    docusignRequest(results.envelope.owner, params, (err, res, body) => {
      if (err)
        return cb(err)

      if (res.statusCode !== 200)
        return cb(Error.Generic(body))

      update({
        id: results.envelope.id,
        docusign_id: results.envelope.docusign_id,
        status: body.status,
        title: results.envelope.title
      }, cb)
    })
  }

  const updateDocuments = (cb, results) => {
    Envelope.saveDocuments(results.envelope.id).nodeify(cb)
  }

  async.auto({
    envelope: cb => Envelope.get(id, cb),
    deal: ['envelope', (cb, results) => Deal.get(results.envelope.deal, cb)],
    updateRecipients: ['envelope', 'deal', updateRecipients],
    updateEnvelope: ['envelope', updateEnvelope],
    documents: ['envelope', updateDocuments],
  }, cb)
}

Envelope.getDocuments = (id, doc, cb) => {
  Envelope.get(id, (err, envelope) => {
    if (err)
      return cb(err)

    const params = {
      uri: `/envelopes/${envelope.docusign_id}/documents/${doc}`,
      headers,
      encoding: null
    }

    docusignRequest(envelope.owner, params, (err, res, body) => {
      if (err || res.statusCode !== 200)
        return cb(Error.Generic(err || body.toString()))

      cb(null, body)
    })
  })
}

Envelope.getSignUrl = ({envelope_id, user, recipient_id}, cb) => {
  const getRecipient = cb => {
    EnvelopeRecipient.get(recipient_id, cb)
  }

  const getRole = (cb, results) => {
    DealRole.get(results.recipient.role).nodeify(cb)
  }

  const getSignUrl = (cb, results) => {
    if (results.role.user !== user.id)
      throw new Error.Forbidden(`${user.id} cannot sign on behalf of ${recipient_id}`)

    const r = results.role

    const params = {
      uri: `/envelopes/${results.envelope.docusign_id}/views/recipient`,
      headers,
      method: 'POST',
      body: {
        authenticationMethod: 'Email',
        clientUserId: r.user,
        email: r.email,
        recipientId: results.recipient.id,
        userName: r.legal_full_name,

        returnUrl: Url.api({
          uri: `/envelopes/${envelope_id}/signed`,
          query: {
            token: results.envelope.webhook_token
          }
        })
      },
      json: true
    }

    docusignRequest(results.envelope.owner, params, (err, res, body) => {
      if (err || res.statusCode !== 201)
        return cb(Error.Generic(err || body))

      cb(null, body.url)
    })
  }

  const done = (err, results) => {
    if (err)
      return cb(err)

    cb(null, results.url)
  }

  async.auto({
    envelope: cb => Envelope.get(envelope_id, cb),
    recipient: getRecipient,
    role: ['recipient', getRole],
    url: ['envelope', 'recipient', 'role', getSignUrl]
  }, done)
}

Envelope.getEditUrl = ({envelope_id}, cb) => {
  const getEditUrl = (cb, results) => {
    const params = {
      uri: `/envelopes/${results.envelope.docusign_id}/views/edit`,
      headers,
      method: 'POST',
      body: {
        returnUrl: Url.api({
          uri: `/envelopes/${envelope_id}/signed`,
          query: {
            token: results.envelope.webhook_token
          }
        })
      },
      json: true
    }

    docusignRequest(results.envelope.owner, params, (err, res, body) => {
      if (err || res.statusCode !== 201)
        return cb(Error.Generic(err || body))

      cb(null, body.url)
    })
  }

  const done = (err, results) => {
    if (err)
      return cb(err)

    cb(null, results.url)
  }

  async.auto({
    envelope: cb => Envelope.get(envelope_id, cb),
    url: ['envelope', getEditUrl]
  }, done)
}


Envelope.void = (envelope_id, cb) => {
  const get = cb => Envelope.get(envelope_id, cb)

  const void_envelope = (cb, results) => {
    const params = {
      uri: `/envelopes/${results.get.docusign_id}`,
      headers,
      method: 'PUT',
      body: {
        status: 'voided',
        voidedReason: 'Envelope voided'
      },
      json: true
    }

    docusignRequest(results.get.owner, params, (err, res, body) => {
      if (err)
        return cb(err)

      if (res.statusCode !== 200)
        return cb(Error.Generic(body))

      return cb()
    })
  }

  const update = cb => {
    db.query('envelope/void', [envelope_id], cb)
  }

  const issueActivity = (cb, results) => {
    /*
     * Normally we expect such activities to be recorded
     * when the envelope webhook is called.
     *
     * But due to a bug[0] in docusign
     * when a draft envelope gets voided, no webhook is called.
     *
     * This is to cicumvent that bug.
     *
     * [0] https://stackoverflow.com/questions/54401340/webhook-not-called-on-a-voided-discarded-draft-envelope
     */

    if (results.get.status !== 'Created')
      return cb()

    issueVoidActivity(results.get).nodeify(cb)
  }

  const done = (err) => {
    if (err)
      return cb(err)

    Envelope.get(envelope_id, cb)
  }

  async.auto({
    get,
    void_envelope: ['get', void_envelope],
    update: ['void_envelope', update],
    activity: ['get', issueActivity]
  }, done)
}

Envelope.resend = (envelope_id, cb) => {
  const get = cb => Envelope.get(envelope_id, cb)

  const resend = (cb, results) => {
    const params = {
      uri: `/envelopes/${results.get.docusign_id}?resend_envelope=true`,
      method: 'PUT',
      headers,
      body: {},
      json: true
    }

    docusignRequest(results.get.owner, params, (err, res, body) => {
      if (err)
        return cb(err)

      if (res.statusCode !== 200)
        return cb(Error.Generic(body))

      return cb()
    })
  }

  const done = (err) => {
    if (err)
      return cb(err)

    Envelope.get(envelope_id, cb)
  }

  async.auto({
    get,
    resend: ['get', resend],
  }, done)
}

module.exports = Envelope
