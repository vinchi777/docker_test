class SiteController < ApplicationController
  def home
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
  end
end
