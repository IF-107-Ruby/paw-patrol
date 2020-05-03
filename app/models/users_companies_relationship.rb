# == Schema Information
#
# Table name: users_companies_relationships
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  company_id :bigint           not null
#  role       :integer          default("company_owner"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UsersCompaniesRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :company

  validates :user, :company, presence: true
end
