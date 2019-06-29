require 'rails_helper'

RSpec.describe "companies/index", :type => :view do
  before(:each) do
    assign(:companies, [
      Company.create!(
        :name => "A Company"
      ),
      Company.create!(
        :name => "B Company"
      )
    ])
  end

  it "renders a list of companies" do
    render
    assert_select "tr>td", :text => "A Company".to_s, :count => 1
    assert_select "tr>td", :text => "B Company".to_s, :count => 1
  end
end
