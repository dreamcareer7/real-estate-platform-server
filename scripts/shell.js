const repl = require('repl')
const promisify = require('../lib/utils/promisify')
const { enqueueJob } = require('../lib/utils/worker')
const queue = require('../lib/utils/queue')
const program = require('commander')
const Brand = require('../lib/models/Brand')
const Job = require('../lib/models/Job')
const User = require('../lib/models/User/get')

program
  .usage('npm run shell [options]')
  .option('-u, --user <user>', 'user-id to be preset on context')
  .option('-b, --brand <brand>', 'brand-id to be preset on context')
  .parse(process.argv)

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


attachCalendarEvents()
attachContactEvents()
attachTouchEventHandler()
attachTaskEventHandler()
attachFlowEventHandler()
attachCalIntEventHandler()
attachContactIntEventHandler()

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
