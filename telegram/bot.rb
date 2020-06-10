require File.expand_path('../config/environment', __dir__)

Rails.configuration.telegram_bot.run do |bot|
  bot.listen do |message|
    Handlers.from_message(message).new(bot, message).execute!
  end
end
