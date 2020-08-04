const db = require('../../../utils/db')
const promisify = require('../../../utils/promisify')
const BrandChecklist = require('../../Brand/deal/checklist')
const Task = require('../../Task')
const Deal = require('../../Deal')
const Brand = require('../../Brand')

const Orm = require('../../Orm/registry')

const DealChecklist = {
  ...require('./get')
}

Orm.register('deal_checklist', 'DealChecklist', DealChecklist)

DealChecklist.create = async checklist => {
  const res = await db.query.promise('deal/checklist/insert', [
    checklist.title,
    checklist.order,
    checklist.deal,
    checklist.origin,
    checklist.is_deactivated,
    checklist.is_terminated
  ])

  return DealChecklist.get(res.rows[0].id)
}

DealChecklist.update = async checklist => {
  await db.query.promise('deal/checklist/update', [
    checklist.id,
    checklist.title,
    checklist.order,
    checklist.is_deactivated,
    checklist.is_terminated
  ])

  return DealChecklist.get(checklist.id)
}

/*
 * This one creates a checklist,
 * But also populated is with tasks
 * that fit the criteria based on `conditions`
 */
DealChecklist.createWithTasks = async (checklist, conditions) => {
  const deal = await promisify(Deal.get)(checklist.deal)

  let parent = deal.brand

  let toSave = {}
  const tasks = []

  while(parent) {
    const brand = await Brand.get(parent)
    parent = brand.parent

    const checklists = (await BrandChecklist.getByBrand(brand.id))

    for (const candidate of checklists) {

      if (candidate.deal_type && candidate.deal_type !== conditions.deal_type)
        continue

      if (candidate.property_type && candidate.property_type !== conditions.property_type)
        continue

      toSave = {
        ...candidate,
        ...checklist,
        origin: candidate.id
      }

      Array.prototype.push.apply(tasks, candidate.tasks)
    }
  }

  const saved = await DealChecklist.create(toSave)

  if (tasks.length < 1)
    return DealChecklist.get(saved.id)

  for(const task of tasks) {
    task.checklist = saved.id
    await Task.create(task)
  }

  return DealChecklist.get(saved.id)
}

DealChecklist.associations = {
  tasks: {
    collection: true,
    model: 'Task'
  }
}

module.exports = DealChecklist
