const Orm = require('../Orm/registry')

const { getAll } = require('./get')


const associations = {
  user: {
    model: 'User'
  },

  brand: {
    optional: true,
    model: 'Brand'
  },

  template_instance: {
    optional: true,
    model: 'TemplateInstance'
  }
}

Orm.register('website', 'Website', {
  getAll,
  associations
})
