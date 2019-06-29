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

company = Company.create(name: 'Alphabet')
policies = Policy.create([
                             {name: 'Sick Leave', company_id: company.id},
                             {name: 'Annual Leave', company_id: company.id},
                              {name: 'Maternity Leave', company_id: company.id}
                         ])

employee = Employee.create(name: 'Green Arrow', email: 'green_arrow@abc.com', phone: 9999999999, company_id: company.id)

employee.policies << policies
employee.save!