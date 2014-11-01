require "rails_helper"

RSpec.describe StudentPaymentsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/student_payments").to route_to("student_payments#index")
    end

    it "routes to #new" do
      expect(:get => "/student_payments/new").to route_to("student_payments#new")
    end

    it "routes to #show" do
      expect(:get => "/student_payments/1").to route_to("student_payments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/student_payments/1/edit").to route_to("student_payments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/student_payments").to route_to("student_payments#create")
    end

    it "routes to #update" do
      expect(:put => "/student_payments/1").to route_to("student_payments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/student_payments/1").to route_to("student_payments#destroy", :id => "1")
    end

  end
end
