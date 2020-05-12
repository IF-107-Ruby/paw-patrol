class Company
  class ReviewPolicy < ApplicationPolicy
    delegate :can_create_ticket?, to: :user

    def index?
      can_create_ticket?
    end

    def create?
      can_create_ticket?
    end

    def update?
      can_create_ticket?
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
