DELETE FROM recommendations t
WHERE COALESCE(ARRAY_LENGTH(referring_alerts, 1), 0) = 0 AND
      referred_shortlist = $1 AND
      (SELECT COUNT(*) FROM messages where messages.message_room = t.message_room) = 0 AND
      (SELECT BOOL_OR(CASE WHEN status = 'Pinned' THEN TRUE ELSE FALSE END) FROM recommendations r where t.referred_shortlist = $1 AND t.object = r.object) = FALSE
