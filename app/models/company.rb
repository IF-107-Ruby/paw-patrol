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
  include CompanyValidations

  has_many :units, dependent: :destroy
  has_many :users_companies_relationships, dependent: :destroy
  has_many :users, through: :users_companies_relationships
  has_many :staff, -> { where(role: 'staff_member') },
           source: :user, through: :users_companies_relationships
end
