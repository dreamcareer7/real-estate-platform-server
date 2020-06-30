const db = require('../utils/db')

Review = {}

Orm.register('review', 'Review')

Review.INCOMPLETE = 'Incomplete'
Review.SUBMITTED = 'Submitted'
Review.DECLINED = 'Declined'
Review.APPROVED = 'Approved'

Review.getAll = async ids => {
  const res = await db.query.promise('review/get', [ids])
  return res.rows
}

Review.get = async id => {
  const reviews = await Review.getAll([id])

  if (reviews.length < 1)
    throw Error.ResourceNotFound(`Review ${id} not found`)

  return reviews[0]
}

Review.create = async review => {
  const res = await db.query.promise('review/insert', [
    review.created_by,
    review.status
  ])

  return Review.get(res.rows[0].id)
}

Review.update = async (id, review) => {
  await db.query.promise('review/update', [
    id,
    review.created_by,
    review.status
  ])
}

Review.associations = {
  updated_by: {
    enabled: false,
    model: 'User'
  }
}