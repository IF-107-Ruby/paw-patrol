class StartTicketCreationHandler < BaseHandler
  def execute!
    return if check_ticket_completion

    telegram_profile.awaiting_unit!

    telegram_api.send_message(chat_id: telegram_profile.id,
                              text: ticket_creation_text,
                              reply_markup: choose_unit_keyboard)
  end

  private

  def check_ticket_completion
    if telegram_profile.awaiting_unit? ||
       telegram_profile.awaiting_ticket_name? ||
       telegram_profile.awaiting_ticket_description?

      telegram_api.send_message(chat_id: telegram_profile.id,
                                text: ticket_creation_completion_text)
      true
    end

    false
  end

  def choose_unit_keyboard
    kb = []

    telegram_profile.user.units.each do |unit|
      kb.push(InlineKeyboardButton.new(text: unit.name.to_s,
                                       callback_data: unit.id.to_s))
    end

    InlineKeyboardMarkup.new(inline_keyboard: kb)
  end

  def ticket_creation_text
    'Please, choose unit: '
  end

  def ticket_creation_completion_text
    'Please, before creating new ticket complete prewious actions.'
  end
end
