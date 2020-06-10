class NotifyTelegramNewTicketJob < ApplicationJob
  queue_as :default

  def perform(ticket_id, user_id)
    ticket = Ticket.find_by({ id: ticket_id })
    user = User.find_by({ id: user_id })
    Rails.configuration.telegram_bot.api
         .send_message(chat_id: user.telegram_user.id,
                       text: "New ticket created \n#{ticket.name}")
  end
end
