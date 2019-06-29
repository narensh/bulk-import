require 'rails_helper'

RSpec.describe "employees/show", :type => :view do
  before(:each) do
    company = Company.create!(name: 'A Company')
    @employee = assign(:employee, Employee.create!(
        :name => "Thor",
        :email => "thor@marvel.com",
        :phone => "1234565",
        :company => company
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Thor/)
    expect(rendered).to match(/thor@marvel.com/)
    expect(rendered).to match(/1234565/)
    expect(rendered).to match(/A Company/)
  end
end
