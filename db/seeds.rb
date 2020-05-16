FactoryBot.create(:admin,
                  email: 'patrol.admin@gmail.com',
                  password: '123456',
                  password_confirmation: '123456')

FactoryBot.create(:company_owner, :with_company,
                  email: 'patrol.user@gmail.com',
                  password: '123456',
                  password_confirmation: '123456')

Company.all.each do |company|
  FactoryBot.create_list(:unit,
                         5,
                         :with_parent,
                         :with_responsible_user,
                         :with_children,
                         :with_employees_and_tickets,
                         company: company)
end

FactoryBot.create_list(:feedback, 50)
