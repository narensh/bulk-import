require 'csv'
class Employee < ApplicationRecord
  include Exceptions

  belongs_to :company
  has_and_belongs_to_many :policies

  validates :name, presence: true
  validates :email, uniqueness: true

  acts_as_nested_set

  def self.import(employee_data, all_policies)
    status = ImportStatus::COMPLETED
    begin
      status = ImportStatus::MANAGER_ASSIGNMENT_PENDING unless employee_data.report_to.blank?

      @employee = Employee.new(name: employee_data.employee_name, email: employee_data.email, phone: employee_data.phone,
                               company_id: employee_data.company_id)
      @employee.policies = fetch_policies(all_policies, employee_data.assigned_policies)
      @employee.save!

    rescue ActiveRecord::RecordInvalid => e
      status = ImportStatus::ERROR
      message = e.message
    end

    employee_data.update(status: status, message: message)
    @employee
  end

  def assign_managers(manager_email)
    manager_id = Employee.find_by_email(manager_email).try(:id)

    if manager_id.nil?
      destroy
      raise Exceptions::ManagerNotFoundException
    end

    update(parent_id: manager_id)
  end

  private
  def self.fetch_policies(all_policies, employee_policy_names)
    employee_policies = []
    Policy.names_to_array(employee_policy_names).map do |employee_policy_name|
      employee_policies << all_policies.select {|p| p.name == employee_policy_name}
    end
    employee_policies.flatten!
    employee_policies
  end
end