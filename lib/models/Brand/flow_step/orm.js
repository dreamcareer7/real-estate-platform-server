const Orm = require('../../Orm/registry')

const { getAll } = require('./get')

const associations = {
  event: {
    model: 'BrandEvent',
    enabled: false,
    collection: false,
    optional: true
  },

  email: {
    model: 'BrandEmail',
    enabled: false,
    collection: false,
    optional: true
  }
}


Orm.register('brand_flow_step', 'BrandFlowStep', {
  getAll,
  associations
})