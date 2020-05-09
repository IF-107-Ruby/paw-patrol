class Company
  class TicketPolicy < ApplicationPolicy
    def create?
      user.employee?
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
