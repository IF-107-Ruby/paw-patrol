# Preview all emails at http://localhost:3000/rails/mailers/ticket_mailer
class TicketMailerPreview < ActionMailer::Preview
  def new_ticket_email
    TicketMailer.new_ticket_email(Ticket.last)
  end
end
