# == Schema Information
#
# Table name: users_units_relationships
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  unit_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UsersUnitsRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :unit

  validates :user, :unit, presence: true
end
