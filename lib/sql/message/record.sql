INSERT INTO messages(
    message_room,
    message_type,
    comment,
    image_url,
    document_url,
    video_url,
    object,
    author,
    image_thumbnail_url,
    viewable_by,
    subjects,
    objects,
    subject_class,
    object_class
)
VALUES($1,
       $2,
       $3,
       $4,
       $5,
       $6,
       $7,
       $8,
       $9,
       $10,
       $11,
       $12,
       $13)
RETURNING id;
