class CompanyRegistrationsForm
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A(\+)?([ 0-9]){10,14}\z/.freeze

  include ActiveModel::Model

  attr_accessor :company_name, :description, :company_email, :phone,
                :first_name, :last_name, :user_email, :password,
                :password_confirmation

  validates :company_name, :first_name, :last_name, :user_email,
            :company_email, :password, :password_confirmation,
            presence: true

  validates :company_email, :user_email,
            format: { with: VALID_EMAIL_REGEX,
                      message: 'format is not valid' }

  validates :phone, format: { with: VALID_PHONE_REGEX,
                              message: 'is invalid: must be from 10 to 14 digits long' },
                    allow_blank: true

  validates :first_name, :last_name,
            length: { minimum: 2,
                      maximum: 50,
                      too_short: 'must have at least %<count>s characters',
                      too_long: 'must have at most %<count>s characters' }

  validates :user_email, length: { minimum: 8,
                                   maximum: 255,
                                   too_short: 'must have at least %<count>s characters',
                                   too_long: 'must have at most %<count>s characters' }

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      persist!
      true
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.message)
      false
    end
  end

  alias save! save

  private

  def persist!
    company = Company.create!(name: company_name, description: description,
                              email: company_email, phone: phone)

    company.members.create!(first_name: first_name,
                            last_name: last_name,
                            email: user_email,
                            password: password,
                            password_confirmation: password_confirmation)
  end
end
