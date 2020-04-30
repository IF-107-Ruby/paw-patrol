FactoryBot.define do
  factory :users_units_relationship do
    user { create(:user) }
    unit { create(:unit) }
  end
end
