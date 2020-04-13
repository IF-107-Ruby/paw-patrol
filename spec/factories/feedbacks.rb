FactoryBot.define do
  factory :feedback do
    user_full_name { Faker::Internet.username(specifier: 6..50) }
    email { Faker::Internet.safe_email }
    describe { Faker::Lorem.paragraph(sentence_count: 4) }
  end
end
