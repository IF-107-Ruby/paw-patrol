# == Schema Information
#
# Table name: telegram_profiles
#
#  id               :bigint           not null, primary key
#  first_name       :string
#  last_name        :string
#  username         :string
#  language_code    :string
#  user_id          :integer
#  connection_token :string
#  connected_at     :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class TelegramProfile < ApplicationRecord
  belongs_to :user, optional: true

  after_commit :notify_user, if: :saved_change_to_user_id?

  validates :first_name, presence: true

  def start_user_connection
    return false if user.present?

    token = generate_token
    update!(connection_token: token)
    token
  end

  def connect_user(user)
    return false if self.user.present?

    update({
             user: user,
             connection_token: nil,
             connected_at: Time.zone.now
           })
  end

  def disconnect_user
    return false if user.blank?

    update({ user: nil, connected_at: nil })
  end

  def self.from_message_context(context)
    user = find_by(id: context.id)
    return user if user.present?

    create({ id: context.id,
             first_name: context.first_name,
             last_name: context.last_name,
             username: context.username,
             language_code: context.language_code })
  end

  private

  def notify_user
    if user.present?
      NotifyTelegramConnectedJob.perform_later(id)
    else
      NotifyTelegramDisconnectedJob.perform_later(id)
    end
  end

  def generate_token
    loop do
      random_token = SecureRandom.random_number(100_000...1_000_000)
      return random_token unless TelegramProfile.exists?(connection_token: random_token)
    end
  end
end
