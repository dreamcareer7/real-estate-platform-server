const db = require('../lib/utils/db')

const migrations = [
  `ALTER TYPE template_type
  ADD VALUE 'JuneTeenth'`,

  `ALTER TYPE template_type
  ADD VALUE 'FirstDayOfSummer'`,

  `ALTER TYPE template_type
  ADD VALUE 'Pride'`,

  `ALTER TYPE template_type
  ADD VALUE 'AsianAmericanAndPacificIslanderHeritageMonth'`,

  `ALTER TYPE template_type
  ADD VALUE 'BlackHistoryMonth'`,

  `ALTER TYPE template_type
  ADD VALUE 'EarthDay'`,

  `ALTER TYPE template_type
  ADD VALUE 'FirstDayOfSpring'`,

  `ALTER TYPE template_type
  ADD VALUE 'CincoDeMayo'`,

  `ALTER TYPE template_type
  ADD VALUE 'FirstDayOfFall'`,
  
  `ALTER TYPE template_type
  ADD VALUE 'FirstDayOfWinter'`,

  `ALTER TYPE template_type
  ADD VALUE 'YomKippur'`,

]

const run = async () => {
  const { conn } = await db.conn.promise()

  for(const sql of migrations) {
    await conn.query(sql)
  }

  conn.release()
}

exports.up = cb => {
  run().then(cb).catch(cb)
}

exports.down = () => {}
