class DashboardsChannel < ApplicationCable::Channel
  def subscribed
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
                last_week_tickets_count: last_week_tickets_count,
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
    [
      { subtitle: 'Workers',
        value: current_company.employees.count },
      { subtitle: 'Responsible users',
        value: current_company.responsible_users.count }
    ]
  end
end
