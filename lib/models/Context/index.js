require('colors')
const Domain = require('domain')
const uuid = require('uuid')
const numeral = require('numeral')

const Context = {}

Context.create = ({id = uuid.v4(), created_at = process.hrtime(), logger = null} = {}) => {
  if (Context.getActive())
    Context.log('Nesting Context', id)

  id = id || uuid.v4()
  created_at = created_at || process.hrtime()

  const domain = Domain.create()

  const on = domain.on.bind(domain)
  const emit = domain.emit.bind(domain)

  let data = {}

  const exit = () => {
    domain.exit()
    domain.removeAllListeners()
  }

  const run = (fn, ...args) => {
    return domain.run(fn, ...args)
  }

  const watchOver = emitter => {
    domain.add(emitter)
  }

  const elapsed = () => {
    const [seconds, nanoseconds] = process.hrtime(created_at)
    const e = Math.round((seconds * 1000) + (nanoseconds * 1e-6))

    return e
  }

  const _logger = (...args) => {
    const e = numeral(elapsed()).format('0,0') + 'ms'

    console.log.apply(this, [
      id.green,
      e,
      ...args
    ])
  }

  const log = logger ? logger : _logger

  const error = (...args) => {
    const e = numeral(elapsed()).format('0,0') + 'ms'

    console.error.apply(this, [
      id.red,
      e,
      ...args
    ])
  }

  const trace = (...args) => {
    const e = numeral(elapsed()).format('0,0') + 'ms'

    console.trace.apply(this, [
      id.green,
      e,
      ...args
    ])
  }

  const warn = (...args) => {
    const e = numeral(elapsed()).format('0,0') + 'ms'

    console.warn.apply(this, [
      id.green,
      e,
      ...args
    ])
  }

  const get = key => {
    return data[key]
  }

  const set = attrs => {
    data = {
      ...data,
      ...attrs
    }
  }

  const unset = key => {
    delete data[key]
  }

  const enter = () => {
    // trace('context.enter called')
    domain.enter()
  }

  const context = {
    id,
    domain,
    created_at,
    elapsed,
    enter,
    exit,
    watchOver,
    run,
    on,
    emit,
    log,
    warn,
    error,
    trace,
    get,
    set,
    unset
  }

  domain.context = context

  return context
}

Context.set = attrs => {
  const active = Context.getActive()
  if(!active)
    return

  active.set(attrs)
}

Context.unset = key => {
  const active = Context.getActive()
  if(!active)
    return

  active.unset(key)
}

Context.get = key => {
  const active = Context.getActive()
  if(!active)
    return

  return active.get(key)
}

Context.getActive = () => {
  if (!process.domain)
    return false

  return process.domain.context
}

/**
 * @returns {string | undefined}
 */
Context.getId = () => {
  const context = Context.getActive()

  if (context) return context.id
}

Context.trace = (...args) => {
  const active = Context.getActive()
  if (active)
    return active.trace.apply(this, args)

  console.log.apply(this, ['<No-Context>', ...args])
}

Context.warn = (...args) => {
  const active = Context.getActive()
  if (active)
    return active.warn.apply(this, args)

  console.log.apply(this, ['<No-Context>', ...args])
}

Context.log = (...args) => {
  const active = Context.getActive()
  if (active)
    return active.log.apply(this, args)

  console.log.apply(this, ['<No-Context>', ...args])
}

Context.error = (...args) => {
  const active = Context.getActive()
  if (active)
    return active.error.apply(this, args)

  console.error.apply(this, ['<No-Context>', ...args])
}

Context.emit = (...args) => {
  const active = Context.getActive()
  if (!active)
    throw new Error('No Active Context Found')

  active.emit.apply(null, args)
}

Context.exit = () => {
  const active = Context.getActive()
  if (!active)
    throw new Error('No Active Context Found')

  active.exit()
}

module.exports = Context
