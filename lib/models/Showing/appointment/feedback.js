const { expect } = require('chai')
const db = require('../../../utils/db')
const { dispatchEvent } = require('./status_fsm')

/**
 * @param {UUID} appointmentId
 * @param {import('./types').AppointmentFeedback} feedback 
 */
async function setFeedback(appointmentId, feedback) {
  expect(feedback, 'questions and answers fields are mandatory').to.include.keys(['questions', 'answers'])
  if (feedback.comment) {
    expect(feedback.comment, 'Comment is an optional string').to.be.a.string
  }

  const result = await db.update('showing/appointment/feedback', [
    appointmentId,
    JSON.stringify({
      questions: feedback.questions,
      answers: feedback.answers,
      comment: feedback.comment ?? null
    })
  ])

  await dispatchEvent('GaveFeedback', appointmentId)
  
  return result
}

module.exports = {
  setFeedback,
}
