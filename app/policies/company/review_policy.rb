class Company
  class ReviewPolicy < ApplicationPolicy
    def index?
      user.company_owner? || user.employee?
    end

    def show?
      true
    end

    def create?
      user.creator_of_closed_ticket?(ticket_id: record.ticket.id)
    end

    def update?
      user.creator_of_closed_ticket?(ticket_id: record.ticket.id)
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
