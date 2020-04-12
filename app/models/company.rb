class Company < ApplicationRecord
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_PHONE_REGEX = /^(\+)?([ 0-9]){10,14}$/
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validate :valid_phone_format

                    
  private

  def valid_phone_format 
    return true if phone.blank?
    errors.add(:phone, 'invalid phone number') unless phone =~ VALID_PHONE_REGEX
  end  
end
