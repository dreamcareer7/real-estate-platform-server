const Context = require('../../Context')
const EmailCampaign = {
  ...require('../../Email/campaign/notify'),
  ...require('../../Email/campaign/constants'),
}
const config = require('../../../config')
const db = require('../../../utils/db')

const promisify = require('../../../utils/promisify')
const redis = require('../../../data-service/redis').createClient()
const zrangebyscore = promisify(redis.zrangebyscore.bind(redis))
const zadd = promisify(redis.zadd.bind(redis))
const zrem = promisify(redis.zrem.bind(redis))

const REDIS_KEY = 'email-campaign-updates'


const touch = async campaign_id => {
  Context.log('Touching campaign', campaign_id)
  return zadd(REDIS_KEY, Date.now(), campaign_id)
}

const updateStats = async (delay = config.email.stat_update_delay) => {
  const until = Date.now() - delay

  const ids = await zrangebyscore(REDIS_KEY, 0, until)

  if (ids.length < 1)
    return

  for(const id of ids)
    await rebuildCampaignStats(id)
}

const rebuildCampaignStats = async id => {
  Context.log('Rebuilding stats for campaign', id)
  const { rows } = await db.query.promise('email/campaign/update-stats', [id])

  await zrem(REDIS_KEY, id)

  const campaign = rows[0]
  EmailCampaign.notify(
    EmailCampaign.STATS_EVENT,
    campaign.created_by,
    campaign.brand,
    [campaign.ids],
    campaign
  )
}


module.exports = {
  touch,
  updateStats,
}
