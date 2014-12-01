json.array! @review_seasons do |s|
  json.id s.id.to_s
  json.season s.season
end