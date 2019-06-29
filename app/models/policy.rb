class Policy < ApplicationRecord
  belongs_to :company
  has_and_belongs_to_many :employees

  validates_uniqueness_of :name, :scope => :company_id
end