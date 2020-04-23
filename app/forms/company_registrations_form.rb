class CompanyRegistrationsForm
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A(\+)?([ 0-9]){10,14}\z/.freeze

  include ActiveModel::Model

  attr_accessor :name, :description, :company_email, :phone,
                :first_name, :last_name, :user_email, :password,
                :password_confirmation, :success

  validates :name, presence: { message: 'can not be blank' }
  validates :company_email, presence: { message: 'can not be blank' }
  # uniqueness: { case_sensitive: false }
  validates :company_email, format: { with: VALID_EMAIL_REGEX,
                                      message: 'format is not valid' },
                            if: ->(c) { c.company_email.present? }
  validates :phone, format: { with: VALID_PHONE_REGEX,
                              message: 'is invalid: must be from 10 to 14 digits long' },
                    allow_blank: true

  validates :first_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :user_email, presence: true, length: { minimum: 8, maximum: 255 },
                         format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true
  validates :password_confirmation, presence: true

  def save
    ActiveRecord::Base.transaction do
      if valid?
        persist!
        @success = true
      else
        @success = false
      end
    rescue ActiveRecord::StatementInvalid => e
      errors.add(:base, e.message)
      @success = false
    end
  end

  private

  def persist!
    company = Company.create!(name: name,
                              description: description,
                              email: company_email,
                              phone: phone)

    user = User.create!(first_name: first_name,
                        last_name: last_name,
                        email: user_email,
                        password: password,
                        password_confirmation: password_confirmation)

    user.create_users_companies_relationship(user: user,
                                             company: company,
                                             role: 0)
  end
end
