class NotifyTelegramDisconnectJob < ApplicationJob
  queue_as :default

  def perform(id)
    telegram_profile = TelegramProfile.find(id).decorate

    AccountDisconnectedNotificationHandler.new(telegram_profile).execute!
  end
end
