class ConnectAccountCommandHandler < BaseHandler
  def execute!
    if telegram_profile.user.present?
      telegram_profile.ready!
      send_notification_for_connected_user
    else
      send_notification_for_disconnected_user
    end
  end

  private

  def send_notification_for_connected_user
    respond_text = 'Already connected'

    if telegram_profile.ready? &&
       (telegram_profile.user.employee? || telegram_profile.user.company_owner?) &&
       telegram_profile.user.units.any?
      reply_markup = ticket_creation_keyboard
    end

    send_message_with_buttons(respond_text, reply_markup)
  end

  def send_notification_for_disconnected_user
    @connection_token = telegram_profile.start_user_connection
    respond_text = success_text
    reply_markup = reply_keyboard

    send_message_with_buttons(respond_text, reply_markup)
  end

  def send_message_with_buttons(respond_text, reply_markup)
    telegram_api.send_message(chat_id: telegram_profile.id,
                              text: respond_text,
                              reply_markup: reply_markup,
                              parse_mode: 'MarkdownV2')
  end

  def reply_keyboard
    kb = [
      InlineKeyboardButton.new(text: 'Connect account',
                               url: company_telegram_profile_url(
                                 telegram: { connection_token: @connection_token }
                               ))
    ]
    InlineKeyboardMarkup.new(inline_keyboard: kb)
  end

  def ticket_creation_keyboard
    kb = [
      KeyboardButton.new(text: 'Create new ticket')
    ]
    ReplyKeyboardMarkup.new(keyboard: kb, one_time_keyboard: true)
  end

  def success_text
    "Just follow link below\n" \
    "Or enter connection token manually\n" \
    "*Connection token: #{@connection_token}*"
  end
end
