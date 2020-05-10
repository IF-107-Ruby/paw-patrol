class CommentPolicy < ApplicationPolicy
  def new?
    user == record.commentable.user || user == record.commentable.unit.responsible_user
  end

  def create?
    user == record.commentable.user || user == record.commentable.unit.responsible_user
  end

  def destroy?
    user == record.user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
