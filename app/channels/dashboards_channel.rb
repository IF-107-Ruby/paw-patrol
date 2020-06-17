class DashboardsChannel < ApplicationCable::Channel
  def subscribed
    reject unless current_user.company_owner?
    stream_from "company_dashboard:#{current_company.id}"
  end

  def unsubscribed
    stop_all_streams
  end

  def recent_tickets
    broadcast_to_current_company(
      event: '@recent_tickets',
      data: current_company_dashboard.recent_tickets
    )
  end

  def fun_facts
    broadcast_to_current_company(
      event: '@fun_facts',
      data: current_company_dashboard.fun_facts
    )
  end

  def review_rates
    broadcast_to_current_company(
      event: '@review_rates',
      data: current_company_dashboard.review_rates
    )
  end

  def dashboard_stats
    broadcast_to_current_company(
      event: '@dashboardStats',
      data: current_company_dashboard.stats
    )
  end

  private

  def broadcast_to_current_company(**args)
    ActionCable.server.broadcast("company_dashboard:#{current_company.id}", args)
  end

  def current_company_dashboard
    CompanyDashboard.new(current_company)
  end
end
