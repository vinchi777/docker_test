require 'rails_helper'

RSpec.describe SiteController, :type => :controller do

  describe "GET about" do
    it "returns http success" do
      get :about
      expect(response).to be_success
    end
  end

  describe "GET founders" do
    it "returns http success" do
      get :founders
      expect(response).to be_success
    end
  end

  describe "GET reviewers" do
    it "returns http success" do
      get :reviewers
      expect(response).to be_success
    end
  end

  describe "GET pricing" do
    it "returns http success" do
      get :pricing
      expect(response).to be_success
    end
  end

end
