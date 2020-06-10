require 'telegram/bot'

token = Rails.application.credentials.telegram_bot_token

Rails.application.config.telegram_bot = Telegram::Bot::Client
                                        .new(token, logger: Logger.new(STDOUT))
