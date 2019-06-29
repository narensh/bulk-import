require 'rails_helper'

RSpec.describe Policy, :type => :model do
  it {should validate_uniqueness_of(:name).scoped_to(:company_id)}

  it {should have_and_belong_to_many(:employees)}

  it {should belong_to(:company)}

  context :fetch_or_save do
    let(:company) {Company.create!(name: 'A Company')}
    let(:existing_policy_name) {'existing policy'}
    let(:new_policy_name) {'New_Policy'}

    before {Policy.create!(name: existing_policy_name, company: company)}

    context 'new policy' do
      it 'should save the policy' do
        expect {Policy.fetch_or_save(company.id, [new_policy_name])}.to change(Policy, :count).by(1)
      end
    end

    context 'existing policy' do
      it 'should not create another policy' do
        expect {Policy.fetch_or_save(company.id, [existing_policy_name])}.to_not change(Policy, :count)
      end
    end

    context 'fetch policies' do
      it 'should fetch the new and existing policies' do
        policies = Policy.fetch_or_save(company.id, [existing_policy_name, new_policy_name])

        expect(policies.count).to eq(2)
        expect(policies.map(&:name)).to eq([existing_policy_name, new_policy_name])
        expect(policies.map(&:company_id).uniq).to eq ([company.id])
      end
    end
  end

  context :names_to_array do
    it 'should translate pipe separated names to array' do
      policy_names = Policy.names_to_array('Thor|Hulk')

      expect(policy_names).to match_array(['Thor', 'Hulk'])
    end

    context 'when nil is given' do
      it 'should return empty array' do
        expect(Policy.names_to_array(nil)).to eq([])
      end
    end

    context 'when empty string is given' do
      it 'should return empty array' do
        expect(Policy.names_to_array("")).to eq([])
      end
    end
  end
end
