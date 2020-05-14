class Event < ApplicationRecord
  belongs_to :unit
  belongs_to :user
  belongs_to :ticket, optional: true

  validates :title, :starts_at, :ends_at, presence: true

  def all_day_event?
    starts_at == starts_at.midnight && ends_at == ends_at.midnight
  end
end
