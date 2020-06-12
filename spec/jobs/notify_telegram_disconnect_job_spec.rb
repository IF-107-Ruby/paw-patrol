require 'rails_helper'

RSpec.describe NotifyTelegramDisconnectJob, type: :job do
  let!(:telegram_profile) { create(:telegram_profile, :with_user) }

  describe '#perform' do
    subject { Handlers::AccountDisconnectedNotificationHandler }

    it 'calls Handlers::AccountDisconnectedNotificationHandler' do
      handler = double('handler')
      allow(subject).to receive(:new).and_return(handler)

      expect(subject).to receive(:new).with(telegram_profile)
      expect(handler).to receive(:execute!)

      described_class.new.perform(telegram_profile.id)
    end
  end
end
