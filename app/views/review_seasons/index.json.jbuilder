json.array! @review_seasons do |s|
  json.id s.id.to_s
  json.season s.season
  json.season_start s.season_start
  json.season_end s.season_end
  json.promo_start s.promo_start
  json.promo_end s.promo_end
  json.first_timer s.first_timer
  json.repeater s.repeater
  json.full_review s.full_review
  json.double_review s.double_review
  json.coaching s.coaching
  json.reservation s.reservation
  json.url review_season_url(s, format: :json)
end
