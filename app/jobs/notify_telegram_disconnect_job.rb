class NotifyTelegramDisconnectJob < ApplicationJob
  queue_as :default

  def perform(id)
    telegram_profile = TelegramProfile.find(id).decorate

    Handlers::AccountDisconnectedNotificationHandler.new(telegram_profile).execute!
  end
end
