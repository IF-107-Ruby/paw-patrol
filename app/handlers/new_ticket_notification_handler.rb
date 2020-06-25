class NewTicketNotificationHandler < BaseHandler
  attr_accessor :ticket

  def initialize(telegram_profile:, ticket:)
    super(telegram_profile: telegram_profile)
    @ticket = ticket
  end

  def execute!
    telegram_api.send_message(chat_id: telegram_profile.id,
                              text: notification_text,
                              reply_markup: notification_keyboard)
  end

  private

  def notification_text
    "#{ticket.user.full_name} created new ticket " \
    "for #{ticket.unit_name}\n" \
    "Title: #{ticket.name}"
  end

  def notification_keyboard
    kb = [
      Telegram::Bot::Types::InlineKeyboardButton
        .new(text: 'View on RoomPassport', url: company_ticket_url(ticket))
    ]
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
  end
end
