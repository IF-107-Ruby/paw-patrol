require 'factory_bot_rails'

10.times do
  FactoryBot.create :company
end

10.times do
  FactoryBot.create :unit
end

50.times do
  FactoryBot.create :feedback
end

10.times do
  FactoryBot.create :user
end

Company.all.each do |company|
  5.times do
    FactoryBot.create(:users_companies_relationship, company: company)
  end
end
