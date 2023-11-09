class BusinessPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user.admin? || @user.super_admin?
        @scope.all
      end
    end
  end

  def index?
    user.admin? || user.super_admin?
  end

  def show?
    user.admin? || user.super_admin?
  end

  def create?
    user.admin? || user.super_admin?
  end

  def update?
    user.admin? || user.super_admin?
  end

  def destroy?
    user.admin? || user.super_admin?
  end
end
