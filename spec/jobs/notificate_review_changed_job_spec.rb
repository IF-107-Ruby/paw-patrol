require 'rails_helper'

RSpec.describe NotificateReviewChangedJob, type: :job do
  let!(:company) { create(:company) }
  let!(:user) { create(:user, company: company) }
  let!(:unit) { create(:unit, company: company) }
  let!(:ticket) { create(:resolved_ticket, user: user, unit: unit) }
  let!(:review) { create(:review, ticket: ticket) }

  describe '#perform' do
    it 'calls NewTicketNotificationHandler' do
      allow(ActionCable.server).to receive(:broadcast)

      expect(ActionCable.server).to receive(:broadcast)\
        .with("company_dashboard:#{company.id}",
              { event: '@reviewRates',
                data: CompanyDashboard.new(company).review_rates })

      described_class.new.perform(review)
    end
  end
end
