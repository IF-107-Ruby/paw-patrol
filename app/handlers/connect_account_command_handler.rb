class ConnectAccountCommandHandler < BaseHandler
  def execute!
    if telegram_profile.user.present?
      respond_text = 'Already connected'
    else
      @link_token = telegram_profile.start_linking
      respond_text = success_text
      reply_markup = reply_keyboard
    end

    bot.api.send_message(chat_id: telegram_profile.id, text: respond_text,
                         reply_markup: reply_markup,
                         parse_mode: 'MarkdownV2')
  end

  private

  def reply_keyboard
    kb = [
      InlineKeyboardButton.new(text: 'Link account',
                               url: company_telegram_profile_url(
                                 telegram: { link_token: @link_token }
                               ))
    ]
    InlineKeyboardMarkup.new(inline_keyboard: kb)
  end

  def success_text
    "Just follow link below\n" \
    "Or enter link token manually\n" \
    "*Link token: #{@link_token}*"
  end
end
