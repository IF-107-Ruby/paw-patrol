# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  noticeable_id   :integer          not null
#  noticeable_type :string           not null
#  user_id         :bigint           not null
#  notified_by_id  :integer          not null
#  read            :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :notification do
    association :noticeable, factory: :comment
    read { false }
    user
    notified_by { create(:user) }
  end
end
