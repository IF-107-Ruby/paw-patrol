require 'telegram/bot'

token = Rails.application.credentials.telegram_bot_token

logger = if Rails.env.production?
           Logger.new("#{Rails.root}/log/telegram.log")
         else
           Logger.new(STDOUT)
         end
bot = Telegram::Bot::Client.new(token, logger: logger)

Rails.application.config.telegram_bot = bot
