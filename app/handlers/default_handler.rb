class DefaultHandler < BaseHandler
  def execute!
    bot.api.send_message(chat_id: telegram_profile.id, text: 'Unknown action')
  end
end
