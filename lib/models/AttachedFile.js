const Busboy = require('busboy')

const uuid = require('node-uuid')
const AWS = require('aws-sdk')
const s3 = new AWS.S3()
const s3s = require('s3-upload-stream')(s3)
const async = require('async')
const Mime = require('mime')
const cf = require('aws-cloudfront-sign')
const db = require('../utils/db')
const config = require('../config')
const request = require('request')

AttachedFile = {}

Orm.register('file', 'AttachedFile')

const private_bucket = config.buckets.private
const public_bucket = config.buckets.public

AttachedFile.get = (id, cb) => {
  AttachedFile.getAll([id], (err, files) => {
    if (err)
      return cb(err)

    if (files.length < 1)
      return cb(Error.ResourceNotFound('File ' + id + ' not found'))

    const file = files[0]
    cb(null, file)
  })
}

AttachedFile.getAll = (file_ids, cb) => {
  db.query('file/get', [file_ids], (err, res) => {
    if (err)
      return cb(err)

    const files = res.rows.map(r => {
      signUrl(r)
      setPreview(r)
      r.mime = Mime.lookup(r.name)

      return r
    })

    return cb(null, files)
  })
}

const hasIcons = [
  'application/pdf',
  'video'
]

function setPreview (file) {
  const assets = config.assets + '/mimes/'

  const mime = Mime.lookup(file.name)
  file.preview_url = assets + 'unknown.png'

  const type = mime.split('/')[0]

  if (type === 'image') {
    file.preview_url = file.url
    return
  }

  if (hasIcons.indexOf(mime) > -1)
    file.preview_url = assets + mime.replace(/\//g, '-') + '.png'

  if (hasIcons.indexOf(type) > -1)
    file.preview_url = assets + type.replace(/\//g, '-') + '.png'
}

function signUrl(file) {
  if (file.public) {
    file.url = config.cdns.public + file.path
    return
  }

  const url = config.cdns.private + file.path

  const options = {
    keypairId: config.cloudfront.keypair.id,
    privateKeyString: config.cloudfront.keypair.private,
    expireTime: Number(new Date()) + (1000 * 86400) //Valid for a day.
  }

  file.url = cf.getSignedUrl(url, options)
}

AttachedFile.isAllowed = filename => {
  const ext = filename.split('.').pop().toLowerCase()

  return config.allowed_upload_types.indexOf(ext) > -1
}

AttachedFile.link = (file_id, relation, cb) => {
  db.query('file/relation/save', [
    file_id,
    relation.role,
    relation.id
  ], cb)
}

const save = ({relations, file, user, public}, cb) => {
  const saveRelations = (cb, results) => {
    async.each(relations, AttachedFile.link.bind(null, results.file.rows[0].id), cb)
  }

  const save = cb => {
    db.query('file/save', [
      file.key,
      file.name,
      user.id,
      public
    ], cb)
  }

  const done = (err, results) => {
    if (err)
      return cb(err)

    AttachedFile.get(results.file.rows[0].id, cb)
  }

  async.auto({
    file: save,
    relations: ['file', saveRelations]
  }, done)
}

const upload = ({key, mime, stream, name, public}, cb) => {
  if (!AttachedFile.isAllowed(name))
    return cb(Error.Validation(`Uploaded file ${name} is not permitted to be saved.`))

  const params = {
    Bucket: public ? public_bucket : private_bucket,
    Key: key,
    ContentType: mime,
    ContentDisposition: name
  }

  const upload = s3s.upload(params)


  upload.on('error', err => {
    cb(Error.Amazon(err))
  })


  upload.on('uploaded', (details) => {
    cb(null, {
      key,
      mime,
      name
    })
  })

  stream.pipe(upload)
}


AttachedFile.saveFromRequest = ({req, relations, path, public}, cb) => {
  const fields = {}

  const attachFile = (fieldname, file, filename, encoding, mime) => {
    /*
     * If the caller sets a public parameter to true/false, use that.
     * If its not set (its undefined), consider client-defined value
     */
    if (public === undefined)
      public = Boolean(fields.public)

    const ext = filename.split('.').pop()
    const key = `${path}/${uuid.v1()}.${ext}`

    upload({
      key,
      public,
      stream: file,
      name: filename,
      mime: Mime.lookup(filename),
    }, (err, file) => {
      if (err)
        return cb(err)

      save({
        relations,
        file,
        public,
        user: req.user,
      }, cb)
    })
  }

  const busboy = new Busboy({
    headers: req.headers,
    limits: {
      fileSize: 200 * 1024 * 1024,
      files: 1
    }
  })

  const setField = (name, val) => {
    fields[name] = val
  }

  busboy.on('file', attachFile)
  busboy.on('error', err => cb(err))
  busboy.on('field', setField)

  req.pipe(busboy)
}

AttachedFile.saveFromUrl = ({url, filename, relations, path, user, public = false}, cb) => {
  const ext = filename.split('.').pop()
  const key = `${path}/${uuid.v1()}.${ext}`

  const stream = request(url)

  const cancel = (err) => {
    stream.emit('error', err)
  }

  stream.on('response', res => {
    if (res.statusCode === 200)
      return

    cancel(`Got ${res.statusCode} while downloading ${JSON.stringify(url)}`)
  })

  upload({
    key,
    stream: stream,
    name: filename,
    mime: Mime.lookup(filename),
    public
  }, (err, file) => {
    if (err)
      return cb(err)

    save({
      relations,
      file,
      user,
      public
    }, cb)
  })
}

AttachedFile.download = (file_id, cb) => {
  AttachedFile.get(file_id, (err, file) => {
    if (err)
      return cb(err)

    s3.getObject({
      Bucket: file.public ? public_bucket : private_bucket,
      Key: file.path
    }, (err, file) => {
      if (err)
        return cb(Error.Amazon(err))

      cb(null, file.Body)
    })
  })
}

AttachedFile.delete = (file_id, cb) => {
  db.query('file/remove', [file_id], cb)
}