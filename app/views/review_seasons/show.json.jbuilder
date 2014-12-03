json.id @review_season.id.to_s
json.season @review_season.season
json.season_start @review_season.season_start
json.season_end @review_season.season_end
json.promo_start @review_season.promo_start
json.promo_end @review_season.promo_end
json.first_timer @review_season.first_timer
json.repeater @review_season.repeater
json.full_review @review_season.full_review
json.double_review @review_season.double_review
json.coaching @review_season.coaching
json.reservation @review_season.reservation
json.enrolled @review_season.enrolled.length
json.enrolling @review_season.enrolling.length
json.url review_season_url(@review_season, format: :json)
