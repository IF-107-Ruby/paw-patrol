class NotifyTelegramConnectJob < ApplicationJob
  queue_as :default

  def perform(id)
    telegram_profile = TelegramProfile.find(id).decorate

    Handlers::AccountConnectedNotificationHandler.new(telegram_profile).execute!
  end
end
