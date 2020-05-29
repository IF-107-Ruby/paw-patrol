class SendTicketResolvedEmailJob < ApplicationJob
  queue_as :default

  def perform(ticket_id)
    ticket = Ticket.find(ticket_id)
    return if ticket.nil?

    TicketMailer.ticket_resolved_email(ticket).deliver_now
  end
end
