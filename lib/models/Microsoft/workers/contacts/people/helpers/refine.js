const isValidDate = (date) => {
  return date instanceof Date && !isNaN(date)
}

const contacts = {
  getEntryId: (metadata) => {
    if ( metadata?.objectType !== 'PERSON' ) {
      return null
    }
  
    const result = metadata.sources.filter(source => (source.type === 'CONTACT')).map(source => source.id)
    return result[0]
  },

  getNames: (names) => {
    const result = names.filter(record => (record?.metadata?.primary && record?.metadata?.source?.type === 'CONTACT')).map(record => {
      return {
        displayName: record.displayName,
        fullName: record.displayName,
        familyName: record.familyName,
        givenName: record.givenName,
        middleName: record.middleName
      }
    })
  
    return result[0]
  },

  getNickname: (nicknames) => {
    const result = nicknames.filter(record => (record?.metadata?.primary && record?.metadata?.source?.type === 'CONTACT')).map(record => record.value)
    return result[0]
  },

  getPhoto: (photos) => {
    const result = photos.filter(record => (record?.metadata?.primary && !record.default)).map(record => record.url)
    return result[0]
  },

  getBirthday: (birthdays) => {
    const textArr = birthdays.filter(record => (record?.metadata?.primary && record?.metadata?.source?.type === 'CONTACT')).map(record => record.text)

    if ( isValidDate(new Date(textArr[0])) ) {
      return textArr[0]
    }

    const dateArr = birthdays.filter(record => (record?.metadata?.primary && record?.metadata?.source?.type === 'CONTACT')).map(record => record.date)
    
    if ( !dateArr[0]?.month || !dateArr[0]?.day || !dateArr[0]?.year ) {
      return null
    }
    
    const temp = `${dateArr[0].month}/${dateArr[0].day}/${dateArr[0].year}`

    if ( isValidDate(new Date(temp)) ) {
      return temp
    }

    return null
  },

  getWebsite: (urls) => {
    const result = urls.filter(record => (record?.metadata?.primary && record?.metadata?.source?.type === 'CONTACT')).map(record => record.value)
    return result[0]
  },

  getOrganization: (organizations) => {
    const result = organizations.filter(record => (record?.metadata?.primary && record?.metadata?.source?.type === 'CONTACT')).map(record => {
      return {
        jobTitle: record.title,
        company: record.name
      }
    })
  
    return result[0]
  },

  getNote: (biographies) => {
    const result = biographies.filter(record => (record?.metadata?.primary && record?.metadata?.source?.type === 'CONTACT')).map(record => record.value)
    return result[0]
  },

  getPhones: (phoneNumbers) => {
    const result = phoneNumbers.filter(record => record?.metadata?.source?.type === 'CONTACT').map(record => {
      return {
        value: record.value,
        type: record.type
      }
    })
  
    return result
  },

  getEmails: (emailAddresses) => {
    const result = emailAddresses.filter(record => record?.metadata?.source?.type === 'CONTACT').map(record => {
      return {
        value: record.value,
        type: record.type
      }
    })
  
    return result
  },

  getAddresses: (addresses) => {
    const result = addresses.filter(record => record?.metadata?.source?.type === 'CONTACT').map(record => {
      return {
        streetAddress: record.streetAddress,
        extendedAddress: record.extendedAddress,
        city: record.city,
        postalCode: record.postalCode,
        country: record.country,
        countryCode: record.countryCode,
        state: record.region,
        type: record.type
      }
    })
  
    return result
  },

  getMemberships: (memberships) => {
    const result = memberships.filter(record => record?.metadata?.source?.type === 'CONTACT').map(record => {
      return record.contactGroupMembership
    })
  
    return result
  }
}

const otherContacts = {
  getEntryId: (metadata) => {
    if ( metadata?.objectType !== 'PERSON' ) {
      return null
    }
  
    const result = metadata.sources.filter(source => (source.type === 'OTHER_CONTACT')).map(source => source.id)
    return result[0]
  },

  getNames: (names) => {
    const result = names.filter(record => (record?.metadata?.primary && record?.metadata?.source?.type === 'OTHER_CONTACT')).map(record => {
      return {
        displayName: record.displayName,
        fullName: record.displayName,
        familyName: record.familyName,
        givenName: record.givenName,
        middleName: null
      }
    })
  
    return result[0]
  },

  getPhones: (phoneNumbers) => {
    const result = phoneNumbers.filter(record => record?.metadata?.source?.type === 'OTHER_CONTACT').map(record => {
      return {
        value: record.value,
        type: record.type
      }
    })
  
    return result
  },

  getEmails: (emailAddresses) => {
    const result = emailAddresses.filter(record => record?.metadata?.source?.type === 'OTHER_CONTACT').map(record => {
      return {
        value: record.value,
        type: record.type
      }
    })
  
    return result
  }
}


const refineConnections = (connections) => {
  const deleted = connections
    .filter(c => !c.error)
    .filter(con => ((con?.metadata?.objectType === 'PERSON') && con.metadata.deleted))
    .map(con => {

      // old id of google contacts apis v3 
      const entry_id     = con.metadata ? contacts.getEntryId(con.metadata) : null
      const resource_id  = con.resourceName.split('people/').pop()

      return {
        etag: con.etag,
        parked: false,
        resource_id,
        entry_id
      }
    })
    .filter(con => con.resource_id && con.entry_id)

  const confirmed = connections
    .filter(c => !c.error)
    .filter(con => ((con?.metadata?.objectType === 'PERSON') && !con.metadata.deleted))
    .map(con => {

      // old id of google contacts apis v3 
      const entry_id     = con.metadata ? contacts.getEntryId(con.metadata) : null
      const resource_id  = con.resourceName.split('people/').pop()
      const names        = con.names ? contacts.getNames(con.names) : []
      const nickName     = con.nicknames ? contacts.getNickname(con.nicknames) : null
      const photo        = con.photos ? contacts.getPhoto(con.photos) : null
      const birthday     = con.birthdays ? contacts.getBirthday(con.birthdays) : null
      const website      = con.urls ? contacts.getWebsite(con.urls) : null
      const organization = con.organizations ? contacts.getOrganization(con.organizations) : null
      const note         = con.biographies ? contacts.getNote(con.biographies) : null
      const phones       = con.phoneNumbers ? contacts.getPhones(con.phoneNumbers) : []
      const emailes      = con.emailAddresses ? contacts.getEmails(con.emailAddresses) : []
      const addresses    = con.addresses ? contacts.getAddresses(con.addresses) : []
      const memberships  = con.memberships ? contacts.getMemberships(con.memberships) : []
      const clientData   = con.clientData ? con.clientData : []

      return {
        etag: con.etag,
        parked: false,
        resource_id,
        entry_id,
        names,
        nickName,
        photo,
        birthday,
        website,
        organization,
        note,
        phones,
        emailes,
        addresses,
        memberships,
        clientData
      }
    })
    .filter(con => con.resource_id && con.entry_id)

  return {
    confirmed,
    deleted
  }
}

const refineOtherContacts = (connections) => {
  const deleted = connections
    .filter(c => !c.error)
    .filter(con => ((con?.metadata?.objectType === 'PERSON') && con.metadata.deleted))
    .map(con => {

      // old id of google contacts apis v3 
      const entry_id     = con.metadata ? otherContacts.getEntryId(con.metadata) : null
      const resource_id  = con.resourceName.split('otherContacts/').pop()

      return {
        etag: con.etag,
        parked: true,
        resource_id,
        entry_id
      }
    })
    .filter(con => con.resource_id && con.entry_id)

  const confirmed = connections
    .filter(c => !c.error)
    .filter(con => ((con?.metadata?.objectType === 'PERSON') && !con.metadata.deleted))
    .map(con => {

      // old id of google contacts apis v3 
      const entry_id     = con.metadata ? otherContacts.getEntryId(con.metadata) : null
      const resource_id  = con.resourceName.split('otherContacts/').pop()
      const names        = con.names ? otherContacts.getNames(con.names) : []
      const phones       = con.phoneNumbers ? otherContacts.getPhones(con.phoneNumbers) : []
      const emailes      = con.emailAddresses ? otherContacts.getEmails(con.emailAddresses) : []

      return {
        etag: con.etag,
        parked: true,
        resource_id,
        entry_id,
        names,
        phones,
        emailes,

        nickName: null,
        photo: null,
        birthday: null,
        website: null,
        organization: null,
        note: null,
        addresses: [],
        memberships: []
      }
    })
    .filter(con => con.resource_id && con.entry_id)

  return {
    confirmed,
    deleted
  }
}


module.exports = {
  refineConnections,
  refineOtherContacts
}