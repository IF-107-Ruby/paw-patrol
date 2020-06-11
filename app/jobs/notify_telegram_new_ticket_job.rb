class NotifyTelegramNewTicketJob < ApplicationJob
  include Rails.application.routes.url_helpers

  attr_accessor :ticket, :user

  queue_as :default

  def perform(ticket_id, user_id)
    @ticket = Ticket.find_by({ id: ticket_id }).decorate
    @user = User.find_by({ id: user_id })
    Rails.configuration.telegram_bot.api
         .send_message(chat_id: user.telegram_profile.id,
                       text: notification_text,
                       reply_markup: notification_kayboard)
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
