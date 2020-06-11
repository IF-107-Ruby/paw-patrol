class TelegramMessanger
  attr_reader :telegram_profile

  def initialize(telegram_profile)
    @telegram_profile = telegram_profile
  end

  def send_message(**args)
    bot.api.send_message(chat_id: telegram_profile.id, **args)
  end

  private

  def bot
    Rails.configuration.telegram_bot
  end
end
