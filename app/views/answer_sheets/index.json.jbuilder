json.array!(@sheets) do |s|
  json.id s.id.to_s
  json.description s.test.description
  json.submitted s.submitted?
  json.submission_date s.submission_date
  json.date s.test.date
  json.deadline s.deadline?
  json.timer s.test.timer
  json.questions_length s.test.questions.length
  json.url answer_sheet_url(s, format: :json)
end
