class CompanyRegistrationsForm
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A(\+)?([ 0-9]){10,14}\z/.freeze

  include ActiveModel::Model

  attr_accessor :name, :description, :company_email, :phone,
                :first_name, :last_name, :user_email, :password,
                :password_confirmation

  validates :name, presence: { message: 'can not be blank' }
  validates :company_email, presence: { message: 'can not be blank' }
  validates :company_email, format: { with: VALID_EMAIL_REGEX,
                                      message: 'format is not valid' },
                            if: ->(c) { c.company_email.present? }
  validates :phone, format: { with: VALID_PHONE_REGEX,
                              message: 'is invalid: must be from 10 to 14 digits long' },
                    allow_blank: true

  validates :first_name, presence: { message: 'can not be blank' }
  validates :first_name,
            length: { minimum: 3,
                      maximum: 50,
                      too_short: 'must have at least %<count>s characters',
                      too_long: 'must have at most %<count>s characters' },
            if: ->(c) { c.first_name.present? }

  validates :last_name, presence: { message: 'can not be blank' }
  validates :last_name,
            length: { minimum: 3,
                      maximum: 50,
                      too_short: 'must have at least %<count>s characters',
                      too_long: 'must have at most %<count>s characters' },
            if: ->(c) { c.last_name.present? }

  validates :user_email, presence: { message: 'can not be blank' }
  validates :user_email, length: { minimum: 8,
                                   maximum: 255,
                                   too_short: 'must have at least %<count>s characters',
                                   too_long: 'must have at most %<count>s characters' },
                         if: ->(c) { c.user_email.present? }

  validates :user_email, format: { with: VALID_EMAIL_REGEX, message: 'is invalid' },
                         if: ->(c) { c.user_email.present? }

  validates :password, presence: { message: 'can not be blank' }
  validates :password_confirmation, presence: { message: 'can not be blank' }

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      persist!
    rescue ActiveRecord::StatementInvalid => e
      errors.add(:base, e.message)
      false
    end
  end

  alias save! save

  private

  def persist!
    company = Company.create!(name: name, description: description,
                              email: company_email, phone: phone)

    company.users.create(first_name: first_name,
                         last_name: last_name,
                         email: user_email,
                         password: password,
                         password_confirmation: password_confirmation)
    company
  end
end
