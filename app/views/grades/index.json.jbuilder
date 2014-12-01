json.grades do
	json.array!(@grades) do |grade|
	  json.id grade.id.to_s
	  json.points grade.points
	  json.average grade.average
	  json.description grade.description
	  json.date grade.date
	  json.review_season_id grade.review_season.id.to_s
	  json.has_timer false
	  json.is_test false
	  json.url grade_url(grade, format: :json)
	end
end
