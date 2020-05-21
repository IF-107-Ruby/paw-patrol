require 'rails_helper'

feature 'Responsible user resolve ticket' do
  include_context 'unit with ticket and resolution'
  let!(:ticket_resolution_params) { ActionText::Content.new(Faker::Lorem.paragraph) }
  let!(:ticket) { create(:ticket, unit: unit, user: unit.users.last) }

  before :each do
    login_as unit.responsible_user
  end

  scenario 'Successfuly resolve ticket with completion' do
    visit company_ticket_path(unit.tickets.first)

    fill_in_trix_editor('ticket_resolution',
                        ticket_resolution_params)

    click_on 'Resolve ticket'

    expect(page).to have_selector('.notification.success.closeable',
                                  text: 'Ticket resolved!')
    expect(page).to have_selector('.headline', text: 'Ticket Completion')
  end

  scenario 'Successfuly resolve ticket without completion' do
    visit company_ticket_path(ticket)

    click_on 'Resolve ticket'

    expect(page).to have_selector('.notification.success.closeable',
                                  text: 'Ticket resolved!')
    expect(page).not_to have_text('Description can\'t be blank')
    expect(page).not_to have_selector('.headline', text: 'Ticket Completion')
  end
end
