SELECT * FROM rooms_users WHERE room = ANY($1::uuid[])