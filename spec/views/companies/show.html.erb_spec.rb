require 'rails_helper'

RSpec.describe "companies/show", :type => :view do
  before(:each) do
    @company = assign(:company, Company.create!(
      :name => "Google"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Google/)
  end
end
