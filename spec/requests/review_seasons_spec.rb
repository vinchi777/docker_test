require 'rails_helper'

RSpec.describe "ReviewSeasons", :type => :request do
  describe "GET /review_seasons" do
    it "works! (now write some real specs)" do
      get review_seasons_path
      expect(response.status).to be(200)
    end
  end
end
