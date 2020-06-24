# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  noticeable_id   :integer          not null
#  noticeable_type :string           not null
#  user_id         :bigint           not null
#  notified_by_id  :integer          not null
#  read            :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Notification < ApplicationRecord
  scope :unread, -> { where(read: false).order(created_at: :desc) }
  scope :read, -> { where(read: true) }

  enum exemplar: { unspecified: 0,
                   new_comment: 1,
                   comment_reply: 2 }

  belongs_to :user
  belongs_to :noticeable, polymorphic: true
  belongs_to :notified_by, class_name: 'User', foreign_key: :notified_by_id,
                           inverse_of: :notifications

  validates :user, :notified_by, :noticeable, presence: true

  after_create_commit :send_notification

  def as_json(options = {})
    super(include:
      { user: { only: %i[id first_name last_name] },
        notified_by: { only: %i[id first_name last_name] },
        noticeable: {} }
        .merge(options))
  end

  private

  def send_notification
    NotifyWebsocketsNewNotificationJob.perform_later(self)
  end
end
