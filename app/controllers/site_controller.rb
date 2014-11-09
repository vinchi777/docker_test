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
    if ReviewSeason.exists?
      @season = ReviewSeason.all.sort_by { |r| r.season_start }.last
    else
      @season = ReviewSeason.new(full_review: 16000, double_review: 22000, coaching: 7000, reservation: 3000)
    end
  end

  def enrollment
  end
end
