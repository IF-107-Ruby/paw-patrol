require 'rails_helper'

feature 'Responsible user resolve ticket' do
  include_context 'unit with ticket and resolution'
  let!(:ticket_resolution_params) { ActionText::Content.new(Faker::Lorem.paragraph) }
  let!(:first_ticket) { create(:ticket, unit: unit, user: unit.users.last) }
  let!(:second_ticket) { create(:ticket, unit: unit, user: unit.users.last) }

  before :each do
    login_as unit.responsible_user
  end

  scenario 'successfuly' do
    visit company_ticket_path(first_ticket)

    fill_in_trix_editor("ticket_resolution_trix_input_ticket_#{first_ticket.id}",
                        ticket_resolution_params)

    click_on 'Resolve ticket'

    expect(page).to have_selector('.notification.success.closeable',
                                  text: 'Ticket resolved!')
    expect(page).to have_selector('.headline', text: 'Ticket Completion')
  end

  scenario 'unsuccesfuly' do
    visit company_ticket_path(second_ticket)

    click_on 'Resolve ticket'

    expect(page).to have_selector('.notification.warning.closeable',
                                  text: 'Ticket is resolved!')
    expect(page).to have_text('Ticket completion must be not empty.')
    expect(page).to have_selector('.headline', text: 'Ticket Completion')
  end
end
