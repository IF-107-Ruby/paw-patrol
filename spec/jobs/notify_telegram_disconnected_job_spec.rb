require 'rails_helper'

RSpec.describe NotifyTelegramDisconnectedJob, type: :job do
  let!(:telegram_profile) { create(:telegram_profile, :with_user) }

  describe '#perform' do
    subject { AccountDisconnectedNotificationHandler }

    it 'calls AccountDisconnectedNotificationHandler' do
      handler = double('handler')
      allow(subject).to receive(:new).and_return(handler)

      expect(subject).to receive(:new).with(telegram_profile)
      expect(handler).to receive(:execute!)

      described_class.new.perform(telegram_profile)
    end
  end
end
