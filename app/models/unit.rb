class Unit < ApplicationRecord
  belongs_to :company
  has_many :tickets, dependent: :destroy

  validates :name, presence: true
  validates :company, presence: true
  has_ancestry
end
