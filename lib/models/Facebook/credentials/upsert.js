const db = require('../../../utils/db')
const { encrypt } = require('../../../utils/kms')

const upsert = async ({
  user,
  brand,
  facebook_id,
  facebook_email,
  first_name,
  last_name,
  access_token,
  scope,
}) => {  
  const encryptedToken = await encrypt(access_token)
  
  const facebookCredentialId = await db.insert('facebook/facebook_credentials/insert', [
    user,
    brand,
    facebook_id,
    decodeURI(facebook_email), // I've used decodeURI because I got something\u0040gmail.com
    first_name,
    last_name,
    encryptedToken,
    scope,
  ])

  return facebookCredentialId
}

module.exports = upsert