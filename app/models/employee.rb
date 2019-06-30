require 'csv'
class Employee < ApplicationRecord
  include Exceptions

  belongs_to :company
  has_and_belongs_to_many :policies


  validates :name, presence: true
  validates :email, uniqueness: true

  acts_as_nested_set

  def assign_manager(manager_email)
    manager = Employee.find_by_email(manager_email)

    raise Exceptions::ManagerNotFoundException if manager.blank?

    move_to_child_of(manager)
  end
end