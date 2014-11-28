json.array!(@tests) do |test|
  json.id test.id.to_s
  json.description test.description
  json.date test.date
  json.deadline test.deadline
  json.timer test.timer
  json.random test.random
  json.questions_length test.questions.length
  json.url test_url(test, format: :json)
end
