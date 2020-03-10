const Context = require('../models/Context')

let fixHeroku = (req, charToSend = '\n') => {
  const res = req.res

  res.header('X-HEROKU-HEARTBEAT', 'Enabled')

  const write = () => {
    Context.log('[HerokuFix] heartbeat')
    res.writeProcessing()
  }

  const interval = setInterval(write, 10000)
  Context.log('[HerokuFix] started')

  res.json = json => {
    clearInterval(interval)
    Context.log('[HerokuFix] done')

    res.write(JSON.stringify(json))
    res.end()
  }

  function clearHerokuFix() {
    clearInterval(interval)
    Context.unset('herokuFix')
    Context.log('[HerokuFix] called off')
  }

  Context.set({
    herokuFix: clearHerokuFix
  })

  return clearHerokuFix
}

if (process.env.NODE_ENV === 'tests') {
  fixHeroku = function() {
    return function() {}
  }
}

module.exports = fixHeroku
