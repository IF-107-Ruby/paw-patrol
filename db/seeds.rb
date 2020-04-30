require 'factory_bot_rails'

if User.count.zero?
  FactoryBot.create(:admin,
                    email: 'patrol.admin@gmail.com',
                    password: '123456',
                    password_confirmation: '123456')

  user_company = FactoryBot.create(:company_with_units, units_count: 6)

  FactoryBot.create(:company_owner, company: user_company,
                                    email: 'patrol.user@gmail.com',
                                    password: '123456',
                                    password_confirmation: '123456')
end

10.times do
  FactoryBot.create(:company_owner, :with_company)
end

50.times do
  FactoryBot.create :feedback
end

Company.all.each do |company|
  5.times do
    FactoryBot.create(:employee, company: company)
  end

  10.times do
    FactoryBot.create(:unit, :with_children, company: company)
  end

  3.times do
    FactoryBot.create(:staff_member, company: company)
  end
end

Unit.all.each do |unit|
  10.times do
    FactoryBot.create(:user, unit: unit)
  end
end
