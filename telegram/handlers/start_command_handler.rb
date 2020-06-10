module Handlers
  class StartCommandHandler < Handlers::BaseHandler
    def execute!
      reply_with(text: reply_text, reply_markup: reply_keyboard)
    end

    private

    def reply_text
      "Hello, #{current_telegram_user.first_name}\n" \
        "I am RoomPassport bot \n" \
        "With my purpose is to improve your UX\n" \
        "I can create tickets, send notiification and many more\n" \
        "But first you need to connect your RoomPassport account\n"
    end

    def reply_keyboard
      kb = [
        InlineKeyboardButton.new(text: 'Start account connection', callback_data: '/link_account')
      ]
      InlineKeyboardMarkup.new(inline_keyboard: kb)
    end
  end
end
