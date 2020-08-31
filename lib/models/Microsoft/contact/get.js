const db = require('../../../utils/db.js')


/**
 * @param {UUID[]} remote_ids
 * @param {UUID} microsoft_credential
 */
const getAll = async (remote_ids, microsoft_credential) => {
  return await db.select('microsoft/contact/get', [remote_ids, microsoft_credential])
}


/**
 * @param {UUID} remote_id
 * @param {UUID} microsoft_credential
 */
const get = async (remote_id, microsoft_credential) => {
  const contacts = await getAll([remote_id], microsoft_credential)

  if (contacts.length < 1)
    return null

  return contacts[0]
}

const getAllBySource = async (remote_ids, microsoft_credential, source) => {
  return await db.select('microsoft/contact/get_by_source', [remote_ids, microsoft_credential, source])
}

/**
 * @param {UUID} credentialId
 * @param {String[]} sourceArr
 */
const getMCredentialContactsAddress = async (credentialId, sourceArr) => {
  const contacts = await db.select('microsoft/contact/get_by_credential', [credentialId])
  const emails   = new Set()

  if (!sourceArr)
    sourceArr = ['contacts', 'sentBox']

  if ( contacts.length > 0 ) {
    for (const contact of contacts) {
      for (const address of contact.data.emailAddresses) {

        if ( sourceArr.includes(contact.source) )
          emails.add(address.address)
      }
    }
  }
  
  return emails
}

/**
 * @param {UUID} microsoft_credential
 * @param {String[]} sourceArr
 */
const getMCredentialContactsNum = async (microsoft_credential, sourceArr) => {
  return await db.select('microsoft/contact/count', [microsoft_credential, sourceArr])
}

/**
 * @param {UUID} credentialId
 */
const getCredentialFolders = async (credentialId) => {
  const contactFolders = await db.select('microsoft/contact_folder/get_by_credential', [credentialId])

  const folderIds = []

  for ( const contactFolder of contactFolders )
    folderIds.push(contactFolder.folder_id)

  return folderIds
}

/**
 * @param {UUID} credentialId
 */
const getRefinedContactFolders = async (credentialId) => {
  const contactFolders = await db.select('microsoft/contact_folder/get_by_credential', [credentialId])

  if ( contactFolders.length > 0 ) {

    const refined = {}

    contactFolders.map(cf => {
      refined[cf.folder_id] = cf.display_name
    })

    return refined
  }

  return null
}


module.exports = {
  getAll,
  get,
  getAllBySource,
  getMCredentialContactsAddress,
  getMCredentialContactsNum,
  getCredentialFolders,
  getRefinedContactFolders
}