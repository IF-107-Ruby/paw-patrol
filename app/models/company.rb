class Company < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A(\+)?([ 0-9]){10,14}\z/.freeze

  has_many :units, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :phone, format: { with: VALID_PHONE_REGEX }, allow_blank: true
end
