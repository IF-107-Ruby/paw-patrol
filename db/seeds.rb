require 'factory_bot_rails'

10.times do
  FactoryBot.create :company
end

10.times do |n|
  name = "test_unit_#{n}"
  Unit.create(name: name)
end

