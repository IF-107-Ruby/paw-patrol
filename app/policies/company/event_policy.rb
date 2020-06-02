class Company
  class EventPolicy < ApplicationPolicy
    def index?
      true
    end

    def show?
      true
    end

    def create?
      user.company_owner? || user.responsible_for?(record.unit)
    end

    def update?
      create?
    end

    def destroy?
      create?
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
