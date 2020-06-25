class NotifyTelegramNewTicketJob < ApplicationJob
  queue_as :default

  def perform(telegram_profile, ticket)
    NewTicketNotificationHandler
      .new(telegram_profile: telegram_profile.decorate, ticket: ticket.decorate)
      .execute!
  end
end
