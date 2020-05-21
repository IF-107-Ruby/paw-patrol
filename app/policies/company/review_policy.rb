class Company
  class ReviewPolicy < ApplicationPolicy
    def index?
      user.can_create_ticket?
    end

    def create?
      user.can_create_ticket? &&
        user.creator_of_closed_ticket?(ticket_id: record.ticket.id)
    end

    def update?
      user.can_create_ticket? &&
        user.creator_of_closed_ticket?(ticket_id: record.ticket.id)
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
