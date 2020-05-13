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

FactoryBot.create_list(:company_owner, 5, :with_company)

Company.all.each do |company|
  FactoryBot.create_list(:unit,
                         10,
                         :with_parent,
                         :with_responsible_user,
                         :with_children,
                         :with_employees_and_tickets,
                         company: company)
end

FactoryBot.create_list(:feedback, 50)
