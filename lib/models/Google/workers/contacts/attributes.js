const _ = require('lodash')


const findNewAttributes = (contact, oldAttributes) => {
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


module.exports = {
  findNewAttributes
}