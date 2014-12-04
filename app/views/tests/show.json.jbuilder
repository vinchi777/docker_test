json.id @test.id.to_s
json.description @test.description
json.date @test.date.strftime('%b %e, %Y')
json.deadline @test.deadline.strftime('%b %e, %Y %I:%M %p')
json.timer @test.timer
json.random @test.random
json.review_season do
  json.id @test.review_season.id.to_s
  json.season @test.review_season.season
end
json.questions @test.questions.each do |q|
  json.id q.id.to_s
  json.text q.text
  json.choice1 q.choice1
  json.choice2 q.choice2
  json.choice3 q.choice3
  json.choice4 q.choice4
  json.answer q.answer
  json.ratio q.ratio
end
json.url test_path(@test)
