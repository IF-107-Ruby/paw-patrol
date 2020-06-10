class TelegramUser < ApplicationRecord
  belongs_to :user, optional: true

  def start_linking
    token = loop do
      random_token = SecureRandom.random_number(100_000...1_000_000)
      break random_token unless TelegramUser.exists?(link_token: random_token)
    end
    update!(link_token: token)
    token
  end

  def connect_user(user)
    return unless update({
                           user: user,
                           link_token: nil,
                           linked_at: Time.zone.now
                         })

    NotifyTelegramConnectJob.perform_later(id)
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
end
