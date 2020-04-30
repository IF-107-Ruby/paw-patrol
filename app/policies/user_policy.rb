class UserPolicy < ApplicationPolicy
  def index?
    user.is_admin?
  end

  def show?
    true
  end

  def new?
    company_owner?
  end

  def create?
    company_owner?
  end

  def edit?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  private

  def company_owner?
    user.company_owner?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
