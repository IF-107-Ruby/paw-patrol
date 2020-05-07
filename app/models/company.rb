# == Schema Information
#
# Table name: companies
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text
#  email       :string           not null
#  phone       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Company < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A\+?[1-9]\d{4,15}\z/.freeze

  has_many :units, dependent: :destroy
  has_many :users_companies_relationships, dependent: :destroy
  has_many :users, through: :users_companies_relationships
  has_many :staff, -> { where(role: 'staff_member') },
           source: :user, through: :users_companies_relationships

  validates :name, presence: { message: 'can not be blank' }
  validates :email, presence: { message: 'can not be blank' },
                    uniqueness: { case_sensitive: false }
  validates :email, format: { with: VALID_EMAIL_REGEX, message: 'format is not valid' },
                    if: ->(c) { c.email.present? }
  validates :phone, format: { with: VALID_PHONE_REGEX,
                              message: 'is invalid: must be from 4 to 15 digits long' },
                    allow_blank: true
end
