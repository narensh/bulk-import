class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employees = Employee.all
  end

  def show
  end

  def new
    @employee = Employee.new
  end

  def edit
  end

  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html {redirect_to @employee, notice: 'Employee was successfully created.'}
        format.json {render :show, status: :created, location: @employee}
      else
        format.html {render :new}
        format.json {render json: @employee.errors, status: :unprocessable_entity}
      end
    end
  end

  def import_show
    Employee.import(params[:file])
  end

  def import
    Employee.import(params[:file])
  end

  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html {redirect_to @employee, notice: 'Employee was successfully updated.'}
        format.json {render :show, status: :ok, location: @employee}
      else
        format.html {render :edit}
        format.json {render json: @employee.errors, status: :unprocessable_entity}
      end
    end
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:name, :email, :phone, :company_id)
  end
end
