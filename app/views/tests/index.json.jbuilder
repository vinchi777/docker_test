json.array!(@tests) do |test|
  json.extract! test, :id, :description, :date, :deadline, :timer, :random
  json.url test_url(test, format: :json)
end
