const moment = require('moment')
const am = require('../utils/async_middleware')
const {writeCSVToStreamWithIndependentHeaders} = require('../utils/convert_to_excel')
const Brand = require('../models/Brand')

const { Deals } = require('../models/Analytics/OLAP/cubes')
const {
  DealsQueryBuilder,
  ContactMailerExportQueryBuilder,
  ContactJointExportQueryBuilder,
  ContactEmailExportQueryBuilder,
  CrmTaskQueryBuilder
} = require('../models/Analytics/OLAP')
const { BadFilter, UndefinedDimension, UndefinedLevel } = require('../models/Analytics/OLAP/errors')

function getCurrentBrand() {
  const brand = Brand.getCurrent()

  if (!brand || !brand.id)
    throw Error.BadRequest('Brand is not specified.')

  return brand.id
}

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

const models = {
  deals: DealsQueryBuilder(Deals),
  crm_task: CrmTaskQueryBuilder,
  contact_export: ContactJointExportQueryBuilder,
  contact_joint_export: ContactMailerExportQueryBuilder,
  contact_email_export: ContactEmailExportQueryBuilder,
}

async function aggregate(req, res) {
  /** @type {'deals'} */
  const cube_name = req.params.cube
  const {drilldown, filter} = req.body

  if (!models.hasOwnProperty(cube_name))
    throw Error.ResourceNotFound('Model name not found.')

  try {
    const queryBuilder = new models[cube_name](drilldown, filter, req.user.id, getCurrentBrand())

    const rows = await queryBuilder.aggregate()

    res.json({
      code: 'OK',
      data: rows
    })
  }
  catch (ex) {
    if (
      (ex instanceof BadFilter) ||
      (ex instanceof UndefinedDimension) ||
      (ex instanceof UndefinedLevel)
    ) {
      throw Error.BadRequest(ex)
    }
    throw ex
  }
}

async function facts(req, res) {
  /** @type {'deals'} */
  const cube_name = req.params.cube
  const {drilldown, filter, project, ...rest_options} = req.body

  if (!models.hasOwnProperty(cube_name))
    throw Error.ResourceNotFound('Model name not found.')

  const {format, ...query} = req.query

  for (const k of ['limit', 'start']) {
    if (query.hasOwnProperty(k))
      query[k] = parseFloat(query[k])
  }

  try {
    const queryBuilder = new models[cube_name](drilldown, filter, req.user.id, getCurrentBrand())

    let fields, headers

    if (Array.isArray(project)) {
      fields = project
    }
    else if (typeof project === 'object') {
      fields = Object.keys(project)
      headers = Object.values(project)
    }

    const options = {...query, ...rest_options}

    if (Array.isArray(fields)) options.fields = fields

    const rows = await queryBuilder.facts(options)

    if (rows.length > 0)
      headers = headers || await queryBuilder.headerMapper(rows[0])
    else
      headers = []

    switch (format) {
      case 'csv':
        const fileName = `Rechat-Report-${moment().format('MM-DD-YY-HH-mm')}.csv`
        res.attachment(fileName)
        writeCSVToStreamWithIndependentHeaders(
          rows,
          headers,
          res
        )
        break
      default:
        res.collection(rows)
        break
    }
  }
  catch (ex) {
    if (
      (ex instanceof BadFilter) ||
      (ex instanceof UndefinedDimension) ||
      (ex instanceof UndefinedLevel)
    ) {
      throw Error.BadRequest(ex)
    }
    throw ex
  }
}

function getModel(req, res) {
  /** @type {'deals'} */
  const cube_name = req.params.cube

  if (!models.hasOwnProperty(cube_name))
    throw Error.ResourceNotFound('Model name not found.')

  const cube = new models[cube_name]().cube

  res.json({
    code: 'OK',
    data: cube.model
  })
}

const router = function (app) {
  const auth = app.auth.bearer.middleware

  app.post('/analytics/:cube/aggregate', brandAccess, auth, am(aggregate))
  app.post('/analytics/:cube/facts', brandAccess, auth, am(facts))
  app.get('/analytics/:cube/model', brandAccess, auth, getModel)
}

module.exports = router
