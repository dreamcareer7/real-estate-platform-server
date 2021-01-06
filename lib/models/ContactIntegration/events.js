const Contact = require('../Contact/emitter')
const IntegrationWorkers = require('./workers/index')


async function handleEvent({ contact_ids, reason }) {
  IntegrationWorkers.resetEtagByContact({ contact_ids, reason })
}


module.exports = function attachEventHandlers() {
  Contact.on('update', handleEvent)
  Contact.on('delete', handleEvent)
}