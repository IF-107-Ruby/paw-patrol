class TicketMailer < ApplicationMailer
  def new_ticket_email(ticket)
    @ticket = ticket
    @responsible_user = ticket.unit.responsible_user

    mail(to: @responsible_user.email, subject: 'New ticket created')
  end

  def assign_responsible_user_email(ticket)
    @ticket = ticket
    @company_owner = ticket.unit.company.users.find_by(role: 'company_owner')

    mail(to: @company_owner.email, subject: 'Assign responsible user')
  end

  def ticket_resolved_email(ticket)
    @ticket = ticket
    @participant_emails = @ticket.participants.pluck(:email)

    mail(to: @participant_emails, subject: "Ticket: #{@ticket.name}")
  end
end
