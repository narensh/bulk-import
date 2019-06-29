require 'rails_helper'

RSpec.describe Policy, :type => :model do
  it {should validate_uniqueness_of(:name).scoped_to(:company_id)}

  it {should have_and_belong_to_many(:employees)}

  it {should belong_to(:company)}
end
