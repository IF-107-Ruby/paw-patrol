# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  commentable_id   :integer          not null
#  commentable_type :string           not null
#  body             :text             not null
#  user_id          :bigint           not null
#  ancestry         :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :comment do
    association :commentable, factory: :ticket
    body { Faker::Lorem.sentence(word_count: 3) }
    user
  end
end
