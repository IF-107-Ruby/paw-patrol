class Company
  class CompanyPolicy < ApplicationPolicy
    def show?
      true
    end

    def update?
      user.company_owner?
    end

    def destroy?
      user.company_owner?
    end

    class Scope < Scope
      def resolve
        user.company
      end
    end
  end
end
