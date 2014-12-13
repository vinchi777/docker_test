json.test do
  json.description @test.description
  json.length @test.questions.length
  json.passed @test.passed
  json.failed @test.failed
  json.passing_rate '%.1f' % @test.passing_rate if @test.deadline?
  json.url test_path(@test)
end

json.students @students do |s|
  json.id s.id.to_s
  json.profile_pic s.profile_pic
  json.last_name s.last_name
  json.first_name s.first_name
  json.middle_initial s.middle_initial
  sheet = @test.answer_sheet_of(s)
  json.answer_sheet do
    json.correct_points sheet.correct_points
    json.percent '%.1f' % sheet.percent if sheet.percent
  end
  json.url answer_sheet_path(sheet)
end
