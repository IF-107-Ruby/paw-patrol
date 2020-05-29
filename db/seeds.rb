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

  company.units.joins(:responsible_user).each do |unit|
    FactoryBot.create_list(:event, 10, unit: unit, user: unit.responsible_user)
    FactoryBot.create_list(:event, 3, :weekly, unit: unit, user: unit.responsible_user)
    FactoryBot.create_list(:event, 3, :biweekly, unit: unit, user: unit.responsible_user)
    FactoryBot.create_list(:event, 5, :monthly, unit: unit, user: unit.responsible_user)
    FactoryBot.create_list(:event, 10, :annually, unit: unit, user: unit.responsible_user)
  end
end

FactoryBot.create_list(:feedback, 50)
