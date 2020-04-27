class UserPolicy < ApplicationPolicy
  def index?
    true
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
    # byebug
    user.company_owner?(user.company)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
