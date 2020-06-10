module Handlers
  def self.from_message(message)
    case message.text
    when '/start' then Handlers::StartCommandHandler
    when '/link_account' then Handlers::LinkAccountCommandHandler
    when '/unlink_account' then Handlers::UnlinkAccountCommandHandler
    end
  end
end
