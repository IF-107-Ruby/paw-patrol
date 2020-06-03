class SendNewEventEmailJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    event = Event.find_by(id: event_id)
    return if event.nil?

    EventMailer.new_event_email(event).deliver_now
  end
end
