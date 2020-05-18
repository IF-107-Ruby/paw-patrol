FactoryBot.define do
  factory :notification do
    association :noticeable, factory: :comment
    read { false }
    user
    notified_by { create(:user) }
  end
end
