module Handlers
  def self.from_message(message)
    if message.is_a? Telegram::Bot::Types::Message
      from_text(message.text)
    elsif message.is_a? Telegram::Bot::Types::CallbackQuery
      from_callback_query(message.data)
    else DefaultHandler; end
  end

  def self.from_text(text)
    case text
    when '/start' then StartCommandHandler
    when '/link_account' then ConnectAccountCommandHandler
    when '/unlink_account' then DisconnectAccountCommandHandler
    else DefaultHandler; end
  end

  def self.from_callback_query(callback_query)
    case callback_query
    when '/link_account' then ConnectAccountCommandHandler
    else DefaultHandler; end
  end
end
