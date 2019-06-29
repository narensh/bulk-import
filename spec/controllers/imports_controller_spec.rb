require 'rails_helper'
include ActionDispatch::Http
RSpec.describe ImportsController, :type => :controller do

  let(:file) {
    fixture_file_upload("spec/fixtures/valid_sample.csv")
  }

  let(:invalid_file) {
    fixture_file_upload("spec/fixtures/invalid_sample.csv")
  }

  let(:uuid) { 'some_uuid_id'}

  let(:valid_attributes) {
    {request_id: 'dummy_request_id', employee_name: 'Thor Odinson', email: 'thor@marvel.com',
     phone: 123454789,
     report_to: 'odinson@marvel', assigned_policies: 'Lightening Leave', company_id: 1,
     file_name: 'marvels.csv'}
  }

  let(:valid_import_params) {{company_id: 1, file: file}}

  let(:invalid_import_params) {{file: invalid_file}}


  let(:invalid_attributes) {
    {employee_name: 'Thor Odinson', email: 'thor@marvel.com',
     phone: 123454789,
     report_to: 'odinson@marvel.com', assigned_policies: 'Lightening Leave', company_id: 1,
     file_name: 'marvels.csv'}
  }

  describe "GET index" do
    it "assigns all imports as @imports" do
      import = Import.create! valid_attributes
      get :index, params: {}
      expect(assigns(:imports)).to eq([import])
    end
  end

  describe "GET show" do
    it "assigns the requested import as @import" do
      import = Import.create! valid_attributes
      get :show, params: {:request_id => import.request_id}
      expect(assigns(:imports)).to eq([import])
    end
  end

  describe "GET new" do
    it "assigns a new import as @import" do
      get :new, params: {}
      expect(assigns(:import)).to be_a_new(Import)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before(:each) {allow_any_instance_of(ActionController::TestRequest).to receive(:uuid).and_return(uuid)}
      it "creates a new Import" do
        expect {
          post :create, params: {:import => valid_import_params}
        }.to change(Import, :count).by(3)
      end

      it "assigns a newly created imports as @imports" do
        post :create, params: {:import => valid_import_params}
        expect(assigns(:imports)).to be_all(Import)
        expect(assigns(:imports)).to eq(Import.all)
      end
    end

    describe "with invalid params" do
      before(:each) {allow_any_instance_of(ActionController::TestRequest).to receive(:uuid).and_return(nil)}
      it "assigns a newly created but unsaved imports as @imports" do
        post :create, params: {:import => invalid_import_params}
        new_import = Import.new({employee_name: 'Bob', email: 'bob@example.com', phone: 81231231,
                      report_to: 'email_not_present@example.com', assigned_policies: 'Sick Leave',
                      company_id: nil, file_name: 'invalid_sample.csv'})
        expect(assigns(:imports).count).to eq(1)
        expect(assigns(:imports).first.attributes).to eq(new_import.attributes)
      end
    end
  end
end
