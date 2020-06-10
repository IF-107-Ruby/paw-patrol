module Handlers
  def self.from_message(message)
    puts message.class
    if message.is_a? Telegram::Bot::Types::Message
      from_text_message(message)
    elsif message.is_a? Telegram::Bot::Types::CallbackQuery
      from_callback_query_message
    else Handlers::DefaultHandler; end
  end

  def self.from_text_message(message)
    case message.text
    when '/start' then Handlers::StartCommandHandler
    when '/link_account' then Handlers::LinkAccountCommandHandler
    when '/unlink_account' then Handlers::UnlinkAccountCommandHandler
    else Handlers::DefaultHandler; end
  end

  def self.from_callback_query_message(message)
    case message.data
    when '/link_account' then Handlers::LinkAccountCommandHandler
    else Handlers::DefaultHandler; end
  end
end
