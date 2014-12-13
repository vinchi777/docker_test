json.array!(@tests) do |test|
  json.id test.id.to_s
  json.description test.description
  json.date test.date
  json.is_deadline test.deadline?
  json.deadline test.deadline
  json.timer test.timer
  json.random test.random
  json.questions_length test.questions.length
  json.url test_url(test, format: :json)
  json.results_url results_test_path(test)
end
