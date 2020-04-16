class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  has_one :users_companies_relationship, dependent: :destroy
  has_one :company, through: :users_companies_relationship

  validates :first_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, length: { minimum: 8, maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
end
