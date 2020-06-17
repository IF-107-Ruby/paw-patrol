require 'rails_helper'

RSpec.describe DashboardsChannel, type: :channel do
  let!(:company) { create(:company) }
  let!(:user) { create(:user, company: company) }
  let!(:employee) { create(:employee, :with_company) }

  describe '#subscribed' do
    it 'successfully subscribes if user is company_owner' do
      stub_connection current_user: user

      subscribe
      expect(subscription).to be_confirmed
    end

    it 'doest subscribe if user is not company_owner' do
      stub_connection current_user: employee

      subscribe
      expect(subscription).to be_rejected
    end
  end

  describe '#dashboard_stats' do
    before do
      stub_connection current_user: user
      subscribe
    end

    it 'broadcasts to current company' do
      perform :dashboard_stats

      expect(transmissions.last)
        .to eq({
          event: '@dashboardStats',
          data: CompanyDashboard.new(company).stats
        }.deep_stringify_keys)
    end
  end

  describe '#recent_tickets' do
    before do
      stub_connection current_user: user
      subscribe
    end

    it 'broadcasts to current company' do
      perform :recent_tickets

      expect(transmissions.last)
        .to eq({
          event: '@recentTickets',
          data: CompanyDashboard.new(company).recent_tickets
        }.deep_stringify_keys)
    end
  end

  describe '#fun_facts' do
    before do
      stub_connection current_user: user
      subscribe
    end

    it 'broadcasts to current company' do
      perform :fun_facts

      expect(transmissions.last)
        .to eq({
          event: '@funFacts',
          data: CompanyDashboard.new(company).fun_facts
        }.deep_stringify_keys)
    end
  end

  describe '#review_rates' do
    before do
      stub_connection current_user: user
      subscribe
    end

    it 'broadcasts to current company' do
      perform :review_rates

      expect(transmissions.last)
        .to eq({
          event: '@reviewRates',
          data: CompanyDashboard.new(company).review_rates
        }.deep_stringify_keys)
    end
  end
end
