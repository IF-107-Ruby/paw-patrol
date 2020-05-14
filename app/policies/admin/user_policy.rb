module Admin
  class UserPolicy < ApplicationPolicy
    def index?
      user.admin?
    end

    def show?
      user.admin?
    end

    def update?
      user.admin? && user == record
    end

    def destroy?
      user.admin?
    end

    def impersonate?
      user.admin?
    end

    def stop_impersonating?
      true
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
