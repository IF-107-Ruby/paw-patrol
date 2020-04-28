class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :unit

  has_rich_text :description

  validates :user, :unit, :description, presence: true
  validates :name, presence: true
  validates :name, length: { in: 6..50 }, if: ->(t) { t.name.present? }
end
