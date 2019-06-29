require 'rails_helper'

RSpec.describe PoliciesHelper, :type => :helper do

  context :fetch_or_persist do
    let(:company) {Company.create!(name: 'A Company')}
    let(:existing_policy_name) {'existing policy'}
    let(:new_policy_name) {'New_Policy'}

    before {Policy.create!(name: existing_policy_name, company: company)}

    context 'new policy' do
      it 'should save the policy' do
        expect {PoliciesHelper.fetch_or_persist(company.id, [new_policy_name])}.to change(Policy, :count).by(1)
      end
    end

    context 'existing policy' do
      it 'should not create another policy' do
        expect {PoliciesHelper.fetch_or_persist(company.id, [existing_policy_name])}.to_not change(Policy, :count)
      end
    end

    context 'fetch policies' do
      it 'should fetch the new and existing policies' do
        policies = PoliciesHelper.fetch_or_persist(company.id, [existing_policy_name, new_policy_name])

        expect(policies.count).to eq(2)
        expect(policies.map(&:name)).to eq([existing_policy_name, new_policy_name])
        expect(policies.map(&:company_id).uniq).to eq ([company.id])
      end
    end
  end

  context :names_to_array do
    it 'should translate pipe separated names to array' do
      policy_names = PoliciesHelper.names_to_array('Thor|Hulk')

      expect(policy_names).to match_array(['Thor', 'Hulk'])
    end

    context 'when nil is given' do
      it 'should return empty array' do
        expect(PoliciesHelper.names_to_array(nil)).to eq([])
      end
    end

    context 'when empty string is given' do
      it 'should return empty array' do
        expect(PoliciesHelper.names_to_array("")).to eq([])
      end
    end
  end

  context :fetch_policies do
    skip('add spec for fetch policies')
  end
end