require 'rails_helper'

RSpec.describe "imports/index", :type => :view do
  before(:each) do
    company_1 = Company.create!(name: 'Asgard')
    company_2 = Company.create!(name: 'Avenger')
    import_params_1 = {request_id: 'dummy_request_id_1', employee_name: 'Thor Odinson', email: 'thor@marvel.com',
                       phone: 123454789, report_to: 'odinson@marvel', assigned_policies: 'Lightening Leave',
                       company_id: company_1.id, file_name: 'asgard.csv'}
    import_params_2 = {request_id: 'dummy_request_id_2', employee_name: 'Iron Man', email: 'ironman@marvel.com',
                       phone: 21232343, report_to: 'nick_fury@marvel', assigned_policies: 'Jarvis',
                       company_id: company_2.id, file_name: 'avengers.csv'}

    assign(:imports, Import.create!([import_params_1, import_params_2]))
  end

  it "renders a list of imports" do
    render

    assert_select "tr>td", :text => "asgard.csv", :count => 1
    assert_select "tr>td", :text => "avengers.csv", :count => 1

    assert_select "tr>td", :text => "NOT_STARTED", :count => 2
    assert_select "tr>td", :text => "Details", :count => 2
  end
end
