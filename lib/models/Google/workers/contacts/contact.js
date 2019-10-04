const _  = require('lodash')
const qs = require('querystring')

const User             = require('../../../User')
const AttachedFile     = require('../../../AttachedFile')
const GoogleCredential = require('../../credential')
const GoogleContact    = require('../../contact')
const Contact          = require('../../../Contact/index')
const ContactAttribute = require('../../../Contact/attribute')


const targetKeys = ['names', 'note', 'photo', 'website', 'birthday', 'organization', 'groupMembership', 'addresses', 'emailes', 'phones']


const parseAttributes = (key, entry, contactGroups) => {
  /** @type {IContactAttributeInput[]} */
  const attributes = []

  if ( key === 'names' ) {
    if (entry.names.givenName) {
      attributes.push({
        attribute_type: 'first_name',
        text: entry.names.givenName
      })
    }

    if (entry.names.familyName) {
      attributes.push({
        attribute_type: 'last_name',
        text: entry.names.familyName
      })
    }

    if (entry.names.additionalName) {
      attributes.push({
        attribute_type: 'middle_name',
        text: entry.names.additionalName
      })
    }

    if (entry.names.nickName) {
      attributes.push({
        attribute_type: 'nickname',
        text: entry.names.nickName
      })
    }
  }

  if (key === 'photo') {
    if (entry.photo) {
      attributes.push({ attribute_type: 'profile_image_url', text: entry.photo })
      attributes.push({ attribute_type: 'cover_image_url', text: entry.photo })
    }
  }

  if (key === 'website') {
    if (entry.website)
      attributes.push({ attribute_type: 'website', text: entry.website })
  }

  if (key === 'birthday') {
    if (entry.birthday) {
      const arr = entry.birthday.split('-') // sample: 1980-10-07

      if ( arr.length === 3 ) {
        const birthday = new Date(arr[0], arr[1] - 1, arr[2], 0, 0, 0)

        attributes.push({
          attribute_type: 'birthday',
          date: birthday.getTime() / 1000
        })
      }
    }
  }

  if (key === 'note') {
    if (entry.note)
      attributes.push({ attribute_type: 'note', text: entry.note })
  }

  if (key === 'organization') {
    if (entry.organization.company)
      attributes.push({ attribute_type: 'company', text: entry.organization.company })

    if (entry.organization.jobTitle)
      attributes.push({ attribute_type: 'job_title', text: entry.organization.jobTitle })
  }

  if (key === 'groupMembership') {
    if ( contactGroups && entry.groupMembership ) {
      if (contactGroups[entry.groupMembership])
        attributes.push({ attribute_type: 'tag', text: contactGroups[entry.groupMembership] })
    }
  }

  if (key === 'addresses') {
    for (let i = 0; i < entry.addresses.length; i++) {

      const addressObj = entry.addresses[i]

      let label = 'Other'

      if ( addressObj.label.toLowerCase() === 'home' )
        label = 'Home'

      if ( addressObj.label.toLowerCase() === 'work' )
        label = 'Work'

      if ( addressObj.label.toLowerCase() === 'investment property' )
        label = 'Investment Property'
        

      if (addressObj.city) {
        attributes.push({
          attribute_type: 'city',
          text: addressObj.city,
          label: label,
          index: i + 1,
          is_primary: i === 0 ? true : false
        })
      }

      if (addressObj.country) {
        attributes.push({
          attribute_type: 'country',
          text: addressObj.country,
          label: label,
          index: i + 1,
          is_primary: i === 0 ? true : false
        })
      }

      if (addressObj.postalCode) {
        attributes.push({
          attribute_type: 'postal_code',
          text: addressObj.postalCode,
          label: label,
          index: i + 1,
          is_primary: i === 0 ? true : false
        })
      }

      if (addressObj.streetAddress) {
        attributes.push({
          attribute_type: 'street_name',
          text: addressObj.streetAddress,
          label: label,
          index: i + 1,
          is_primary: i === 0 ? true : false
        })
      }
    }
  }

  if (key === 'emailes') {
    for (let i = 0; i < entry.emailes.length; i++) {

      const emailObj = entry.emailes[i]

      let label = 'Other'

      if ( emailObj.label.toLowerCase() === 'personal' )
        label = 'Personal'

      if ( emailObj.label.toLowerCase() === 'work' )
        label = 'Work'

      if (emailObj.address) {
        attributes.push({
          attribute_type: 'email',
          text: emailObj.address,
          label: label,
          is_primary: i === 0 ? true : false
        })
      }
    }
  }

  if (key === 'phones') {
    for (let i = 0; i < entry.phones.length; i++) {

      const phoneObj = entry.phones[i]

      let label = 'Other'

      if ( phoneObj.label.toLowerCase() === 'home' )
        label = 'Home'

      if ( phoneObj.label.toLowerCase() === 'mobile' )
        label = 'Mobile'

      if ( phoneObj.label.toLowerCase() === 'work' )
        label = 'Work'

      if ( phoneObj.label.toLowerCase() === 'fax' )
        label = 'Fax'

      if ( phoneObj.label.toLowerCase() === 'whatsApp' )
        label = 'WhatsApp'

      if (phoneObj.phoneNumber) {
        attributes.push({
          attribute_type: 'phone_number',
          text: phoneObj.phoneNumber,
          label: label,
          is_primary: i === 0 ? true : false
        })
      }
    }
  }

  return attributes
}

const parseFeed = (entries) => {
  const connections = []

  for ( const entry of entries ) {
    const url = _.get(entry, 'id.$t', '')

    const conn = {
      entry_id: null,
      photo: '',
      note: null,
      birthday: null,
      website: null,
      groupMembership: null,
      organization: {},
      names: {},
      addresses: [],
      emailes: [],
      phones: []
    }

    conn.entry_id = url.substring(_.lastIndexOf(url, '/') + 1)
    conn.note     = _.get(entry, 'content.$t')
    conn.website  = _.get(entry, 'gContact$website.0.href')
    conn.birthday = _.get(entry, 'gContact$birthday.when')

    conn.organization['jobTitle'] = _.get(entry, 'gd$organization.0.gd$orgTitle.$t')
    conn.organization['company']  = _.get(entry, 'gd$organization.0.gd$orgName.$t')

    conn.names = {
      name: _.get(entry, 'title.$t'), // title
      givenName: _.get(entry, 'gd$name.gd$givenName.$t'),
      familyName: _.get(entry, 'gd$name.gd$familyName.$t'),
      additionalName: _.get(entry, 'gd$name.gd$additionalName.$t'), // middlename
      fullName: _.get(entry, 'gd$name.gd$fullName.$t'), // displayName
      nickName: _.get(entry, 'gContact$nickname.$t')
    }

    const addressesObj = _.get(entry, 'gd$structuredPostalAddress')
    const emailesObj   = _.get(entry, 'gd$email')
    const phonesObj    = _.get(entry, 'gd$phoneNumber')
    const links        = _.get(entry, 'link')
    const memberships  = _.get(entry, 'gContact$groupMembershipInfo')


    if (addressesObj) {
      if ( addressesObj.length > 0 ) {
        for (let i = 0; i < addressesObj.length; i ++) {
  
          let label = addressesObj[i]['label']
  
          if (!label) {
            const labelString = addressesObj[i]['rel']
            const arr = labelString.split('#')
            if (arr[1])
              label = arr[1]
          }
  
          const addresseObj = {
            label: label
          }
  
          if ( addressesObj[i]['gd$formattedAddress'] )
            addresseObj['formatted'] = addressesObj[i]['gd$formattedAddress']['$t']
  
          if ( addressesObj[i]['gd$street'] )
            addresseObj['streetAddress'] = addressesObj[i]['gd$street']['$t']
  
          if ( addressesObj[i]['gd$neighborhood'] )
            addresseObj['extendedAddress'] = addressesObj[i]['gd$neighborhood']['$t']
  
          if ( addressesObj[i]['gd$city'] )
            addresseObj['city'] = addressesObj[i]['gd$city']['$t']
  
          if ( addressesObj[i]['gd$postcode'] )
            addresseObj['postalCode'] = addressesObj[i]['gd$postcode']['$t']
  
          if ( addressesObj[i]['gd$country'] )
            addresseObj['country'] = addressesObj[i]['gd$country']['$t']
  
          conn.addresses.push(addresseObj)
        }
      }
    }

    if (emailesObj) {
      if ( emailesObj.length > 0 ) {
        for (let i = 0; i < emailesObj.length; i ++) {

          let label = emailesObj[i]['label']

          if (!label) {
            const labelString = emailesObj[i]['rel']
            const arr = labelString.split('#')
            if (arr[1])
              label = arr[1]
          }

          const emailObj = {
            label: label,
            address: emailesObj[i]['address']
          }

          conn.emailes.push(emailObj)
        }
      }
    }

    if (phonesObj) {
      if ( phonesObj.length > 0 ) {
        for (let i = 0; i < phonesObj.length; i ++) {

          let label = phonesObj[i]['label']

          if (!label) {
            const labelString = phonesObj[i]['rel']
            const arr = labelString.split('#')
            if (arr[1])
              label = arr[1]
          }

          const phoneObj = {
            label: label,
            phoneNumber: phonesObj[i]['$t']
          }

          conn.phones.push(phoneObj)
        }
      }
    }

    if (links) {
      if ( links.length > 0 ) {
        for (let i = 0; i < links.length; i ++) {

          if ( links[i]['type'] === 'image/*' && links[i]['gd$etag'] )
            conn.photo = `https://www.google.com/m8/feeds/photos/media/default/${conn.entry_id}`
        }
      }
    }

    if (memberships) {
      if ( memberships.length > 0 ) {
        for (let i = 0; i < memberships.length; i ++) {

          if ( memberships[i]['deleted'] === 'false' || memberships[i]['deleted'] === false )
            conn.groupMembership = memberships[i]['href']
        }
      }
    }

    if (conn.entry_id)
      connections.push(conn)
  }

  return connections
}

const findNewAttributes = async (contact, oldAttributes) => {
  const rawData     = contact.rawData
  const oldRawData  = contact.oldRawData
  const refinedAtts = _.groupBy(oldAttributes, function(entry) { return entry.attribute_type})

  /** @type {IContactAttributeInput[]} */
  const attributes = []


  // Singular Attributes
  if ( rawData.names.givenName !== oldRawData.names.givenName ) {
    const firstNameAtt = refinedAtts.first_name ? (refinedAtts.first_name.length ? refinedAtts.first_name[0].text : null) : null

    if (rawData.names.givenName && !firstNameAtt)
      attributes.push({ attribute_type: 'first_name', text: rawData.names.givenName })
  }

  if ( rawData.names.familyName !== oldRawData.names.familyName ) {
    const lastNameAtt = refinedAtts.last_name ? (refinedAtts.last_name.length ? refinedAtts.last_name[0].text : null) : null

    if (rawData.names.familyName && !lastNameAtt)
      attributes.push({ attribute_type: 'last_name', text: rawData.names.familyName })
  }

  if ( rawData.names.additionalName !== oldRawData.names.additionalName ) {
    const additionalNameAtt = refinedAtts.middle_name ? (refinedAtts.middle_name.length ? refinedAtts.middle_name[0].text : null) : null

    if (rawData.names.additionalName && !additionalNameAtt)
      attributes.push({ attribute_type: 'middle_name', text: rawData.names.additionalName })
  }

  if ( rawData.names.nickName !== oldRawData.names.nickName ) {
    const nickNameAtt = refinedAtts.nickname ? (refinedAtts.nickname.length ? refinedAtts.nickname[0].text : null) : null

    if (rawData.names.nickName && !nickNameAtt)
      attributes.push({ attribute_type: 'nickname', text: rawData.names.nickName })
  }


  if ( rawData.organization.jobTitle !== oldRawData.organization.jobTitle ) {
    const jobTitleAtt = refinedAtts.job_title ? (refinedAtts.job_title.length ? refinedAtts.job_title[0].text : null) : null

    if (rawData.organization.jobTitle && !jobTitleAtt)
      attributes.push({ attribute_type: 'job_title', text: rawData.organization.jobTitle })
  }

  if ( rawData.organization.company !== oldRawData.organization.company ) {
    const companyAtt = refinedAtts.company ? (refinedAtts.company.length ? refinedAtts.company[0].text : null) : null

    if (rawData.organization.company && !companyAtt)
      attributes.push({ attribute_type: 'company', text: rawData.organization.company })
  }


  if ( rawData.birthday !== oldRawData.birthday ) {
    const birthdayAtt = refinedAtts.birthday ? (refinedAtts.birthday.length ? refinedAtts.birthday[0].date : null) : null

    if (rawData.birthday && !birthdayAtt) {
      const birthday = new Date(rawData.birthday)
      attributes.push({ attribute_type: 'birthday', date: birthday.getTime() / 1000 })
    }
  }

  if ( rawData.website !== oldRawData.website ) {
    const websiteeAtt = refinedAtts.website ? (refinedAtts.website.length ? refinedAtts.website[0].text : null) : null

    if (rawData.website && !websiteeAtt)
      attributes.push({ attribute_type: 'website', text: rawData.website })
  }



  // None Singulr Attributes
  if ( rawData.note !== oldRawData.note ) {
    if (rawData.note)
      attributes.push({ attribute_type: 'note', text: rawData.note })
  }


  const oldPhoneNumbers = refinedAtts.phone_number ? (refinedAtts.phone_number.map(entry => entry.text)) : []

  for ( const phone of rawData.phones ) {
    if ( !oldPhoneNumbers.includes(phone.phoneNumber) ) {

      let label = 'Other'

      if ( phone.label.toLowerCase() === 'home' )
        label = 'Home'

      if ( phone.label.toLowerCase() === 'mobile' )
        label = 'Mobile'

      if ( phone.label.toLowerCase() === 'work' )
        label = 'Work'

      if ( phone.label.toLowerCase() === 'fax' )
        label = 'Fax'

      if ( phone.label.toLowerCase() === 'whatsApp' )
        label = 'WhatsApp'

      attributes.push({
        attribute_type: 'phone_number',
        text: phone.phoneNumber,
        label: label,
        is_primary: false
      })
    }
  }


  const oldEmails = refinedAtts.email ? (refinedAtts.email.map(entry => entry.text)) : []

  for ( const email of rawData.emailes ) {
    if ( !oldEmails.includes(email.address) ) {

      let label = 'Other'

      if ( email.label.toLowerCase() === 'personal' )
        label = 'Personal'

      if ( email.label.toLowerCase() === 'work' )
        label = 'Work'

      attributes.push({
        attribute_type: 'email',
        text: email.address,
        label: label,
        is_primary: false
      })
    }
  }


  if ( rawData.addresses.length ) {

    let maxIndex     = 1
    const addressArr = [...refinedAtts.postal_code || [], ...refinedAtts.street_name || [], ...refinedAtts.city || [], ...refinedAtts.country || []]
  
    for ( const entry of addressArr ) {
      if ( Number(entry.index) > maxIndex )
        maxIndex = Number(entry.index)
    }
  
    let addressesArr = []
  
    if ( oldRawData.addresses.length === 0 ) {
      addressesArr = rawData.addresses

    } else {

      for ( const address of rawData.addresses ) {
        let flag = true

        for ( const oldAddress of oldRawData.addresses ) {
          if ( _.isEqual(address, oldAddress) )
            flag = false
        }

        if (flag)
          addressesArr.push(address)
      }
    }

    for ( const address of addressesArr ) {
      maxIndex ++

      let label = 'Other'

      if ( address.label.toLowerCase() === 'home' )
        label = 'Home'

      if ( address.label.toLowerCase() === 'work' )
        label = 'Work'

      if ( address.label.toLowerCase() === 'investment property' )
        label = 'Investment Property'

      if (address.streetAddress) {
        attributes.push({
          attribute_type: 'street_name',
          text: address.streetAddress,
          label: label,
          index: maxIndex,
          is_primary: false
        })
      }
    
      if (address.city) {
        attributes.push({
          attribute_type: 'city',
          text: address.city,
          label: label,
          index: maxIndex,
          is_primary: false
        })
      }
    
      if (address.country) {
        attributes.push({
          attribute_type: 'country',
          text: address.country,
          label: label,
          index: maxIndex,
          is_primary: false
        })
      }
    
      if (address.postalCode) {
        attributes.push({
          attribute_type: 'postal_code',
          text: address.postalCode,
          label: label,
          index: maxIndex,
          is_primary: false
        })
      }
    }
  }


  return attributes
}

const extractPhoto = async (google, userId, brand, conn) => {
  try {
    const imageData = await google.getContactPhoto(conn.photo)

    if (!imageData)
      return null

    const user = await User.get(userId)

    const file = await AttachedFile.saveFromBuffer({
      buffer: Buffer.from(imageData, 'binary'),
      filename: `google_cover_${conn.entry_id}.jpg`,
      relations: [],
      path: `${brand}/avatars`,
      user: user,
      public: true
    })

    return file

  } catch (ex) {
    return null
  }
}

const buildGoogleApiPath = (lastSyncAt) => {
  lastSyncAt = new Date(lastSyncAt)
  lastSyncAt.setHours(lastSyncAt.getHours() - 1)

  const query = {
    'v': '3.0',
    'alt': 'json',
    'showdeleted': false,
    'max-results': 1000,
    'updated-min': new Date(lastSyncAt).toISOString()
  }

  const path = `/m8/feeds/contacts/default/full?${qs.stringify(query)}`

  return path
}

const syncContacts = async (google, data) => {
  const credentialId = data.googleCredential.id
  const lastSyncAt   = data.googleCredential.contacts_last_sync_at
  const brand        = data.googleCredential.brand
  const user         = data.googleCredential.user
  
  const records            = []
  const toUpdateRecords    = []
  const newContacts        = []
  const toUpdateContacts   = []
  const toUpdateContactIds = []
  const contactsMap        = {}

  let createdNum = 0

  try {

    const path = buildGoogleApiPath(lastSyncAt)

    const entries = await google.getContacts(path)

    if (entries.length) {

      const contacts = await parseFeed(entries)

      for (const contact of contacts) {
        if (!contact.photo)
          continue
  
        const file = await extractPhoto(google, user, brand, contact)

        if (file)
          contact.photo = file.url
      }
  
      const entryIdsArr              = contacts.map(c => c.entry_id)
      const oldGoogleContacts        = await GoogleContact.getAll(entryIdsArr, credentialId)
      const contactGroups            = await GoogleContact.getRefinedContactGroups(credentialId)
      const oldGoogleContactEntryIds = oldGoogleContacts.map(c => c.entry_id)

      for (const contact of contacts) {
        if ( oldGoogleContactEntryIds.includes(contact.entry_id) ) {

          const oldGContact = await GoogleContact.get(contact.entry_id, credentialId)
          
          if ( !oldGContact.deleted_at ) {

            const result = await Contact.fastFilter(brand, [], { google_id: oldGContact.id })

            if (result.ids[0]) {
              toUpdateContactIds.push(result.ids[0])

              contactsMap[result.ids[0]] = {
                rawData: contact,
                oldRawData: oldGContact.entry,
              }
            }

            toUpdateRecords.push({ google_credential: credentialId, entry_id: contact.entry_id, entry: JSON.stringify(contact) })
          }    

        } else {

          records.push({ google_credential: credentialId, entry_id: contact.entry_id, entry: JSON.stringify(contact) })
        }
      }

      if ( toUpdateContactIds.length ) {
        const contactsAtts = await ContactAttribute.getForContacts(toUpdateContactIds)
        const refinedAtts  = _.groupBy(contactsAtts, function(entry) { return entry.contact})
  
        for (const key in refinedAtts) {
          const newAttributes = await findNewAttributes(contactsMap[key], refinedAtts[key])

          if (newAttributes.length)
            toUpdateContacts.push({ id: key, attributes: newAttributes })
        }
      }

      // New Contacts
      const createdGoogleContacts = await GoogleContact.create(records)
  
      for (const createdGoogleContact of createdGoogleContacts) {
  
        /** @type {IContactInput} */
        const contact = {
          user: user,
          google_id: createdGoogleContact.id,
          attributes: [{ attribute_type: 'source_type', text: 'Google' }]
        }
  
        for (const key in createdGoogleContact.entry) {
          if (targetKeys.indexOf(key) >= 0) {
            const attributes = parseAttributes(key, createdGoogleContact.entry, contactGroups)
            contact.attributes = contact.attributes.concat(attributes)
          }
        }
  
        if ( contact.attributes.length > 0 )
          newContacts.push(contact)
      }
  

      // Updated Contacts
      await GoogleContact.create(toUpdateRecords)
      await Contact.update(toUpdateContacts, user, brand, 'google_integration')


      // console.log('contacts.length', contacts.length)
      // console.log('entryIdsArr.length', entryIdsArr.length)
      // console.log('oldGoogleContacts.length', oldGoogleContacts.length)
      // console.log('oldGoogleContactEntryIds.length', oldGoogleContactEntryIds.length)
      // console.log('records.length', records.length)

      // console.log('createdGoogleContacts.length', createdGoogleContacts.length)
      // console.log('newContacts.length', newContacts.length)

      // console.log('updatedMicrosoftContacts.length', updatedMicrosoftContacts.length)
      // console.log('updatedContacts.length', updatedContacts.length)

      if (newContacts.length)
        await Contact.create(newContacts, user, brand, 'google_integration', { activity: false, relax: true, get: false })

      createdNum = createdGoogleContacts.length
    }

    const totalContactsNum = await GoogleContact.getGCredentialContactsNum(credentialId)

    await GoogleCredential.updateContactsLastSyncAt(credentialId)

    return {
      status: true,
      ex: null,
      createdNum: createdNum,
      totalNum: totalContactsNum[0]['count']
    }

  } catch (ex) {

    return  {
      status: false,
      ex: ex,
      createdNum: 0,
      totalNum: 0
    }
  }
}


module.exports = {
  syncContacts
}