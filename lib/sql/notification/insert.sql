INSERT INTO notifications(
            action,
            object_class,
            object,
            notifying_user,
            message,
            auxiliary_object_class,
            auxiliary_object,
            recommendation,
            notified_user,
            shortlist,
            subject,
            subject_class,
            auxiliary_subject_class
        )
VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13) RETURNING id;
