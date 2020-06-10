module Handlers
  class BaseHandler
    attr_accessor :message, :current_telegram_user
    attr_reader :bot

    delegate :api, to: :bot

    def initialize(bot, message)
      @bot = bot
      @message = message
      @current_telegram_user = TelegramUser.from_message_context(message.from)
    end
  end
end
