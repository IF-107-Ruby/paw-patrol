require 'rails_helper'

RSpec.describe NotifyTelegramNewTicketJob, type: :job do
  include_context 'company with users'
  let!(:telegram_profile) { create(:telegram_profile, :with_user, user: staff_member) }
  let!(:unit) { create(:unit, company: company, users: [employee]) }
  let!(:ticket) { create(:ticket, user: employee, unit: unit) }

  describe '#perform' do
    subject { NewTicketNotificationHandler }

    it 'calls NewTicketNotificationHandler' do
      handler = double('handler')
      allow(subject).to receive(:new).and_return(handler)

      expect(subject).to receive(:new).with(telegram_profile, ticket)
      expect(handler).to receive(:execute!)

      described_class.new.perform(telegram_profile, ticket)
    end
  end
end
