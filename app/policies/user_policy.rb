class UserPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user.admin? || @user.super_admin?
        @scope.all
      else
        @scope.where(id: @user.id)
      end
    end
  end

  def index?
    true
  end

  def show?
    user.admin? || record.id == user.id
  end

  def create?
    user.admin? || user.author?
  end

  def update?
    return user.super_admin? if record.super_admin?

    user.admin? || record.id == user.id
  end

  def destroy?
    return user.super_admin? if record.super_admin?

    user.admin? || record.id == user.id
  end
end
