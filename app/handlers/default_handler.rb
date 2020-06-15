class DefaultHandler < BaseHandler
  def execute!
    telegram_api.send_message(chat_id: telegram_profile.id, text: 'Unknown action')
  end
end
