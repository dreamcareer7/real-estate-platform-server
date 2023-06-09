WITH verified AS (
    UPDATE users
    SET phone_confirmed = TRUE,
        updated_at = CLOCK_TIMESTAMP()
    WHERE phone_number = $2 AND
    EXISTS (
        SELECT id
        FROM phone_verifications
        WHERE code = $1 AND
              phone_number = $2
    )
)
DELETE FROM phone_verifications
WHERE code = $1 AND
      phone_number = $2
