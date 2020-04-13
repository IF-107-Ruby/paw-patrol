class Feedback < ApplicationRecord
  before_save :downcase_email

  validates :user_full_name, length: { in: 6..50 }, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, length: { maximum: 255 },
                    presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :describe, presence: true, length: { maximum: 255 }

  default_scope { order(created_at: :desc) }

  private

  def downcase_email
    email.downcase!
  end
end
