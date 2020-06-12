module Handlers
  class AccountConnectedNotificationHandler < BaseHandler
    def execute!
      notification_text = "Connected to account: #{telegram_profile.user.full_name}"

      bot.api.send_message(chat_id: telegram_profile.id,
                           text: notification_text)
    end
  end
end
