class Unit < ApplicationRecord
  validates :name, presence: true
  has_ancestry
end
