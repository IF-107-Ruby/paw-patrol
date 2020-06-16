class NotificateTicketResolvedJob < ApplicationJob
  queue_as :default

  attr_reader :ticket

  def perform(id)
    @ticket = Ticket.find(id)

    send_emails
    broadcast_to_websocket
  end

  def broadcast_to_websocket
    ActionCable.server.broadcast(
      "dashboards_#{ticket.company.id}_channel",
      { event: '@ticketResolved',
        data: ticket.as_json }
    )
  end

  def send_emails
    TicketMailer.ticket_resolved_email(ticket).deliver_now
  end
end
