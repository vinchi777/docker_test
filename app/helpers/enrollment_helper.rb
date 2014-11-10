module EnrollmentHelper
  def first_step?
    step == wizard_steps.first
  end

  def last_step?
    step == wizard_steps.last
  end

  def active_indicator?(_step)
    _step == step || past_step?(_step)
  end
end
