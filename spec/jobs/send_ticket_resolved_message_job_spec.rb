require 'rails_helper'

RSpec.describe SendTicketResolvedEmailJob, type: :job do
  include_context 'employee with ticket'

  describe '#perform' do
    it 'calls TicketMailer' do
      allow(TicketMailer).to receive_message_chain(:ticket_resolved_email, :deliver_now)

      described_class.new.perform(ticket.id)

      expect(TicketMailer).to have_received(:ticket_resolved_email).with(ticket)
    end
  end

  describe '#perform later' do
    it 'adds the job to the queue' do
      described_class.perform_later(ticket.id)

      expect(enqueued_jobs.last[:job]).to eq described_class
    end
  end
end
