class SendNewTicketJob < ApplicationJob
  queue_as :default

  def perform(ticket_id)
    ticket = Ticket.find_by(id: ticket_id)
    TicketMailer.new_ticket_email(ticket).deliver_now
  end
end
