class EventMailer < ApplicationMailer
  def new_event_email(event)
    @event = event
    @employee_emails = @event.unit.employees.pluck(:email)

    mail(to: @employee_emails, subject: 'New event planned')
  end
end
