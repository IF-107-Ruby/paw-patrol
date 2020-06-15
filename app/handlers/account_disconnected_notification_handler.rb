class AccountDisconnectedNotificationHandler < BaseHandler
  def execute!
    telegram_api.send_message(chat_id: telegram_profile.id,
                              text: 'Account was disconnected successfully')
  end
end
