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
#  admin                  :boolean          default(FALSE), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  role                   :integer          default("company_owner"), not null
#
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    admin { false }
    email { Faker::Internet.unique.safe_email }
    sequence(:password) { |n| "testpassword#{n}" }
    sequence(:password_confirmation) { |n| "testpassword#{n}" }
    confirmed_at { Time.zone.now }

    trait :with_avatar do
      avatar do
        Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/avatars/#{rand(0..4)}.jpg",
                                     'image/jpeg')
      end
    end

    trait :with_company do
      company
    end
  end

  trait :with_access_token do
    access_token { SecureRandom.base64 }
    access_token_enabled { true }
  end

  factory :admin, parent: :user do
    admin { true }
  end

  factory :company_owner, parent: :user do
    role { :company_owner }
  end

  factory :employee, parent: :user do
    role { :employee }
  end

  factory :staff_member, parent: :user do
    role { :staff_member }
  end
end
