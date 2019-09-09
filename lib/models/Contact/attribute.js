const { EventEmitter } = require('events')

const _ = require('lodash')

const squel = require('../../utils/squel_extensions')
const validator = require('../../utils/validator.js')
const belt = require('../../utils/belt')
const db = require('../../utils/db')

const Context = require('../Context')
const Orm = require('../Orm')
const AttributeDef = require('./attribute_def')
const Summary = require('./summary')

const expect = validator.expect

const formatters = {
  email: function(attr) {
    attr.text = attr.text ? attr.text.toLowerCase() : attr.text
  }
}

/**
 * Loads attribute defs for a user plus any additional def ids needed
 * @param {UUID} brand_id
 * @param {UUID[]} additional_defs
 */
async function loadUserAttributeDefs(brand_id, additional_defs = []) {
  const defs_for_user = await AttributeDef.getForBrand(brand_id)
  const def_ids_to_get = Array.from(
    new Set(defs_for_user.concat(additional_defs || []))
  )
  const defs = await AttributeDef.getAll(def_ids_to_get)
  return _.keyBy(defs, 'id')
}

function ensureFieldsOnAttributes(attributes, fields) {
  for (const attr of attributes) {
    for (const k of fields) {
      if (attr[k] === undefined) attr[k] = null
    }
    if (attr.is_primary === null) attr.is_primary = false
    if (attr.is_partner === null) attr.is_partner = false
    if (attr.label === '') attr.label = null
  }
}

/**
 * Updates updated_at for contacts
 * @param {UUID[]} contact_ids
 * @param {TContactActionReason} _reason
 */
function set_updated_at_for_contacts(contact_ids, user_id, _reason = 'direct_request') {
  return db.update('contact/set_updated_at', [
    contact_ids,
    user_id,
    Context.getId(),
    _reason
  ])
}

/**
 *
 * @param {IContactAttributeInputWithContact} attr
 * @param {_.Dictionary<IContactAttributeDef>} defs_by_id
 */
function get_def_from_attribute(attr, defs_by_id) {
  let def

  if (attr.attribute_def) {
    def = defs_by_id[attr.attribute_def]
  }
  else if (attr.attribute_type) {
    const defs = Object.values(defs_by_id)
    const defs_by_name = _.keyBy(defs, 'name')

    def = defs_by_name[attr.attribute_type]
  }

  if (!def) {
    throw Error.Validation(
      `Attribute definition ${attr.attribute_type || attr.attribute_def} not found.`
    )
  }

  return def
}

class ContactAttribute extends EventEmitter {
  /**
   * @param {IContactAttributeInputWithContact} attribute
   * @param {Record<UUID, IContactAttributeDef>} defs_by_id
   */
  validate(attribute, defs_by_id) {
    if (
      typeof attribute.attribute_def !== 'string' &&
      typeof attribute.attribute_type !== 'string'
    ) {
      throw Error.Validation('Attribute definition is not specified.')
    }

    if (typeof attribute.contact !== 'string') {
      throw Error.Validation('Contact is not specified.')
    }

    const def = get_def_from_attribute(attribute, defs_by_id)

    switch (def.data_type) {
      case 'text':
        expect(attribute.text).to.be.a('string')
        break
      case 'number':
      case 'date':
      default:
        expect(attribute[def.data_type]).to.be.a('number')
        break
    }
  }

  /**
   * Get contact attributes by id without any restriction
   * @param {UUID[]} ids
   * @returns {Promise<IContactAttribute[]>}
   */
  async getAll(ids) {
    const attributes = await db.select('contact/attribute/get', [ids])

    return attributes
  }

  /**
   * Get a ContactAttribute by id
   * @param {UUID} id ContactAttribute id
   */
  async get(id) {
    const attributes = await this.getAll([id])

    if (!attributes || attributes.length < 1) {
      throw Error.ResourceNotFound(`ContactAttribute ${id} not found`)
    }

    return attributes[0]
  }

  /**
   * Gets all attributes for a given contact
   * @param {UUID[]} contact_ids
   * @param {UUID[]=} attribute_defs
   * @returns {Promise<IContactAttribute[]>}
   */
  async getForContacts(contact_ids, attribute_defs) {
    const ids = await db.selectIds('contact/attribute/for_contacts', [
      contact_ids,
      attribute_defs
    ])

    if (ids.length < 1) return []

    return this.getAll(ids)
  }

  /**
   * Normalize and clean contact attributes before create or update
   * @param {IContactAttributeInputWithContact[]} attributes
   * @param {Record<UUID, IContactAttributeDef>} defs_by_id
   */
  normalizeAttributes(attributes, defs_by_id) {
    for (let i = 0; i < attributes.length; i++) {
      const attr = attributes[i]

      this.validate(attr, defs_by_id)

      const def = get_def_from_attribute(attr, defs_by_id)
      attr.attribute_def = def.id

      if (def.name === 'email') {
        formatters.email(attr)
      }

      if (def.section === 'Addresses') {
        if (typeof attr.index !== 'number' ) {
          throw Error.Validation('index field on address attributes cannot be empty.')
        }

        if (attr.label === null || attr.label === undefined || attr.label.length < 1) {
          attr.label = 'Home'
        }
      }

      if (def.data_type === 'date' && attr.date) {
        attr.date = belt.epochToDate(attr.date).toISOString()
        if (attr.date[0] === '+') {
          attr.date = attr.date.substring(1)
        }
      }

      attr.attribute_type = def.name
    }

    return attributes
  }

  /**
   * Create multiple attributes
   * @param {IContactAttributeInputWithContact[]} attributes
   * @param {UUID} user_id Creator of the attributes
   * @param {UUID} brand_id Owner of the attributes
   * @param {TContactActionReason} _reason
   */
  async create(attributes, user_id, brand_id, _reason) {
    if (!attributes || attributes.length < 1) return { attribute_ids: [], affected_contact_ids: [] }

    const defs_by_id = await loadUserAttributeDefs(brand_id)
    const fields = [
      'created_by',
      'created_within',
      'created_for',
      'contact',
      'attribute_def',
      'attribute_type',
      'text',
      'date',
      'number',
      'label',
      'is_primary',
      'is_partner',
      'index'
    ]

    const to_create = attributes
      .filter(attr => {
        if (attr.text)
          return attr.text.trim() !== ''

        return attr.text !== ''
      })
      .map(attr => /** @type {IContactAttributeInputWithContact} */({
        ..._.pick(attr, fields),
        created_for: _reason
      }))

    this.normalizeAttributes(to_create, defs_by_id)
    ensureFieldsOnAttributes(to_create, fields)

    const LIBPQ_PARAMETER_LIMIT = 0xffff

    try {
      const chunks = await Promise.all(
        _(to_create)
          .chunk(Math.floor(LIBPQ_PARAMETER_LIMIT / fields.length))
          .map((chunk, i) => {
            const q = squel
              .insert()
              .into('contacts_attributes')
              .setFieldsRows(chunk)
              .returning('id')
              .returning('is_primary')
              .returning('contact')

            // @ts-ignore
            q.name = 'contact/attribute/create#' + i
            return db.select(q)
          })
          .value()
      )

      const result = chunks.flat()

      const primary_attrs = result.filter(c => c.is_primary).map(c => c.id)
      if (primary_attrs.length > 0) {
        await db.update('contact/attribute/clear_primaries', [ primary_attrs ])
      }

      const attribute_ids = result.map(c => c.id)
      const affected_contact_ids = _.uniq(result.map(c => c.contact))

      await set_updated_at_for_contacts(
        affected_contact_ids,
        user_id,
        _reason
      )

      return { attribute_ids, affected_contact_ids }
    } catch (ex) {
      if (ex.constraint === 'unique_index_for_contact_attribute_cst') {
        throw Error.BadRequest(ex.detail)
      } else {
        throw ex
      }
    }
  }

  /**
   * Deletes multiple attributes
   * @param {UUID[]} attribute_ids
   * @param {UUID} user_id
   * @param {TContactActionReason} _reason
   */
  async delete(attribute_ids, user_id, _reason = 'direct_request') {
    const affected_contacts = await db.map('contact/attribute/delete', [
      attribute_ids,
      user_id,
      Context.getId(),
      _reason
    ], 'contact')

    await db.update('contact/set_updated_at', [
      affected_contacts,
      user_id,
      Context.getId(),
      _reason
    ])

    await Summary.update(affected_contacts)

    this.emit('delete', { attribute_ids, affected_contacts, user_id })

    return affected_contacts
  }

  /**
   * Deletes an attribute by id for a contact
   * @param {UUID} contact_id
   * @param {UUID} attribute_id
   * @param {UUID} user_id
   * @param {TContactActionReason} _reason
   */
  async deleteForContact(contact_id, attribute_id, user_id, _reason = 'direct_request') {
    const attr = await this.get(attribute_id)
    if (!attr || attr.contact !== contact_id) return 0

    await this.delete([attr.id], user_id, _reason)
    return 1
  }

  /**
   * Updates a number of a contact's attributes
   * @param {IContactAttributeInputWithContact[]} attributes
   * @param {UUID} user_id
   * @param {TContactActionReason} _reason
   * @returns {Promise<Set<UUID>>}
   */
  async update(attributes, user_id, _reason = 'direct_request') {
    if (!Array.isArray(attributes) || attributes.length < 1) return new Set()

    const update_fields = [
      'id',
      'text',
      'date',
      'number',
      'label',
      'is_primary',
      'index'
    ]

    const audit_fields = [
      'updated_by',
      'updated_for',
      'updated_within'
    ]

    const contact_ids = new Set(attributes.map(attr => attr.contact))
    const contact_attrs = await this.getForContacts(Array.from(contact_ids))
    const attrs_by_id = _.keyBy(contact_attrs, 'id')

    const merged_attributes = attributes
      .filter(
        /** @type {TIsRequirePropPresent<IContactAttributeInputWithContact, 'id'>} */ (attr =>
          attr.hasOwnProperty('id'))
      )
      .filter(attr => attrs_by_id[attr.id])
      .map(attr => ({ ...attrs_by_id[attr.id], ..._.pick(attr, update_fields) }))

    const def_ids = new Set(merged_attributes.map(attr => attr.attribute_def))
    const defs = await AttributeDef.getAll(Array.from(def_ids))
    const defs_by_id = _.keyBy(defs, 'id')

    this.normalizeAttributes(merged_attributes, defs_by_id)
    const final_attributes = merged_attributes.map(attr => _.pick(attr, update_fields))
    ensureFieldsOnAttributes(final_attributes, update_fields)

    const LIBPQ_PARAMETER_LIMIT = 0xffff

    try {
      const chunks = await Promise.all(
        _(final_attributes)
          .chunk(Math.floor(LIBPQ_PARAMETER_LIMIT / (update_fields.length + audit_fields.length)))
          .map((chunk, i) => {
            const q = squel
              .update()
              .withValues('update_values', chunk)
              .table('contacts_attributes', 'ca')
              .set('text = uv.text')
              .set('date = uv.date::timestamptz')
              .set('number = uv.number::float')
              .set('index = uv.index::int2')
              .set('label = uv.label')
              .set('is_primary = uv.is_primary::boolean')
              .set('updated_at = now()')
              .set('updated_by = ?', user_id)
              .set('updated_for = ?', _reason)
              .set('updated_within = ?', Context.getId())
              .from('update_values', 'uv')
              .where('ca.id = (uv.id)::uuid')
              .returning('ca.id')
              .returning('ca.is_primary')

            // @ts-ignore
            q.name = 'contact/attribute/update#' + i

            return /** @type {Promise<{ id: UUID; is_primary: boolean; }[]>} */(db.select(q))
          })
          .value()
      )

      const result = chunks.flat()

      const primary_attrs = result.filter(c => c.is_primary).map(c => c.id)
      if (primary_attrs.length > 0) {
        await db.query.promise('contact/attribute/clear_primaries', [ primary_attrs ])
      }

      await set_updated_at_for_contacts(Array.from(contact_ids), user_id, _reason)

      return contact_ids
    } catch (ex) {
      if (ex.constraint === 'unique_index_for_contact_attribute_cst') {
        throw Error.BadRequest(ex.details)
      } else {
        throw ex
      }
    }
  }
}

ContactAttribute.prototype.associations = {
  attribute_def: {
    model: 'ContactAttributeDef',
    enabled: false
  }
}

module.exports = new ContactAttribute()

Orm.register('contact_attribute', 'ContactAttribute', module.exports)
