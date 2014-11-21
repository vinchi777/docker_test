class SiteController < ApplicationController
  def home
    @testimonials = Testimonial.seed
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

  def students
    @batches = StudentEnrollment.all.group_by { |e| e.review_season }
  end
end
