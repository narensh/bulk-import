require 'rails_helper'

RSpec.describe CompaniesController, :type => :controller do

  let(:valid_attributes) {{name: 'A Company'}}

  let(:invalid_attributes) {{name: 123454}}

  describe "GET index" do
    it "assigns all companies as @companies" do
      company = Company.create! valid_attributes
      get :index, params: {}
      expect(assigns(:companies)).to eq([company])
    end
  end

  describe "GET show" do
    it "assigns the requested company as @company" do
      company = Company.create!(valid_attributes)
      get :show, params: {id: company.to_param}
      expect(assigns(:company)).to eq(company)
    end
  end

  describe "GET new" do
    it "assigns a new company as @company" do
      get :new, params: {}
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe "GET edit" do
    it "assigns the requested company as @company" do
      company = Company.create! valid_attributes
      get :edit, params: {:id => company.to_param}
      expect(assigns(:company)).to eq(company)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Company" do
        expect {
          post :create, params: {:company => valid_attributes}
        }.to change(Company, :count).by(1)
      end

      it "assigns a newly created company as @company" do
        post :create, params: {:company => valid_attributes}
        expect(assigns(:company)).to be_a(Company)
        expect(assigns(:company)).to be_persisted
      end

      it "redirects to the created company" do
        post :create, params: {:company => valid_attributes}
        expect(response).to redirect_to(Company.last)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {{name: 'B Company'}}

      it "updates the requested company" do
        company = Company.create! valid_attributes
        put :update, params: {:id => company.to_param, :company => new_attributes}
        company.reload
        expect(company.name).to eq('B Company')
      end

      it "assigns the requested company as @company" do
        company = Company.create! valid_attributes
        put :update, params: {:id => company.to_param, :company => valid_attributes}
        expect(assigns(:company)).to eq(company)
      end

      it "redirects to the company" do
        company = Company.create! valid_attributes
        put :update, params: {:id => company.to_param, :company => valid_attributes}
        expect(response).to redirect_to(company)
      end
    end

    describe "with invalid params" do
      it "assigns the company as @company" do
        company = Company.create! valid_attributes
        put :update, params: {:id => company.to_param, :company => invalid_attributes}
        expect(assigns(:company)).to eq(company)
      end
    end
  end
end
