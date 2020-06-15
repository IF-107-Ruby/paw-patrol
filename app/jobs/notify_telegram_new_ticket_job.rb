class NotifyTelegramNewTicketJob < ApplicationJob
  queue_as :default

  def perform(telegram_profile_id, ticket_id)
    telegram_profile = TelegramProfile.find(telegram_profile_id).decorate
    ticket = Ticket.find(ticket_id).decorate

    NewTicketNotificationHandler.new(telegram_profile, ticket).execute!
  end
end
