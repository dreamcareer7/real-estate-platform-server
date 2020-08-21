const Orm = require('../../../Orm/registry')

const { getAll } = require('./get')

Orm.register('brand_checklist', 'BrandChecklist', {
  getAll
})
