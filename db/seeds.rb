require 'factory_bot_rails'

10.times do
  FactoryBot.create(:company_with_units, units_count: 6).units.length
end
