const _ = require('lodash')
const jasmine = require('jasmine-node')
const async = require('async')

global.frisby = require('frisby')
global.results = {}

frisby.globalSetup({
  timeout: 90000,
  request: {
    json: true,
    baseUri: process.argv[3],
    headers: {}
  }
})

const transformTasks = (suite, fns) => {
  return Object.keys(fns)
    .map((name) => ({
      suite: suite,
      name: name,
      fn: fns[name]
    }))
}

const runFrisbies = function (tasks, prefix = '', cb) {
  const runF = function (task, doneCb) {
    try {
      if (typeof task.fn === 'object') {
        return runFrisbies(transformTasks(task.suite, task.fn), prefix ? prefix + '.' + task.name : task.name, doneCb)
      }

      const f = task.fn((err, res) => {
        if (err) {
          console.error(err)
        }
    
        if (res && res.body) {
          const key = `${task.suite}${prefix ? '.' + prefix : ''}.${task.name}`
          _.set(global.results, key, res.body)
        }

        doneCb(err, res)
      })

      f.current.outgoing.headers['x-suite'] = process.argv[2]
      f.current.outgoing.headers['x-original-suite'] = task.suite
      f.current.outgoing.headers['x-test-name'] = task.name
      f.current.outgoing.headers['x-test-description'] = f.current.describe

      f.toss()
    }
    catch (ex) {
      process.send({
        code: 'suite error',
        suite: process.argv[2],
        error: ex
      })
      console.error(ex)
      throw ex
    }
  }

  if (cb) {
    async.forEachSeries(tasks, runF, cb)
  } else {
    async.forEachSeries(tasks, runF)
  }
}

const prepareTasks = function () {
  const frisbies = []
  global.registerSuite = (suite, tests) => {
    const fns = require('./suites/' + suite + '.js')

    if (!results[suite])
      results[suite] = {}

    Object.keys(fns)
      .filter((name) => (!tests || tests.indexOf(name) > -1))
      .map((name) => {
        frisbies.push({
          suite: suite,
          name: name,
          fn: fns[name]
        })
      })

    return fns
  }

  registerSuite('authorize')
  registerSuite(process.argv[2])

  return frisbies
}

function reportData (test) {
  const results = test.results()

  const data = {
    name: test.getFullName(),
    description: test.description,
    total: results.totalCount,
    passed: results.passedCount,
    failed: results.failedCount,
    messages: []
  }

  results.items_.forEach((item) => {
    item.items_
      .filter(item => !item.passed_)
      .forEach(item => {
        data.messages.push(item)
      })
  })

  process.send({
    code: 'test done',
    test: data
  })
}

function setupJasmine () {
  const jasmineEnv = jasmine.getEnv()
  jasmineEnv.updateInterval = 250

  const reporter = new jasmine.JsApiReporter()

  reporter.reportSuiteResults = reportData
  reporter.reportRunnerResults = process.exit

  jasmineEnv.addReporter(reporter)

  jasmineEnv.execute()
}

runFrisbies(prepareTasks())
setupJasmine()
