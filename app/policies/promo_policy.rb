# frozen_string_literal: true

class PromoPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      return unless @user.super_admin?

      @scope.all
    end
  end

  def index?
    user.super_admin?
  end

  def show?
    user.super_admin?
  end

  def create?
    user.super_admin?
  end

  def update?
    user.super_admin?
  end

  def destroy?
    user.super_admin?
  end

  def bulk_activation_toggle?
    user.at_least_admin?
  end
end
