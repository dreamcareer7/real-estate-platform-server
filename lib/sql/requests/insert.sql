INSERT INTO http_requests
(
  id,
  method,
  path,
  elapsed,
  response,
  client,
  user_id,
  queries,
  route
)
VALUES
(
  $1,$2,$3,$4,$5,$6,$7,$8,$9
)
