SELECT * FROM chargebee_subscriptions
WHERE customer = $1
AND   plan     = $2
AND   deleted_at IS NULL