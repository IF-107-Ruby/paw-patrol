require 'rails_helper'

RSpec.describe TicketDecorator do
  let!(:company) { create(:company) }
  let!(:unit) { create(:unit, :with_employee_and_ticket, company: company) }
  let!(:ticket) { unit.tickets.first }

  it 'place_were_opened' do
    expect(ticket.decorate.place_were_opened).to eq('Ticket open for ' + ticket.unit.name)
  end
end
