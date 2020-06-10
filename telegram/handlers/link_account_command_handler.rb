module Handlers
  class LinkAccountCommandHandler < Handlers::BaseHandler
    def execute!
      if current_telegram_user.user.present?
        respond_text = 'Already connected'
      else
        link_token = current_telegram_user.start_linking
        respond_text = "Link token is, #{link_token}"
      end
      api.send_message(chat_id: current_telegram_user.id, text: respond_text)
    end
  end
end
