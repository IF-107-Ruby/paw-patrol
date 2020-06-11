class TelegramProfile < ApplicationRecord
  belongs_to :user, optional: true

  after_update :notify_user, if: :saved_change_to_user_id?

  validates :first_name, presence: true

  def start_linking
    return false if user.present?

    token = generate_token
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
    return false if user.blank?

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

  def generate_token
    loop do
      random_token = SecureRandom.random_number(100_000...1_000_000)
      return random_token unless TelegramProfile.exists?(link_token: random_token)
    end
  end
end
