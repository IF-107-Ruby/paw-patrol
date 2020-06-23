class NotificateTicketResolvedJob < ApplicationJob
  queue_as :default

  def perform(ticket)
    ActionCable.server.broadcast(
      "company_dashboard:#{ticket.company.id}",
      { event: '@ticketResolved',
        data: ticket }
    )
  end
end
