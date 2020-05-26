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
#  status     :integer          default("open"), not null
#
FactoryBot.define do
  factory :ticket do
    name { Faker::Lorem.sentence(word_count: 3) }
    description { ActionText::Content.new(Faker::Lorem.paragraph) }
    status { :open }
    user
    unit

    trait :with_comments do
      after(:build) do |ticket|
        ticket.comments = build_list(:comment, 2,
                                     commentable: ticket,
                                     user: ticket.unit.users.sample)
      end
    end
  end

  factory :resolved_ticket, parent: :ticket do
    status { :resolved }

    trait :with_review do
      after(:build) do |resolved_ticket|
        resolved_ticket.review = build(:review, ticket: resolved_ticket)
      end
    end
  end
end
