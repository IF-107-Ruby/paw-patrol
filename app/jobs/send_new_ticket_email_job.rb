class SendNewTicketEmailJob < ApplicationJob
  queue_as :default

  def perform(ticket_id, has_responsible_user)
    ticket = Ticket.find_by(id: ticket_id)
    return if ticket.nil?

    if has_responsible_user
      TicketMailer.new_ticket_email(ticket)
    else
      TicketMailer.assign_responsible_user_email(ticket)
    end.deliver_now
  end
end
