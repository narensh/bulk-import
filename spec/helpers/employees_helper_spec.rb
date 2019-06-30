require 'rails_helper'

RSpec.describe EmployeesHelper, :type => :helper do

  context :create_employee do
    it 'should create employee' do
      company = Company.create!(name: 'Marvel')
      employee_data = double('Employee Data', request_id: 'dummy_request_id', employee_name: 'Thor Odinson', email: 'thor@marvel.com',
                       phone: "123454789", report_to: 'odinson@marvel', assigned_policies: 'Lightening Leave|Winter Leave',
                       company_id: company.id, file_name: 'marvels.csv')
      all_policies = Policy.create!([{name: 'Lightening Leave', company: company},
                                     {name: 'Annual Leave', company: company},
                                     {name: 'Winter Leave', company: company}])

      employee = EmployeesHelper.create_employee(company, employee_data, all_policies)

      expect(employee).to be_persisted
      expect(employee.name).to eq(employee_data.employee_name)
      expect(employee.email).to eq(employee_data.email)
      expect(employee.phone).to eq(employee_data.phone)
      expect(employee.company).to eq(company)
      expect(employee.policies.map(&:name)).to eq(['Lightening Leave','Winter Leave'])
    end
  end
end