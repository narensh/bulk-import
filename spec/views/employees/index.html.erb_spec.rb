require 'rails_helper'

RSpec.describe "employees/index", :type => :view do
  before(:each) do
    company_1 = Company.create!(name: 'A Company')
    company_2 = Company.create!(name: 'B Company')
    assign(:employees, [
        Employee.create!(
            :name => "Thor",
            :email => "thor@marvel.com",
            :phone => "1234565",
            :company => company_1
        ),
        Employee.create!(
            :name => "IronMan",
            :email => "ironman@marvel.com",
            :phone => "3434565",
            :company => company_2
        )
    ])
  end

  it "renders a list of employees" do
    render
    assert_select "tr>td", :text => "Thor".to_s, :count => 1
    assert_select "tr>td", :text => "thor@marvel.com".to_s, :count => 1
    assert_select "tr>td", :text => "1234565".to_s, :count => 1
    assert_select "tr>td", :text => "A Company", :count => 1

    assert_select "tr>td", :text => "IronMan".to_s, :count => 1
    assert_select "tr>td", :text => "ironman@marvel.com".to_s, :count => 1
    assert_select "tr>td", :text => "3434565".to_s, :count => 1
    assert_select "tr>td", :text => "B Company", :count => 1
  end
end
