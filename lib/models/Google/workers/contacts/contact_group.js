const GoogleContact = require('../../contact')



const syncContactGroups = async (google, data) => {
  try {
    const entries = await google.getContactGroups()

    if (!entries.length)
      return { status: true }

    const contactGroups = []

    for (const entry of entries) {
      contactGroups.push({
        entry_id: entry['id']['$t'],
        entry: entry
      })
    }
  
    for (const contactGroup of contactGroups) {
      await GoogleContact.addContactGroup(data.googleCredential, contactGroup)
    }

    return  {
      status: true,
      ex: null
    }

  } catch (ex) {

    return  {
      status: false,
      ex: ex
    }
  }
}

module.exports = {
  syncContactGroups
}