const getClient = require('../client')
const { updateMessagesSyncHistoryId } = require('../credential/update')


/**
 * @param {UUID} gcid
 */
const watchMailBox = async (gcid) => {
  const google = await getClient(gcid, 'gmail')
  return await google.watchMailBox()
}

/**
 * @param {UUID} gcid
 */
const stopWatchMailBox = async (gcid) => {
  const google = await getClient(gcid, 'gmail')

  await google.stopWatchMailBox()
  await updateMessagesSyncHistoryId(gcid, null, null)

  return true
}


module.exports = {
  watchMailBox,
  stopWatchMailBox
}