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
  end

  def our_students
    @batches = StudentEnrollment.enrolled.group_by { |e| e.review_season }
  end
end
