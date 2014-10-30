json.array!(@review_seasons) do |review_season|
  json.extract! review_season, :id, :start, :end, :promoStart, :promoEnd, :repeater, :fullReview, :doubleReview, :coaching, :reservation
  json.url review_season_url(review_season, format: :json)
end
