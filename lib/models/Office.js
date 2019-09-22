const db = require('../utils/db.js')
const validator = require('../utils/validator.js')

Office = {}

Orm.register('office', 'Office')

const schema = {
  type: 'object',
  properties: {
    board: {
      type: 'string'
    },

    email: {
      type: 'string'
    },

    fax: {
      type: 'string'
    },

    office_mui: {
      type: 'number'
    },

    office_mls_id: {
      type: 'string'
    },

    license_number: {
      type: 'string'
    },

    address: {
      type: 'string'
    },

    care_of: {
      type: 'string'
    },

    city: {
      type: 'string'
    },

    postal_code: {
      type: 'string'
    },

    postal_code_plus4: {
      type: 'string'
    },

    state: {
      type: 'string'
    },

    matrix_unique_id: {
      type: 'number',
      required: true
    },

    matrix_modified_dt: {
      type: 'string'
    },

    mls: {
      type: 'string'
    },

    mls_id: {
      type: 'string'
    },

    mls_provider: {
      type: 'string'
    },

    nar_number: {
      type: 'string'
    },

    contact_mui: {
      type: 'string'
    },

    contact_mls_id: {
      type: 'string'
    },

    long_name: {
      type: 'string'
    },

    name: {
      type: 'string'
    },

    status: {
      type: 'string'
    },

    phone: {
      type: 'string'
    },

    other_phone: {
      type: 'string'
    },

    st_address: {
      type: 'string'
    },

    st_city: {
      type: 'string'
    },

    st_country: {
      type: 'string'
    },

    st_postal_code: {
      type: 'string'
    },

    st_postal_code_plus4: {
      type: 'string'
    },

    st_state: {
      type: 'string'
    },

    url: {
      type: 'string'
    }
  }
}

const validate = validator.promise.bind(null, schema)

Office.create = async office => {
  await validate(office)

  const res = await db.query.promise('office/insert', [
    office.board,
    office.email,
    office.fax,
    office.office_mui,
    office.office_mls_id,
    office.license_number,
    office.address,
    office.care_of,
    office.city,
    office.postal_code,
    office.postal_code_plus4,
    office.state,
    office.matrix_unique_id,
    office.matrix_modified_dt,
    office.mls_name,
    office.mls_id,
    office.mls_provider,
    office.nar_number,
    office.contact_mui,
    office.contact_mls_id,
    office.long_name,
    office.name,
    office.status,
    office.phone,
    office.other_phone,
    office.st_address,
    office.st_city,
    office.st_country,
    office.st_postal_code,
    office.st_postal_code_plus4,
    office.st_state,
    office.url
  ])

  return res.rows[0].id
}

Office.getAll = async office_ids => {
  const res = await db.query.promise('office/get', [office_ids])
  return res.rows
}

Office.getByMLS = async id => {
  const res = await db.query.promise('office/get_mls', [id])

  if (res.rows.length < 1)
    throw Error.ResourceNotFound(`Office ${id} not found`)

  const office = res.rows[0]

  // TODO: WTF? Associations please?
  const agents = await Agent.getByOfficeId(office.mls_id)
  office.agents = agents

  return office
}

Office.search = async query => {
  const res = await db.query.promise('office/search', [query])
  return Office.getAll(res.rows.map(r => r.id))
}

module.exports = function () {}
