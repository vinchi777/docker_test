module GradesHelper
  def on_off(bool)
    bool ? 'on' : 'off'
  end

  def grades_in_season(season)
    @grades.where(review_season: season).desc(:date)
  end

  def existing_student(student)
    'excluded' if @grade.student_grades.none? { |g| g.student == student }
  end
end