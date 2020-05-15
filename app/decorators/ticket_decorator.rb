class TicketDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_association :review

  def place_were_opened
    "Ticket opened for #{unit.name}"
  end

  def created_by
    "Created by #{user.full_name}"
  end

  def display_status
    status
  end

  def completion_description
    ticket_completion.description
  end
end
