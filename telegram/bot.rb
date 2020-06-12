require File.expand_path('../config/environment', __dir__)

Rails.configuration.telegram_bot.run do |bot|
  bot.listen do |message|
    telegram_profile = TelegramProfile.from_message_context(message.from)
    Handlers.from_message(message).new(telegram_profile).execute!
  end
end
