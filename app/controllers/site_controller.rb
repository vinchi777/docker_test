class SiteController < ApplicationController
  def home
  end

  def about
  end

  def founders
    @founders = Founder.seed
  end

  def reviewers
  end

  def courses
  end

  def pricing
  end
end
