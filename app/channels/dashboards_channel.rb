class DashboardsChannel < ApplicationCable::Channel
  def subscribed
    reject unless current_user.company_owner?
    stream_from "company_dashboard:#{current_company.id}"
  end

  def unsubscribed
    stop_all_streams
  end

  def tickets
    broadcast_to_current_company(
      event: '@tickets',
      data: recent_tickets
    )
  end

  def fun_facts
    broadcast_to_current_company(
      event: '@fun_facts',
      data: fun_facts_data
    )
  end

  def review_rates
    broadcast_to_current_company(
      event: '@review_rates',
      data: review_rates_data
    )
  end

  def dashboard_stats
    broadcast_to_current_company(
      event: '@dashboardStats',
      data: { tickets: recent_tickets,
              fun_facts: fun_facts_data,
              review_rates: review_rates_data }
    )
  end

  private

  def broadcast_to_current_company(**args)
    ActionCable.server.broadcast("company_dashboard:#{current_company.id}", args)
  end

  def recent_tickets
    current_company.recent_tickets.as_json
  end

  def last_week_tickets_count
    current_company.tickets
                   .where('tickets.created_at >= ?', 1.week.ago).count
  end

  def fun_facts_data
    {
      employees_count: current_company.employees.count,
      responsible_users_count: current_company.responsible_users.count,
      last_week_tickets_count: last_week_tickets_count,
      open_tickets_count: current_company.tickets.open.count
    }
  end

  def review_rates_data
    ReadSatisfaction.call(current_company).as_json
  end
end
