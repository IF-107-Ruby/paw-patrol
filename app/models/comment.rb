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
  has_ancestry

  validates :body, :user, :commentable, presence: true

  def belongs_to?(current_user)
    user == current_user
  end
end
