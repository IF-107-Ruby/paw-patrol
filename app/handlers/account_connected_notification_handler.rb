class AccountConnectedNotificationHandler < BaseHandler
  def execute!
    if telegram_profile.ready? &&
       (telegram_profile.user.employee? || telegram_profile.user.company_owner?) &&
       telegram_profile.user.units.any?

      send_conection_notification_with_buttons
    else
      send_conection_notification
    end
  end

  private

  def send_conection_notification
    telegram_api.send_message(chat_id: telegram_profile.id,
                              text: notification_text)
  end

  def send_conection_notification_with_buttons
    telegram_api.send_message(chat_id: telegram_profile.id,
                              text: notification_text,
                              reply_markup: ticket_creation_keyboard)
  end

  def ticket_creation_keyboard
    kb = [
      KeyboardButton.new(text: 'Create new ticket')
    ]
    ReplyKeyboardMarkup.new(keyboard: kb, one_time_keyboard: true)
  end

  def notification_text
    "Connected to account: #{telegram_profile.user.full_name}"
  end
end
