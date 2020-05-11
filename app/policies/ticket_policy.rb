class TicketPolicy < ApplicationPolicy
  def new?
    user.employee?
  end

  def create?
    user.employee?
  end

  class Scope < Scope
    def resolve
      Ticket.where(unit_id: user.company.unit_ids)
    end
  end
end
