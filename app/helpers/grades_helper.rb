module GradesHelper
  def on_off(bool)
    bool ? 'on' : 'off'
  end

  def grades_in_season(season)
    @grades.where(review_season: season).desc(:date)
  end
end
