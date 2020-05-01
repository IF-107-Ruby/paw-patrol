# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  first_name             :string
#  last_name              :string
#  email                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_admin               :boolean          default(FALSE), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    is_admin { false }
    email { Faker::Internet.safe_email }
    sequence(:password) { |n| "testpassword#{n}" }
    sequence(:password_confirmation) { |n| "testpassword#{n}" }
  end

  factory :admin, parent: :user do
    is_admin { true }
  end

  factory :company_owner, parent: :user do
    role { 0 }
  end

  factory :employee, parent: :user do
    role { 1 }
  end

  factory :staff_member, parent: :user do
    role { 2 }
  end
end
