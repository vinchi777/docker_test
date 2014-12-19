json.array! @review_seasons do |s|
  json.id s.id.to_s
  json.season s.season
  json.season_start s.season_start.strftime('%b %e, %Y')
  json.season_end s.season_end.strftime('%b %e, %Y')
  json.promo_start s.promo_start.strftime('%b %e, %Y') if s.promo_start
  json.promo_end s.promo_end.strftime('%b %e, %Y') if s.promo_end
  json.first_timer s.first_timer
  json.repeater s.repeater
  json.full_review s.full_review
  json.double_review s.double_review
  json.coaching s.coaching
  json.reservation s.reservation
  json.enrolled s.enrolled.length
  json.enrolling s.enrolling.length
  json.url review_season_url(s, format: :json)
end
