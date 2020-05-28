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
  belongs_to :noticeable, polymorphic: true
  belongs_to :notified_by, class_name: 'User', foreign_key: :notified_by_id,
                           inverse_of: :notifications
  belongs_to :user

  validates :user, :notified_by, :noticeable, presence: true

  scope :unread, -> { where(read: false).order('created_at DESC') }
  scope :read, -> { where(read: true) }

  def self.mark_comments_as_read(noticeable, user)
    Notification.where(noticeable: noticeable.comments, user: user).update read: true
  end
end
