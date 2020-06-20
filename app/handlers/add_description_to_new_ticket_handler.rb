class AddDescriptionToNewTicketHandler < BaseHandler
  def execute!
    @ticket = telegram_profile.user.tickets.last.decorate
    @ticket.update(ticket_description)

    telegram_profile.ready!
    @ticket.open!

    send_ticket_creation_notification
  end

  private

  def send_ticket_creation_notification
    telegram_api.send_message(chat_id: telegram_profile.id,
                              text: description_text)
    telegram_api.send_message(chat_id: telegram_profile.id,
                              text: notification_text,
                              reply_markup: notification_keyboard)
  end

  def description_text
    "Description: #{message}"
  end

  def notification_text
    'Your ticket was created ' \
    "for #{@ticket.unit_name}\n" \
    "Name: #{@ticket.name}"
  end

  def ticket_description
    {
      description: message
    }
  end

  def notification_keyboard
    kb = [
      Telegram::Bot::Types::InlineKeyboardButton
        .new(text: 'View on RoomPassport', url: company_ticket_url(@ticket))
    ]
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
  end
end
