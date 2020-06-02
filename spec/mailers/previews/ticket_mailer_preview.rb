# Preview all emails at http://localhost:3000/rails/mailers/ticket_mailer
class TicketMailerPreview < ActionMailer::Preview
  def new_ticket_email
    ticket = Ticket.all.detect { |t| t.unit.responsible_user.present? }
    TicketMailer.new_ticket_email(ticket)
  end

  def assign_responsible_user_email
    ticket = Ticket.all.detect { |t| t.unit.responsible_user.nil? }
    TicketMailer.assign_responsible_user_email(ticket)
  end

  def ticket_has_comment_email
    ticket = Ticket.all.detect { |t| t.comments.any? }
    TicketMailer.ticket_has_comment_email(ticket)
  end

  def ticket_resolved_email
    ticket = Ticket.all.detect(&:resolved?)
    TicketMailer.ticket_resolved_email(ticket)
  end
end
