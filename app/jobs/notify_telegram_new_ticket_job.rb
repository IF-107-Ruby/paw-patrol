class NotifyTelegramNewTicketJob < ApplicationJob
  queue_as :default

  def perform(telegram_profile, ticket)
    NewTicketNotificationHandler.new(telegram_profile, ticket).execute!
  end
end
