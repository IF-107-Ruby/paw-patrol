class Company
  class TicketPolicy < ApplicationPolicy
    def create?
      user.can_create_ticket?
    end

    class Scope < Scope
      def resolve
        Ticket.where(unit_id: user.company.unit_ids)
      end
    end
  end
end
