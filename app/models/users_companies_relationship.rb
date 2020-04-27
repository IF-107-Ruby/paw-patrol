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
  enum role: { company_owner: 0, employee: 1, staff_member: 2 }

  belongs_to :user
  belongs_to :company

  validates :role, :user, :company, presence: true
end
