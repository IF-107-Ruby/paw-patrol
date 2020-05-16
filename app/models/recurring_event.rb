class RecurringEvent < ApplicationRecord
  enum frequency: { weekly: 0, biweekly: 1, monthly: 2, annually: 3 }

  belongs_to :unit
  belongs_to :user
  belongs_to :ticket, optional: true

  validates :unit, :user, :title, :frequency, :anchor, :duration, :color,
            presence: true
  validates :duration, numericality: { greater_than: 0 }
  validates :color, format: {
    with: /\A#([A-Fa-f0-9]{3}|[A-Fa-f0-9]{4}|[A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})\z/,
    message: 'must be valid hexa color'
  }

  def all_day_event?
    anchor == anchor.midnight &&
      (anchor + duration.minutes) == (anchor + duration.minutes).midnight
  end

  def schedule
    @schedule ||= begin
      schedule = IceCube::Schedule.new(anchor)
      schedule.add_recurrence_rule(rule)
      schedule
    end
  end

  def events(start_date, end_date)
    start_frequency = start_date ? start_date.to_date : 1.year.ago
    end_frequency = end_date ? end_date.to_date : 1.year.from_now
    schedule.occurrences_between(start_frequency, end_frequency, spans: true)
  end

  private

  def rule
    if weekly?
      IceCube::Rule.weekly(1)
    elsif biweekly?
      IceCube::Rule.weekly(2)
    elsif monthly?
      IceCube::Rule.monthly(1)
    elsif annually?
      IceCube::Rule.yearly(1)
    end
  end
end
