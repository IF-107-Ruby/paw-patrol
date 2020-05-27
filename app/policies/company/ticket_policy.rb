class Company
  class TicketPolicy < ApplicationPolicy
    def index?
      create?
    end

    def create?
      user.company_owner? || user.employee?
    end

    class Scope < Scope
      def resolve
        Ticket.where(unit_id: user.company.unit_ids)
      end
    end
  end
end
