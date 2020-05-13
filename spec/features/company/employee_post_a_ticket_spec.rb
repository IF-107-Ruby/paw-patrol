require 'rails_helper'

feature 'EmployeePostATicket' do
  include_context 'employee with ticket'
  let(:ticket_attributes) { FactoryBot.attributes_for :ticket }

  before do
    login_as employee
    visit new_company_ticket_path
  end

  scenario 'successfully' do
    expect(page).to have_selector('.dashboard-headline h3', text: 'Post a Ticket')
    expect(page).to have_selector('.ticket-form')

    fill_in 'ticket_name', with: ticket_attributes[:name]
    find(:select, 'ticket_unit_id')
      .first(:option, unit.name)
      .select_option
    fill_in_trix_editor('ticket_description_trix_input_ticket',
                        ticket_attributes[:description])

    within('.dashboard-content-inner') do
      click_on 'Post a Ticket'
    end
    expect(page).to have_selector('.notification.success.closeable',
                                  text: 'Ticket posted!')
  end

  scenario 'unsuccessfully' do
    expect(page).to have_selector('.ticket-form')

    within('.dashboard-content-inner') do
      click_on 'Post a Ticket'
    end

    expect(page).to have_selector('.notification.warning.closeable',
                                  text: 'Ticket is not posted!')
    expect(page).to have_selector('#error_explanation')
  end
end
