class DashboardsChannel < ApplicationCable::Channel
  def subscribed
    reject unless current_user.company_owner?
    stream_from "dashboards_#{current_company.id}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def dashboard_stats
    ActionCable.server.broadcast(
      "dashboards_#{current_company.id}_channel",
      {
        event: '@dashboardStats',
        data: { tickets: recent_tickets,
                fun_facts: fun_facts }
      }
    )
  end

  private

  def recent_tickets
    current_company.recent_tickets.as_json
  end

  def last_week_tickets_count
    current_company.tickets
                   .where('tickets.created_at >= ?', 1.week.ago).count
  end

  def fun_facts
    {
      employees_count: current_company.employees.count,
      responsible_users_count: current_company.responsible_users.count,
      last_week_tickets_count: last_week_tickets_count,
      open_tickets_count: current_company.tickets.open.count
    }
  end
end
