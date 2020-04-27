# == Schema Information
#
# Table name: feedbacks
#
#  id             :bigint           not null, primary key
#  user_full_name :string
#  email          :string
#  message        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :feedback do
    user_full_name { Faker::Internet.username(specifier: 6..50) }
    email { Faker::Internet.safe_email }
    describe { Faker::Lorem.paragraph(sentence_count: 4) }
  end
end
