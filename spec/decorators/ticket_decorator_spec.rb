require 'rails_helper'

RSpec.describe TicketDecorator do
  let!(:company) { create(:company) }
  let!(:staff_member) { create(:staff_member, company: company, unit: unit ) }
  let!(:unit) { create(:unit, :with_employee_and_ticket, company: company) }
  let!(:ticket_completion ) { create(user: staff_member, ticket: ticket) }
  let!(:ticket) { unit.tickets.first.decorate }
  let!(:user) { ticket.user.decorate }

  it 'place_were_opened' do
    expect(ticket.place_were_opened).to eq('Ticket opened for ' + ticket.unit.name)
  end

  it 'created_by' do
    expect(ticket.created_by).to eq("Created by #{user.full_name}")
  end

  it 'display_status' do
    expect(ticket.display_status).to eq('open')
  end

  it 'completion_description' do
    expect(ticket.completion_description).to eq("#{ticket_completion.description}")
  end

  it 'completion' do
    expect(ticket.completion).to eq(ticket_completion)
  end
end
