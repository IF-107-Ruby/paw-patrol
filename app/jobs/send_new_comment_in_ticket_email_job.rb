class SendNewCommentInTicketEmailJob < ApplicationJob
  queue_as :default

  def perform(ticket_id)
    ticket = Ticket.find_by(id: ticket_id)
    return if ticket.nil?

    TicketMailer.ticket_has_comment_email(ticket).deliver_now
  end
end
