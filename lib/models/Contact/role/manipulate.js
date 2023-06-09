const differenceWith = require('lodash/differenceWith')
const map = require('lodash/map')

const db = require('../../../utils/db')

const Contact = require('../emitter')
const ContactRole = {
  ...require('./get'),
  ...require('./delete'),
}

/** @typedef {Pick<IContactRole, 'brand' | 'contact' | 'user' | 'role' | 'created_by'>} ContactRoleInput */

/**
 * @param {Pick<IContactRole, 'contact' | 'role' | 'created_by'>} common
 * @param {Pick<IContactRole, 'brand' | 'user'>[]} newRoles
 */
async function set (common, newRoles) {
  const oldRoleIds = await ContactRole.filter({
    contact: [common.contact],
    role: common.role,
  })
  const oldRoles = await ContactRole.getAll(oldRoleIds)

  const compareRoles = (a, b) => a.brand === b.brand && a.user === b.user
  const toInsert = differenceWith(newRoles, oldRoles, compareRoles)
  const toDelete = differenceWith(oldRoles, newRoles, compareRoles)

  await upsertMany(common, toInsert)
  await deleteMany(map(toDelete, 'id'))

  // XXX: do we need to update `created_by` and `updated_at` columns of existing roles?

  if (toInsert.length || toDelete.length) {
    const removedBrands = [...new Set(map(toDelete, 'brand'))]
    
    Contact.emit('assigned', {
      contact_ids: [common.contact],
      removed_brands: removedBrands,
    })
    
    /* NOTE: following UGLY workaround, prevents this BUGGY scenario:
     * 1. admin creates a contact having the tag T.
     * 2. admin assigns the contact to user1 and user2.
     * 3. both users create a contact list based on the tag T.
     * 4. both users could see the contact in their lists members. [OK]
     * 5. admin unassigns user2.
     * 6. user1 could not see the contact in their lists members. [BUG] */
    const emitAgain = newRoles.some(r => removedBrands.includes(r.brand))    
    if (emitAgain) {
      Contact.emit('assigned', {
        contact_ids: [common.contact],
        removed_brands: [],
      })
    }
  }
}

/**
 * NOTE: Does not emit any Contact event
 * @param {Pick<IContactRole, 'contact' | 'role' | 'created_by'>} common
 * @param {Pick<IContactRole, 'brand' | 'user'>[]} roles
 */
async function upsertMany (common, roles) {
  if (!roles.length) { return [] }

  const ids = await db.selectIds('contact/role/upsert_many', [
    common.contact,
    common.role,
    common.created_by,
    JSON.stringify(roles),
  ])

  // TODO: send notification to the assignees

  return ids
}

/**
 * NOTE: Does not emit any Contact event
 * @param {IContactRole['id'][]} ids
 */
async function deleteMany (ids) {
  if (!ids.length) { return 0 }

  return db.update('contact/role/delete_many', [ids])
}

module.exports = {
  set,
  upsertMany,
  deleteMany,
}
