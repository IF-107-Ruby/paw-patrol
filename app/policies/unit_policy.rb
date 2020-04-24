class UnitPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    check_company_owner?
  end

  def update?
    check_company_owner?
  end

  def destroy?
    check_company_owner?
  end

  private

  def check_company_owner?
    user.company_owner?(record.company)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
