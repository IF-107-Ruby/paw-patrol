require 'rails_helper'

RSpec.describe TicketDecorator do
  let(:ticket) { create(:ticket) }

  it 'place_were_opened' do
    expect(ticket.decorate.place_were_opened).to eq('Ticket open for ' + ticket.unit.name)
  end
end
