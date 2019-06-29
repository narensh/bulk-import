require 'rails_helper'

RSpec.describe "policies/show", :type => :view do
  before(:each) do
    company = Company.create!(name: 'A Company')
    @policy = assign(:policy, Policy.create!(
      :name => "A Policy",
      :company => company
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/A Policy/)
    expect(rendered).to match(/A Company/)
  end
end
