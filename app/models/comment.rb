# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  commentable_id   :integer          not null
#  commentable_type :string           not null
#  body             :text             not null
#  user_id          :bigint           not null
#  ancestry         :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_many :notification, as: :noticeable, dependent: :destroy

  validates :body, :user, :commentable, presence: true

  after_save :create_notification

  has_ancestry

  def belongs_to?(current_user)
    user == current_user
  end

  private

  def users_to_notify
    users = []
    users += commentable.participants if commentable.is_a?(Ticket)
    users
  end

  def create_notification
    notification_type = depth.zero? ? :new_comment : :comment_reply
    users_to_notify.each do |user|
      next if user == self.user

      Notification.create(user: user, notified_by: self.user,
                          noticeable: self, exemplar: notification_type)
    end
  end
end
