require 'factory_bot_rails'

10.times do
  FactoryBot.create :company
end

50.times do
  FactoryBot.create(:feedback)
end
