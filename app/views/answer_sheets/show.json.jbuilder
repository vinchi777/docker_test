json.id @sheet.id.to_s
json.elapsed Time.now - @sheet.start_time
json.submitted @sheet.submitted
json.answers @sheet.answers do |a|
  json.id a.id.to_s
  json.text a.question.text
  json.choice1 a.question.choice1
  json.choice2 a.question.choice2
  json.choice3 a.question.choice3
  json.choice4 a.question.choice4
  json.index a.index
end

json.test do
  json.description @sheet.test.description
  json.date @sheet.test.date.strftime('%b %e, %Y')
  json.deadline @sheet.test.deadline.strftime('%b %e, %Y %I:%M %p')
  json.timer @sheet.test.timer
  json.random @sheet.test.random
end

json.url edit_test_path(@sheet)