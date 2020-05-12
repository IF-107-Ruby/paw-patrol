class SendNewTicketJob < ApplicationJob
  queue_as :default

  def perform(ticket)
    @ticket = ticket
    TicketMailer.new_ticket_email(@ticket).deliver_now
  end
end