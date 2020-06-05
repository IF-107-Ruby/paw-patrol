# Preview all emails at http://localhost:3000/rails/mailers/event_mailer
class EventMailerPreview < ActionMailer::Preview
  def new_event_email
    unit = Unit.all.detect { |u| u.events.any? && u.employees.any? }
    EventMailer.new_event_email(unit.events.first)
  end
end
