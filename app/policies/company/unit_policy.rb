class Company
  class UnitPolicy < ApplicationPolicy
    delegate :company_owner?, to: :user

    def index?
      true
    end

    def show?
      true
    end

    def create?
      company_owner?
    end

    def update?
      company_owner?
    end

    def destroy?
      company_owner?
    end

    def events?
      user.company_owner? || user.responsible_for?(record)
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
