require 'rails_helper'
include Exceptions
RSpec.describe Employee, :type => :model do
  let(:company) {Company.create!(name: 'A Company')}
  let(:manager) {Employee.create!({name: 'Nick Fury', email: 'nick_fury@marvel.com', phone: 88888888, company_id: company.id})}
  let(:employee) {Employee.create!({name: 'Hawkeye', email: 'hawekey@marvel.com', phone: 9999999999, company_id: company.id})}

  it {should validate_presence_of(:name)}

  it {should validate_uniqueness_of(:email)}

  it {should belong_to(:company)}

  it {should have_and_belong_to_many(:policies)}

  context '#act_as_nested_set' do
    it 'should act as nested set' do
      employee.move_to_child_of(manager)

      expect(employee.parent.id).to eq(manager.id)
      expect(manager.children.map(&:id)).to eq([employee.id])
    end
  end

  context :assign_manager do
    context 'when manager is present in the system' do
      it 'should assign the manager for the given employee' do
        employee.assign_manager(manager.email)

        expect(employee.parent.id).to eq(manager.id)
      end
    end

    context 'when manager is not present in the system' do
      it 'should raise error' do
        expect {employee.assign_manager('i_dont_exist@marvel.com')}
            .to raise_error(ManagerNotFoundException)
      end
    end
  end
end
