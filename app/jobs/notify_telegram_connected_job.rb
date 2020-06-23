class NotifyTelegramConnectedJob < ApplicationJob
  queue_as :default

  def perform(telegram_profile)
    AccountConnectedNotificationHandler.new(telegram_profile.decorate).execute!
  end
end
