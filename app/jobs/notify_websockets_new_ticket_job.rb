class NotifyWebsocketsNewTicketJob < ApplicationJob
  queue_as :default

  def perform(ticket)
    ActionCable.server.broadcast(
      "company_dashboard:#{ticket.company.id}",
      { event: '@newTicket',
        data: ticket }
    )
  end
end
