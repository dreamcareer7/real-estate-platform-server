const program = require('commander')
const path = require('path')
const repl = require('repl')

program
  .usage('npm run shell [options]')
  .option('-u, --user <user>', 'user-id to be preset on context')
  .option('-b, --brand <brand>', 'brand-id to be preset on context')
  .option('-e, --env <env>', 'env file name to be used')
  .option('-i, --import <imports...>', 'models and utils to import')
  .parse(process.argv)

const options = program.opts()

if (options.env) {
  console.log(`setting up env using .env.${options.env}`)
  require('dotenv').config({ path: path.resolve(process.cwd(), `.env.${options.env}`) })
}

const promisify = require('../lib/utils/promisify')
const { enqueueJob } = require('../lib/utils/worker')
const queue = require('../lib/utils/queue')
const Brand = require('../lib/models/Brand')
const Job = require('../lib/models/Job')
const User = require('../lib/models/User/get')

const db = require('../lib/utils/db')
const sql = require('../lib/utils/sql')
const Context = require('../lib/models/Context/index')
const redis = require('../lib/data-service/redis').createClient()

const attachCalendarEvents = require('../lib/models/Calendar/events')
const attachContactEvents = require('../lib/models/Contact/events')
const attachTouchEventHandler = require('../lib/models/CRM/Touch/events')
const attachTaskEventHandler = require('../lib/models/CRM/Task/events')
const attachFlowEventHandler = require('../lib/models/Flow/events')
const attachCalIntEventHandler = require('../lib/models/CalendarIntegration/events')
const attachContactIntEventHandler = require('../lib/models/ContactIntegration/events')
const attachShowingEvents = require('../lib/models/Showing/showing/events')


attachCalendarEvents()
attachContactEvents()
attachTouchEventHandler()
attachTaskEventHandler()
attachFlowEventHandler()
attachCalIntEventHandler()
attachContactIntEventHandler()
attachShowingEvents()

function processImports(replContext) {
  for (const part of options.import ?? []) {
    switch (part) {
      case 'google':
        replContext.GoogleCredential = require('../lib/models/Google/credential/get')
        replContext.GoogleApis = require('../lib/models/Google/plugin/googleapis')
        break
      default:
        break
      default:
        break
    }
  }
}

const context = Context.create({
  id: '<rechat-shell>',
  created_at: process.hrtime()
})

context.enter()

db.conn(async (err, client) => {
  if (err) {
    process.exit(1)
  }

  const r = repl.start({
    prompt: 'Rechat Shell> ',
    replMode: repl.REPL_MODE_STRICT,
    domain: context.domain
  })

  r.on('exit', cleanup)

  r.context.db = db
  r.context.sql = sql
  r.context.context = context
  r.context.promisify = promisify
  r.context.enqueueJob = enqueueJob
  processImports(r.context)
  r.context.handleJobs = async () => { 
    await promisify(Job.handle)(Context.get('jobs'))
    Context.set({ jobs: [], rabbit_jobs: [] })
  }

  context.set({
    db: client,
    jobs: [],
    rabbit_jobs: []
  })

  if (program.user) {
    const user = await User.get(program.user)
    context.log(`Logged in as ${user.display_name}`)
    context.set({ user })
  }

  if (program.brand) {
    const brand = await Brand.get(program.brand)
    context.log(`Active brand set to ${brand.name}`)
    context.set({ brand })
  }
})


function cleanup() {
  queue.shutdown(500, () => {})
  redis.quit()
  context.get('db').release()
  db.close()
  process.exit()
}
