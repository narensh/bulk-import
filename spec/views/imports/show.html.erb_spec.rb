require 'rails_helper'

RSpec.describe "imports/show", :type => :view do
  before(:each) do
    company = Company.create!(name: 'Asgard')
    import_attributes = {request_id: 'dummy_request_id_1', employee_name: 'Thor Odinson', email: 'thor@marvel.com',
                     phone: 123454789, report_to: 'odinson@marvel', assigned_policies: 'Lightening Leave',
                     company_id: company.id, file_name: 'asgard.csv'}
    @imports = assign(:import, Import.create!([import_attributes]))
  end

  it "renders attributes in <p>" do
    render

    assert_select 'tr>td', :text => 'Thor Odinson', :count => 1
    assert_select 'tr>td', :text => 'thor@marvel.com', :count => 1
    assert_select 'tr>td', :text => '123454789', :count => 1
    assert_select 'tr>td', :text => 'odinson@marvel', :count => 1
    assert_select 'tr>td', :text => 'Lightening Leave', :count => 1
    assert_select 'tr>td', :text => 'Asgard', :count => 1
    assert_select 'tr>td', :text => @imports.first.updated_at.to_s, :count => 1
    assert_select 'tr>td', :text => 'NOT_STARTED', :count => 1
  end
end
