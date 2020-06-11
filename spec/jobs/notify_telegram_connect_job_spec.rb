require 'rails_helper'

RSpec.describe NotifyTelegramConnectJob, type: :job do
  let!(:telegram_profile) { create(:telegram_profile, :with_user) }

  describe '#perform' do
    it 'calls TelegramMessanger' do
      telegram_messanger = double('telegram_messanger')
      allow(TelegramMessanger).to receive(:new).and_return(telegram_messanger)

      expect(TelegramMessanger).to receive(:new).with(telegram_profile)
      expect(telegram_messanger).to receive(:send_message)

      described_class.new.perform(telegram_profile.id)
    end
  end
end
