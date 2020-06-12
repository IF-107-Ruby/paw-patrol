require 'rails_helper'

RSpec.describe NotifyTelegramNewTicketJob, type: :job do
  include_context 'company with users'
  let!(:telegram_profile) { create(:telegram_profile, :with_user, user: staff_member) }
  let!(:unit) { create(:unit, company: company, users: [employee]) }
  let!(:ticket) { create(:ticket, user: employee, unit: unit) }

  describe '#perform' do
    subject { Handlers::NewTicketNotificationHandler }

    it 'calls Handlers::NewTicketNotificationHandler' do
      handler = double('handler')
      allow(subject).to receive(:new).and_return(handler)

      expect(subject).to receive(:new).with(telegram_profile, ticket)
      expect(handler).to receive(:execute!)

      described_class.new.perform(ticket.id, telegram_profile.id)
    end
  end
end
