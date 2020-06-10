require 'telegram/bot'

token = Rails.application.credentials.telegram_bot_token

bot = Telegram::Bot::Client.new(token, logger: Logger.new(STDOUT))

Rails.application.config.telegram_bot = bot
