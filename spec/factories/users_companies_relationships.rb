# == Schema Information
#
# Table name: users_companies_relationships
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  company_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :users_companies_relationship do
    user { create(:user) }
    company { create(:company) }
  end

  factory :company_owner_relationship, parent: :users_companies_relationship do
    user { create(:company_owner) }
  end

  factory :employee_relationship, parent: :users_companies_relationship do
    user { create(:employee) }
  end

  factory :staff_member_relationship, parent: :users_companies_relationship do
    user { create(:staff_member) }
  end
end
