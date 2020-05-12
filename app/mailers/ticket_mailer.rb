class TicketMailer < ApplicationMailer
  def new_ticket_email(ticket)
    @ticket = ticket
    @responsible_user = ticket.unit.responsible_user
    @root_url = root_url
    @url = ticket_url(@ticket)

    mail(to: @responsible_user.email, subject: 'New ticket')
  end
end