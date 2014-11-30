json.array!(@grades) do |season,grades|
  json.description season.season
  json.grades grades do |grade|
    json.id grade.id.to_s
    json.points grade.points
    json.description grade.description
    json.date grade.date
    json.has_timer false
    json.is_test false
    json.url grade_url(grade, format: :json)
  end
end