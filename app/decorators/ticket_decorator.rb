class TicketDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_association :review
  decorates_association :employees

  def place_were_opened
    "Ticket opened for #{unit.name}"
  end

  def created_by
    "Created by #{user.full_name}"
  end

  def watchers_info
    {
      available_watchers: available_watchers.map do |w|
        { id: w.id, full_name: w.full_name }
      end,
      selected_ids: watcher_ids,
      ticket_id: id
    }
  end
end
