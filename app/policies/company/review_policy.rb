class Company
  class ReviewPolicy < ApplicationPolicy
    def index?
      user.company_owner? || user.employee?
    end

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
