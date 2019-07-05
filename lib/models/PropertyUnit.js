const db = require('../utils/db.js')
const validator = require('../utils/validator.js')

PropertyUnit = {}

const schema = {
  type: 'object',
  properties: {
    matrix_unique_id: {
      type: 'number',
      required: true
    }
  }
}

const validate = validator.promise.bind(null, schema)

PropertyUnit.create = async unit => {
  await validate(unit)

  const res = await db.query.promise('property_unit/insert', [
    unit.dining_length,
    unit.dining_width,
    unit.kitchen_length,
    unit.kitchen_width,
    unit.lease,
    unit.listing_mui,
    unit.living_length,
    unit.living_width,
    unit.master_length,
    unit.master_width,
    unit.matrix_unique_id,
    unit.matrix_modified_dt,
    unit.full_bath,
    unit.half_bath,
    unit.beds,
    unit.units,
    unit.square_feet,
    unit.mls
  ])

  return res.rows[0].id
}

module.exports = function () {}
