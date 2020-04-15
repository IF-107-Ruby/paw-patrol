class Feedback < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :user_full_name, length: { in: 6..50 }, presence: true
  validates :email, length: { maximum: 255 },
                    presence: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :describe, presence: true, length: { maximum: 255 }

  scope :ordered_by_created_at, -> { order(created_at: :desc) }
end
