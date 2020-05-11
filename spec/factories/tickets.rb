# == Schema Information
#
# Table name: tickets
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  user_id    :bigint           not null
#  unit_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :ticket do
    name { Faker::Lorem.sentence(word_count: 3) }
    description { ActionText::Content.new(Faker::Lorem.paragraph) }
    user
    unit

    trait :with_comments do
      after(:build) do |ticket|
        ticket.comments = build_list(:comment, 5, commentable: ticket)
      end
    end
  end
end
