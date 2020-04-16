FactoryBot.define do
  factory :unit do
    sequence(:name) { |n| "unit_#{n}" }
    qr_link { 'TEST_QR_LINK' }
    company { create(:company) }
  end
end
