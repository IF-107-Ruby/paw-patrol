module Handlers
  def self.from_message(message, telegram_profile)
    if message.is_a? Telegram::Bot::Types::Message
      from_text(message.text, telegram_profile)
    elsif message.is_a? Telegram::Bot::Types::CallbackQuery
      from_text(message.data, telegram_profile)
    else DefaultHandler; end
  end

  def self.from_text(text, telegram_profile)
    case text
    when '/start' then StartCommandHandler
    when '/connect_account' then ConnectAccountCommandHandler
    when '/disconnect_account' then DisconnectAccountCommandHandler
    when 'Create new ticket' then StartTicketCreationHandler
    else check_additional_handlers(telegram_profile); end
  end

  def self.check_additional_handlers(telegram_profile)
    if telegram_profile.awaiting_unit?
      AddUnitToNewTicketHandler
    elsif telegram_profile.awaiting_ticket_name?
      AddTitleToNewTicketHandler
    elsif telegram_profile.awaiting_ticket_description?
      AddDescriptionToNewTicketHandler
    else
      DefaultHandler
    end
  end
end
