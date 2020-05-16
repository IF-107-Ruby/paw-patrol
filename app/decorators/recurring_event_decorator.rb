class RecurringEventDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  delegate :name, to: :ticket, prefix: true

  def place
    'This happens at '.html_safe +
      h.link_to(unit.name, [:company, unit])
  end

  def duration_in_words
    "Duration: #{h.distance_of_time_in_words(anchor, anchor + duration.minutes)}"
  end

  def attachment
    'Attached: '.html_safe + h.link_to(ticket_name, [:company, ticket])
  end

  def planned_by
    'Planned by '.html_safe + h.link_to(user.full_name, [:company, user])
  end
end
