class NotifyTelegramDisconnectJob < ApplicationJob
  queue_as :default

  def perform(id)
    telegram_profile = TelegramProfile.find(id).decorate

    TelegramMessanger.new(telegram_profile)
                     .send_message(text: 'Account was disconnected successfully')
  end
end
