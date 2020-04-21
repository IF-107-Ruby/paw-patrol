class Unit < ApplicationRecord
  belongs_to :company
  validates :name, presence: true
  validates :company, presence: true
  has_ancestry
end
