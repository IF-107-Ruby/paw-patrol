module Handlers
  class BaseHandler
    include Rails.application.routes.url_helpers
    include Telegram::Bot::Types

    attr_accessor :message, :current_telegram_user
    attr_reader :bot

    delegate :api, to: :bot

    def initialize(bot, message)
      @bot = bot
      @message = message
      @current_telegram_user = TelegramUser.from_message_context(message.from)
    end

    private

    def reply_with(**args)
      api.send_message(chat_id: current_telegram_user.id, **args)
    end
  end
end
