require 'rails_helper'

RSpec.describe "Imports", :type => :request do

  let(:user) {User.create(email: 'Thor', password: 'password', password_confirmation: 'password')}

  describe "GET /imports" do
    it "works! (now write some real specs)" do
      sign_in user
      get imports_path
      expect(response.status).to be(200)
    end
  end
end
