require 'rails_helper'

RSpec.describe TicketDecorator do
  let!(:company) { create(:company) }
  let!(:unit) { create(:unit, :with_employee_and_ticket, company: company) }
  let!(:ticket) { unit.tickets.first.decorate }
  let!(:user) { ticket.user.decorate }

  it 'place_were_opened' do
    expect(ticket.place_were_opened).to eq('Ticket open for ' + ticket.unit.name)
  end

  it 'created_by' do
    expect(ticket.created_by).to eq("Created by #{user.full_name}")
  end
end
