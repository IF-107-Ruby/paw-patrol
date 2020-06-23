require 'rails_helper'

RSpec.describe NotificateTicketResolvedJob, type: :job do
  let!(:company) { create(:company) }
  let!(:user) { create(:user, company: company) }
  let!(:unit) { create(:unit, company: company) }
  let!(:ticket) { create(:resolved_ticket, user: user, unit: unit) }

  describe '#perform' do
    it 'calls NewTicketNotificationHandler' do
      allow(ActionCable.server).to receive(:broadcast)

      expect(ActionCable.server).to receive(:broadcast)\
        .with("company_dashboard:#{company.id}",
              { event: '@ticketResolved',
                data: ticket })

      described_class.new.perform(ticket)
    end
  end
end
