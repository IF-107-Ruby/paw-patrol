class StartCommandHandler < BaseHandler
  def execute!
    bot.api.send_message(chat_id: telegram_profile.id,
                         text: reply_text,
                         reply_markup: reply_keyboard)
  end

  private

  def reply_text
    "Hello, #{telegram_profile.first_name}. " \
      "I'm RoomPassport bot\n" \
      "My purpose is to improve your UX\n" \
      "I can create tickets, send notification and many more\n" \
      "But first you need to connect your RoomPassport account\n"
  end

  def reply_keyboard
    kb = [
      InlineKeyboardButton.new(text: 'Start account connection',
                               callback_data: '/connect_account')
    ]
    InlineKeyboardMarkup.new(inline_keyboard: kb)
  end
end
