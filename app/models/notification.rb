class Notification < ApplicationRecord
  belongs_to :noticeable, polymorphic: true
  belongs_to :notified_by, class_name: 'User', foreign_key: :notified_by_id,
                           inverse_of: :notifications
  belongs_to :user

  validates :user, :notified_by, :noticeable, presence: true

  scope :unread, -> { where(read: false) }
  scope :read, -> { where(read: true) }

  def self.mark_comments_as_read(object, user)
    Notification.where(noticeable: object.comments, user: user).update read: true
  end
end
