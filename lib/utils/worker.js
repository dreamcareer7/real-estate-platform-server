const Context = require('../models/Context')
const Job = require('../models/Job')


function formatJobName(job) {
  let name = job.type
  if (job.data && job.data.type) {
    name += ':' + job.data.type
  }

  return name
}

function combineHandlers(handlers) {
  const res = {}

  for (const [key, handler] of Object.entries(handlers)) {
    if (typeof handler === 'function') {
      res[key] = (job, done) => {
        Context.log(formatJobName(job))
        Context.log(job.data)
        handler(job).nodeify(done)
      }
    }
    else {
      res[key] = aggregate(handler)
    }
  }

  return res
}

function aggregate(handlers) {
  return (job, done) => {
    Context.log(formatJobName(job))
    try {
      const handler = handlers[job.data.type]
      if (typeof handler !== 'function') {
        return done(new Error(`No handler for ${job.data.type} job.`))
      }

      handler(job).nodeify(done)
    }
    catch (ex) {
      console.error(ex)
    }
  }
}

function enqueueJob(queue, type, data) {
  const job = Job.queue.create(queue, {
    ...data,
    type
  }).removeOnComplete(true)

  Context.get('jobs').push(job)

  return job
}

module.exports = {
  aggregate,
  combineHandlers,
  enqueueJob
}
