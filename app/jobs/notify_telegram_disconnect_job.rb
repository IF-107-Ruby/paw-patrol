class NotifyTelegramDisconnectJob < ApplicationJob
  queue_as :default

  def perform(id)
    Rails.configuration.telegram_bot.api
         .send_message(chat_id: id, text: 'Account was disconnected successfully')
  end
end
