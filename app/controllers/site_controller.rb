class SiteController < ApplicationController
  def home
    @testimonials = Testimonial.seed
    @student_count = StudentEnrollment.enrolled.count
  end

  def about
  end

  def founders
    @founders = Founder.seed
  end

  def reviewers
    @reviewers = Reviewer.seed
  end

  def courses
  end

  def pricing
    @season = ReviewSeason.current
    unless @season
      @season = ReviewSeason.new({
                                     first_timer: 14000,
                                     repeater: 12000,
                                     full_review: 16000,
                                     double_review: 22000,
                                     coaching: 7000,
                                     reservation: 3000,
                                 })
    end
  end

  def our_students
    @batches = StudentEnrollment.enrolled.group_by { |e| e.review_season }
  end
end
