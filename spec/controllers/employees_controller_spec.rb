require 'rails_helper'

RSpec.describe EmployeesController, :type => :controller do

  before {warden.set_user User.create(email: 'Thor', password: 'password', password_confirmation: 'password')}

  let(:company) {Company.create!(name: 'A Company')}
  let(:valid_attributes) {{name: 'Green Arrow', email: 'green_arrow@abc.com', phone: 9999999999, company_id: company.id}}

  let(:invalid_attributes) {
    {name: 'foo bar', email: 'invalid@abc.com', phone: '9999999999', company_id: 9999}}

  describe "GET index" do
    it "assigns all employees as @employees" do
      employee = Employee.create! valid_attributes
      get :index, params: {}
      expect(assigns(:employees)).to eq([employee])
    end
  end

  describe "GET show" do
    it "assigns the requested employee as @employee" do
      employee = Employee.create! valid_attributes
      get :show, params: {:id => employee.to_param}
      expect(assigns(:employee)).to eq(employee)
    end
  end

  describe "GET new" do
    it "assigns a new employee as @employee" do
      get :new, params: {}
      expect(assigns(:employee)).to be_a_new(Employee)
    end
  end

  describe "GET edit" do
    it "assigns the requested employee as @employee" do
      employee = Employee.create! valid_attributes
      get :edit, params: {:id => employee.to_param}
      expect(assigns(:employee)).to eq(employee)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Employee" do
        expect {
          post :create, params: {:employee => valid_attributes}
        }.to change(Employee, :count).by(1)
      end

      it "assigns a newly created employee as @employee" do
        post :create, params: {:employee => valid_attributes}
        expect(assigns(:employee)).to be_a(Employee)
        expect(assigns(:employee)).to be_persisted
      end

      it "redirects to the created employee" do
        post :create, params: {:employee => valid_attributes}
        expect(response).to redirect_to(Employee.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved employee as @employee" do
        post :create, params: {:employee => invalid_attributes}
        expect(assigns(:employee)).to be_a_new(Employee)
      end

      it "re-renders the 'new' template" do
        post :create, params: {:employee => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {name: 'The Flash', email: 'flash@abc.com', phone: 8889999999, company_id: company.id}
      }

      it "updates the requested employee" do
        employee = Employee.create! valid_attributes
        put :update, params: {:id => employee.to_param, :employee => new_attributes}
        employee.reload
        expect(employee.name).to eq('The Flash')
        expect(employee.email).to eq('flash@abc.com')
        expect(employee.phone).to eq('8889999999')
        expect(employee.company_id).to eq(company.id)
      end

      it "assigns the requested employee as @employee" do
        employee = Employee.create! valid_attributes
        put :update, params: {:id => employee.to_param, :employee => valid_attributes}
        expect(assigns(:employee)).to eq(employee)
      end

      it "redirects to the employee" do
        employee = Employee.create! valid_attributes
        put :update, params: {:id => employee.to_param, :employee => valid_attributes}
        expect(response).to redirect_to(employee)
      end
    end

    describe "with invalid params" do
      it "assigns the employee as @employee" do
        employee = Employee.create! valid_attributes
        put :update, params: {:id => employee.to_param, :employee => invalid_attributes}
        expect(assigns(:employee)).to eq(employee)
      end

      it "re-renders the 'edit' template" do
        employee = Employee.create! valid_attributes
        put :update, params: {:id => employee.to_param, :employee => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end
end
