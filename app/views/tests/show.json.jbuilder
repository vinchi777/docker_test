json.id @test.id.to_s
json.description @test.description
json.date @test.date.strftime('%b %e, %Y')
json.deadline @test.deadline.strftime('%b %e, %Y %I:%M %p')
json.timer @test.timer
json.random @test.random
json.questions @test.questions
json.url edit_test_path(@test)
