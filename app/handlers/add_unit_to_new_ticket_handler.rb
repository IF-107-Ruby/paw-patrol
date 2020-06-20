class AddUnitToNewTicketHandler < BaseHandler
  def execute!
    @unit = Unit.find_by(id: message.data)

    Ticket.create(name: 'Telegram Bot Ticket',
                  description: 'Some Ticket Bot Description',
                  user: telegram_profile.user,
                  unit: @unit,
                  status: 2)

    telegram_profile.awaiting_ticket_name!

    send_adding_unit_notification
  end

  private

  def send_adding_unit_notification
    telegram_api.send_message(chat_id: telegram_profile.id,
                              text: selected_unit_text)
    telegram_api.send_message(chat_id: telegram_profile.id,
                              text: await_ticket_name_text)
  end

  def selected_unit_text
    "Selected unit: #{@unit.name}"
  end

  def await_ticket_name_text
    'Please, enter ticket name:'
  end
end
