class Unit < ApplicationRecord
  belongs_to :company
  validates :name, presence: true
  validates :company_id, presence: true
end
