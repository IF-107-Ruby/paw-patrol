module Handlers
  class UnlinkAccountCommandHandler < Handlers::BaseHandler
    def execute!
      if current_telegram_user.user.present?
        current_telegram_user.disconnect_user
        respond_text = 'User disconnected'
      else
        respond_text = 'Account is not connected'
      end
      api.send_message(chat_id: current_telegram_user.id, text: respond_text)
    end
  end
end
