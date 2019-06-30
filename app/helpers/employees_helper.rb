module EmployeesHelper

  def self.create_employee(company, employee_data, all_policies)
    @employee = Employee.new(name: employee_data.employee_name, email: employee_data.email, phone: employee_data.phone,
                             company: company)
    @employee.policies = PoliciesHelper.fetch_policies(all_policies, employee_data.assigned_policies)
    @employee.save!
    @employee
  end
end