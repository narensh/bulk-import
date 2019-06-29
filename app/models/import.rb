require 'csv'
class Import < ApplicationRecord
  validates :request_id, presence: true
end