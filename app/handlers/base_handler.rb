class BaseHandler
  include Rails.application.routes.url_helpers
  include Telegram::Bot::Types
  include Pundit

  attr_accessor :telegram_profile
  attr_accessor :message

  def initialize(telegram_profile:, message: '')
    @telegram_profile = telegram_profile
    @message = message
  end

  def telegram_api
    Rails.configuration.telegram_bot.api
  end

  private

  def current_user
    telegram_profile.user
  end
end
