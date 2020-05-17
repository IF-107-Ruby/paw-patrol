module CompanyValidations
  extend ActiveSupport::Concern

  included do
    validates :name, :email, presence: { message: 'can not be blank' }

    validates :phone, length: 6..20,
                      format: { with: /\A(\+)?[0-9]*\z/,
                                message: 'is invalid: must be from 6 to 20 digits long' },
                      allow_blank: true

    validates :email,
              length: { minimum: 8,
                        maximum: 255,
                        too_short: 'must have at least %<count>s characters',
                        too_long: 'must have at most %<count>s characters' },
              email: true
  end
end
