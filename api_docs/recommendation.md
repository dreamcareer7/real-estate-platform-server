# Group Recommendation

A `Recommendation` is a listing, recommended to a `Room`.
Each room member will be able to discard, favorite, comment it.


## Get Feed [GET /rooms/{id}/recs/feed]
Series of recommendations you havent seen already
<!-- include(tests/recommendation/feed.md) -->

## Get Favorited listings on a room [GET /rooms/{id}/recs/favorites]
Recommendation's you have marked as favorite (Loved)
<!-- include(tests/recommendation/getFavorites.md) -->


## Mark as Seen [DELETE /rooms/{rid}/recs/feed/{id}]
<!-- include(tests/recommendation/markAsSeen.md) -->

## Mark as Favorite [PATCH /rooms/{rid}/recs/{id}/favorite]
<!-- include(tests/recommendation/markAsFavorite.md) -->

## Recommend Manually [POST /rooms/{id}/recs]
You can recommend (share) an item with others.
<!-- include(tests/recommendation/recommendManually.md) -->

## Mark as Read in bulk [DELETE /rooms/:id/recs/feed]
Mark a series of recommendation as read
<!-- include(tests/recommendation/bulkMarkAsRead.md) -->

## Get Favorited listings [GET /user/favorites]
List of listings favorited by a user
<!-- include(tests/recommendation/getFavoritedListings.md) -->
