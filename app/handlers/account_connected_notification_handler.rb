class AccountConnectedNotificationHandler < BaseHandler
  def execute!
    telegram_api.send_message(chat_id: telegram_profile.id,
                              text: notification_text)
  end

  private

  def notification_text
    "Connected to account: #{telegram_profile.user.full_name}"
  end
end
