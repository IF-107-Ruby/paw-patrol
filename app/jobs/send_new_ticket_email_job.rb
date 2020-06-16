class SendNewTicketEmailJob < ApplicationJob
  queue_as :default

  def perform(ticket)
    if ticket.responsible_user.present?
      TicketMailer.new_ticket_email(ticket)
    else
      TicketMailer.assign_responsible_user_email(ticket)
    end.deliver_now
  end
end
