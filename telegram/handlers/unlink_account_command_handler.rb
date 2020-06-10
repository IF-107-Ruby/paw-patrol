module Handlers
  class UnlinkAccountCommandHandler < Handlers::BaseHandler
    def execute!
      if current_telegram_user.user.present?
        current_telegram_user.disconnect_user
        respond_text = 'User disconnected'
      else
        respond_text = 'Account is not connected'
      end
      reply_with(text: respond_text)
    end
  end
end
