class DisconnectAccountCommandHandler < BaseHandler
  def execute!
    return if telegram_profile.disconnect_user

    telegram_api.send_message(chat_id: telegram_profile.id,
                              text: 'Account is not connected')
  end
end
