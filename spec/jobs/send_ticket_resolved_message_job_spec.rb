require 'rails_helper'

RSpec.describe SendTicketResolvedEmailJob, type: :job do
  describe '#perform' do
    it 'calls TicketMailer' do
      ticket = double('ticket', id: 1)
      allow(Ticket).to receive(:find).and_return(ticket)
      allow(TicketMailer).to receive_message_chain(:ticket_resolved_email, :deliver_now)

      described_class.new.perform(ticket_id: ticket.id)

      expect(TicketMailer).to have_received(:ticket_resolved_email).with(ticket)
    end
  end

  describe '#perform later' do
    it 'adds the job to the queue' do
      described_class.perform_later(1)

      expect(enqueued_jobs.last[:job]).to eq described_class
    end
  end
end
