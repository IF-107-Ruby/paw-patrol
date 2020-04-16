require 'factory_bot_rails'

10.times do
  FactoryBot.create :company
end

Company.all.each do |company|
  5.times do
    FactoryBot.create(:unit, company: company)
  end
end
