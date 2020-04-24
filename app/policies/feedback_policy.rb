class FeedbackPolicy < ApplicationPolicy
  def index?
    user.is_admin?
  end

  def show?
    user.is_admin?
  end

  def create?
    true
  end

  def destroy?
    user.is_admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
