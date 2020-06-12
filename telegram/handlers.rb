module Handlers
  def self.from_message(message)
    if message.is_a? Telegram::Bot::Types::Message
      from_text(message.text)
    elsif message.is_a? Telegram::Bot::Types::CallbackQuery
      from_text(message.data)
    else DefaultHandler; end
  end

  def self.from_text(text)
    case text
    when '/start' then StartCommandHandler
    when '/connect_account' then ConnectAccountCommandHandler
    when '/disconnect_account' then DisconnectAccountCommandHandler
    else DefaultHandler; end
  end
end
