class Ticket < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true, length: { in: 6..50 }
end
