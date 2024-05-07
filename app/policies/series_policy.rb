class SeriesPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user.admin? || @user.super_admin?
        @scope.all
      else
        @scope.where(author_id: @user.id)
      end
    end
  end

  def index?
    true
  end

  def show?
    user.admin? || user.super_admin? || record.author_id == user.id
  end

  def create?
    true
  end

  def update?
    user.admin? || user.super_admin? || record.author_id == user.id
  end 

  def destroy?
    user.admin? || user.super_admin? || record.author_id == user.id
  end
end
