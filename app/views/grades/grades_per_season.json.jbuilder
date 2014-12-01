json.array!(@grades) do |season,grades|
  json.season season.season
  json.season_id season.id.to_s
  json.grades grades do |grade|
    json.id grade.id.to_s
    json.points grade.points
    json.average grade.average
    json.description grade.description
    json.date grade.date
    json.has_timer false
    json.is_test false
    json.url grade_url(grade, format: :json)
  end
end