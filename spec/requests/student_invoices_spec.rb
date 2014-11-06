require 'rails_helper'

RSpec.describe "StudentPayments", :type => :request do
  describe "GET /student_payments" do
    it "works! (now write some real specs)" do
      get student_payments_path
      expect(response.status).to be(200)
    end
  end
end
