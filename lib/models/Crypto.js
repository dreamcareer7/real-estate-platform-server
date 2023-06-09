/**
 * @namespace Crypto
 */

const config = require('../config.js')
const crypto = require('crypto')
const b64 = require('base64url').default

const algorithm = 'aes-256-ctr'
const key = crypto.createHash('sha256').update(config.crypto.key, 'ascii').digest()
const iv = config.crypto.iv

const Crypto = {}

/**
 * Encrypts a plain data based on key and iv parameters using **AES-256-CTR**
 * @param {string} data - data buffer to be encrypted
 * @returns {string} encrypted data
 */
Crypto.encrypt = function (data) {
  const cipher = crypto.createCipheriv(algorithm, key, iv)
  let crypted = cipher.update(data, 'utf8', 'base64')
  crypted += cipher.final('base64')
  return crypted
}

Crypto.encryptObject = function (obj) {
  const raw = JSON.stringify(obj)
  return b64.encode(Crypto.encrypt(raw))
}

/**
 * Decrypts an encrypted data based on key and iv parameters using **AES-256-CTR**
 * @param {string} data - encrypted data buffer to be decrypted
 * @returns {string} decrypted data
 */
Crypto.decrypt = function (data) {
  const decipher = crypto.createDecipheriv(algorithm, key, iv)
  let dec = decipher.update(data, 'base64', 'utf8')
  dec += decipher.final('utf8')
  return dec
}

Crypto.decryptJSON = function (data) {
  const str = Crypto.decrypt(b64.decode(data))
  return JSON.parse(str)
}

Crypto.sign = data => {
  const sign = crypto.createSign(config.crypto.sign.alghoritm)
  sign.update(data)
  return sign.sign(config.crypto.sign.private)
}

Crypto.verify = (data, signature) => {
  const verify = crypto.createVerify(config.crypto.sign.alghoritm)

  verify.write(data)
  verify.end()

  return verify.verify(config.crypto.sign.public, signature)
}

module.exports = Crypto
