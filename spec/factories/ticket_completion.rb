FactoryBot.define do
  factory :ticket_completion do
    description { ActionText::Content.new(Faker::Lorem.paragraph) }
    user
    ticket
  end
end
