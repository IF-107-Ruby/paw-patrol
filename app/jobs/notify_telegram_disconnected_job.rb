class NotifyTelegramDisconnectedJob < ApplicationJob
  queue_as :default

  def perform(telegram_profile)
    AccountDisconnectedNotificationHandler
      .new(telegram_profile: telegram_profile.decorate)
      .execute!
  end
end
