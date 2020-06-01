require 'rails_helper'

RSpec.describe SendEmailAboutNewCommentJob, type: :job do
  include_context 'employee with ticket'

  describe '#perform' do
    before do
      allow(TicketMailer).to receive_message_chain(:ticket_has_comment_email,
                                                   :deliver_now)
    end

    it 'calls TicketMailer' do
      described_class.new.perform(ticket.id)

      expect(TicketMailer).to have_received(:ticket_has_comment_email).with(ticket)
    end

    it 'not calls TicketMailer it ticket id not exist' do
      described_class.new.perform(ticket.id + 100)

      expect(TicketMailer).not_to have_received(:ticket_has_comment_email).with(ticket)
    end
  end

  describe '#perform later' do
    it 'adds the job to the queue' do
      described_class.perform_later(ticket.id)

      expect(enqueued_jobs.last[:job]).to eq described_class
    end
  end
end
