require 'factory_bot_rails'
if User.count == 0
  FactoryBot.create(:admin,
                    email: 'patrol.admin@gmail.com',
                    password: '123456',
                    password_confirmation: '123456')

  FactoryBot.create(:user,
                    email: 'patrol.user@gmail.com',
                    password: '123456',
                    password_confirmation: '123456')

  10.times do
    FactoryBot.create :user
  end
end

10.times do
  FactoryBot.create(:company_with_units, units_count: 6)
end

50.times do
  FactoryBot.create :feedback
end

Company.all.each do |company|
  5.times do
    FactoryBot.create(:employee, company: company)
  end

  3.times do
    FactoryBot.create(:staff_member, company: company)
  end
end
