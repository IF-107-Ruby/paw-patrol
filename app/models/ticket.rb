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

  validates_with ImageAttachmentsValidator,
                 if: ->(ticket) { ticket.description.body.attachments.any? }

  validate :unit_permission

  private

  def unit_permission
    available_units = AvailableUserUnitsQuery.new(user: :user).to_units_array
    return unless available_units.include?(:unit)

    errors.add(:unit, 'user is not allowed to create a ticket for this unit')
  end
end
