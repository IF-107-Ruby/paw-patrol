# require 'rails_helper'
#
# feature 'Company owner set responsible user' do
#   include_context 'company with unit, ticket and ticket completion'
#   let!(:ticket_completion_attributes) { FactoryBot.attributes_for :ticket_completion }
#
#   before :each do
#     login_as unit.responsible_user
#     visit company_ticket_path(unit.tickets.last)
#   end
#
#   scenario 'Successfuly resolve ticket' do
#     find('i', class: 'complete-ticket-icon').click
#
#     print page.body
#
#     expect(page).to have_selector('.dashboard-headline h3', text: 'Add ticket completion')
#     expect(page).to have_selector('.ticket-form')
#
#     fill_in_trix_editor('ticket_completion_description_trix_input_ticket_completion',
#                         ticket_completion_attributes[:description])
#
#     click_on 'Resolve ticket'
#
#     expect(page).to have_selector('.notification.success.closeable',
#                                   text: 'Ticket resolved!')
#   end
#
# end
