require File.expand_path('../config/environment', __dir__)
require 'telegram/bot'

token = Rails.application.credentials.telegram_bot_token

Telegram::Bot::Client.run(token, logger: Logger.new(STDOUT)) do |bot| # rubocop:disable Metrics/BlockLength
  bot.listen do |message|
    current_telegram_user = TelegramUser.from_message_context(message.from)
    bot.logger.info(current_telegram_user)
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id,
                           text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id,
                           text: "Bye, #{message.from.first_name}")
    when '/link_account'
      if current_telegram_user.user.present?
        bot.api.send_message(chat_id: message.chat.id, text: 'Already connected')
      else
        link_token = current_telegram_user.start_linking
        bot.api.send_message(chat_id: message.chat.id,
                             text: "Link token is, #{link_token}")
      end
    when '/unlink_account'
      if current_telegram_user.user.present?
        current_telegram_user.disconnect_user
        bot.api.send_message(chat_id: message.chat.id, text: 'User disconnected')
      else
        bot.api.send_message(chat_id: message.chat.id, text: 'Account is not connected')
      end
    end
  end
end
