class Policy < ApplicationRecord
  belongs_to :company
  has_and_belongs_to_many :employees

  validates_uniqueness_of :name, :scope => :company_id

  def self.fetch_or_save(company_id, names)
    names.map do |name|
      Policy.find_or_create_by({name: name, company_id: company_id})
    end
  end

  def self.names_to_array(names)
    names.to_s.strip.split('|')
  end
end