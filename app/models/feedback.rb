class Feedback < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :user_full_name, presence: true
  validates :user_full_name, length: { in: 6..50 },
                             if: ->(f) { f.user_full_name.present? }
  validates :email, presence: true
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    if: ->(f) { f.email.present? }
  validates :message, presence: true, length: { maximum: 255 }

  scope :ordered_by_created_at, -> { order(created_at: :desc) }
end
