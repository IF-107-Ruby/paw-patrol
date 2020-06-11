module Handlers
  def self.from_message(message)
    puts message.class
    if message.is_a? Telegram::Bot::Types::Message
      from_text(message)
    elsif message.is_a? Telegram::Bot::Types::CallbackQuery
      from_callback_query(message)
    else DefaultHandler; end
  end

  def self.from_text(message)
    case message.text
    when '/start' then StartCommandHandler
    when '/link_account' then LinkAccountCommandHandler
    when '/unlink_account' then UnlinkAccountCommandHandler
    else DefaultHandler; end
  end

  def self.from_callback_query(message)
    case message.data
    when '/link_account' then LinkAccountCommandHandler
    else DefaultHandler; end
  end
end
