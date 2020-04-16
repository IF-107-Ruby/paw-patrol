class UsersCompaniesRelationship < ApplicationRecord
  enum role: { company_owner: 0, employee: 1, staff_member: 2 }

  belongs_to :user
  belongs_to :company

  validates :role, :user, :company, presence: true
end
