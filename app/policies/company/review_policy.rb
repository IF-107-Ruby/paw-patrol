class Company
  class ReviewPolicy < ApplicationPolicy
    def show?
      true
    end

    def create?
      user.ticket_ids.include?(record.ticket.id)
    end

    def update?
      create?
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
