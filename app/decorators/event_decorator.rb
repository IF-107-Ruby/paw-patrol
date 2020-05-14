class EventDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  delegate :name, to: :ticket, prefix: true

  def place
    'This event will happen at '.html_safe +
      h.link_to(unit.name, [:company, unit])
  end

  def timespan
    "From #{starts_at.to_formatted_s(:short)} to #{ends_at.to_formatted_s(:short)}"
  end

  def planed_by
    h.link_to(user.full_name, [:company, user])
  end
end
