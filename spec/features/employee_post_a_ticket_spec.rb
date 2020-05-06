require 'rails_helper'
require 'capybara/dsl'
require 'selenium-webdriver'

feature 'EmployeePostATicket' do
  let!(:company) { create(:company_with_units) }
  let!(:employee) { create(:employee) }
  let!(:users_companies_relationship) do
    create(:users_companies_relationship, user: employee, company: company)
  end
  let(:ticket_attributes) { FactoryBot.attributes_for :ticket }

  before do
    login_as employee
    visit new_ticket_path
  end

  scenario 'successfully' do
    expect(page).to have_selector('h2', text: 'Post a Ticket')
    expect(page).to have_selector('.ticket-form')

    fill_in 'ticket_name', with: ticket_attributes[:name]
    find(:select, 'ticket_unit_id')
      .first(:option, company.units.first.name)
      .select_option
    fill_in_trix_editor('ticket_description_trix_input_ticket',
                        ticket_attributes[:description])
    click_on 'Post a Ticket'

    expect(page).to have_selector('.notification.success.closeable',
                                  text: 'Ticket posted!')
  end

  scenario 'unsuccessfully' do
    expect(page).to have_selector('.ticket-form')
    click_on 'Post a Ticket'

    expect(page).to have_selector('.notification.warning.closeable',
                                  text: 'Ticket is not posted!')
    expect(page).to have_selector('#error_explanation')
  end
end
