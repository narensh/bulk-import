class Company < ApplicationRecord
  has_many :employees

  validates :name, presence: true

  def to_s
    name
  end
end
