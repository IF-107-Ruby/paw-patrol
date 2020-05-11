class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_ancestry

  validates :body, :user, :commentable, presence: true

  def belongs_to?(current_user)
    user == current_user
  end
end
