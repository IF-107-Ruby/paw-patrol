module Handlers
  class DisconnectAccountCommandHandler < BaseHandler
    def execute!
      return if telegram_profile.disconnect_user

      bot.api.send_message(chat_id: telegram_profile.id, text: 'Account is not connected')
    end
  end
end
