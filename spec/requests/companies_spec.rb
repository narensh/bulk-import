require 'rails_helper'

RSpec.describe "Companies", :type => :request do

  let(:user) {User.create(email: 'Thor', password: 'password', password_confirmation: 'password')}

  describe "GET /companies" do
    it "works! (now write some real specs)" do
      sign_in user
      get companies_path
      expect(response.status).to be(200)
    end
  end
end
