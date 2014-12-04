module GradesHelper
  def on_off(bool)
    bool ? 'on' : 'off'
  end

  def grades_in_season(season)
    @grades.select{|g| g.review_season == season}.sort {|a,b| b.date <=> a.date}
  end

  def existing_student(student)
    'excluded' if @grade.student_grades.none? { |g| g.student == student }
  end

  def grade_name_attr(index)
    "grade[student_grades_attributes][#{index}]"
  end
end