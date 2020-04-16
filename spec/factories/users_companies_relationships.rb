FactoryBot.define do
  factory :users_companies_relationship do
    user { create(:user) }
    company { create(:company) }
    role { rand(0..2) }
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
