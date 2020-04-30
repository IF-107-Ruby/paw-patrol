# == Schema Information
#
# Table name: tickets
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  user_id    :bigint           not null
#  unit_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :unit

  has_rich_text :description

  validates :user, :unit, :description, presence: true
  validates :name, presence: true, length: { in: 6..50 }
end
