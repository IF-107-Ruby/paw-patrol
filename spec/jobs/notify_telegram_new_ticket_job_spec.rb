require 'rails_helper'

RSpec.describe NotifyTelegramNewTicketJob, type: :job do
  include_context 'company with users'
  let!(:telegram_profile) { create(:telegram_profile, :with_user, user: staff_member) }
  let!(:unit) { create(:unit, company: company, users: [employee]) }
  let!(:ticket) { create(:ticket, user: employee, unit: unit) }

  describe '#perform' do
    it 'calls TelegramMessanger' do
      telegram_messanger = double('telegram_messanger')
      TelegramMessanger.stub(:new).and_return(telegram_messanger)
      expect(telegram_messanger).to receive(:send_message)

      described_class.new.perform(ticket.id, telegram_profile.id)
    end
  end
end
