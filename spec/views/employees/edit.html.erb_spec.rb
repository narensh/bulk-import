require 'rails_helper'

RSpec.describe "employees/edit", :type => :view do
  before(:each) do
    company = Company.create!(name: 'A Company')
    @employee = assign(:employee, Employee.create!(
        :name => "A Employee",
        :email => "a@company.com",
        :phone => "1234354",
        :company => company
    ))
  end

  it "renders the edit employee form" do
    render

    assert_select "form[action=?][method=?]", employee_path(@employee), "post" do

      assert_select "input#employee_name[name=?]", "employee[name]"

      assert_select "input#employee_email[name=?]", "employee[email]"

      assert_select "input#employee_phone[name=?]", "employee[phone]"

      assert_select "input#employee_company_id[name=?]", "employee[company_id]"
    end
  end
end
