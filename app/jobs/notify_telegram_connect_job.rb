class NotifyTelegramConnectJob < ApplicationJob
  queue_as :default

  def perform(id)
    telegram_profile = TelegramProfile.find(id).decorate
    notification_text = "Connected to account: #{telegram_profile.user.full_name}"

    TelegramMessanger.new(telegram_profile).send_message(text: notification_text)
  end
end
