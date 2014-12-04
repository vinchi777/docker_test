json.id @sheet.id.to_s
unless @sheet.submitted?
  json.remaining @sheet.remaining
end
json.submitted @sheet.submitted?
json.submission_date @sheet.submission_date
json.start_time @sheet.start_time
json.started @sheet.started?
json.expired @sheet.expired?
json.deadline @sheet.deadline?
json.correct_points @sheet.correct_points
json.total_points @sheet.total_points
json.percent '%.1f' % @sheet.percent if @sheet.percent
json.answers @sheet.answers do |a|
  json.id a.id.to_s
  json.text a.question.text
  json.choice1 a.question.choice1
  json.choice2 a.question.choice2
  json.choice3 a.question.choice3
  json.choice4 a.question.choice4
  if @sheet.deadline?
    json.answer a.question.answer
    json.ratio a.question.ratio
  end
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