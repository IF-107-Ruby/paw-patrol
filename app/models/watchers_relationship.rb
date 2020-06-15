# == Schema Information
#
# Table name: watchers_relationships
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  ticket_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class WatchersRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  validates :user, :ticket, presence: true
end
