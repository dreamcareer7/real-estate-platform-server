const { groupBy } = require('lodash')
const Context = require('../../../Context')
const ContactAttribute = require('../../../Contact/attribute/get')
const MicrosoftContact = require('../../contact')
const Contact          = {
  ...require('../../../Contact/fast_filter'),
  ...require('../../../Contact/manipulate'),
}

const { parseAttributes, findNewAttributes } = require('./helper')
const { extractPhoto } = require('./photo')

const targetKeys = [
  'givenName', 'surname', 'middleName', 'nickName', 'title', 'categories',
  'photo', 'parentFolderId', 'birthday', 'personalNotes',
  'jobTitle', 'companyName', 'businessHomePage',
  'mobilePhone', 'homePhones', 'businessPhones',
  'emailAddresses', 'homeAddress', 'businessAddress', 'otherAddress'
]


const syncContacts = async (microsoft, credential, lastSyncAt) => {
  const credentialId = credential.id
  const brand        = credential.brand
  const user         = credential.user
  
  const uniqueRec  = []
  const uniqueToUp = []

  const records            = []
  const toUpdateRecords    = []
  const newContacts        = []
  const toUpdateContacts   = []
  const toUpdateContactIds = []
  const contactsMap        = {}

  let deletedAttributes = []

  let createdNum = 0

  const projection = [
    'id', 'createdDateTime', 'lastModifiedDateTime', 'changeKey', 'parentFolderId',
    'displayName', 'givenName', 'middleName', 'nickName', 'surname', 'title', 'categories',
    'jobTitle', 'companyName',
    'businessHomePage', 'birthday', 'personalNotes',
    'homePhones', 'mobilePhone', 'businessPhones',
    'emailAddresses', 'homeAddress', 'businessAddress', 'otherAddress',
  ]

  try {
    const folders  = await MicrosoftContact.getCredentialFolders(credentialId)
    const contacts = await microsoft.getContactsNative(lastSyncAt, folders, projection)

    if (contacts.length) {
      
      for (const contact of contacts) {
        const file = await extractPhoto(microsoft, user, brand, contact)
        if (file) {
          contact.photo = file.url
        }
      }

      const remoteIdsArr         = contacts.map(c => c.id)
      const oldMicrosoftContacts = await MicrosoftContact.getAllBySource(remoteIdsArr, credentialId, 'contacts')
      const contactFolders       = await MicrosoftContact.getRefinedContactFolders(credentialId)
      const oldMicrosoftContactRemoteIds = oldMicrosoftContacts.map(c => c.remote_id)

      // Updated Contacts
      for (const contact of contacts) {
        if ( oldMicrosoftContactRemoteIds.includes(contact.id) ) {

          const oldMContact = await MicrosoftContact.get(contact.id, credentialId)

          // This is a temporary change to import tag/category of already synced contacts
          // if ( !oldMContact.deleted_at && (oldMContact.data.changeKey !== contact.changeKey) ) {
          if ( !oldMContact.deleted_at ) {

            const result = await Contact.fastFilter(brand, [], { microsoft_id: oldMContact.id })

            if (result.ids[0]) {
              toUpdateContactIds.push(result.ids[0])

              contactsMap[result.ids[0]] = {
                rawData: contact,
                oldRawData: oldMContact.data,
              }
            }
            
            if ( !uniqueToUp.includes(contact.id) ) {
              uniqueToUp.push(contact.id)
              toUpdateRecords.push({ microsoft_credential: credentialId, remote_id: contact.id, data: JSON.stringify(contact) })
            }
          }          

        } else {

          if ( !uniqueRec.includes(contact.id) ) {
            uniqueRec.push(contact.id)
            records.push({ microsoft_credential: credentialId, remote_id: contact.id, data: JSON.stringify(contact) })
          }
        }
      }

      Context.log('SyncMicrosoftContacts - [Debug] toUpdateContactIds', toUpdateContactIds)

      if ( toUpdateContactIds.length ) {
        const contactsAtts = await ContactAttribute.getForContacts(toUpdateContactIds)        
        const refinedAtts  = groupBy(contactsAtts, function(entry) { return entry.contact})
        // const refinedAtts = groupBy(contactsAtts.filter(att => (!att.deleted_at && att.created_for === 'microsoft_integration')), function(entry) { return entry.contact})

        Context.log('SyncMicrosoftContacts - [Debug] contactsAtts', contactsAtts)
        Context.log('SyncMicrosoftContacts - [Debug] refinedAtts', refinedAtts)

        for (const key in refinedAtts) {
          const { attributes, deletedAtt } = findNewAttributes(contactsMap[key], refinedAtts[key])

          deletedAttributes = deletedAttributes.concat(deletedAtt)

          if (attributes.length) {
            toUpdateContacts.push({ id: key, attributes })
          }
        }
      }

      // New Contacts
      const createdMicrosoftContacts = await MicrosoftContact.create(records)

      for (const createdMicrosoftContact of createdMicrosoftContacts) {
  
        /** @type {IContactInput} */
        const contact = {
          user: user,
          microsoft_id: createdMicrosoftContact.id,
          attributes: [{ attribute_type: 'source_type', text: 'Microsoft' }],
          parked: false
        }
  
        for (const key in createdMicrosoftContact.data) {
          if (targetKeys.indexOf(key) >= 0) {
            const attributes = parseAttributes(key, createdMicrosoftContact.data, contactFolders)
            contact.attributes = contact.attributes.concat(attributes)
          }
        }
  
        newContacts.push(contact)
      }

      Context.log('SyncMicrosoftContacts - [Debug]-4', credential.id, toUpdateContacts)

      // Updated Contacts
      await MicrosoftContact.create(toUpdateRecords)
      await Contact.update(toUpdateContacts, user, brand, 'microsoft_integration')

      // New Contacts
      await Contact.create(newContacts, user, brand, 'microsoft_integration', { activity: false, relax: true, get: false })

      // Delete old removed remote attributes
      // if ( deletedAttributes.length ) {
      //   await ContactAttribute.delete(deletedAttributes, user)
      // }

      createdNum = createdMicrosoftContacts.length
    }

    return {
      status: true,
      createdNum
    }

  } catch (ex) {

    Context.log(`SyncMicrosoft - syncContacts - catch ex => Email: ${credential.email}, Code: ${ex.statusCode}, Message: ${ex.message}`)

    if ( ex.statusCode === 504 || ex.statusCode === 503 || ex.statusCode === 501 || ex.message === 'Error: read ECONNRESET' ) {
      return  {
        status: false,
        skip: true,
        ex
      }
    }
      
    return  {
      status: false,
      skip: false,
      ex
    }
  }
}


module.exports = {
  syncContacts
}
