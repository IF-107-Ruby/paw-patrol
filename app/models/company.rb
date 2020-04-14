class Company < ApplicationRecord
  validates :name, presence: { message: 'can not be blank' }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A(\+)?([ 0-9]){10,14}\z/.freeze
  validates :email, presence: { message: 'can not be blank' },
                    format: { with: VALID_EMAIL_REGEX, message: 'format is not valid' },
                    uniqueness: { case_sensitive: false }
  validates :phone, format: { with: VALID_PHONE_REGEX,
                              message: 'is invalid: must be between 10 -
                    15 digits long' },
                    allow_blank: true
end
