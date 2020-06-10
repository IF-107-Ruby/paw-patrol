module Handlers
  class StartCommandHandler < Handlers::BaseHandler
    def execute!
      api.send_message(chat_id: current_telegram_user.id,
                       text: "Hello, #{current_telegram_user.first_name}")
    end
  end
end
