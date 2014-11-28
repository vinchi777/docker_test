require "rails_helper"

RSpec.describe ReviewSeasonsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/review_seasons").to route_to("review_seasons#index")
    end

    it "routes to #new" do
      expect(:get => "/review_seasons/new").to route_to("review_seasons#new")
    end

    it "routes to #show" do
      expect(:get => "/review_seasons/1").to route_to("review_seasons#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/review_seasons/1/edit").to route_to("review_seasons#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/review_seasons").to route_to("review_seasons#create")
    end

    it "routes to #update" do
      expect(:put => "/review_seasons/1").to route_to("review_seasons#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/review_seasons/1").to route_to("review_seasons#destroy", :id => "1")
    end

  end
end
