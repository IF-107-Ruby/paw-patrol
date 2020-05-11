FactoryBot.define do
  factory :comment do
    association :commentable, factory: :ticket
    body { Faker::Lorem.sentence(word_count: 3) }
    user
  end
end
