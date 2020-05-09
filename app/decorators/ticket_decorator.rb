class TicketDecorator < Draper::Decorator
  delegate_all

  def place_were_opened
    "Ticket open for #{unit.name}"
  end
end
