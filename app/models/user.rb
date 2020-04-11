class User < ApplicationRecord
  validates :first_name, presence: true, length: {minimum:3, maximum:50}
  validates :last_name, presence: true, length: {minimum:3, maximum:50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {minimum:8, maximum:255}, 
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :is_admin, presence: true
end
