class TelegramProfile < ApplicationRecord
  belongs_to :user, optional: true

  after_update :notify_user, if: :saved_change_to_user_id?

  def start_linking
    token = loop do
      random_token = SecureRandom.random_number(100_000...1_000_000)
      break random_token unless TelegramProfile.exists?(link_token: random_token)
    end
    update!(link_token: token)
    token
  end

  def connect_user(user)
    return false if self.user.present?

    update({
             user: user,
             link_token: nil,
             linked_at: Time.zone.now
           })
  end

  def disconnect_user
    update({ user: nil, linked_at: nil })
  end

  def self.from_message_context(context)
    find_or_create_by(
      { id: context.id,
        first_name: context.first_name,
        last_name: context.last_name,
        username: context.username,
        language_code: context.language_code }
    )
  end

  private

  def notify_user
    if user.present?
      NotifyTelegramConnectJob.perform_later(id)
    else
      NotifyTelegramDisconnectJob.perform_later(id)
    end
  end
end
