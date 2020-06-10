class NotifyTelegramConnectJob < ApplicationJob
  queue_as :default

  def perform(id)
    telegram_user = TelegramUser.find_by({ id: id }).decorate

    Rails.configuration.telegram_bot.api
         .send_message(chat_id: telegram_user.id,
                       text: "Connected to account #{telegram_user.user.full_name}")
  end
end
