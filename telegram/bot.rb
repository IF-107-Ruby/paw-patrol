require File.expand_path('../config/environment', __dir__)
require File.expand_path('handlers', __dir__)

Rails.configuration.telegram_bot.run do |bot|
  bot.listen do |message|
    telegram_profile = TelegramProfile.from_message_context(message.from)
    Handlers
      .from_message(message, telegram_profile)
      .new(telegram_profile: telegram_profile, message: message)
      .execute!
  rescue StandardError => e
    bot.logger.error(message)
    bot.logger.error(e)
  end
end
