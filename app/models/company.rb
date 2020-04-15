class Company < ApplicationRecord
  has_many :units, dependent: :destroy
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A(\+)?([ 0-9]){10,14}\z/.freeze
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :phone, format: { with: VALID_PHONE_REGEX }, allow_blank: true
end
