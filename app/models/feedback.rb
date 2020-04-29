# == Schema Information
#
# Table name: feedbacks
#
#  id             :bigint           not null, primary key
#  user_full_name :string
#  email          :string
#  message        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Feedback < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :user_full_name, length: { in: 6..50 }, presence: true
  validates :email, length: { maximum: 255 },
                    presence: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :message, presence: true, length: { maximum: 255 }

  scope :ordered_by_created_at, -> { order(created_at: :desc) }
end
