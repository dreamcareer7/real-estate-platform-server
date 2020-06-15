const Context = require('../../../Context')

const MicrosoftMailFolder = require('../../mail_folders')



const listFolders = async (microsoft) => {
  const { vBeta, vOne } = await microsoft.listFolders()

  if (vBeta.error) {
    Context.log('SyncOutlookMessages - fetchMessages - listFolders-version-beta-failed', vBeta.error.message, vBeta.error)
  }

  if (vOne.error) {
    Context.log('SyncOutlookMessages - fetchMessages - listFolders-version-one-failed', vOne.error.message, vOne.error)
  }

  return {
    vBeta: vBeta.folders,
    vOne: vOne.folders
  }
}

const syncFolders = async (microsoft, credential) => {
  const fobj = await listFolders(microsoft)

  return await MicrosoftMailFolder.upsertFolders(credential.id, fobj)
}


module.exports = {
  syncFolders
}