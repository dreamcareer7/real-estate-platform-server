INSERT INTO notifications(
            action,
            object_class,
            object,
            subject,
            message,
            auxiliary_object_class,
            auxiliary_object,
            recommendation,
            room,
            auxiliary_subject,
            subject_class,
            auxiliary_subject_class,
            extra_subject_class,
            extra_object_class,
            exclude,
            specific,
            title,
            data,
            sound
        )
VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19) RETURNING id;
