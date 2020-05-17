# == Schema Information
#
# Table name: events
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  starts_at  :datetime         not null
#  ends_at    :datetime         not null
#  color      :string           default("#0000ff"), not null
#  ticket_id  :integer
#  user_id    :integer
#  unit_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Event < ApplicationRecord
  belongs_to :unit
  belongs_to :user
  belongs_to :ticket, optional: true

  validates :unit, :user, :title, :starts_at, :ends_at, :color,
            presence: true
  validates :color, format: {
    with: /\A#([A-Fa-f0-9]{3}|[A-Fa-f0-9]{4}|[A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})\z/,
    message: 'must be valid hexa color'
  }
  validate :end_date_after_start_date

  def all_day_event?
    starts_at == starts_at.midnight && ends_at == ends_at.midnight
  end

  private

  def end_date_after_start_date
    return if ends_at.blank? || starts_at.blank?

    errors.add(:ends_at, 'must be after the start date') if ends_at < starts_at
  end
end
