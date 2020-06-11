class NotifyTelegramConnectJob < ApplicationJob
  queue_as :default

  def perform(id)
    telegram_profile = TelegramProfile.find_by({ id: id }).decorate

    Rails.configuration.telegram_bot.api
         .send_message(chat_id: telegram_profile.id,
                       text: "Connected to account: #{telegram_profile.user.full_name}")
  end
end
