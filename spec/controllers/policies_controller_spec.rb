require 'rails_helper'

RSpec.describe PoliciesController, :type => :controller do

  before {warden.set_user User.create(email: 'Thor', password: 'password', password_confirmation: 'password')}

  let(:company) {Company.create!(name: 'A Company')}

  let(:valid_attributes) {{name: 'A Policy', company_id: company.id}}

  let(:invalid_attributes) {{name: 'An Invalid Policy', company_id: 9999999}}

  let(:valid_session) {}

  describe "GET index" do
    it "assigns all policies as @policies" do
      policy = Policy.create! valid_attributes
      get :index, params: {}
      expect(assigns(:policies)).to eq([policy])
    end
  end

  describe "GET show" do
    it "assigns the requested policy as @policy" do
      policy = Policy.create! valid_attributes
      get :show, params: {:id => policy.to_param}
      expect(assigns(:policy)).to eq(policy)
    end
  end

  describe "GET new" do
    it "assigns a new policy as @policy" do
      get :new, params: {}
      expect(assigns(:policy)).to be_a_new(Policy)
    end
  end

  describe "GET edit" do
    it "assigns the requested policy as @policy" do
      policy = Policy.create! valid_attributes
      get :edit, params: {:id => policy.to_param}
      expect(assigns(:policy)).to eq(policy)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Policy" do
        expect {
          post :create, params: {:policy => valid_attributes}
        }.to change(Policy, :count).by(1)
      end

      it "assigns a newly created policy as @policy" do
        post :create, params: {:policy => valid_attributes}
        expect(assigns(:policy)).to be_a(Policy)
        expect(assigns(:policy)).to be_persisted
      end

      it "redirects to the created policy" do
        post :create, params: {:policy => valid_attributes}
        expect(response).to redirect_to(Policy.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved policy as @policy" do
        post :create, params: {:policy => invalid_attributes}
        expect(assigns(:policy)).to be_a_new(Policy)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {name: 'A Policy with New Name'}
      }

      it "updates the requested policy" do
        policy = Policy.create! valid_attributes
        put :update, params: {:id => policy.to_param, :policy => new_attributes}
        policy.reload
        expect(policy.name).to eq('A Policy with New Name')
      end

      it "assigns the requested policy as @policy" do
        policy = Policy.create! valid_attributes
        put :update, params: {:id => policy.to_param, :policy => valid_attributes}
        expect(assigns(:policy)).to eq(policy)
      end

      it "redirects to the policy" do
        policy = Policy.create! valid_attributes
        put :update, params: {:id => policy.to_param, :policy => valid_attributes}
        expect(response).to redirect_to(policy)
      end
    end

    describe "with invalid params" do
      it "assigns the policy as @policy" do
        policy = Policy.create! valid_attributes
        put :update, params: {:id => policy.to_param, :policy => invalid_attributes}
        expect(assigns(:policy)).to eq(policy)
      end
    end
  end
end
