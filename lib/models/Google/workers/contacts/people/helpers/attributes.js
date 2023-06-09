const {
  isEqual,
  groupBy,
  difference,
  get,
  differenceWith,
} = require('lodash')
const { haveSameMembers } = require('../../../../../../utils/array-utils')

/** @typedef {{ value?: string, type?: string }} TypedAndLabeled */
/** @typedef {TypedAndLabeled} GooglePhone */
/** @typedef {TypedAndLabeled} GoogleEmail */

const PHONE_LABEL_MAPPING = {
  home: 'Home',
  mobile: 'Mobile',
  work: 'Work',
  fax: 'Fax',
  whatsapp: 'WhatsApp',
}

const EMAIL_LABEL_MAPPING = {
  personal: 'Personal',
  work: 'Work',
}

const ADDRESS_LABEL_MAPPING = {
  home: 'Home',
  work: 'Work',
  'investment property': 'Investment Property',
}

const parseAttributes = (key, resource, contactGroups) => {
  resource || (resource = {})
  
  /** @type {IContactAttributeInput[]} */
  const attributes = []

  if ( key === 'names' ) {
    if (resource?.names?.givenName) {
      attributes.push({
        attribute_type: 'first_name',
        text: resource.names.givenName || ''
      })
    }

    if (resource?.names?.familyName) {
      attributes.push({
        attribute_type: 'last_name',
        text: resource.names.familyName || ''
      })
    }

    if (resource?.names?.middleName) {
      attributes.push({
        attribute_type: 'middle_name',
        text: resource.names.middleName || ''
      })
    }

    if (resource?.nickName) {
      attributes.push({
        attribute_type: 'nickname',
        text: resource.nickName || ''
      })
    }

    if (resource?.honorificPrefix) {
      attributes.push({
        attribute_type: 'title',
        text: resource.honorificPrefix || '',
      })
    }
  }

  if (key === 'website') {
    if (resource.website) {
      attributes.push({ attribute_type: 'website', text: resource.website || '' })
    }
  }

  if (key === 'birthday') {
    if (resource.birthday) {
      const temp     = new Date(resource.birthday)
      const tzOffset = temp.getTimezoneOffset() * 60000
      const birthday = new Date(temp.getTime() - tzOffset)
      
      attributes.push({
        attribute_type: 'birthday',
        date: birthday.getTime() / 1000
      })
    }
  }

  if (key === 'note') {
    if (resource.note) {
      attributes.push({ attribute_type: 'note', text: resource.note || '' })
    }
  }

  if (key === 'organization') {
    if (resource?.organization?.company) {
      attributes.push({ attribute_type: 'company', text: resource.organization.company || '' })
    }

    if (resource?.organization?.jobTitle) {
      attributes.push({ attribute_type: 'job_title', text: resource.organization.jobTitle || '' })
    }
  }

  if (key === 'memberships') {
    if (resource.memberships) {
      for ( const membership of resource.memberships ) {
        const gname = membership.contactGroupResourceName

        if ( gname && contactGroups[gname] ) {
          attributes.push({ attribute_type: 'tag', text: contactGroups[gname] || '' })  
        }
      }
    }
  }

  if (key === 'addresses') {
    for (let i = 0; i < resource.addresses.length; i++) {

      const addressObj = resource.addresses[i]

      const label = ADDRESS_LABEL_MAPPING[addressObj?.type?.toLowerCase()] ?? 'Other'
      
      if (addressObj.city) {
        attributes.push({
          attribute_type: 'city',
          text: addressObj.city || '',
          label: label,
          index: i + 1,
          is_primary: i === 0 ? true : false
        })
      }

      if (addressObj.country) {
        attributes.push({
          attribute_type: 'country',
          text: addressObj.country || '',
          label: label,
          index: i + 1,
          is_primary: i === 0 ? true : false
        })
      }

      if (addressObj.state) {
        attributes.push({
          attribute_type: 'state',
          text: addressObj.state || '',
          label: label,
          index: i + 1,
          is_primary: i === 0 ? true : false
        })
      }

      if (addressObj.postalCode) {
        attributes.push({
          attribute_type: 'postal_code',
          text: addressObj.postalCode || '',
          label: label,
          index: i + 1,
          is_primary: i === 0 ? true : false
        })
      }

      if (addressObj.streetAddress) {
        attributes.push({
          attribute_type: 'street_name',
          text: addressObj.streetAddress || '',
          label: label,
          index: i + 1,
          is_primary: i === 0 ? true : false
        })
      }
    }
  }

  if (key === 'emailes') {
    for (let i = 0; i < resource.emailes.length; i++) {

      const emailObj = resource.emailes[i]

      const label = EMAIL_LABEL_MAPPING[emailObj?.type?.toLowerCase()] ?? 'Other'

      if (emailObj.value) {
        attributes.push({
          attribute_type: 'email',
          text: emailObj.value || '',
          label: label,
          is_primary: i === 0 ? true : false
        })
      }
    }
  }

  if (key === 'phones') {
    for (let i = 0; i < resource.phones.length; i++) {

      const phoneObj = resource.phones[i]

      const label = PHONE_LABEL_MAPPING[phoneObj?.type?.toLowerCase()] ?? 'Other'

      if (phoneObj.value) {
        attributes.push({
          attribute_type: 'phone_number',
          text: phoneObj.value || '',
          label: label,
          is_primary: i === 0 ? true : false
        })
      }
    }
  }

  return attributes
}

/**
 * @typedef {import('../../../../contact/defs').Google.Contact} GoogleContact
 * @param {GoogleContact} resource - new (current) contact resource
 * @param {GoogleContact} oldResource - old (previous) contact resource
 * @param {IContactAttribute[]} oldAttributes - old (previous) attributes
 * @param {Record<string, string>} contactGroups
 * @returns {{ attributes: IContactAttributeInput[], deletedAtt: UUID[] }}
 */
const findNewAttributes = (resource, oldResource, oldAttributes, contactGroups) => {
  /**
   * @param {string} propChain
   * @returns {boolean}
   */
  const changed = prop => !isEqual(get(resource, prop), get(oldResource, prop))

  /**
   * @param {string} propChain
   * @returns {boolean}
   */
  const arrayChanged = prop => !haveSameMembers(get(resource, prop), get(oldResource, prop))

  /**
   * Returns true when the arguments have same value and type.
   * @param {TypedAndLabeled} e1 - 1st entry (a google phone/email object)
   * @param {TypedAndLabeled} e2 - 2nd entry (a google phone/email object)
   * @returns {boolean}
   */
  const haveSameValueAndType = (e1, e2) => e1.value === e2.value && e1.type === e2.type

  /**
   * Tries to find related phone-attribute in `refinedAtts`.
   * @param {GooglePhone} ph
   * @returns {IContactAttribute | undefined | null}
   */
  const findPhoneAttr = ph => {
    const label = PHONE_LABEL_MAPPING[ph?.type?.toLowerCase?.()] ?? 'Other'
    return refinedAtts.phone_number?.find?.(
      entry => entry.text === ph.value && entry.label === label
    )
  }

  /**
   * Tries to find related email-attribute in `refinedAtts`.
   * @param {GoogleEmail} email
   * @returns {IContactAttribute | undefined | null}
   */
  const findEmailAttr = email => {
    const label = EMAIL_LABEL_MAPPING[email?.type?.toLowerCase?.()] ?? 'Other'
    return refinedAtts.emails?.find?.(
      entry => entry.text === email.value && entry.label === label
    )
  }

  resource || (resource = {})
  oldResource || (oldResource = {})

  const refinedAtts = groupBy(oldAttributes, 'attribute_type')

  /** @type {IContactAttributeInput[]} */
  const attributes = []

  /** @type {UUID[]} */
  const deletedAtt = []

  // Singular Attributes
  if (changed('names.givenName')) {
    const firstNameAtt = refinedAtts.first_name?.[0]

    attributes.push({
      ...(firstNameAtt ? { id: firstNameAtt.id } : null),
      attribute_type: 'first_name',
      text: resource?.names?.givenName || ''
    })
  }

  if (changed('names.familyName')) {
    const lastNameAtt = refinedAtts.last_name?.[0]

    attributes.push({
      ...(lastNameAtt ? { id: lastNameAtt.id } : null),
      attribute_type: 'last_name',
      text: resource?.names?.familyName || '',
    })
  }

  if (changed('names.middleName')) {
    const middleNameAtt = refinedAtts.middle_name?.[0]

    attributes.push({
      ...(middleNameAtt ? { id: middleNameAtt.id } : null),
      attribute_type: 'middle_name',
      text: resource?.names?.middleName || ''
    })
  }

  if (changed('names.honorificPrefix')) {
    const titleAtt = refinedAtts.title?.[0]

    attributes.push({
      ...(titleAtt ? { id: titleAtt.id } : null),
      attribute_type: 'title',
      text: resource?.names?.honorificPrefix || '',
    })
  }

  if (changed('nickName')) {
    const nickNameAtt = refinedAtts.nickname?.[0]

    attributes.push({
      ...(nickNameAtt ? { id: nickNameAtt.id } : null),
      attribute_type: 'nickname',
      text: resource.nickName || ''
    })
  }

  if (changed('organization.jobTitle')) {
    const jobTitleAtt = refinedAtts.job_title?.[0]

    attributes.push({
      ...(jobTitleAtt ? { id: jobTitleAtt.id } : null),
      attribute_type: 'job_title',
      text: resource?.organization?.jobTitle || ''
    })
  }

  if (changed('organization.company')) {
    const companyAtt = refinedAtts.company?.[0]

    attributes.push({
      ...(companyAtt ? { id: companyAtt.id } : null),
      attribute_type: 'company',
      text: resource?.organization?.company || ''
    })
  }

  if (changed('website')) {
    const websiteAtt = refinedAtts.website?.[0]

    attributes.push({
      ...(websiteAtt ? { id: websiteAtt.id } : null),
      attribute_type: 'website',
      text: resource.website || ''
    })
  }

  if (changed('birthday')) {
    const birthdayAtt = refinedAtts.birthday?.[0]

    const temp     = new Date(resource.birthday)
    const tzOffset = temp.getTimezoneOffset() * 60000
    const birthday = new Date(temp.getTime() - tzOffset)

    attributes.push({
      ...(birthdayAtt ? { id: birthdayAtt.id } : null),
      attribute_type: 'birthday',
      date: resource.birthday ? (birthday.getTime() / 1000) : 0
    })
  }

  if (arrayChanged('memberships')) {
    const newTags = (resource.memberships || [])
      .map(m => m.contactGroupResourceName)
      .map(gname => gname ? contactGroups[gname] : null)
      .filter(Boolean)

    const oldTags = (oldResource.memberships || [])
      .map(m => m.contactGroupResourceName)
      .map(gname => gname ? contactGroups[gname] : null)
      .filter(Boolean)

    const deletedTags = difference(oldTags, newTags)
    const addedTags = difference(newTags, oldTags)
    
    deletedTags
      .map(dt => refinedAtts.tag?.find?.(e => e.text === dt))
      .filter(Boolean)
      .forEach(attr => deletedAtt.push(attr.id))

    addedTags.forEach(at => {
      if (!at) { return }
      
      const existing = refinedAtts.tag?.find?.(e => e.text === at)

      attributes.push({
        ...(existing ? { id: existing.id } : null),
        attribute_type: 'tag',
        text: at || '',
      })      
    })
  }


  // Non Singular Attributes
  if (changed('note')) {
    const noteAtt = refinedAtts.note?.find?.(e => e.text === resource.note)

    attributes.push({
      ...(noteAtt ? { id: noteAtt.id } : null),
      attribute_type: 'note',
      text: resource.note || ''
    })
  }

  if (arrayChanged('phones')) {
    const deletedPhones = differenceWith(
      oldResource.phones, resource.phones, haveSameValueAndType
    )

    const addedPhones = differenceWith(
      resource.phones, oldResource.phones, haveSameValueAndType
    )

    deletedPhones
      .map(findPhoneAttr)
      .filter(Boolean)
      .forEach(attr => deletedAtt.push(attr.id))

    addedPhones.forEach(ap => {
      if (!ap?.value) { return }
      
      const label = PHONE_LABEL_MAPPING[ap?.type?.toLowerCase?.()] ?? 'Other'
      const existing = findPhoneAttr(ap)

      attributes.push({
        ...(existing ? { id: existing.id } : null),
        attribute_type: 'phone_number',
        text: ap.value || '',
        label: label,
        is_primary: false,
      })
    })
  }

  if (arrayChanged('emailes')) {
    const deletedEmails = differenceWith(
      oldResource.emailes, resource.emailes, haveSameValueAndType
    )

    const addedEmails = differenceWith(
      resource.emailes, oldResource.emailes, haveSameValueAndType
    )

    deletedEmails
      .map(findEmailAttr)
      .filter(Boolean)
      .forEach(attr => deletedAtt.push(attr.id))

    addedEmails.forEach(ae => {
      if (!ae?.value) { return }
      
      const label = EMAIL_LABEL_MAPPING[ae?.type?.toLowerCase?.()] ?? 'Other'
      const existing = findEmailAttr(ae)

      attributes.push({
        ...(existing ? { id: existing.id } : null),
        attribute_type: 'email',
        text: ae.value || '',
        label: label,
        is_primary: false,
      })
    })
  }

  if (arrayChanged('addresses')) {
    const addressArr = [
      ...refinedAtts.postal_code || [],
      ...refinedAtts.street_name || [],
      ...refinedAtts.city || [],
      ...refinedAtts.country || []
    ]

    /* Let's simply delete all existing address-related records \m/ */
    deletedAtt.push(...addressArr.map(att => att.id))
    
    let maxIndex = addressArr
      .map(e => Number(e.index))
      .reduce((i, j) => Math.max(i, j), 1)

    for ( const address of resource.addresses ) {
      maxIndex ++

      const label = ADDRESS_LABEL_MAPPING[address?.type?.toLowerCase?.()] ?? 'Other'

      if (address.streetAddress) {
        attributes.push({
          attribute_type: 'street_name',
          text: address.streetAddress || '',
          label: label,
          index: maxIndex,
          is_primary: false
        })
      }
    
      if (address.city) {
        attributes.push({
          attribute_type: 'city',
          text: address.city || '',
          label: label,
          index: maxIndex,
          is_primary: false
        })
      }
    
      if (address.country) {
        attributes.push({
          attribute_type: 'country',
          text: address.country || '',
          label: label,
          index: maxIndex,
          is_primary: false
        })
      }

      if (address.state) {
        attributes.push({
          attribute_type: 'state',
          text: address.state || '',
          label: label,
          index: maxIndex,
          is_primary: false
        })
      }
    
      if (address.postalCode) {
        attributes.push({
          attribute_type: 'postal_code',
          text: address.postalCode || '',
          label: label,
          index: maxIndex,
          is_primary: false
        })
      }
    }
  }

  return { attributes, deletedAtt }
}

const generateGContacts = (credential, contacts) => {
  return contacts.map(contact => {
    const clientData = [{
      key: `rechatCredential:${credential}`,
      value: `rechatContact:${contact.id}`
    }]

    const names = [{
      givenName: contact.first_name, //`specialxx-${contact.first_name}`,
      familyName: contact.last_name,
      middleName: contact.middle_name,
      ...(contact.title ? { honorificPrefix: contact.title } : null),
    }]

    const nicknames = [{ value: contact.nickname }]

    let birthdays = []

    if (contact.birthday) {
      const birthday     = new Date(contact.birthday)
      const birthdayObj  = { year: birthday.getFullYear(), month: birthday.getMonth() + 1, day: birthday.getDate() }
      const birthdayText = `${birthdayObj.month}/${birthdayObj.day}/${birthdayObj.year}`
      
      birthdays = [{
        date: birthdayObj,
        text: birthdayText
      }]
    }

    const urls = contact.attributes.filter(a => a.attribute_type === 'website' ).map(a => {
      return {
        value: a.text
      }
    })

    let addresses = []

    if ( contact.address ) {
      addresses = contact.address.splice(0, 5).map(a => {
        return {
          type: a.extra,
          streetAddress: a.line1,
          city: a.city,
          region: a.state ? a.state.toUpperCase() : '',
          postalCode: a.postcode,
          country: a.country || 'US',
          countryCode: a.country || 'US'
        }
      })
    }

    const emailAddresses = contact.attributes.filter(a => a.attribute_type === 'email' ).map(a => {
      return {
        type: a.label,
        value: a.text
      }
    })

    const phoneNumbers = contact.attributes.filter(a => a.attribute_type === 'phone_number' ).map(a => {
      return {
        type: a.label,
        value: a.text
      }
    })

    // Cannot have more than one person.biographies per source
    let biographies = []

    const primaryBiographies = contact.attributes.filter(a => a.attribute_type === 'note' && a.is_primary ).map(a => {
      return {
        contentType: 'TEXT_HTML',
        value: a.text
      }
    })

    const ordinaryBiographies = contact.attributes.filter(a => a.attribute_type === 'note' && !a.is_primary ).map(a => {
      return {
        contentType: 'TEXT_HTML',
        value: a.text
      }
    })

    if ( primaryBiographies.length ) {
      biographies = [primaryBiographies[0]]
    } else {
      biographies = [ordinaryBiographies[0]]
    }

    const organizations = [{ name: contact.company, title: contact.job_title }]

    return {
      contact: contact.id,

      resource: {
        clientData,
        names,
        nicknames,
        birthdays,
        urls,
        addresses,
        emailAddresses,
        phoneNumbers,
        biographies,
        organizations
      }
    }
  })
}


module.exports = {
  parseAttributes,
  findNewAttributes,
  generateGContacts,
}
