class DashboardsChannel < ApplicationCable::Channel
  def subscribed
    reject unless current_user.company_owner?
    stream_from "company_dashboard:#{current_company.id}"
  end

  def unsubscribed
    stop_all_streams
  end

  def dashboard_stats
    transmit(event: '@dashboardStats',
             data: current_company_dashboard.stats)
  end

  def recent_tickets
    transmit(event: '@recentTickets',
             data: current_company_dashboard.recent_tickets)
  end

  def fun_facts
    transmit(event: '@funFacts',
             data: current_company_dashboard.fun_facts)
  end

  def review_rates
    transmit(event: '@reviewRates',
             data: current_company_dashboard.review_rates)
  end

  private

  def current_company_dashboard
    CompanyDashboard.new(current_company)
  end
end
