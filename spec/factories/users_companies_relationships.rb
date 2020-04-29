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
FactoryBot.define do
  factory :users_companies_relationship do
    user { create(:user) }
    company { create(:company) }
    role { 1 }
  end

  factory :company_owner, parent: :users_companies_relationship do
    role { 0 }
  end

  factory :employee, parent: :users_companies_relationship do
    role { 1 }
  end

  factory :staff_member, parent: :users_companies_relationship do
    role { 2 }
  end
end
