class AddTitleToNewTicketHandler < BaseHandler
  def execute!
    @ticket = telegram_profile.user.draft_ticket.decorate
    @ticket.update(ticket_name)

    telegram_profile.awaiting_ticket_description!

    telegram_api.send_message(chat_id: telegram_profile.id,
                              text: notification_text)
  end

  private

  def notification_text
    "Name: #{@ticket.name} \n" \
    'Please, enter description:'
  end

  def ticket_name
    {
      name: message
    }
  end
end
