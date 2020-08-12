const spawn = require('child_process').exec
const mkdir = require('fs').mkdirSync
const aglio = require('aglio')
const fs = require('fs')
const async = require('async')

const program = require('commander')
  .option('-o, --no-tests', 'Disable running tests, only regenerate docs')
  .option('-t, --theme <theme>', 'Aglio theme to use')

const options = program.parse(process.argv)

try {
  mkdir('docs')
} catch (e) {
  // FIXME: What is to be done here?
}

if (options.tests) {
  const c = spawn('node ' + __dirname + '/../tests/functional/run --docs', {
    maxBuffer: 1024 * 1000
  }, err => {
    if (err) {
      console.log(err)
      process.exit()
      return
    }

    generate()
  })

  c.stderr.pipe(process.stderr)
} else
  generate()

function generate() {
  console.log('Generating documentation')

  const files = fs.readdirSync('docs')
    .filter(filename => {
      if (filename.substr(0,1) === '.')
        return false

      if (filename.split('.').pop() !== 'md')
        return false

      return true
    })
    .map(filename => filename.substr(0, filename.length - 3))

  const done = err => {
    if (err)
      return console.log('Error while generating docs', err)

    console.log('Done')
    process.exit(0)
  }

  async.map(files, generateMd, done)
}

function generateMd(docName, cb) {
  const md = fs.readFileSync(`docs/${docName}.md`).toString()

  console.log('Generating', docName)

  aglio.render(md, {
    theme: options.theme || 'olio',
    //     themeTemplate:'triple',
    themeFullWidth: true,
    includePath: 'docs'
  }, (err, html) => {
    if (err)
      return cb(err)

    console.log('Done Generating', docName)
    fs.writeFile(`docs/${docName}.html`, html, cb)
  })
}
