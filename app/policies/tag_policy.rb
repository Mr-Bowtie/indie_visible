# frozen_string_literal: true

class TagPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      return unless @user.at_least_admin?

      @scope.all
    end
  end

  def index?
    user.at_least_admin?
  end

  def show?
    user.at_least_admin?
  end

  def create?
    user.at_least_admin?
  end

  def update?
    user.at_least_admin?
  end

  def destroy?
    user.at_least_admin?
  end
end
