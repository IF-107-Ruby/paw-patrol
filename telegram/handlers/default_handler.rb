module Handlers
  class DefaultHandler < Handlers::BaseHandler
    def execute!
      reply_with(text: 'Unknown action')
    end
  end
end
