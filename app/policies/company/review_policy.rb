class Company
  class ReviewPolicy < ApplicationPolicy
    def show?
      true
    end

    def create?
      record.ticket.belongs_to?(user)
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
