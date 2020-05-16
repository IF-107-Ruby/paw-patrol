class WatchersRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  validates :user, :ticket, presence: true
end
