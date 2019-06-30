# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# Sick Leave|Annual Leave|Maternity Leave

return unless Rails.env == 'development'

company = Company.create(name: 'DC Comics')
policies = Policy.create([
                             {name: 'Sick Leave', company_id: company.id},
                             {name: 'Annual Leave', company_id: company.id},
                             {name: 'Paternity Leave', company_id: company.id}
                         ])

employee = Employee.create(name: 'Green Arrow', email: 'green_arrow@dc.com', phone: 9999999999, company_id: company.id)
employee.policies << policies.first
employee.save!

employee = Employee.create(name: 'Superman', email: 'superman@dc.com', phone: 9999999900, company_id: company.id)
employee.policies << policies.second
employee.save!

employee = Employee.create(name: 'Batman', email: 'i_am_batman@dc.com', phone: 9999999988, company_id: company.id)
employee.policies << policies
employee.save!