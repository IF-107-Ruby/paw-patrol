class TelegramUserDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  def full_name
    [first_name, last_name].join(' ').strip
  end
end
