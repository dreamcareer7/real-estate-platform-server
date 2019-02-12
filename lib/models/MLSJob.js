const db = require('../utils/db.js')
const validator = require('../utils/validator.js')

const schema = {
  type: 'object',
  properties: {
    name: {
      required: true,
      type: 'string'
    },

    last_id: {
      type: 'number'
    },

    last_modified_date: {
      type: 'string'
    },

    results: {
      type: 'number'
    },

    is_initial_completed: {
      type: 'boolean'
    },

    query: {
      type: 'string'
    }
  }
}

const validate = validator.bind(null, schema)

const MLSJob = {
  insert(job, cb) {
    validate(job, function (err) {
      if (err)
        return cb(err)
  
      db.query('mls_job/insert', [
        job.last_modified_date,
        job.last_id,
        job.results,
        job.query,
        job.is_initial_completed,
        job.name,
        job.limit,
        job.offset
      ], cb)
    })
  },

  getLastRun(job_name, cb) {
    db.query('mls_job/last_run', [job_name], (err, res) => {
      if (err)
        return cb(err)
  
      cb(null, res.rows[0])
    })
  }
}

global['MLSJob'] = MLSJob
module.exports = MLSJob
