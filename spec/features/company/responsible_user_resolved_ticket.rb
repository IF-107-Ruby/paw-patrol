require 'rails_helper'

feature 'Responsible user resolve ticket' do
  include_context 'company with unit, ticket and ticket completion'
  let!(:ticket_completion_attributes) { FactoryBot.attributes_for :ticket_completion }

  before :each do
    login_as unit.responsible_user
    visit company_ticket_path(unit.tickets.last)
  end

  scenario 'Successfuly resolve ticket' do
    fill_in_trix_editor('ticket_completion_description_trix_input_ticket_completion',
                        ticket_completion_attributes[:description])

    click_on 'Resolve ticket'

    expect(page).to have_selector('.notification.success.closeable',
                                  text: 'Ticket resolved!')

    expect(page).to have_selector('.headline', text: 'Ticket Completion')
  end

  scenario 'unsuccessfuly resolve ticket' do
    fill_in_trix_editor('ticket_completion_description_trix_input_ticket_completion', '')

    click_on 'Resolve ticket'

    expect(page).to have_selector('.notification.warning.closeable',
                                  text: 'Ticket is not resolved!')
    expect(page).to have_text('Description can\'t be blank')
  end
end
