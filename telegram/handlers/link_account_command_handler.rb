module Handlers
  class LinkAccountCommandHandler < Handlers::BaseHandler
    attr_accessor :link_token

    def execute!
      if current_telegram_profile.user.present?
        respond_text = 'Already connected'
      else
        @link_token = current_telegram_profile.start_linking
        respond_text = success_text
        reply_markup = reply_keyboard
      end
      reply_with(text: respond_text,
                 reply_markup: reply_markup,
                 parse_mode: 'MarkdownV2')
    end

    private

    def reply_keyboard
      kb = [
        InlineKeyboardButton.new(text: 'Link account',
                                 url: company_telegram_account_url(
                                   telegram: { link_token: link_token }
                                 ))
      ]
      InlineKeyboardMarkup.new(inline_keyboard: kb)
    end

    def success_text
      "Just follow link bellow\n" \
      "Or enter link token manually\n" \
      "*Link token: #{link_token}*"
    end
  end
end
