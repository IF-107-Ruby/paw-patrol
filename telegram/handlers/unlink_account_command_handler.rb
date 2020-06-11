module Handlers
  class UnlinkAccountCommandHandler < Handlers::BaseHandler
    def execute!
      return if current_telegram_profile.disconnect_user

      reply_with(text: 'Account is not connected')
    end
  end
end
