class Ticket < ApplicationRecord
  belongs_to :user

  has_rich_text :description

  validates :user, :description, presence: true
  validates :name, presence: true, length: { in: 6..50 }
end
