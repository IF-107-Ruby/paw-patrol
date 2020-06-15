class DashboardsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "dashboards_#{current_company.id}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def tickets
    ActionCable.server.broadcast(
      "dashboards_#{current_company.id}_channel",
      { event: '@tickets', data: current_company.recent_tickets.as_json }
    )
  end
end
