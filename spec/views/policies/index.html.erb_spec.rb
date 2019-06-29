require 'rails_helper'

RSpec.describe "policies/index", :type => :view do
  before(:each) do
    company = Company.create!(name: 'A Company')
    assign(:policies, [
      Policy.create!(
        :name => "A Policy",
        :company => company
      ),
      Policy.create!(
        :name => "B Policy",
        :company => company
      )
    ])
  end

  it "renders a list of policies" do
    render
    assert_select "tr>td", :text => "A Policy".to_s, :count => 1
    assert_select "tr>td", :text => "B Policy".to_s, :count => 1
  end
end
