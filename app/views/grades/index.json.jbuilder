json.array!(@grades) do |grade|
  json.extract! grade, :id, :description, :date, :points
  json.url grade_url(grade, format: :json)
end
