class NotifyTelegramNewTicketJob < ApplicationJob
  include Rails.application.routes.url_helpers

  attr_accessor :ticket, :telegram_profile

  queue_as :default

  def perform(ticket_id, telegram_profile_id)
    @ticket = Ticket.find_by({ id: ticket_id }).decorate
    @telegram_profile = TelegramProfile.find(telegram_profile_id).decorate

    TelegramMessanger.new(telegram_profile)
                     .send_message(
                       text: notification_text,
                       reply_markup: notification_kayboard
                     )
  end

  private

  def notification_text
    "#{ticket.user.full_name} created new ticket " \
      "for #{ticket.unit_name}\n" \
      "Title: #{ticket.name}"
  end

  def notification_kayboard
    kb = [
      Telegram::Bot::Types::InlineKeyboardButton
        .new(text: 'View on RoomPassport', url: company_ticket_url(ticket))
    ]
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
  end
end
