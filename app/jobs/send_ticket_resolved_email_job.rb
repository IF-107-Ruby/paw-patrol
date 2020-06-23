class SendTicketResolvedEmailJob < ApplicationJob
  queue_as :default

  def perform(ticket)
    TicketMailer.ticket_resolved_email(ticket).deliver_now
  end
end
