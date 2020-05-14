class Company
  class EventPolicy < ApplicationPolicy
    def index?
      true
    end

    def show?
      true
    end

    def create?
      user.can_manage_unit_events?(record.unit)
    end

    def update?
      user.can_manage_unit_events?(record.unit)
    end

    def destroy?
      user.can_manage_unit_events?(record.unit)
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
